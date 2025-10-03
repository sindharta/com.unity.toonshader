//Unity Toon Shader 2D
//Converted from 3D Unity Toon Shader for URP 2D Renderer
//Based on Unity Toon Shader by nobuyuki@unity3d.com and toshiyuki@unity3d.com

Shader "Toon/2D" {
    Properties {
        [HideInInspector] _simpleUI ("SimpleUI", Int ) = 0
        [HideInInspector][Enum(OFF, 0, ON, 1)] _isUnityToonshader("Material is touched by Unity Toon Shader", Int) = 1
        [HideInInspector] _utsVersionX("VersionX", Float) = 0
        [HideInInspector] _utsVersionY("VersionY", Float) = 12
        [HideInInspector] _utsVersionZ("VersionZ", Float) = 0
        [HideInInspector] _utsTechnique ("Technique", int ) = 0

        // Main texture and color
        _MainTex ("BaseMap", 2D) = "white" {}
        _BaseMap ("BaseMap", 2D) = "white" {}
        _BaseColor ("BaseColor", Color) = (1,1,1,1)
        _Color ("Color", Color) = (1,1,1,1)
        
        // Alpha and transparency
        _Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
        [Toggle(_ALPHAPREMULTIPLY_ON)] _AlphaPremultiply("Alpha Premultiply", Float) = 0.0
        
        // Toon shading properties
        [Toggle(_)] _Is_LightColor_Base ("Is_LightColor_Base", Float ) = 1
        _1st_ShadeMap ("1st_ShadeMap", 2D) = "white" {}
        [Toggle(_)] _Use_BaseAs1st ("Use BaseMap as 1st_ShadeMap", Float ) = 0
        _1st_ShadeColor ("1st_ShadeColor", Color) = (0.8,0.8,0.8,1)
        [Toggle(_)] _Is_LightColor_1st_Shade ("Is_LightColor_1st_Shade", Float ) = 1
        _2nd_ShadeMap ("2nd_ShadeMap", 2D) = "white" {}
        [Toggle(_)] _Use_1stAs2nd ("Use 1st_ShadeMap as 2nd_ShadeMap", Float ) = 0
        _2nd_ShadeColor ("2nd_ShadeColor", Color) = (0.6,0.6,0.6,1)
        [Toggle(_)] _Is_LightColor_2nd_Shade ("Is_LightColor_2nd_Shade", Float ) = 1
        
        // Shading steps and feathering
        _BaseColor_Step ("BaseColor_Step", Range(0, 1)) = 0.5
        _BaseShade_Feather ("Base/Shade_Feather", Range(0.0001, 1)) = 0.0001
        _ShadeColor_Step ("ShadeColor_Step", Range(0, 1)) = 0
        _1st2nd_Shades_Feather ("1st/2nd_Shades_Feather", Range(0.0001, 1)) = 0.0001
        _1st_ShadeColor_Step ("1st_ShadeColor_Step", Range(0, 1)) = 0.5
        _1st_ShadeColor_Feather ("1st_ShadeColor_Feather", Range(0.0001, 1)) = 0.0001
        _2nd_ShadeColor_Step ("2nd_ShadeColor_Step", Range(0, 1)) = 0
        _2nd_ShadeColor_Feather ("2nd_ShadeColor_Feather", Range(0.0001, 1)) = 0.0001
        
        // Highlight
        _HighColor ("HighColor", Color) = (1,1,1,1)
        _HighColor_Tex ("HighColor_Tex", 2D) = "white" {}
        [Toggle(_)] _Is_LightColor_HighColor ("Is_LightColor_HighColor", Float ) = 1
        _HighColor_Power ("HighColor_Power", Range(0, 1)) = 0
        [Toggle(_)] _Is_BlendAddToHiColor ("Is_BlendAddToHiColor", Float ) = 0
        _Set_HighColorMask ("Set_HighColorMask", 2D) = "white" {}
        _Tweak_HighColorMaskLevel ("Tweak_HighColorMaskLevel", Range(-1, 1)) = 0
        
        // Rim Light
        [Toggle(_)] _RimLight ("RimLight", Float ) = 0
        _RimLightColor ("RimLightColor", Color) = (1,1,1,1)
        [Toggle(_)] _Is_LightColor_RimLight ("Is_LightColor_RimLight", Float ) = 1
        _RimLight_Power ("RimLight_Power", Range(0, 1)) = 0.1
        _RimLight_InsideMask ("RimLight_InsideMask", Range(0.0001, 1)) = 0.0001
        [Toggle(_)] _RimLight_FeatherOff ("RimLight_FeatherOff", Float ) = 0
        _Set_RimLightMask ("Set_RimLightMask", 2D) = "white" {}
        _Tweak_RimLightMaskLevel ("Tweak_RimLightMaskLevel", Range(-1, 1)) = 0
        
        // Emissive
        [KeywordEnum(SIMPLE,ANIMATION)] _EMISSIVE("EMISSIVE MODE", Float) = 0
        _Emissive_Tex ("Emissive_Tex", 2D) = "white" {}
        [HDR]_Emissive_Color ("Emissive_Color", Color) = (0,0,0,1)
        _Base_Speed ("Base_Speed", Float ) = 0
        _Scroll_EmissiveU ("Scroll_EmissiveU", Range(-1, 1)) = 0
        _Scroll_EmissiveV ("Scroll_EmissiveV", Range(-1, 1)) = 0
        _Rotate_EmissiveUV ("Rotate_EmissiveUV", Float ) = 0
        [Toggle(_)] _Is_PingPong_Base ("Is_PingPong_Base", Float ) = 0
        
        // 2D Lighting specific
        _LightIntensity ("Light Intensity", Range(0, 2)) = 1.0
        _ShadowIntensity ("Shadow Intensity", Range(0, 1)) = 0.5
        _AmbientIntensity ("Ambient Intensity", Range(0, 2)) = 0.2
        
        // Render state
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Src Blend", Float) = 1 // One
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Dst Blend", Float) = 0 // Zero
        [Enum(Off, 0, On, 1)] _ZWrite("ZWrite", Float) = 1.0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull", Float) = 2.0 // Back
    }

    SubShader {
        Tags {
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "Geometry"
        }

        Pass {
            Name "Universal2D"
            Tags {
                "LightMode" = "Universal2D"
            }

            Blend [_SrcBlend] [_DstBlend]
            ZWrite [_ZWrite]
            Cull [_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            #pragma vertex vert
            #pragma fragment frag

            // Material Keywords
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _ALPHAPREMULTIPLY_ON
            #pragma shader_feature_local _USE_BASEAS1ST_ON
            #pragma shader_feature_local _USE_1STAS2ND_ON
            #pragma shader_feature_local _IS_LIGHTCOLOR_BASE_ON
            #pragma shader_feature_local _IS_LIGHTCOLOR_1ST_SHADE_ON
            #pragma shader_feature_local _IS_LIGHTCOLOR_2ND_SHADE_ON
            #pragma shader_feature_local _IS_LIGHTCOLOR_HIGHCOLOR_ON
            #pragma shader_feature_local _IS_BLENDADDTOHICOLOR_ON
            #pragma shader_feature_local _RIMLIGHT_ON
            #pragma shader_feature_local _IS_LIGHTCOLOR_RIMLIGHT_ON
            #pragma shader_feature_local _RIMLIGHT_FEATHEROFF_ON
            #pragma shader_feature_local _EMISSIVE_SIMPLE _EMISSIVE_ANIMATION

            // Unity Keywords
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "UnityToon2DInput.hlsl"

            struct Attributes {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
                float3 positionWS : TEXCOORD1;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            Varyings vert(Attributes input) {
                Varyings output = (Varyings)0;

                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                output.positionCS = vertexInput.positionCS;
                output.positionWS = vertexInput.positionWS;
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color;

                return output;
            }

            half4 frag(Varyings input) : SV_Target {
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

                // Sample base texture
                half4 baseMap = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
                half4 baseColor = baseMap * _BaseColor * input.color;

                // Sample shade maps
                half4 firstShadeMap = _Use_BaseAs1st ? baseMap : SAMPLE_TEXTURE2D(_1st_ShadeMap, sampler_1st_ShadeMap, input.uv);
                half4 secondShadeMap = _Use_1stAs2nd ? firstShadeMap : SAMPLE_TEXTURE2D(_2nd_ShadeMap, sampler_2nd_ShadeMap, input.uv);

                // Calculate 2D lighting factor
                // For 2D, we use a simplified lighting model based on the main light direction
                Light mainLight = GetMainLight();
                half3 lightDir = normalize(mainLight.direction);
                
                // Create a pseudo-normal for 2D sprites (facing camera)
                half3 normal = half3(0, 0, 1);
                half NdotL = dot(normal, lightDir);
                
                // Apply 2D-specific lighting calculation
                half lightAttenuation = mainLight.distanceAttenuation * mainLight.shadowAttenuation;
                half lightIntensity = saturate(NdotL * 0.5 + 0.5) * lightAttenuation * _LightIntensity;
                
                // Toon shading steps
                half toonStep1 = smoothstep(_BaseColor_Step - _BaseShade_Feather, _BaseColor_Step + _BaseShade_Feather, lightIntensity);
                half toonStep2 = smoothstep(_1st_ShadeColor_Step - _1st_ShadeColor_Feather, _1st_ShadeColor_Step + _1st_ShadeColor_Feather, lightIntensity);
                half toonStep3 = smoothstep(_2nd_ShadeColor_Step - _2nd_ShadeColor_Feather, _2nd_ShadeColor_Step + _2nd_ShadeColor_Feather, lightIntensity);

                // Apply toon shading
                half3 finalColor = baseColor.rgb;
                
                // First shade
                half3 firstShadeColor = _1st_ShadeColor.rgb;
                if (_Is_LightColor_1st_Shade) {
                    firstShadeColor *= mainLight.color;
                }
                finalColor = lerp(firstShadeMap.rgb * firstShadeColor, finalColor, toonStep1);
                
                // Second shade
                half3 secondShadeColor = _2nd_ShadeColor.rgb;
                if (_Is_LightColor_2nd_Shade) {
                    secondShadeColor *= mainLight.color;
                }
                finalColor = lerp(secondShadeMap.rgb * secondShadeColor, finalColor, toonStep2);

                // Apply main light color to base if enabled
                if (_Is_LightColor_Base) {
                    finalColor *= mainLight.color;
                }

                // Highlight
                half4 highColorTex = SAMPLE_TEXTURE2D(_HighColor_Tex, sampler_HighColor_Tex, input.uv);
                half4 highColorMask = SAMPLE_TEXTURE2D(_Set_HighColorMask, sampler_Set_HighColorMask, input.uv);
                half highColorMaskLevel = saturate(highColorMask.g + _Tweak_HighColorMaskLevel);
                
                half3 highColor = _HighColor.rgb;
                if (_Is_LightColor_HighColor) {
                    highColor *= mainLight.color;
                }
                
                half highColorPower = pow(saturate(lightIntensity), _HighColor_Power * 10);
                half3 highColorResult = highColorTex.rgb * highColor * highColorPower * highColorMaskLevel;
                
                if (_Is_BlendAddToHiColor) {
                    finalColor += highColorResult;
                } else {
                    finalColor = lerp(finalColor, highColorResult, highColorPower * highColorMaskLevel);
                }

                // Rim Light (simplified for 2D)
                #ifdef _RIMLIGHT_ON
                half4 rimLightMask = SAMPLE_TEXTURE2D(_Set_RimLightMask, sampler_Set_RimLightMask, input.uv);
                half rimMaskLevel = saturate(rimLightMask.g + _Tweak_RimLightMaskLevel);
                
                // For 2D, rim light is based on UV coordinates from center
                half2 rimUV = input.uv - 0.5;
                half rimDistance = length(rimUV);
                half rimPower = 1.0 - smoothstep(_RimLight_InsideMask, _RimLight_Power, rimDistance);
                
                if (!_RimLight_FeatherOff) {
                    rimPower = smoothstep(0.0, 1.0, rimPower);
                }
                
                half3 rimLightColor = _RimLightColor.rgb;
                if (_Is_LightColor_RimLight) {
                    rimLightColor *= mainLight.color;
                }
                
                finalColor += rimLightColor * rimPower * rimMaskLevel;
                #endif

                // Emissive
                half4 emissiveTex = SAMPLE_TEXTURE2D(_Emissive_Tex, sampler_Emissive_Tex, input.uv);
                half3 emissiveColor = _Emissive_Color.rgb;
                
                #ifdef _EMISSIVE_ANIMATION
                // Animated emissive
                half time = _Time.y * _Base_Speed;
                half2 emissiveUV = input.uv;
                
                // Scrolling
                emissiveUV += half2(_Scroll_EmissiveU, _Scroll_EmissiveV) * time;
                
                // Rotation
                if (_Rotate_EmissiveUV != 0) {
                    half2 center = half2(0.5, 0.5);
                    half2 rotUV = emissiveUV - center;
                    half angle = _Rotate_EmissiveUV * time;
                    half cosA = cos(angle);
                    half sinA = sin(angle);
                    emissiveUV = half2(
                        rotUV.x * cosA - rotUV.y * sinA,
                        rotUV.x * sinA + rotUV.y * cosA
                    ) + center;
                }
                
                emissiveTex = SAMPLE_TEXTURE2D(_Emissive_Tex, sampler_Emissive_Tex, emissiveUV);
                
                if (_Is_PingPong_Base) {
                    emissiveColor *= (sin(time) * 0.5 + 0.5);
                }
                #endif
                
                finalColor += emissiveTex.rgb * emissiveColor;

                // Apply ambient lighting
                finalColor += _AmbientIntensity * unity_AmbientSky.rgb;

                // Alpha handling
                half alpha = baseColor.a;
                #ifdef _ALPHATEST_ON
                clip(alpha - _Cutoff);
                #endif

                #ifdef _ALPHAPREMULTIPLY_ON
                finalColor *= alpha;
                #endif

                return half4(finalColor, alpha);
            }
            ENDHLSL
        }

        // Shadow Caster Pass for 2D shadows
        Pass {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            #include "UnityToon2DInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }

        // Depth Only Pass
        Pass {
            Name "DepthOnly"
            Tags{"LightMode" = "DepthOnly"}

            ZWrite On
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            #pragma target 2.0

            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            #pragma shader_feature_local_fragment _ALPHATEST_ON

            #pragma multi_compile_instancing
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            #include "UnityToon2DInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/DepthOnlyPass.hlsl"
            ENDHLSL
        }
    }

    CustomEditor "UnityEditor.Rendering.Toon.UTS2D_GUI"
    Fallback "Sprites/Default"
}