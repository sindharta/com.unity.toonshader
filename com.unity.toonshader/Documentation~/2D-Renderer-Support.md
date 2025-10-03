# Unity Toon Shader - 2D Renderer Support

## Overview

The Unity Toon Shader package now supports the 2D Renderer in Universal Render Pipeline (URP) projects. This enables you to use toon shading effects on sprites, 2D graphics, and other 2D elements in your URP 2D games.

## Features

The 2D Renderer implementation includes the following toon shader features:

### Core Shading Features
- **Multi-Step Toon Shading**: Base color, 1st shade, and 2nd shade colors with customizable steps and feathering
- **2D Light Support**: Full integration with URP 2D lights (Global, Freeform, Sprite, Point, and Directional)
- **Additional Lights**: Support for multiple 2D lights with proper toon shading
- **Shadows**: Shadow receiving from 2D lights with toon-style shadow rendering
- **Normal Mapping**: Optional normal maps for enhanced lighting detail

### Visual Effects
- **Rim Light**: Fresnel-style rim lighting with customizable power and color
  - Standard rim light
  - Antipodean (inverted) rim light
  - Light color influence
  
- **High Color/Specular**: Toon-style specular highlights
  - Specular or toon-style modes
  - Customizable intensity and color
  - Light color influence

- **Emissive**: Self-illumination effects
  - Simple emissive mode
  - Animated emissive with scrolling and color shifting

- **Outline**: Toon-style outlines rendered in 2D space
  - Normal-based or position-based outline methods
  - Distance-based outline width scaling
  - Outline texture support
  - Blend with base color option

### Additional Features
- **Alpha Clipping**: For transparent sprites with sharp edges
- **Alpha Blending**: Smooth transparency support
- **GI/Ambient Light**: Scene ambient light integration
- **Unlit Intensity**: For scenes without lights
- **GPU Instancing**: Performance optimization for multiple instances
- **Stencil Support**: For masking and special effects

## Setup

### Requirements
- Unity 2021.3 or higher
- Universal Render Pipeline (URP) 10.5.0 or higher
- 2D Renderer asset configured in your URP settings

### Configuring 2D Renderer

1. **Create or Configure URP Asset**:
   - If you don't have a URP asset, create one via `Assets > Create > Rendering > URP Asset (with 2D Renderer)`
   - Assign it in `Project Settings > Graphics > Scriptable Render Pipeline Settings`

2. **Set up 2D Renderer**:
   - In your URP asset, ensure the renderer is set to use 2D Renderer
   - Configure 2D lighting settings as needed

3. **Add 2D Lights**:
   - Add 2D lights to your scene: `GameObject > Light > 2D > [Light Type]`
   - Configure light intensity, color, and falloff

### Using the Toon Shader on 2D Objects

1. **Create a Material**:
   - Create a new material: `Assets > Create > Material`
   - Assign the shader: Select `Toon` shader from the dropdown

2. **Apply to Sprite Renderer**:
   - Select your sprite GameObject
   - Assign the material to the Sprite Renderer component
   - The shader will automatically work with 2D lights

3. **Configure Toon Settings**:
   - Adjust Base Color, 1st Shade, and 2nd Shade colors
   - Set shading steps and feathering for desired toon look
   - Enable and configure rim light, specular, outlines as needed

## Parameters

### Base Colors
- **BaseMap**: Main texture/sprite texture
- **BaseColor**: Color tint for the base (lit) areas
- **1st_ShadeColor**: Color for first shadow step
- **2nd_ShadeColor**: Color for deepest shadow step
- **Use_BaseAs1st**: Use base texture for 1st shade
- **Use_1stAs2nd**: Use 1st shade for 2nd shade

### Shading Steps
- **BaseColor_Step**: Threshold for base to 1st shade transition (0-1)
- **BaseShade_Feather**: Smoothness of base to 1st shade transition
- **ShadeColor_Step**: Threshold for 1st to 2nd shade transition (0-1)
- **1st2nd_Shades_Feather**: Smoothness of 1st to 2nd shade transition

### Lighting
- **Is_LightColor_Base**: Enable light color influence on base color
- **Is_LightColor_1st_Shade**: Enable light color influence on 1st shade
- **Is_LightColor_2nd_Shade**: Enable light color influence on 2nd shade
- **GI_Intensity**: Ambient/GI light intensity (0-1)
- **Unlit_Intensity**: Base lighting when no lights present (0-4)

### Rim Light
- **RimLight**: Enable rim lighting
- **RimLightColor**: Color of the rim light
- **RimLight_Power**: Intensity/width of rim light (0-1)
- **RimLight_InsideMask**: Inner cutoff for rim light (0-1)
- **Add_Antipodean_RimLight**: Enable inverted rim light
- **Ap_RimLightColor**: Color of antipodean rim light

### High Color (Specular)
- **HighColor**: Specular/highlight color
- **HighColor_Power**: Specular intensity (0-1)
- **Is_SpecularToHighColor**: Use specular calculation vs toon style
- **Is_BlendAddToHiColor**: Additive blending for highlight

### Outline
- **Outline_Width**: Width of the outline
- **Outline_Color**: Color of the outline
- **Farthest_Distance**: Distance where outline reaches maximum width
- **Nearest_Distance**: Distance where outline starts scaling
- **Is_BlendBaseColor**: Blend outline with base texture color
- **Is_LightColor_Outline**: Apply light color to outline

### Emissive
- **Emissive_Tex**: Emissive texture/mask
- **Emissive_Color**: Emissive color and intensity (HDR)
- **Scroll_EmissiveU/V**: UV scrolling speed for animation
- **Base_Speed**: Animation speed multiplier

## Workflow Tips

### For Sprites and 2D Characters
1. Start with a simple setup: configure BaseColor, 1st_ShadeColor, and 2nd_ShadeColor
2. Adjust BaseColor_Step to control where shadows appear (typically 0.4-0.6)
3. Add feathering for softer transitions or keep low for hard cel-shaded look
4. Enable rim light for character outlines/highlights (power around 0.1-0.3)
5. Add outline for traditional toon look (width 0.01-0.05)

### For 2D Environments
1. Use higher GI_Intensity for ambient-lit look (0.3-0.8)
2. Use multiple shade steps to create depth without harsh shadows
3. Consider using MatCap for stylized environment lighting
4. Disable outlines for a cleaner look on tiles/backgrounds

### For Sprites with Lights
1. Position 2D lights to highlight key areas
2. Use colored lights for dramatic toon shading effects
3. Adjust shading steps to match your light intensity
4. Consider using light color influence on shades for dynamic coloring

### Performance Optimization
1. Disable unused features (rim light, specular, etc.)
2. Use texture atlasing for sprites with same material
3. Enable GPU instancing for repeated sprites
4. Reduce additional lights count if not needed

## Differences from 3D Renderer

The 2D renderer implementation differs from the 3D version in the following ways:

1. **Lighting Model**: Uses 2D light data instead of 3D directional lights
2. **Normal Handling**: Simplified normal calculations optimized for 2D sprites
3. **Outline Rendering**: Outlines are rendered in screen space for consistent width
4. **Shadow Receiving**: Uses 2D shadow maps instead of 3D shadow cascades
5. **MatCap**: 2D-optimized view-space calculations
6. **Performance**: Optimized for 2D sprite rendering pipelines

## Troubleshooting

### Shader not appearing on sprites
- Ensure you're using a 2D Renderer in your URP asset
- Check that the material is assigned to the Sprite Renderer, not a 3D Mesh Renderer
- Verify the shader compiles without errors in the Console

### No lighting/shading visible
- Add 2D lights to your scene (`GameObject > Light > 2D`)
- Ensure lights have intensity > 0
- Check that "Is_LightColor_Base" or similar options are enabled
- Try increasing Unlit_Intensity temporarily to verify the shader is working

### Outlines not showing
- Ensure Outline_Width is greater than 0
- Check that the outline color has visible alpha
- Verify the outline pass is not being culled by your camera settings
- The outline may be very thin - try increasing Outline_Width to 0.1 for testing

### Performance issues
- Disable unused features in the material
- Reduce the number of 2D lights affecting each sprite
- Enable GPU instancing for repeated sprites
- Consider using simpler shading (fewer steps/features)

### Sprite appears incorrect in Scene view but correct in Game view
- This is expected behavior - 2D lights only affect Game view rendering
- Scene view uses simplified lighting for editing
- Always test in Game view or with "Always Refresh" enabled

## Examples

Example materials and scenes for 2D renderer usage can be found in the URP samples (if available) or created using the guidelines above.

### Basic Toon Sprite Setup
```
Material Settings:
- BaseColor: White (or character color)
- 1st_ShadeColor: Darker version of base (e.g., 0.6, 0.6, 0.6)
- 2nd_ShadeColor: Even darker (e.g., 0.3, 0.3, 0.3)
- BaseColor_Step: 0.5
- BaseShade_Feather: 0.01 (hard edge) or 0.1 (soft)
- RimLight: Enabled
- RimLight_Power: 0.2
- RimLightColor: Light blue or white
- Outline_Width: 0.02
- Outline_Color: Dark blue or black
```

## Known Limitations

1. **Tessellation**: Not supported in 2D renderer
2. **Some 3D features**: Features like angel ring may behave differently in 2D
3. **Z-fighting**: Outline rendering may cause z-fighting in some cases - adjust Offset_Z if needed
4. **Normal maps**: Work but may need careful setup for 2D sprites

## Future Enhancements

Potential future additions to 2D renderer support:
- Sprite shape support
- Tile map specific optimizations
- 2D shadow casting for toon elements
- Additional 2D-specific effects

## Support

For issues, questions, or feature requests related to 2D renderer support:
- Check the main documentation for general shader usage
- Review URP 2D Renderer documentation
- Report issues on the GitHub repository

---

**Note**: The 2D renderer support is designed to work seamlessly with Unity's URP 2D Renderer. For best results, ensure your project is properly configured for 2D rendering with URP.
