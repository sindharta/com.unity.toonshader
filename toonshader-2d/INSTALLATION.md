# Installation Guide - Unity Toon Shader 2D

## Quick Installation

### Method 1: Package Manager (Recommended)
1. Open Unity Package Manager (`Window > Package Manager`)
2. Click the `+` button in the top-left corner
3. Select `Add package from disk...`
4. Navigate to the `package.json` file in this directory
5. Click `Open`

### Method 2: Manual Installation
1. Copy the entire `toonshader-2d` folder to your project's `Packages` directory
2. Unity will automatically detect and import the package

## Prerequisites

### Unity Version
- **Minimum**: Unity 2021.3 LTS
- **Recommended**: Unity 2022.3 LTS or later

### Render Pipeline
- **Required**: Universal Render Pipeline (URP) 10.0.0 or later
- **Recommended**: URP 12.0.0 or later for best compatibility

### 2D Renderer Setup
1. Open your URP Asset (usually in `Assets/Settings`)
2. In the Inspector, find the `Renderer List`
3. Ensure you have a 2D Renderer assigned
4. If not, create one: `Assets > Create > Rendering > URP 2D Renderer`

## Post-Installation Setup

### 1. Configure Project Settings
```
Edit > Project Settings > Graphics
- Scriptable Render Pipeline Settings: [Your URP Asset]

Edit > Project Settings > Quality
- Render Pipeline Asset: [Your URP Asset]
```

### 2. Set Up 2D Renderer
```
Window > Rendering > Render Pipeline Converter
- Convert Built-in Materials to URP (if needed)
- Convert 2D Lights to URP 2D Lights
```

### 3. Verify Installation
1. Create a new Material
2. Set Shader to `Toon/2D` or `Toon/Sprite`
3. If shaders appear in the list, installation is successful

## First Usage

### Creating Your First Toon 2D Material

1. **Create Material**:
   ```
   Assets > Create > Material
   Name: MyToon2DMaterial
   ```

2. **Assign Shader**:
   ```
   Inspector > Shader dropdown > Toon > 2D
   ```

3. **Configure Basic Settings**:
   ```
   Main Tex: [Your sprite texture]
   Base Color: White (1,1,1,1)
   1st Shade Color: Light Gray (0.8,0.8,0.9,1)
   2nd Shade Color: Dark Gray (0.6,0.6,0.8,1)
   ```

4. **Adjust Toon Steps**:
   ```
   Base Color Step: 0.8
   1st Shade Color Step: 0.5
   2nd Shade Color Step: 0.2
   Feather: 0.05
   ```

### Applying to Sprites

1. **For Sprite Renderers**:
   ```
   Select your GameObject with SpriteRenderer
   Inspector > Materials > Element 0: [Your Toon Material]
   ```

2. **For UI Images**:
   ```
   Select your UI Image
   Inspector > Material: [Your Toon Material]
   ```

## Sample Content

### Import Samples
1. Open Package Manager
2. Find "Unity Toon Shader 2D" in the list
3. Expand "Samples" section
4. Click "Import" next to "2D Toon Shader Samples"

### Sample Materials
- `SampleToon2D.mat` - Full-featured 2D toon material
- `SampleToonSprite.mat` - Optimized sprite material

### Sample Scripts
- `ToonShader2DController.cs` - Runtime parameter control example

## Troubleshooting

### Shaders Not Appearing
**Problem**: Toon shaders don't appear in shader dropdown
**Solution**: 
1. Ensure URP is properly configured
2. Check Unity version compatibility
3. Reimport the package (`Right-click package > Reimport`)

### Pink Materials
**Problem**: Materials appear pink/magenta
**Solution**:
1. Verify URP Asset is assigned in Graphics Settings
2. Check that 2D Renderer is configured
3. Ensure shader compilation completed (check Console for errors)

### Performance Issues
**Problem**: Low framerate with toon shaders
**Solution**:
1. Use `Toon/Sprite` shader for simple sprites
2. Disable unused features (rim light, emission)
3. Check texture sizes and compression settings
4. Use texture atlases to reduce draw calls

### Lighting Not Working
**Problem**: Toon shading not responding to lights
**Solution**:
1. Ensure you're using URP 2D lights
2. Check Light Intensity parameter in material
3. Verify 2D Renderer is active
4. Check light layer masks

### Mobile Performance
**Problem**: Poor performance on mobile devices
**Solution**:
1. Use `Toon/Sprite` shader variant
2. Reduce texture resolution
3. Enable texture compression
4. Disable complex features for distant objects

## Advanced Configuration

### Custom Shader Variants
To create custom variants with specific features:

1. **Duplicate Shader**:
   ```
   Copy UnityToon2D.shader
   Rename to your custom name
   ```

2. **Remove Unused Features**:
   ```hlsl
   // Comment out unused #pragma shader_feature lines
   // Remove corresponding code sections
   ```

3. **Optimize for Your Use Case**:
   ```hlsl
   // Adjust precision (half vs float)
   // Remove unused texture samples
   // Simplify calculations
   ```

### Integration with Other Systems

#### Animation Systems
```csharp
// Example: Animate toon parameters
var controller = GetComponent<ToonShader2DController>();
controller.AnimateToShading(0.9f, 0.6f, 0.3f, 2.0f);
```

#### Particle Systems
```csharp
// Use toon materials with particle systems
var particleRenderer = GetComponent<ParticleSystemRenderer>();
particleRenderer.material = toonMaterial;
```

## Best Practices

### Performance
1. **Batch Similar Materials**: Use texture atlases
2. **LOD System**: Switch to simpler shaders for distant objects
3. **Feature Toggles**: Disable unused features per material
4. **Mobile Optimization**: Use half precision where possible

### Visual Quality
1. **Consistent Lighting**: Use similar light setups across scenes
2. **Color Harmony**: Choose complementary shade colors
3. **Feather Values**: Use consistent feathering for style coherence
4. **Testing**: Test on target platforms early

### Workflow
1. **Material Libraries**: Create reusable material presets
2. **Version Control**: Include .meta files for proper references
3. **Documentation**: Document custom parameter combinations
4. **Team Standards**: Establish naming conventions

## Support Resources

### Documentation
- `README.md` - Complete usage guide
- `CONVERSION_NOTES.md` - Technical conversion details
- `CHANGELOG.md` - Version history

### Unity Resources
- [URP Documentation](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest)
- [2D Renderer Guide](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/manual/2d-index.html)
- [Shader Graph Documentation](https://docs.unity3d.com/Packages/com.unity.shadergraph@latest)

### Community
- Unity Forums - URP Section
- Unity Discord - 2D Channel
- GitHub Issues (if applicable)

## Uninstallation

### Remove Package
1. Open Package Manager
2. Find "Unity Toon Shader 2D"
3. Click "Remove"

### Clean Up
1. Delete any materials using toon shaders
2. Remove sample content if imported
3. Clear shader cache: `Edit > Preferences > GI Cache > Clear Cache`

---

**Note**: This package is based on the Unity Toon Shader and adapted for 2D rendering. For 3D toon shading needs, use the original Unity Toon Shader package.