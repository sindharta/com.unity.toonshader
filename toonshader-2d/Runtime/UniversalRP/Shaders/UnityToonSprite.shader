//Unity Toon Shader for Sprites
//Optimized 2D toon shader for sprite rendering in URP
//Based on Unity Toon Shader by nobuyuki@unity3d.com and toshiyuki@unity3d.com

Shader "Toon/Sprite" {
    Properties {
        // Main texture and color
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        
        // Toon shading
        _1st_ShadeColor ("1st Shade Color", Color) = (0.8,0.8,0.8,1)
        _2nd_ShadeColor ("2nd Shade Color", Color) = (0.6,0.6,0.6,1)
        
        // Shading control
        _ShadingSteps ("Shading Steps", Range(1, 4)) = 2
        _BaseColor_Step ("Base Color Step", Range(0, 1)) = 0.8
        _1st_ShadeColor_Step ("1st Shade Step", Range(0, 1)) = 0.5
        _2nd_ShadeColor_Step ("2nd Shade Step", Range(0, 1)) = 0.2
        _Feather ("Feather", Range(0.001, 0.3)) = 0.05
        
        // Highlight
        _HighColor ("Highlight Color", Color) = (1,1,1,1)
        _HighColor_Power ("Highlight Power", Range(0, 2)) = 0.5
        _HighColor_Threshold ("Highlight Threshold", Range(0, 1)) = 0.8
        
        // Rim Light
        [Toggle(_RIMLIGHT_ON)] _RimLight ("Enable Rim Light", Float) = 0
        _RimLightColor ("Rim Light Color", Color) = (1,1,1,1)
        _RimLight_Power ("Rim Light Power", Range(0, 1)) = 0.2
        _RimLight_Threshold ("Rim Light Threshold", Range(0, 1)) = 0.5
        
        // Emissive
        [Toggle(_EMISSION)] _EnableEmission ("Enable Emission", Float) = 0
        [HDR] _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _EmissionMap ("Emission Map", 2D) = "white" {}
        
        // Animation
        [Toggle(_ANIMATED_EMISSION)] _AnimatedEmission ("Animated Emission", Float) = 0
        _EmissionSpeed ("Emission Speed", Float) = 1.0
        _EmissionPulse ("Emission Pulse", Range(0, 1)) = 0.5
        
        // 2D Lighting
        _LightInfluence ("Light Influence", Range(0, 1)) = 0.8
        _ShadowInfluence ("Shadow Influence", Range(0, 1)) = 0.6
        _AmbientInfluence ("Ambient Influence", Range(0, 1)) = 0.3
        
        // Render State
        [HideInInspector] _RendererColor ("RendererColor", Color) = (1,1,1,1)
        [HideInInspector] _Flip ("Flip", Vector) = (1,1,1,1)
        [HideInInspector] _AlphaTex ("External Alpha", 2D) = "white" {}
        [HideInInspector] _EnableExternalAlpha ("Enable External Alpha", Float) = 0
        
        // Stencil
        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
        
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader {
        Tags {
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
            "RenderPipeline" = "UniversalPipeline"
            "PreviewType" = "Plane"
            "CanUseSpriteAtlas" = "True"
        }

        Stencil {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend One OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass {
            Name "ToonSprite"
            Tags { "LightMode" = "Universal2D" }

            HLSLPROGRAM
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x

            #pragma vertex SpriteVert
            #pragma fragment SpriteFrag

            // Material Keywords
            #pragma shader_feature_local _ _RIMLIGHT_ON
            #pragma shader_feature_local _ _EMISSION
            #pragma shader_feature_local _ _ANIMATED_EMISSION
            #pragma multi_compile_local _ PIXELSNAP_ON
            #pragma multi_compile_local _ ETC1_EXTERNAL_ALPHA
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_0
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_1
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_2
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_3

            // Unity Keywords
            #pragma multi_compile_instancing
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            CBUFFER_START(UnityPerMaterial)
                half4 _Color;
                half4 _1st_ShadeColor;
                half4 _2nd_ShadeColor;
                half _ShadingSteps;
                half _BaseColor_Step;
                half _1st_ShadeColor_Step;
                half _2nd_ShadeColor_Step;
                half _Feather;
                half4 _HighColor;
                half _HighColor_Power;
                half _HighColor_Threshold;
                half4 _RimLightColor;
                half _RimLight_Power;
                half _RimLight_Threshold;
                half4 _EmissionColor;
                half _EmissionSpeed;
                half _EmissionPulse;
                half _LightInfluence;
                half _ShadowInfluence;
                half _AmbientInfluence;
                half4 _RendererColor;
                half4 _Flip;
                float4 _MainTex_ST;
                float4 _EmissionMap_ST;
            CBUFFER_END

            TEXTURE2D(_MainTex);        SAMPLER(sampler_MainTex);
            TEXTURE2D(_AlphaTex);       SAMPLER(sampler_AlphaTex);
            TEXTURE2D(_EmissionMap);    SAMPLER(sampler_EmissionMap);

            struct Attributes {
                float4 positionOS : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings {
                float4 positionCS : SV_POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            Varyings SpriteVert(Attributes input) {
                Varyings output = (Varyings)0;

                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                output.positionCS = vertexInput.positionCS;
                output.positionWS = vertexInput.positionWS;

                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color * _Color * _RendererColor;

                #ifdef PIXELSNAP_ON
                output.positionCS = UnityPixelSnap(output.positionCS);
                #endif

                return output;
            }

            half4 SpriteFrag(Varyings input) : SV_Target {
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

                // Sample main texture
                half4 texColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);

                #if ETC1_EXTERNAL_ALPHA
                half4 alpha = SAMPLE_TEXTURE2D(_AlphaTex, sampler_AlphaTex, input.uv);
                texColor.a = lerp(texColor.a, alpha.r, _EnableExternalAlpha);
                #endif

                // Apply vertex color
                texColor *= input.color;

                // Calculate 2D lighting
                Light mainLight = GetMainLight();
                half3 lightColor = mainLight.color;
                half lightAttenuation = mainLight.distanceAttenuation;
                
                // Simple 2D lighting calculation
                // For sprites, we assume they face the camera (normal = (0,0,1))
                half3 lightDir = normalize(mainLight.direction);
                half lightInfluence = saturate(dot(half3(0,0,1), lightDir) * 0.5 + 0.5);
                lightInfluence *= lightAttenuation * _LightInfluence;

                // Toon shading steps
                half3 baseColor = texColor.rgb;
                half3 finalColor = baseColor;

                // Apply toon shading based on light influence
                if (_ShadingSteps >= 2) {
                    // First shade
                    half step1 = smoothstep(_1st_ShadeColor_Step - _Feather, _1st_ShadeColor_Step + _Feather, lightInfluence);
                    half3 shade1Color = baseColor * _1st_ShadeColor.rgb;
                    finalColor = lerp(shade1Color, finalColor, step1);
                }

                if (_ShadingSteps >= 3) {
                    // Second shade
                    half step2 = smoothstep(_2nd_ShadeColor_Step - _Feather, _2nd_ShadeColor_Step + _Feather, lightInfluence);
                    half3 shade2Color = baseColor * _2nd_ShadeColor.rgb;
                    finalColor = lerp(shade2Color, finalColor, step2);
                }

                // Apply light color influence
                finalColor = lerp(finalColor, finalColor * lightColor, _LightInfluence);

                // Highlight
                half highlightMask = smoothstep(_HighColor_Threshold - 0.1, _HighColor_Threshold + 0.1, lightInfluence);
                half3 highlight = _HighColor.rgb * _HighColor_Power * highlightMask;
                finalColor += highlight;

                // Rim Light
                #ifdef _RIMLIGHT_ON
                // For 2D sprites, rim light is based on UV distance from edges
                half2 rimUV = abs(input.uv - 0.5) * 2.0;
                half rimMask = max(rimUV.x, rimUV.y);
                rimMask = smoothstep(_RimLight_Threshold, 1.0, rimMask);
                half3 rimLight = _RimLightColor.rgb * _RimLight_Power * rimMask;
                finalColor += rimLight;
                #endif

                // Emission
                #ifdef _EMISSION
                half4 emission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, input.uv);
                half3 emissionColor = emission.rgb * _EmissionColor.rgb;
                
                #ifdef _ANIMATED_EMISSION
                half time = _Time.y * _EmissionSpeed;
                half pulse = sin(time) * _EmissionPulse + (1.0 - _EmissionPulse);
                emissionColor *= pulse;
                #endif
                
                finalColor += emissionColor;
                #endif

                // Apply ambient lighting
                finalColor += unity_AmbientSky.rgb * _AmbientInfluence;

                // Final color
                texColor.rgb = finalColor;

                #ifdef UNITY_UI_ALPHACLIP
                clip(texColor.a - 0.001);
                #endif

                // Premultiply alpha
                texColor.rgb *= texColor.a;

                return texColor;
            }
            ENDHLSL
        }
    }

    CustomEditor "UnityEditor.Rendering.Toon.ToonSpriteShaderGUI"
    Fallback "Sprites/Default"
}