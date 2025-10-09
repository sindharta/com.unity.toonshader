# Sample Installation Guide

The **Unity Toon Shader** package includes comprehensive sample scenes for all three render pipelines. These samples demonstrate various features and provide excellent starting points for your own projects.

## Prerequisites

Before installing samples:

1. **Install Unity Toon Shader**: Make sure the main package is installed ([Installation Guide](installation.md))
2. **Configure Render Pipeline**: Set up your chosen render pipeline before installing samples
3. **Unity Version**: Ensure you're using Unity 2021.3.19 or later

## Installation Steps

### Step 1: Open Package Manager
1. In Unity, go to `Window` → `Package Manager`
2. In the left panel, select **Unity Toon Shader**

### Step 2: Import Samples
1. In the right panel, you'll see available sample packages
2. Click **Import** next to the sample package for your render pipeline:
   - **Built-In Render Pipeline** samples
   - **Universal Render Pipeline** samples  
   - **High Definition Render Pipeline** samples

### Step 3: Configure Pipeline Assets
After importing samples, configure your project:

**For URP**: Set `UTS2URPPipelineAsset` as your Graphics Pipeline Asset
**For HDRP**: Set `HDRenderPipelineAsset_UTS` as your Graphics Pipeline Asset

To configure:
1. Go to `Edit` → `Project Settings`
2. Navigate to `Graphics`
3. Set the appropriate Pipeline Asset

## Sample Scenes Overview

### Universal Render Pipeline Samples
Located in: `Assets/Samples/Unity Toon Shader/[version]/Universal render pipeline/`

| Scene | Description | Features Demonstrated |
|-------|-------------|----------------------|
| **Sample/Sample.unity** | Basic introduction scene | Core cel-shading features |
| **ToonShader.unity** | Illustration-style shading | Advanced shading techniques |
| **ToonShader_CelLook.unity** | Classic cel-shading style | Traditional anime shading |
| **ToonShader_Emissive.unity** | Emission effects | [Emission](Emission.md) features |
| **ToonShader_Firefly.unity** | Multiple point lights | Point light interactions |
| **AngelRing/AngelRing.unity** | Angel Ring effects | [Angel Ring](AngelRing.md) projection |
| **Baked Normal/Cube_HardEdge.unity** | Baked normal reference | Normal mapping techniques |
| **BoxProjection/BoxProjection.unity** | Box projection lighting | Environment lighting |
| **EmissiveAnimation/EmisssiveAnimation.unity** | Animated emission | [Emission](Emission.md) animation |
| **LightAndShadows/LightAndShadows.unity** | PBR vs Toon comparison | Shader comparison |
| **MatCapMask/MatCapMask.unity** | MatCap masking | [MatCap](MatCap.md) masking |
| **Mirror/MirrorTest.unity** | Mirror reflections | Reflection handling |
| **NormalMap/NormalMap.unity** | Normal map techniques | [Normal mapping](NormalMap.md) |
| **PointLightTest/PointLightTest.unity** | Point light cel-shading | Point light shading |

### Built-in Render Pipeline Samples
Located in: `Assets/Samples/Unity Toon Shader/[version]/Legacy render pipeline/`

Contains similar scenes optimized for the Built-in Render Pipeline.

### High Definition Render Pipeline Samples  
Located in: `Assets/Samples/Unity Toon Shader/[version]/High definition render pipeline/`

Contains scenes showcasing HDRP-specific features like tessellation and advanced lighting.

## Using the Samples

### Learning Workflow
1. **Start with Basic**: Open `Sample/Sample.unity` to understand fundamentals
2. **Explore Styles**: Try `ToonShader.unity` and `ToonShader_CelLook.unity` for different approaches
3. **Study Features**: Open specific feature scenes (e.g., `ToonShader_Emissive.unity`)
4. **Compare Techniques**: Use `LightAndShadows.unity` to see PBR vs Toon differences

### Customization Tips
- **Materials**: Examine material settings in each scene
- **Lighting**: Study how different lighting setups affect the shader
- **Textures**: Look at texture setups and UV mapping
- **Parameters**: Experiment with shader parameters in real-time

## Troubleshooting

### Samples Don't Appear
- Ensure you've imported the correct sample package for your render pipeline
- Check that the main Unity Toon Shader package is installed
- Verify your Unity version compatibility

### Scenes Don't Load Properly
- Configure the correct Pipeline Asset (see Step 3 above)
- Check that your render pipeline is properly set up
- Ensure all required packages are installed

### Visual Issues in Samples
- Verify you're using Linear Color Space
- Check that your graphics settings are appropriate
- Ensure your hardware meets the minimum requirements

## Next Steps

After exploring the samples:

1. **Follow Tutorials**: Complete the [Getting Started Guide](GettingStarted.md)
2. **Read Documentation**: Study the [Parameter Settings](Parameter-Settings.md) reference
3. **Experiment**: Create your own materials using the samples as reference
4. **Join Community**: Visit the [GitHub repository](https://github.com/sindharta/com.unity.toonshader) for support

---

*Sample scenes are regularly updated with new features and improvements. Check for updates in the Package Manager.*