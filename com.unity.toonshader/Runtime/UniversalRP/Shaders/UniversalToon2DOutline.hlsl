#ifndef UNIVERSAL_TOON_2D_OUTLINE_INCLUDED
#define UNIVERSAL_TOON_2D_OUTLINE_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "UniversalToon2DInput.hlsl"

// Outline specific parameters
CBUFFER_START(OutlineParams)
float _Outline_Width;
float _Farthest_Distance;
float _Nearest_Distance;
float4 _Outline_Color;
fixed _Is_BlendBaseColor;
fixed _Is_LightColor_Outline;
fixed _Is_OutlineTex;
float _Offset_Z;
CBUFFER_END

TEXTURE2D(_Outline_Sampler);    SAMPLER(sampler_Outline_Sampler);
TEXTURE2D(_OutlineTex);         SAMPLER(sampler_OutlineTex);

struct OutlineAttributes
{
    float4 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float2 uv           : TEXCOORD0;
    float4 color        : COLOR;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct OutlineVaryings
{
    float4 positionCS   : SV_POSITION;
    float2 uv           : TEXCOORD0;
    float4 color        : COLOR;
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
};

OutlineVaryings Toon2DOutlineVert(OutlineAttributes input)
{
    OutlineVaryings output = (OutlineVaryings)0;
    
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input, output);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
    
    // Get vertex position inputs
    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS);
    
    // Calculate outline width based on distance
    float3 positionWS = vertexInput.positionWS;
    float distanceToCamera = distance(_WorldSpaceCameraPos, positionWS);
    float outlineScale = saturate((distanceToCamera - _Nearest_Distance) / (_Farthest_Distance - _Nearest_Distance));
    
    // Sample outline width texture
    float outlineWidth = _Outline_Width;
    #ifdef _USE_OUTLINE_TEX
    float4 outlineTex = SAMPLE_TEXTURE2D_LOD(_Outline_Sampler, sampler_Outline_Sampler, input.uv, 0);
    outlineWidth *= outlineTex.r;
    #endif
    
    // For 2D, we expand outward in screen space
    float3 normalWS = normalInput.normalWS;
    
    #ifdef _OUTLINE_NML
    // Normal-based outline (expand along normal in world space)
    float3 outlineOffset = normalWS * outlineWidth * 0.01 * outlineScale;
    positionWS += outlineOffset;
    output.positionCS = TransformWorldToHClip(positionWS);
    #else
    // Position-based outline (expand in screen space)
    output.positionCS = vertexInput.positionCS;
    float3 normalCS = TransformWorldToHClipDir(normalWS);
    float2 offset = normalize(normalCS.xy) * outlineWidth * 0.01 * outlineScale;
    output.positionCS.xy += offset * output.positionCS.w;
    #endif
    
    // Apply Z offset
    output.positionCS.z += _Offset_Z * 0.01;
    
    output.uv = TRANSFORM_TEX(input.uv, _MainTex);
    output.color = input.color;
    
    return output;
}

half4 Toon2DOutlineFrag(OutlineVaryings input) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
    
    // Base outline color
    half4 outlineColor = _Outline_Color;
    
    // Blend with base color if enabled
    if (_Is_BlendBaseColor > 0.5)
    {
        half4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
        outlineColor.rgb = lerp(outlineColor.rgb, baseColor.rgb * _BaseColor.rgb, 0.5);
    }
    
    // Apply outline texture if enabled
    #ifdef _IS_OUTLINETEX
    if (_Is_OutlineTex > 0.5)
    {
        half4 outlineTex = SAMPLE_TEXTURE2D(_OutlineTex, sampler_OutlineTex, input.uv);
        outlineColor.rgb *= outlineTex.rgb;
    }
    #endif
    
    // Apply light color if enabled
    if (_Is_LightColor_Outline > 0.5)
    {
        Light mainLight = GetMainLight();
        outlineColor.rgb *= mainLight.color;
    }
    
    // Apply vertex color
    outlineColor *= input.color;
    
    // Alpha clipping for outline
    #ifdef _IS_OUTLINE_CLIPPING_YES
    half4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
    half alpha = baseColor.a * _BaseColor.a;
    clip(alpha - _Cutoff);
    #endif
    
    return outlineColor;
}

#endif // UNIVERSAL_TOON_2D_OUTLINE_INCLUDED
