#ifndef UTS_OUTLINE_CORE_INCLUDED
#define UTS_OUTLINE_CORE_INCLUDED

#ifndef UTS_OUTLINE_OBJECT_TO_WORLD
#error "UTS_OUTLINE_OBJECT_TO_WORLD must be defined before including UTSOutlineCore.hlsl"
#endif

#ifndef UTS_OUTLINE_Z_OVERDRAW_SCALE
#error "UTS_OUTLINE_Z_OVERDRAW_SCALE must be defined before including UTSOutlineCore.hlsl"
#endif

inline float4x4 UTSOutlineGetObjectToWorldMatrix()
{
    return UTS_OUTLINE_OBJECT_TO_WORLD;
}

inline float3x3 UTSOutlineBuildTangentFrame(float3 normalOS, float4 tangentOS, out float3 normalDir, out float3 tangentDir, out float3 bitangentDir)
{
    float4x4 objectToWorld = UTSOutlineGetObjectToWorldMatrix();
    normalDir = UnityObjectToWorldNormal(normalOS);
    tangentDir = normalize(mul(objectToWorld, float4(tangentOS.xyz, 0.0)).xyz);
    bitangentDir = normalize(cross(normalDir, tangentDir) * tangentOS.w);
    return float3x3(tangentDir, bitangentDir, normalDir);
}

inline float3 UTSOutlineApplyBakedNormal(float3x3 tangentTransform, float3 bakedNormalSample)
{
    return normalize(mul(bakedNormalSample, tangentTransform));
}

inline float UTSOutlineComputeWidth(float outlineSamplerValue, float3 objectOriginWS)
{
    float distanceToCamera = distance(objectOriginWS, _WorldSpaceCameraPos);
    float outlineWidth = _Outline_Width * 0.001f * smoothstep(_Farthest_Distance, _Nearest_Distance, distanceToCamera) * outlineSamplerValue;
    return outlineWidth * UTS_OUTLINE_Z_OVERDRAW_SCALE;
}

#endif // UTS_OUTLINE_CORE_INCLUDED
