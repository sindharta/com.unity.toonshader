using UnityEngine;
using UnityEngine.Rendering;

namespace Unity.ToonShader2D.Samples
{
    /// <summary>
    /// Example script demonstrating how to control Toon Shader 2D parameters at runtime
    /// </summary>
    public class ToonShader2DController : MonoBehaviour
    {
        [Header("Target Renderer")]
        [SerializeField] private SpriteRenderer targetRenderer;
        
        [Header("Toon Shading Controls")]
        [Range(0f, 1f)]
        [SerializeField] private float baseColorStep = 0.8f;
        
        [Range(0f, 1f)]
        [SerializeField] private float firstShadeStep = 0.5f;
        
        [Range(0f, 1f)]
        [SerializeField] private float secondShadeStep = 0.2f;
        
        [Range(0.001f, 0.3f)]
        [SerializeField] private float feather = 0.05f;
        
        [Header("Colors")]
        [SerializeField] private Color baseColor = Color.white;
        [SerializeField] private Color firstShadeColor = new Color(0.8f, 0.8f, 0.9f, 1f);
        [SerializeField] private Color secondShadeColor = new Color(0.6f, 0.6f, 0.8f, 1f);
        
        [Header("Highlight")]
        [SerializeField] private Color highlightColor = Color.white;
        [Range(0f, 2f)]
        [SerializeField] private float highlightPower = 0.5f;
        
        [Header("Rim Light")]
        [SerializeField] private bool enableRimLight = true;
        [SerializeField] private Color rimLightColor = new Color(0.8f, 0.9f, 1f, 1f);
        [Range(0f, 1f)]
        [SerializeField] private float rimLightPower = 0.3f;
        
        [Header("Lighting")]
        [Range(0f, 2f)]
        [SerializeField] private float lightIntensity = 1f;
        [Range(0f, 1f)]
        [SerializeField] private float shadowIntensity = 0.5f;
        [Range(0f, 2f)]
        [SerializeField] private float ambientIntensity = 0.2f;
        
        [Header("Animation")]
        [SerializeField] private bool animateShading = false;
        [SerializeField] private float animationSpeed = 1f;
        
        private Material materialInstance;
        private float animationTime;
        
        // Shader property IDs for performance
        private static readonly int BaseColorStepID = Shader.PropertyToID("_BaseColor_Step");
        private static readonly int FirstShadeStepID = Shader.PropertyToID("_1st_ShadeColor_Step");
        private static readonly int SecondShadeStepID = Shader.PropertyToID("_2nd_ShadeColor_Step");
        private static readonly int FeatherID = Shader.PropertyToID("_BaseShade_Feather");
        private static readonly int BaseColorID = Shader.PropertyToID("_BaseColor");
        private static readonly int FirstShadeColorID = Shader.PropertyToID("_1st_ShadeColor");
        private static readonly int SecondShadeColorID = Shader.PropertyToID("_2nd_ShadeColor");
        private static readonly int HighlightColorID = Shader.PropertyToID("_HighColor");
        private static readonly int HighlightPowerID = Shader.PropertyToID("_HighColor_Power");
        private static readonly int RimLightColorID = Shader.PropertyToID("_RimLightColor");
        private static readonly int RimLightPowerID = Shader.PropertyToID("_RimLight_Power");
        private static readonly int RimLightToggleID = Shader.PropertyToID("_RimLight");
        private static readonly int LightIntensityID = Shader.PropertyToID("_LightIntensity");
        private static readonly int ShadowIntensityID = Shader.PropertyToID("_ShadowIntensity");
        private static readonly int AmbientIntensityID = Shader.PropertyToID("_AmbientIntensity");
        
        void Start()
        {
            // Get or create material instance
            if (targetRenderer == null)
                targetRenderer = GetComponent<SpriteRenderer>();
                
            if (targetRenderer != null)
            {
                materialInstance = targetRenderer.material;
                UpdateShaderProperties();
            }
        }
        
        void Update()
        {
            if (materialInstance == null) return;
            
            // Handle animation
            if (animateShading)
            {
                animationTime += Time.deltaTime * animationSpeed;
                AnimateShading();
            }
            
            // Update properties if changed in inspector
            UpdateShaderProperties();
        }
        
        void UpdateShaderProperties()
        {
            if (materialInstance == null) return;
            
            // Toon shading steps
            materialInstance.SetFloat(BaseColorStepID, baseColorStep);
            materialInstance.SetFloat(FirstShadeStepID, firstShadeStep);
            materialInstance.SetFloat(SecondShadeStepID, secondShadeStep);
            materialInstance.SetFloat(FeatherID, feather);
            
            // Colors
            materialInstance.SetColor(BaseColorID, baseColor);
            materialInstance.SetColor(FirstShadeColorID, firstShadeColor);
            materialInstance.SetColor(SecondShadeColorID, secondShadeColor);
            
            // Highlight
            materialInstance.SetColor(HighlightColorID, highlightColor);
            materialInstance.SetFloat(HighlightPowerID, highlightPower);
            
            // Rim light
            materialInstance.SetFloat(RimLightToggleID, enableRimLight ? 1f : 0f);
            materialInstance.SetColor(RimLightColorID, rimLightColor);
            materialInstance.SetFloat(RimLightPowerID, rimLightPower);
            
            // Lighting
            materialInstance.SetFloat(LightIntensityID, lightIntensity);
            materialInstance.SetFloat(ShadowIntensityID, shadowIntensity);
            materialInstance.SetFloat(AmbientIntensityID, ambientIntensity);
            
            // Update keywords
            if (enableRimLight)
                materialInstance.EnableKeyword("_RIMLIGHT_ON");
            else
                materialInstance.DisableKeyword("_RIMLIGHT_ON");
        }
        
        void AnimateShading()
        {
            // Example animation: pulse the shading steps
            float pulse = Mathf.Sin(animationTime) * 0.1f + 0.9f;
            materialInstance.SetFloat(BaseColorStepID, baseColorStep * pulse);
            
            // Animate rim light color
            Color animatedRimColor = rimLightColor;
            animatedRimColor.r = rimLightColor.r * (Mathf.Sin(animationTime * 2f) * 0.2f + 0.8f);
            materialInstance.SetColor(RimLightColorID, animatedRimColor);
        }
        
        /// <summary>
        /// Set toon shading parameters programmatically
        /// </summary>
        public void SetToonShading(float baseStep, float firstStep, float secondStep, float featherAmount)
        {
            baseColorStep = Mathf.Clamp01(baseStep);
            firstShadeStep = Mathf.Clamp01(firstStep);
            secondShadeStep = Mathf.Clamp01(secondStep);
            feather = Mathf.Clamp(featherAmount, 0.001f, 0.3f);
            
            UpdateShaderProperties();
        }
        
        /// <summary>
        /// Set lighting parameters programmatically
        /// </summary>
        public void SetLighting(float light, float shadow, float ambient)
        {
            lightIntensity = Mathf.Clamp(light, 0f, 2f);
            shadowIntensity = Mathf.Clamp01(shadow);
            ambientIntensity = Mathf.Clamp(ambient, 0f, 2f);
            
            UpdateShaderProperties();
        }
        
        /// <summary>
        /// Toggle rim light effect
        /// </summary>
        public void ToggleRimLight(bool enable)
        {
            enableRimLight = enable;
            UpdateShaderProperties();
        }
        
        /// <summary>
        /// Animate to target shading over time
        /// </summary>
        public void AnimateToShading(float targetBase, float targetFirst, float targetSecond, float duration)
        {
            StartCoroutine(AnimateToShadingCoroutine(targetBase, targetFirst, targetSecond, duration));
        }
        
        private System.Collections.IEnumerator AnimateToShadingCoroutine(float targetBase, float targetFirst, float targetSecond, float duration)
        {
            float startBase = baseColorStep;
            float startFirst = firstShadeStep;
            float startSecond = secondShadeStep;
            
            float elapsed = 0f;
            
            while (elapsed < duration)
            {
                elapsed += Time.deltaTime;
                float t = elapsed / duration;
                
                baseColorStep = Mathf.Lerp(startBase, targetBase, t);
                firstShadeStep = Mathf.Lerp(startFirst, targetFirst, t);
                secondShadeStep = Mathf.Lerp(startSecond, targetSecond, t);
                
                UpdateShaderProperties();
                yield return null;
            }
            
            // Ensure final values are set
            baseColorStep = targetBase;
            firstShadeStep = targetFirst;
            secondShadeStep = targetSecond;
            UpdateShaderProperties();
        }
        
        void OnDestroy()
        {
            // Clean up material instance if we created one
            if (materialInstance != null && materialInstance != targetRenderer.sharedMaterial)
            {
                if (Application.isPlaying)
                    Destroy(materialInstance);
                else
                    DestroyImmediate(materialInstance);
            }
        }
        
        void OnValidate()
        {
            // Update properties when values change in inspector
            if (Application.isPlaying && materialInstance != null)
            {
                UpdateShaderProperties();
            }
        }
    }
}