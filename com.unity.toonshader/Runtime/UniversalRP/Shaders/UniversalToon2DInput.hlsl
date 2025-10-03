#ifndef UNIVERSAL_TOON_2D_INPUT_INCLUDED
#define UNIVERSAL_TOON_2D_INPUT_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonMaterial.hlsl"

#define fixed  half
#define fixed3 half3
#define fixed4 half4

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _BaseMap_ST;
float4 _Color;
float4 _BaseColor;
float _Cutoff;

// Toon shading parameters
fixed _Use_BaseAs1st;
fixed _Use_1stAs2nd;
fixed _Is_LightColor_Base;

float4 _1st_ShadeMap_ST;
float4 _1st_ShadeColor;
fixed _Is_LightColor_1st_Shade;

float4 _2nd_ShadeMap_ST;
float4 _2nd_ShadeColor;
fixed _Is_LightColor_2nd_Shade;

float4 _NormalMap_ST;
float _BumpScale;
fixed _Is_NormalMapToBase;

// Shading step parameters
float _BaseColor_Step;
float _BaseShade_Feather;
float _ShadeColor_Step;
float _1st2nd_Shades_Feather;
float _1st_ShadeColor_Step;
float _1st_ShadeColor_Feather;
float _2nd_ShadeColor_Step;
float _2nd_ShadeColor_Feather;

// Position maps
float4 _Set_1st_ShadePosition_ST;
float4 _Set_2nd_ShadePosition_ST;

// Shading grade map
float4 _ShadingGradeMap_ST;
float _Tweak_ShadingGradeMapLevel;
fixed _BlurLevelSGM;

// High color (specular)
float4 _HighColor;
float4 _HighColor_Tex_ST;
fixed _Is_LightColor_HighColor;
fixed _Is_NormalMapToHighColor;
float _HighColor_Power;
fixed _Is_SpecularToHighColor;
fixed _Is_BlendAddToHiColor;
fixed _Is_UseTweakHighColorOnShadow;
float _TweakHighColorOnShadow;
float4 _Set_HighColorMask_ST;
float _Tweak_HighColorMaskLevel;

// Rim light
fixed _RimLight;
float4 _RimLightColor;
fixed _Is_LightColor_RimLight;
fixed _Is_NormalMapToRimLight;
float _RimLight_Power;
float _RimLight_InsideMask;
fixed _RimLight_FeatherOff;
fixed _LightDirection_MaskOn;
float _Tweak_LightDirection_MaskLevel;
fixed _Add_Antipodean_RimLight;
float4 _Ap_RimLightColor;
fixed _Is_LightColor_Ap_RimLight;
float _Ap_RimLight_Power;
fixed _Ap_RimLight_FeatherOff;
float4 _Set_RimLightMask_ST;
float _Tweak_RimLightMaskLevel;

// MatCap
fixed _MatCap;
float4 _MatCap_Sampler_ST;
float4 _MatCapColor;
fixed _Is_LightColor_MatCap;
fixed _Is_BlendAddToMatCap;
float _Tweak_MatCapUV;
float _Rotate_MatCapUV;
fixed _Is_NormalMapForMatCap;
float4 _NormalMapForMatCap_ST;
float _BumpScaleMatcap;
float _Rotate_NormalMapForMatCapUV;
fixed _Is_UseTweakMatCapOnShadow;
float _TweakMatCapOnShadow;
float4 _Set_MatcapMask_ST;
float _Tweak_MatcapMaskLevel;
fixed _Inverse_MatcapMask;
fixed _Is_Ortho;
fixed _CameraRolling_Stabilizer;
fixed _BlurLevelMatcap;

// Angel Ring
fixed _AngelRing;
float4 _AngelRing_Sampler_ST;
float4 _AngelRing_Color;
fixed _Is_LightColor_AR;
float _AR_OffsetU;
float _AR_OffsetV;
fixed _ARSampler_AlphaOn;

// Emissive
float4 _Emissive_Tex_ST;
float4 _Emissive_Color;
float _Base_Speed;
float _Scroll_EmissiveU;
float _Scroll_EmissiveV;
float _Rotate_EmissiveUV;
fixed _Is_PingPong_Base;
fixed _Is_ColorShift;
float4 _ColorShift;
float _ColorShift_Speed;
fixed _Is_ViewShift;
float4 _ViewShift;
fixed _Is_ViewCoord_Scroll;

// Lighting
float _GI_Intensity;
float _Unlit_Intensity;
fixed _Is_Filter_LightColor;

// Clipping
float4 _ClippingMask_ST;
fixed _Inverse_Clipping;
float _Clipping_Level;
float _Tweak_transparency;
float _IsBaseMapAlphaAsClippingMask;

CBUFFER_END

// Texture declarations
TEXTURE2D(_MainTex);            SAMPLER(sampler_MainTex);
TEXTURE2D(_BaseMap);            SAMPLER(sampler_BaseMap);
TEXTURE2D(_1st_ShadeMap);       SAMPLER(sampler_1st_ShadeMap);
TEXTURE2D(_2nd_ShadeMap);       SAMPLER(sampler_2nd_ShadeMap);
TEXTURE2D(_NormalMap);          SAMPLER(sampler_NormalMap);
TEXTURE2D(_Set_1st_ShadePosition);   SAMPLER(sampler_Set_1st_ShadePosition);
TEXTURE2D(_Set_2nd_ShadePosition);   SAMPLER(sampler_Set_2nd_ShadePosition);
TEXTURE2D(_ShadingGradeMap);    SAMPLER(sampler_ShadingGradeMap);
TEXTURE2D(_HighColor_Tex);      SAMPLER(sampler_HighColor_Tex);
TEXTURE2D(_Set_HighColorMask);  SAMPLER(sampler_Set_HighColorMask);
TEXTURE2D(_Set_RimLightMask);   SAMPLER(sampler_Set_RimLightMask);
TEXTURE2D(_MatCap_Sampler);     SAMPLER(sampler_MatCap_Sampler);
TEXTURE2D(_NormalMapForMatCap); SAMPLER(sampler_NormalMapForMatCap);
TEXTURE2D(_Set_MatcapMask);     SAMPLER(sampler_Set_MatcapMask);
TEXTURE2D(_AngelRing_Sampler);  SAMPLER(sampler_AngelRing_Sampler);
TEXTURE2D(_Emissive_Tex);       SAMPLER(sampler_Emissive_Tex);
TEXTURE2D(_ClippingMask);       SAMPLER(sampler_ClippingMask);

#endif // UNIVERSAL_TOON_2D_INPUT_INCLUDED
