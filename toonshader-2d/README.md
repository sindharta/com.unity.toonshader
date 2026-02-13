# Unity Toon Shader 2D

A specialized 2D version of the Unity Toon Shader, optimized for the Universal Render Pipeline (URP) 2D Renderer.

## Overview

This package provides toon shading capabilities specifically designed for 2D sprites and graphics in Unity's URP 2D Renderer. It's derived from the original Unity Toon Shader but adapted to work efficiently with 2D rendering workflows.

## Features

### Core Toon Shading
- **Multi-step toon shading**: Support for base color, 1st shade, and 2nd shade with customizable steps
- **Feathering control**: Smooth transitions between shading steps
- **Light influence**: Configurable response to 2D lighting

### Visual Effects
- **Rim Lighting**: Edge lighting effects optimized for 2D sprites
- **Highlights**: Specular-like highlights with customizable power and threshold
- **Emission**: Both static and animated emission with scrolling and pulsing effects

### 2D Optimizations
- **Sprite compatibility**: Works with Unity's sprite system and atlases
- **2D lighting integration**: Properly responds to URP 2D lights
- **Performance optimized**: Simplified calculations for 2D rendering
- **UI compatible**: Can be used with UI elements

## Shaders Included

### 1. Toon/2D
The main 2D toon shader with full feature set:
- Multi-step toon shading
- Rim lighting
- Highlights
- Animated emission
- 2D lighting integration

**Usage**: Best for general 2D sprites and graphics that need full toon shading features.

### 2. Toon/Sprite
Optimized sprite shader with essential toon features:
- Simplified toon shading
- Sprite-specific optimizations
- UI compatibility
- External alpha support

**Usage**: Ideal for sprites in games, UI elements, and performance-critical scenarios.

## Key Differences from 3D Version

### Lighting Model
- **Simplified lighting**: Uses 2D-appropriate lighting calculations
- **No normal mapping**: Assumes sprites face the camera
- **2D light integration**: Works with URP 2D light types

### Removed Features
- **3D-specific effects**: MatCap, complex normal mapping, tessellation
- **Outline rendering**: Not typically needed for 2D sprites
- **Complex shadow mapping**: Uses simplified 2D shadow approach

### Added Features
- **Sprite compatibility**: Built-in support for sprite rendering
- **UV-based rim lighting**: Rim effects based on sprite edges
- **2D animation support**: Optimized for 2D animation workflows

## Installation

1. Copy the package to your project's `Packages` folder
2. Or install via Package Manager using the package.json file
3. Ensure you're using URP with 2D Renderer

## Usage

### Basic Setup
1. Create a material using one of the toon 2D shaders
2. Assign your sprite texture to the Main Tex slot
3. Configure toon shading parameters:
   - **Base Color Step**: Controls where first shading step occurs
   - **1st Shade Color**: Color for first shadow level
   - **2nd Shade Color**: Color for deeper shadows
   - **Feather**: Controls softness of transitions

### Advanced Features

#### Rim Lighting
1. Enable "RimLight" toggle
2. Set **Rim Light Color** and **Rim Light Power**
3. Adjust **Rim Light Threshold** for edge detection

#### Highlights
1. Configure **High Color** and **High Color Power**
2. Set **High Color Threshold** to control where highlights appear

#### Animated Emission
1. Set **EMISSIVE** mode to "ANIMATION"
2. Configure scrolling with **Scroll Emissive U/V**
3. Add rotation with **Rotate Emissive UV**
4. Enable pulsing with **Is PingPong Base**

### 2D Lighting Integration
- **Light Intensity**: Controls how much 2D lights affect the shader
- **Shadow Intensity**: Controls shadow strength from 2D shadow casters
- **Ambient Intensity**: Controls ambient light contribution

## Performance Considerations

### Optimization Tips
1. Use the **Toon/Sprite** shader for simple sprites
2. Disable unused features (rim light, emission) when not needed
3. Use texture atlases to reduce draw calls
4. Consider LOD for distant sprites

### Mobile Optimization
- The shaders are designed to work on mobile platforms
- Use lower precision settings when possible
- Minimize texture samples for better performance

## Compatibility

### Unity Versions
- Unity 2021.3 or later
- Universal Render Pipeline 10.0.0 or later

### Platforms
- All platforms supported by URP
- Optimized for mobile and desktop
- WebGL compatible

## Migration from 3D Version

If you're converting from the 3D Unity Toon Shader:

1. **Materials**: Create new materials with 2D shaders
2. **Textures**: Main textures can be reused
3. **Parameters**: Most toon parameters have equivalent 2D versions
4. **Lighting**: Adjust lighting parameters for 2D setup

### Parameter Mapping
- `_BaseColor_Step` → Same in 2D version
- `_1st_ShadeColor` → Same in 2D version
- `_RimLight_Power` → Adapted for UV-based calculation
- `_HighColor_Power` → Same functionality, 2D optimized

## Troubleshooting

### Common Issues

**Shader not appearing in 2D renderer**
- Ensure you're using URP with 2D Renderer enabled
- Check that the shader is in the correct "Universal2D" pass

**Lighting not working**
- Verify 2D lights are set up correctly
- Check Light Intensity parameter
- Ensure sprites have proper sorting layers

**Performance issues**
- Use simpler Toon/Sprite shader for basic needs
- Disable unused features
- Check texture sizes and compression

## Examples and Samples

The package includes sample materials and scenes demonstrating:
- Basic toon shading setup
- Rim lighting effects
- Animated emission
- Integration with 2D lighting
- UI usage examples

## License

This package is based on the Unity Toon Shader and follows the same licensing terms.

## Credits

- Original Unity Toon Shader: nobuyuki@unity3d.com, toshiyuki@unity3d.com
- 2D Adaptation: Converted for URP 2D Renderer compatibility

## Support

For issues and questions:
1. Check the troubleshooting section
2. Review Unity's URP 2D documentation
3. Refer to the original Unity Toon Shader documentation for core concepts