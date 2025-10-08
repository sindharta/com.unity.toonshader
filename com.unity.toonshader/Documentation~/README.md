# Unity Toon Shader Documentation

Welcome to the comprehensive documentation for the **Unity Toon Shader** (UTS3). This documentation will help you create beautiful cel-shaded characters and environments in Unity.

## 📚 Documentation Structure

### 🚀 Getting Started
- **[Overview](index.md)** - Introduction to Unity Toon Shader
- **[System Requirements](System-Requirements.md)** - Hardware and software requirements
- **[Installation Guide](installation.md)** - Step-by-step installation instructions
- **[Getting Started Tutorial](GettingStarted.md)** - Your first cel-shaded character
- **[Sample Installation](sample-instlation.md)** - Installing example scenes

### 🎨 Core Features
- **[Material Converter](MaterialConverter.md)** - Convert existing materials to UTS
- **[Inspector Settings](Parameter-Settings.md)** - Complete parameter reference

### 🎯 Basic Shading
- **[Modes](Modes.md)** - Shader operation modes
- **[Shader Settings](Shader.md)** - Basic shader configuration
- **[Three Color Maps](Basic.md)** - Foundation of cel-shading
- **[Shading Steps & Feather](ShadingStepAndFeather.md)** - Control shadow boundaries
- **[Normal Maps](NormalMap.md)** - Add surface detail

### ✨ Advanced Effects
- **[Highlights](Highlight.md)** - Specular reflections
- **[Rim Light](Rimlight.md)** - Edge lighting effects
- **[Material Capture (MatCap)](MatCap.md)** - Pre-rendered lighting
- **[Emission](Emission.md)** - Self-illuminated materials
- **[Angel Ring](AngelRing.md)** - Hair and fabric highlights
- **[Scene Light Control](SceneLight.md)** - Advanced lighting control

### 🖼️ Outline System
- **[Outline Settings](Outline.md)** - Character outlines and borders

### 🔧 Specialized Features
- **[Metaverse Settings](Metaverse.md)** - Experimental VR/AR features
- **[Tessellation (Built-in)](TessellationLegacy.md)** - Surface subdivision
- **[Tessellation (HDRP)](TessellationHDRP.md)** - HDRP tessellation

### 🎬 HDRP-Specific Features
- **[Box Light](HDRPBoxLight.md)** - Area lighting for HDRP
- **[Toon EV Adjustment](ToonEVAdjustment.md)** - Exposure control

### 📖 Reference
- **[Feature Differences](FeatureModel_en.md)** - Render pipeline compatibility
- **[Known Issues](Known-issue.md)** - Troubleshooting guide

## 🎯 Quick Navigation

### I'm New to Unity Toon Shader
1. Start with the [Overview](index.md)
2. Check [System Requirements](System-Requirements.md)
3. Follow the [Installation Guide](installation.md)
4. Complete the [Getting Started Tutorial](GettingStarted.md)
5. Install [Samples](sample-instlation.md) for examples

### I Want to Learn Specific Features
- **Basic cel-shading**: [Three Color Maps](Basic.md) → [Shading Steps & Feather](ShadingStepAndFeather.md)
- **Character outlines**: [Outline Settings](Outline.md)
- **Hair effects**: [Angel Ring](AngelRing.md) → [Material Capture](MatCap.md)
- **Special effects**: [Emission](Emission.md) → [Rim Light](Rimlight.md)

### I'm Having Issues
1. Check [Known Issues](Known-issue.md)
2. Review [System Requirements](System-Requirements.md)
3. Verify [Feature Differences](FeatureModel_en.md) for your render pipeline

## 🎨 Workflow Tips

### For Character Artists
1. Start with [Three Color Maps](Basic.md) for basic shading
2. Use [Shadow Control Maps](Basic.md#shadow-control-maps) for precise shadow placement
3. Add [Outlines](Outline.md) for definition
4. Enhance with [Highlights](Highlight.md) and [Rim Light](Rimlight.md)

### For Environment Artists
1. Use [Material Capture](MatCap.md) for consistent lighting
2. Apply [Emission](Emission.md) for glowing elements
3. Consider [Normal Maps](NormalMap.md) for surface detail

### For Technical Artists
1. Review [Feature Differences](FeatureModel_en.md) for pipeline compatibility
2. Use [Material Converter](MaterialConverter.md) for bulk conversions
3. Optimize with [Scene Light Control](SceneLight.md)

## 🔗 External Resources

- **[Unity Toon Shader GitHub](https://github.com/sindharta/com.unity.toonshader)** - Source code and issues
- **[Unity Documentation](https://docs.unity3d.com/)** - Unity's official documentation
- **[Unity Asset Store](https://assetstore.unity.com/)** - Additional assets and examples

## 📝 Contributing

Found an issue with the documentation? Have suggestions for improvement?

1. Check the [GitHub repository](https://github.com/sindharta/com.unity.toonshader)
2. Submit issues or pull requests
3. Join the community discussions

---

*This documentation is maintained by the Unity Toon Shader team. Last updated for version 0.12.0-preview.*