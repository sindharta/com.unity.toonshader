#ifndef UTS_COMMON_MATH_INCLUDED
#define UTS_COMMON_MATH_INCLUDED

inline float2 RotateUV(float2 uv, float angleRadians, float2 pivot, float timeValue)
{
    float rotateUV_cos = cos(timeValue * angleRadians);
    float rotateUV_sin = sin(timeValue * angleRadians);
    return mul(uv - pivot, float2x2(rotateUV_cos, -rotateUV_sin, rotateUV_sin, rotateUV_cos)) + pivot;
}

inline float3 DecodeLightProbe(float3 normal)
{
    return ShadeSH9(float4(normal, 1.0));
}

#endif // UTS_COMMON_MATH_INCLUDED
