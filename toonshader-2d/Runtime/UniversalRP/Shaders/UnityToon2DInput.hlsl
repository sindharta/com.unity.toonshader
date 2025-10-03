#ifndef UNITY_TOON_2D_INPUT_INCLUDED
#define UNITY_TOON_2D_INPUT_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonMaterial.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"

CBUFFER_START(UnityPerMaterial)
    // Main texture and color
    float4 _MainTex_ST;
    float4 _BaseMap_ST;
    half4 _BaseColor;
    half4 _Color;
    half _Cutoff;

    // Toon shading colors
    float4 _1st_ShadeMap_ST;
    half4 _1st_ShadeColor;
    float4 _2nd_ShadeMap_ST;
    half4 _2nd_ShadeColor;

    // Shading steps and feathering
    half _BaseColor_Step;
    half _BaseShade_Feather;
    half _ShadeColor_Step;
    half _1st2nd_Shades_Feather;
    half _1st_ShadeColor_Step;
    half _1st_ShadeColor_Feather;
    half _2nd_ShadeColor_Step;
    half _2nd_ShadeColor_Feather;

    // Highlight
    half4 _HighColor;
    float4 _HighColor_Tex_ST;
    half _HighColor_Power;
    float4 _Set_HighColorMask_ST;
    half _Tweak_HighColorMaskLevel;

    // Rim Light
    half4 _RimLightColor;
    half _RimLight_Power;
    half _RimLight_InsideMask;
    float4 _Set_RimLightMask_ST;
    half _Tweak_RimLightMaskLevel;

    // Emissive
    float4 _Emissive_Tex_ST;
    half4 _Emissive_Color;
    half _Base_Speed;
    half _Scroll_EmissiveU;
    half _Scroll_EmissiveV;
    half _Rotate_EmissiveUV;

    // 2D Lighting specific
    half _LightIntensity;
    half _ShadowIntensity;
    half _AmbientIntensity;

    // Toggles (stored as half for compatibility)
    half _Use_BaseAs1st;
    half _Use_1stAs2nd;
    half _Is_LightColor_Base;
    half _Is_LightColor_1st_Shade;
    half _Is_LightColor_2nd_Shade;
    half _Is_LightColor_HighColor;
    half _Is_BlendAddToHiColor;
    half _RimLight;
    half _Is_LightColor_RimLight;
    half _RimLight_FeatherOff;
    half _Is_PingPong_Base;

    // Render state
    half _SrcBlend;
    half _DstBlend;
    half _ZWrite;
    half _Cull;
CBUFFER_END

// Texture declarations
TEXTURE2D(_MainTex);            SAMPLER(sampler_MainTex);
TEXTURE2D(_BaseMap);            SAMPLER(sampler_BaseMap);
TEXTURE2D(_1st_ShadeMap);       SAMPLER(sampler_1st_ShadeMap);
TEXTURE2D(_2nd_ShadeMap);       SAMPLER(sampler_2nd_ShadeMap);
TEXTURE2D(_HighColor_Tex);      SAMPLER(sampler_HighColor_Tex);
TEXTURE2D(_Set_HighColorMask);  SAMPLER(sampler_Set_HighColorMask);
TEXTURE2D(_Set_RimLightMask);   SAMPLER(sampler_Set_RimLightMask);
TEXTURE2D(_Emissive_Tex);       SAMPLER(sampler_Emissive_Tex);

// Alpha testing function
half Alpha(half albedoAlpha, half4 color, half cutoff)
{
#if !defined(_SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A) && !defined(_GLOSSINESS_FROM_BASE_ALPHA)
    half alpha = albedoAlpha * color.a;
#else
    half alpha = color.a;
#endif

#if defined(_ALPHATEST_ON)
    clip(alpha - cutoff);
#endif

    return alpha;
}

// Sample albedo alpha
half4 SampleAlbedoAlpha(float2 uv, TEXTURE2D_PARAM(albedoAlphaMap, sampler_albedoAlphaMap))
{
    return half4(SAMPLE_TEXTURE2D(albedoAlphaMap, sampler_albedoAlphaMap, uv));
}

// Initialize surface data for 2D
inline void InitializeToon2DSurfaceData(float2 uv, out SurfaceData outSurfaceData)
{
    outSurfaceData = (SurfaceData)0;
    
    half4 albedoAlpha = SampleAlbedoAlpha(uv, TEXTURE2D_ARGS(_BaseMap, sampler_BaseMap));
    outSurfaceData.albedo = albedoAlpha.rgb * _BaseColor.rgb;
    outSurfaceData.alpha = Alpha(albedoAlpha.a, _BaseColor, _Cutoff);
    
    // For 2D, we don't need complex material properties
    outSurfaceData.metallic = 0.0h;
    outSurfaceData.specular = half3(0.0h, 0.0h, 0.0h);
    outSurfaceData.smoothness = 0.0h;
    outSurfaceData.normalTS = half3(0.0h, 0.0h, 1.0h);
    outSurfaceData.occlusion = 1.0h;
    
    // Sample emissive
    half4 emissive = SAMPLE_TEXTURE2D(_Emissive_Tex, sampler_Emissive_Tex, uv);
    outSurfaceData.emission = emissive.rgb * _Emissive_Color.rgb;
}

// Utility functions for 2D toon shading
half CalculateToonStep(half value, half step, half feather)
{
    return smoothstep(step - feather, step + feather, value);
}

half2 RotateUV(half2 uv, half angle, half2 center)
{
    half2 rotUV = uv - center;
    half cosA = cos(angle);
    half sinA = sin(angle);
    return half2(
        rotUV.x * cosA - rotUV.y * sinA,
        rotUV.x * sinA + rotUV.y * cosA
    ) + center;
}

// 2D-specific lighting calculation
half Calculate2DLighting(Light light, half3 normal)
{
    // For 2D sprites, we use a simplified lighting model
    half3 lightDir = normalize(light.direction);
    half NdotL = dot(normal, lightDir);
    
    // Convert to 0-1 range and apply attenuation
    half lightIntensity = saturate(NdotL * 0.5 + 0.5);
    lightIntensity *= light.distanceAttenuation * light.shadowAttenuation;
    
    return lightIntensity;
}

#endif // UNITY_TOON_2D_INPUT_INCLUDED