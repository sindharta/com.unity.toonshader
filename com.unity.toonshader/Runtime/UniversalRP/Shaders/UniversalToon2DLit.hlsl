#ifndef UNIVERSAL_TOON_2D_LIT_INCLUDED
#define UNIVERSAL_TOON_2D_LIT_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "UniversalToon2DInput.hlsl"

struct Attributes
{
    float4 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float4 tangentOS    : TANGENT;
    float2 uv           : TEXCOORD0;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float4 positionCS   : SV_POSITION;
    float2 uv           : TEXCOORD0;
    float3 positionWS   : TEXCOORD1;
    float3 normalWS     : TEXCOORD2;
    float4 tangentWS    : TEXCOORD3;
    float3 viewDirWS    : TEXCOORD4;
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
};

// Helper function to calculate smooth step with feather
float SmoothStepFeather(float value, float step, float feather)
{
    float featherMin = saturate(step - feather);
    float featherMax = saturate(step + feather);
    return smoothstep(featherMin, featherMax, value);
}

// Helper function to calculate hard step
float HardStep(float value, float step)
{
    return step < value ? 1.0 : 0.0;
}

// Calculate toon shading with 2D lights
half3 CalculateToonShading(Varyings input, half3 baseColor, half3 normalWS)
{
    // Sample textures
    half4 mainTex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
    half3 albedo = mainTex.rgb * _BaseColor.rgb;
    
    // Sample shade maps
    half3 shade1Color = _1st_ShadeColor.rgb;
    half3 shade2Color = _2nd_ShadeColor.rgb;
    
    #ifdef _USE_SHADE_TEXTURES
    if (_Use_BaseAs1st < 0.5)
    {
        half4 shade1Tex = SAMPLE_TEXTURE2D(_1st_ShadeMap, sampler_1st_ShadeMap, input.uv);
        shade1Color *= shade1Tex.rgb;
    }
    else
    {
        shade1Color *= albedo;
    }
    
    if (_Use_1stAs2nd < 0.5)
    {
        half4 shade2Tex = SAMPLE_TEXTURE2D(_2nd_ShadeMap, sampler_2nd_ShadeMap, input.uv);
        shade2Color *= shade2Tex.rgb;
    }
    else
    {
        shade2Color *= shade1Color;
    }
    #endif
    
    // Initialize final color
    half3 finalColor = albedo;
    
    // Get main light (for 2D, this is typically a 2D light)
    Light mainLight = GetMainLight();
    half3 lightDir = normalize(mainLight.direction);
    half3 lightColor = mainLight.color;
    
    // Calculate N·L for lighting
    half NdotL = dot(normalWS, lightDir);
    half lightIntensity = NdotL * 0.5 + 0.5; // Remap to 0-1
    
    // Apply light attenuation for 2D lights
    lightIntensity *= mainLight.distanceAttenuation * mainLight.shadowAttenuation;
    
    // Calculate toon shading steps
    half baseShadeStep = _BaseColor_Step;
    half baseShadeFeather = _BaseShade_Feather;
    half shadeColorStep = _ShadeColor_Step;
    half shadesFeather = _1st2nd_Shades_Feather;
    
    // Apply shading steps
    half shadeFactor1 = SmoothStepFeather(lightIntensity, baseShadeStep, baseShadeFeather);
    half shadeFactor2 = SmoothStepFeather(lightIntensity, shadeColorStep, shadesFeather);
    
    // Mix colors based on shading
    finalColor = lerp(shade2Color, shade1Color, shadeFactor2);
    finalColor = lerp(finalColor, albedo, shadeFactor1);
    
    // Apply light color if enabled
    if (_Is_LightColor_Base > 0.5)
    {
        finalColor *= lightColor;
    }
    
    // Add additional 2D lights
    #ifdef _ADDITIONAL_LIGHTS
    uint pixelLightCount = GetAdditionalLightsCount();
    for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
    {
        Light light = GetAdditionalLight(lightIndex, input.positionWS);
        half3 addLightDir = normalize(light.direction);
        half addNdotL = dot(normalWS, addLightDir);
        half addLightIntensity = (addNdotL * 0.5 + 0.5) * light.distanceAttenuation;
        
        // Apply toon shading to additional light
        half addShadeFactor = SmoothStepFeather(addLightIntensity, baseShadeStep, baseShadeFeather);
        finalColor += albedo * light.color * addShadeFactor * 0.5; // Attenuate additional lights
    }
    #endif
    
    // Add ambient/GI
    half3 ambient = SampleSH(normalWS) * _GI_Intensity;
    finalColor += ambient * albedo;
    
    // Add unlit intensity (for scenes without lights)
    if (_Unlit_Intensity > 0.0)
    {
        finalColor += albedo * _Unlit_Intensity;
    }
    
    return finalColor;
}

// Calculate rim light
half3 CalculateRimLight(Varyings input, half3 normalWS, half3 viewDirWS, half3 lightColor)
{
    if (_RimLight < 0.5)
        return half3(0, 0, 0);
    
    half NdotV = saturate(dot(normalWS, viewDirWS));
    half rimIntensity = pow(1.0 - NdotV, _RimLight_Power * 10.0);
    
    // Apply inside mask
    half rimMask = smoothstep(_RimLight_InsideMask, 1.0, rimIntensity);
    
    if (_RimLight_FeatherOff > 0.5)
    {
        rimMask = step(_RimLight_InsideMask, rimIntensity);
    }
    
    half3 rimColor = _RimLightColor.rgb * rimMask;
    
    if (_Is_LightColor_RimLight > 0.5)
    {
        rimColor *= lightColor;
    }
    
    // Antipodean rim light
    if (_Add_Antipodean_RimLight > 0.5)
    {
        half apRimIntensity = pow(NdotV, _Ap_RimLight_Power * 10.0);
        half apRimMask = apRimIntensity;
        
        if (_Ap_RimLight_FeatherOff > 0.5)
        {
            apRimMask = step(0.5, apRimIntensity);
        }
        
        half3 apRimColor = _Ap_RimLightColor.rgb * apRimMask;
        
        if (_Is_LightColor_Ap_RimLight > 0.5)
        {
            apRimColor *= lightColor;
        }
        
        rimColor += apRimColor;
    }
    
    return rimColor;
}

// Calculate high color (specular)
half3 CalculateHighColor(Varyings input, half3 normalWS, half3 viewDirWS, half3 lightDir, half3 lightColor)
{
    if (_HighColor_Power <= 0.0)
        return half3(0, 0, 0);
    
    half3 halfDir = normalize(lightDir + viewDirWS);
    half NdotH = saturate(dot(normalWS, halfDir));
    
    half specIntensity;
    if (_Is_SpecularToHighColor > 0.5)
    {
        // Specular style
        specIntensity = pow(NdotH, _HighColor_Power * 100.0);
    }
    else
    {
        // Toon style
        specIntensity = step(1.0 - _HighColor_Power, NdotH);
    }
    
    half3 highColor = _HighColor.rgb * specIntensity;
    
    if (_Is_LightColor_HighColor > 0.5)
    {
        highColor *= lightColor;
    }
    
    return highColor;
}

// Calculate emissive
half3 CalculateEmissive(Varyings input)
{
    #ifdef _EMISSIVE_SIMPLE
    half4 emissiveTex = SAMPLE_TEXTURE2D(_Emissive_Tex, sampler_Emissive_Tex, input.uv);
    return emissiveTex.rgb * _Emissive_Color.rgb;
    #elif _EMISSIVE_ANIMATION
    float2 scrollUV = input.uv;
    scrollUV += float2(_Scroll_EmissiveU, _Scroll_EmissiveV) * _Time.y * _Base_Speed;
    half4 emissiveTex = SAMPLE_TEXTURE2D(_Emissive_Tex, sampler_Emissive_Tex, scrollUV);
    return emissiveTex.rgb * _Emissive_Color.rgb;
    #else
    return half3(0, 0, 0);
    #endif
}

Varyings Toon2DLitVert(Attributes input)
{
    Varyings output = (Varyings)0;
    
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input, output);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
    
    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
    
    output.positionCS = vertexInput.positionCS;
    output.positionWS = vertexInput.positionWS;
    output.uv = TRANSFORM_TEX(input.uv, _MainTex);
    output.normalWS = normalInput.normalWS;
    
    real sign = input.tangentOS.w * GetOddNegativeScale();
    output.tangentWS = half4(normalInput.tangentWS.xyz, sign);
    
    output.viewDirWS = GetWorldSpaceViewDir(vertexInput.positionWS);
    
    return output;
}

half4 Toon2DLitFrag(Varyings input) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
    
    // Sample main texture
    half4 mainTex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
    half alpha = mainTex.a * _BaseColor.a;
    
    // Alpha clipping
    #ifdef _ALPHATEST_ON
    clip(alpha - _Cutoff);
    #endif
    
    // Get normal (for 2D, we can use simple normal or normal map)
    half3 normalWS = normalize(input.normalWS);
    
    #ifdef _NORMALMAP
    half3 normalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, input.uv), _BumpScale);
    half3 bitangentWS = input.tangentWS.w * cross(input.normalWS, input.tangentWS.xyz);
    normalWS = TransformTangentToWorld(normalTS, half3x3(input.tangentWS.xyz, bitangentWS, input.normalWS));
    normalWS = normalize(normalWS);
    #endif
    
    // Get view direction
    half3 viewDirWS = normalize(input.viewDirWS);
    
    // Calculate base toon shading
    half3 color = CalculateToonShading(input, mainTex.rgb, normalWS);
    
    // Get main light
    Light mainLight = GetMainLight();
    half3 lightDir = normalize(mainLight.direction);
    
    // Add rim light
    color += CalculateRimLight(input, normalWS, viewDirWS, mainLight.color);
    
    // Add high color (specular)
    color += CalculateHighColor(input, normalWS, viewDirWS, lightDir, mainLight.color);
    
    // Add emissive
    color += CalculateEmissive(input);
    
    // Apply alpha premultiply if needed
    #ifdef _ALPHAPREMULTIPLY_ON
    color *= alpha;
    #endif
    
    return half4(color, alpha);
}

#endif // UNIVERSAL_TOON_2D_LIT_INCLUDED
