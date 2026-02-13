# Unity Toon Shader 3D to 2D Conversion Notes

This document outlines the conversion process from the 3D Unity Toon Shader to the 2D version optimized for URP 2D Renderer.

## Conversion Overview

The original Unity Toon Shader was designed for 3D rendering with complex lighting models, normal mapping, and various 3D-specific effects. This 2D version maintains the core toon shading aesthetic while optimizing for 2D sprite rendering.

## Key Changes Made

### 1. Lighting Model Simplification

**Original 3D Approach:**
- Complex normal mapping calculations
- Multiple light types (directional, point, spot)
- Shadow mapping with cascades
- View-dependent effects

**2D Adaptation:**
- Simplified lighting assuming sprites face camera (normal = (0,0,1))
- Focus on main directional light
- 2D shadow system integration
- UV-based effects instead of view-dependent

### 2. Removed 3D-Specific Features

**MatCap (Sphere Mapping):**
- Not applicable to 2D sprites
- Replaced with simpler highlight system

**Outline Rendering:**
- Complex 3D outline passes removed
- 2D sprites typically don't need outline rendering
- Can be achieved through sprite effects if needed

**Tessellation:**
- Not relevant for 2D sprite rendering
- Removed all tessellation-related code

**Complex Normal Mapping:**
- 2D sprites don't typically use normal maps
- Simplified to flat normal assumption

### 3. Added 2D-Specific Features

**Sprite Compatibility:**
- Support for Unity's sprite system
- Proper handling of sprite atlases
- Vertex color support for sprite tinting

**UV-Based Rim Lighting:**
- Rim effects calculated from sprite edges
- Uses UV coordinates instead of view angles
- More predictable for 2D artwork

**2D Animation Support:**
- Optimized for 2D animation workflows
- Reduced per-frame calculations
- Better performance for animated sprites

### 4. Shader Structure Changes

**Pass Reduction:**
```hlsl
// Original 3D shader had multiple passes:
// - ForwardLit (complex lighting)
// - Outline (geometry-based outline)
// - ShadowCaster (complex shadow mapping)
// - DepthOnly
// - DepthNormals
// - Universal2D (basic fallback)

// 2D version focuses on:
// - Universal2D (main toon shading)
// - ShadowCaster (simplified)
// - DepthOnly (simplified)
```

**Vertex Shader Simplification:**
```hlsl
// 3D version calculated:
// - World space positions
// - Tangent space matrices
// - Multiple texture coordinates
// - Complex lighting vectors

// 2D version calculates:
// - Screen space positions
// - Simple UV coordinates
// - Vertex colors
// - Basic world positions for lighting
```

**Fragment Shader Optimization:**
```hlsl
// 3D version:
// - Complex BRDF calculations
// - Multiple texture samples
// - Normal mapping
// - View-dependent effects

// 2D version:
// - Simplified toon steps
// - Essential texture samples
// - UV-based effects
// - Performance-optimized calculations
```

## Feature Mapping

### Core Toon Shading
| 3D Feature | 2D Equivalent | Notes |
|------------|---------------|-------|
| Base Color | Base Color | Same functionality |
| 1st Shade | 1st Shade | Simplified lighting calculation |
| 2nd Shade | 2nd Shade | Simplified lighting calculation |
| Shading Steps | Shading Steps | Same parameter control |
| Feathering | Feathering | Same smoothing approach |

### Lighting Effects
| 3D Feature | 2D Equivalent | Notes |
|------------|---------------|-------|
| High Color | Highlight | Simplified specular-like effect |
| Rim Light | Rim Light | UV-based instead of view-based |
| MatCap | Removed | Not applicable to 2D |
| Angel Ring | Removed | 3D-specific effect |

### Material Properties
| 3D Feature | 2D Equivalent | Notes |
|------------|---------------|-------|
| Normal Map | Removed | Assumes flat sprites |
| Metallic/Smoothness | Removed | Not needed for toon 2D |
| Occlusion | Removed | Simplified ambient |
| Emission | Emission | Enhanced with 2D animations |

## Performance Optimizations

### Reduced Calculations
1. **No Normal Mapping**: Eliminates tangent space calculations
2. **Simplified Lighting**: Single light source focus
3. **Fewer Texture Samples**: Only essential textures
4. **No Complex BRDF**: Direct toon step calculations

### Mobile Optimizations
1. **Lower Precision**: Uses `half` precision where possible
2. **Reduced Branching**: Simplified conditional logic
3. **Texture Compression**: Optimized for mobile formats
4. **Batching Friendly**: Reduced state changes

## Usage Differences

### Material Setup
**3D Version:**
```
- Main Tex (albedo)
- Normal Map
- 1st Shade Map
- 2nd Shade Map
- High Color Tex
- MatCap Sampler
- Rim Light Mask
- Outline settings
```

**2D Version:**
```
- Main Tex (sprite)
- 1st Shade Map (optional)
- 2nd Shade Map (optional)
- High Color Tex (optional)
- Rim Light Mask (optional)
- Emission Map (optional)
```

### Parameter Differences
**New 2D Parameters:**
- `Light Intensity`: Controls 2D light influence
- `Shadow Intensity`: Controls 2D shadow strength
- `Ambient Intensity`: Controls ambient contribution

**Removed 3D Parameters:**
- Normal map settings
- MatCap parameters
- Outline width/distance
- Tessellation settings

## Integration with URP 2D

### 2D Renderer Compatibility
- Uses "Universal2D" LightMode
- Integrates with 2D light types
- Supports 2D shadow casters
- Compatible with sprite sorting

### 2D Lighting System
- Responds to 2D directional lights
- Works with 2D point lights
- Supports 2D shadow mapping
- Integrates with 2D global lighting

## Best Practices for 2D Usage

### Performance
1. Use the simpler "Toon/Sprite" shader for basic sprites
2. Disable unused features (rim light, emission)
3. Use texture atlases to reduce draw calls
4. Consider LOD for background elements

### Visual Quality
1. Design sprites with toon shading in mind
2. Use consistent lighting direction across scenes
3. Test with different 2D light setups
4. Consider sprite pivot points for rim lighting

### Workflow Integration
1. Works with sprite packer
2. Compatible with 2D animation systems
3. Supports UI rendering
4. Integrates with 2D physics visualization

## Future Enhancements

### Potential Additions
1. **2D Normal Maps**: For sprites with depth
2. **Parallax Scrolling**: For background layers
3. **Wind Effects**: For foliage sprites
4. **Dissolve Effects**: For special effects

### Performance Improvements
1. **Shader Variants**: More granular feature control
2. **Compute Shaders**: For complex animations
3. **GPU Instancing**: For particle-like sprites
4. **Texture Streaming**: For large sprite atlases

## Conclusion

The 2D conversion maintains the visual quality and flexibility of the original Unity Toon Shader while providing significant performance improvements and better integration with Unity's 2D rendering pipeline. The simplified approach makes it more accessible for 2D artists and developers while preserving the essential toon shading characteristics that make the original shader popular.