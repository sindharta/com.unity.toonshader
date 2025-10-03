# Unity Toon Shader - 2D Quick Start Guide

This is a quick start guide for using Unity Toon Shader with the 2D Renderer in URP projects.

## 5-Minute Setup

### Step 1: Verify Your Project Setup
1. Ensure you have URP installed (Window > Package Manager > Universal RP)
2. Check that your project uses the 2D Renderer:
   - Go to Project Settings > Graphics
   - Verify your URP asset is assigned
   - Open your URP asset and ensure "Renderer List" contains a 2D Renderer

### Step 2: Add 2D Lights
1. Add a Global Light: `GameObject > Light > 2D > Global Light 2D`
2. Configure the light:
   - Intensity: 1.0 (default)
   - Color: White or desired tint
   - This will be your main light source

### Step 3: Create Toon Material
1. Create a new material: Right-click in Project > Create > Material
2. In the Inspector, select shader: `Shader > Toon`
3. Assign your sprite texture to "BaseMap"

### Step 4: Apply to Sprite
1. Select your sprite GameObject in the hierarchy
2. In the Sprite Renderer component, assign your new toon material
3. You should now see toon shading on your sprite!

### Step 5: Configure Toon Look
Adjust these key parameters in the material:

**For Basic Cel-Shading:**
```
BaseColor: White (or your sprite's color)
1st_ShadeColor: Slightly darker (e.g., RGB: 0.6, 0.6, 0.6)
2nd_ShadeColor: Much darker (e.g., RGB: 0.3, 0.3, 0.3)
BaseColor_Step: 0.5 (controls where shadow starts)
BaseShade_Feather: 0.01 (for hard edge) or 0.1 (for soft edge)
```

**For Outlines:**
```
Outline_Width: 0.02
Outline_Color: Black or dark blue
```

**For Rim Light:**
```
RimLight: Enable (check the box)
RimLight_Power: 0.2
RimLightColor: Light blue or white
```

## Common Configurations

### Character Sprite (Anime Style)
```yaml
BaseMap: Your character sprite
BaseColor: (1, 1, 1, 1) - White
1st_ShadeColor: (0.65, 0.65, 0.75, 1) - Light cool shadow
2nd_ShadeColor: (0.35, 0.35, 0.5, 1) - Deep cool shadow
BaseColor_Step: 0.5
BaseShade_Feather: 0.05
Outline_Width: 0.025
Outline_Color: (0.1, 0.1, 0.2, 1) - Dark blue
RimLight: Enabled
RimLight_Power: 0.15
RimLightColor: (0.8, 0.9, 1, 1) - Light blue
```

### Background Object (Soft Shading)
```yaml
BaseMap: Your texture
BaseColor: (1, 1, 1, 1) - White
1st_ShadeColor: (0.7, 0.7, 0.7, 1)
2nd_ShadeColor: (0.5, 0.5, 0.5, 1)
BaseColor_Step: 0.45
BaseShade_Feather: 0.2 (softer transitions)
GI_Intensity: 0.5 (more ambient light)
Outline_Width: 0 (no outline)
```

### Glowing Object (With Emissive)
```yaml
BaseMap: Your texture
Emissive_Tex: Emission mask
Emissive_Color: (Bright color, HDR > 1.0)
EMISSIVE_MODE: SIMPLE or ANIMATION
RimLight: Enabled
RimLight_Power: 0.3
```

## Light Setup Tips

### For Top-Down Games
```
Add: Global Light 2D (angle: 45-60 degrees)
Intensity: 0.8-1.0
Add ambient: Unlit_Intensity: 0.2
```

### For Side-Scrollers
```
Add: Global Light 2D (angle: 30-45 degrees from side)
Intensity: 1.0
Add: Point Light 2D for dramatic highlights
```

### For Indoor Scenes
```
Add: Multiple Point Light 2D or Freeform Light 2D
Use warm/cool color contrasts
Unlit_Intensity: 0.3 (for ambient lighting)
```

## Troubleshooting

**Problem**: No shading visible
- **Solution**: Add a 2D light to the scene, increase light intensity

**Problem**: Shading too harsh
- **Solution**: Increase BaseShade_Feather value (0.1-0.3)

**Problem**: Outlines too thick/thin
- **Solution**: Adjust Outline_Width (try 0.01-0.05 range)

**Problem**: Sprite appears too dark
- **Solution**: Increase Unlit_Intensity or GI_Intensity

**Problem**: Rim light not visible
- **Solution**: Ensure RimLight is enabled, increase RimLight_Power

## Advanced: Multiple Shade Variations

Create multiple materials for different lighting situations:

1. **Day Material**: Bright colors, moderate shadows
2. **Night Material**: Darker colors, higher rim light
3. **Indoor Material**: Warmer tones, softer shadows
4. **Dramatic Material**: High contrast, strong rim light

Swap materials at runtime based on scene/lighting conditions.

## Performance Tips

1. Disable unused features (MatCap, Angel Ring, etc.)
2. Use GPU instancing for repeated sprites
3. Keep additional light count low (2-4 max for best performance)
4. Use texture atlasing for sprites with same material
5. Disable outlines on background elements

## Next Steps

- Read the full [2D Renderer Support](2D-Renderer-Support.md) documentation
- Experiment with rim light and specular settings
- Try animated emissive for glowing effects
- Create material presets for different object types
- Explore stencil masking for advanced effects

## Resources

- [Full 2D Documentation](2D-Renderer-Support.md)
- [Parameter Settings](Parameter-Settings.md)
- [Outline Settings](Outline.md)
- [Rim Light Settings](Rimlight.md)

---

**Tip**: Always test in Game view (not Scene view) as 2D lights only affect Game view rendering!
