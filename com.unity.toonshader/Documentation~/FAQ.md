# Frequently Asked Questions (FAQ)

This page answers the most common questions about the Unity Toon Shader.

## 🚀 Getting Started

### Q: What is Unity Toon Shader?
A: Unity Toon Shader (UTS3) is a comprehensive set of shaders designed for creating cel-shaded 3D characters and environments. It provides professional-grade toon shading with real-time control over lighting, colors, and effects.

### Q: Which Unity versions are supported?
A: Unity Toon Shader requires Unity 2021.3.19 or later. We recommend using Unity 2022.3 LTS for the best experience.

### Q: Do I need to know shader programming to use this?
A: No! Unity Toon Shader is designed to be artist-friendly. You can create beautiful cel-shaded characters using the material inspector without any shader programming knowledge.

### Q: Is this free to use?
A: Yes, Unity Toon Shader is free to use in both personal and commercial projects. It uses Unity's standard licensing terms.

## 🎨 Features and Capabilities

### Q: Which render pipelines are supported?
A: Unity Toon Shader supports all three Unity render pipelines:
- Built-in Render Pipeline
- Universal Render Pipeline (URP)
- High Definition Render Pipeline (HDRP)

### Q: What's the difference between UTS2 and UTS3?
A: UTS3 (Unity Toon Shader) is the successor to UTS2 (Unity-chan Toon Shader 2.0). Key improvements include:
- Support for all render pipelines (UTS2 was Built-in only)
- Package Manager installation
- Unified shader system
- Better performance and features

### Q: Can I use this for mobile games?
A: Yes! Unity Toon Shader works on mobile platforms. For best mobile performance, use the Universal Render Pipeline (URP) and optimize your materials by reducing texture sizes and limiting active features.

### Q: Does it support VR/AR?
A: Yes, Unity Toon Shader supports VR and AR platforms. There are also experimental Metaverse features available for VR/AR applications.

## 🔧 Installation and Setup

### Q: How do I install Unity Toon Shader?
A: Install through Unity's Package Manager:
1. Open `Window` → `Package Manager`
2. Click the `+` button
3. Select "Add package by name"
4. Enter `com.unity.toonshader`
5. Click "Add"

See the [Installation Guide](installation.md) for detailed steps.

### Q: Why can't I find the package in Package Manager?
A: Make sure you're using Unity 2021.3.19 or later. If you still can't find it, try:
- Restarting Unity
- Clearing the package cache
- Using the Git URL method: `https://github.com/sindharta/com.unity.toonshader.git`

### Q: Do I need Git installed?
A: Yes, Git is required for package installation. Download it from [git-scm.com](https://git-scm.com/) and restart Unity after installation.

### Q: Should I install samples?
A: Yes! The sample scenes are highly recommended as they demonstrate all features and provide excellent learning material. See the [Sample Installation Guide](sample-instlation.md).

## 🎯 Usage and Workflow

### Q: How do I create my first cel-shaded character?
A: Follow these steps:
1. Install the package and samples
2. Read the [Getting Started Guide](GettingStarted.md)
3. Create a material and assign a Toon shader
4. Set up your three basic colors (Base, 1st Shading, 2nd Shading)
5. Adjust shading steps and feather
6. Add outlines

### Q: What are the three basic colors?
A: The three basic colors form the foundation of cel-shading:
- **Base Color**: The main color for unshaded areas
- **1st Shading Color**: Color for lighter shadows
- **2nd Shading Color**: Color for darker shadows

See [Three Color Map Settings](Basic.md) for detailed information.

### Q: How do I control where shadows appear?
A: Use Shadow Control Maps (also called Position Maps). These grayscale textures define exactly where each shading color appears on your character, giving you complete control over lighting regardless of scene lights.

### Q: Can I use my existing PBR materials?
A: Yes! Use the [Material Converter](MaterialConverter.md) to automatically convert existing PBR materials to Unity Toon Shader materials.

## 🎨 Visual and Styling

### Q: How do I get that anime/cel-shaded look?
A: Key techniques for anime-style shading:
- Use clear boundaries between light and shadow (low feather values)
- Apply appropriate colors for each shading level
- Use outlines to define character shapes
- Consider using Material Capture (MatCap) for hair highlights

### Q: How do I make hair look realistic?
A: For realistic hair:
- Use [Angel Ring](AngelRing.md) for hair highlights
- Apply [Material Capture (MatCap)](MatCap.md) for consistent lighting
- Use normal maps for hair detail
- Consider using multiple materials for different hair sections

### Q: Can I animate the shader properties?
A: Yes! Most shader properties can be animated. This is particularly useful for:
- Emission effects
- Color transitions
- Outline width changes
- Highlight animations

### Q: How do I create glowing effects?
A: Use the [Emission](Emission.md) features:
- Set up emission maps and colors
- Use emission animation for dynamic effects
- Combine with bloom post-processing for enhanced glow

## 🔧 Technical Issues

### Q: Why don't my outlines appear?
A: Common solutions:
- **For URP**: Disable Depth Priming Mode in your URP Renderer settings
- Check that Outline is enabled in your material
- Verify Outline Width is greater than 0
- Ensure you're using a Toon shader variant

### Q: Why do my colors look washed out?
A: This is usually due to color space settings:
- Set your project to use **Linear Color Space** in Project Settings
- Ensure textures are imported with correct settings
- Check that your scene lighting is properly configured

### Q: The shader won't compile. What's wrong?
A: Common causes:
- Using an unsupported Unity version
- Incorrect render pipeline configuration
- Missing dependencies
- Try reimporting the package

### Q: Performance is poor. How can I optimize?
A: Optimization tips:
- Use URP for better mobile performance
- Reduce texture resolutions
- Limit the number of active shader features
- Use LOD systems for distant objects
- Consider using simpler shader variants for background elements

## 🎬 Production and Export

### Q: Can I use this in commercial projects?
A: Yes! Unity Toon Shader is free to use in both personal and commercial projects under Unity's standard licensing terms.

### Q: Does it work with Unity's recording tools?
A: Yes, but there are some considerations:
- For AOV recording, manually disable outlines in materials
- Test your specific recording setup to ensure compatibility
- See [Known Issues](Known-issue.md) for specific recording limitations

### Q: Can I export to different platforms?
A: Yes! Unity Toon Shader supports all platforms that Unity supports, including:
- Desktop (Windows, macOS, Linux)
- Mobile (iOS, Android)
- Console (PlayStation, Xbox, Nintendo Switch)
- Web (WebGL)
- VR/AR platforms

### Q: How do I optimize for mobile?
A: Mobile optimization strategies:
- Use URP instead of HDRP
- Reduce texture sizes
- Limit active shader features
- Use simpler outline methods
- Test on actual devices regularly

## 🆘 Getting Help

### Q: Where can I get help if I'm stuck?
A: Several resources are available:
- Check the [Known Issues](Known-issue.md) page
- Review the [GitHub repository](https://github.com/sindharta/com.unity.toonshader) for community discussions
- Study the sample scenes for examples
- Join Unity community forums

### Q: How do I report bugs?
A: Report bugs on the [GitHub repository](https://github.com/sindharta/com.unity.toonshader) with:
- Unity version
- Render pipeline used
- Steps to reproduce
- Screenshots or error messages

### Q: Can I contribute to the project?
A: Yes! Contributions are welcome. Check the [GitHub repository](https://github.com/sindharta/com.unity.toonshader) for contribution guidelines and the [Contributing Guide](../CONTRIBUTING.md) for details.

## 📚 Learning Resources

### Q: Are there tutorials available?
A: Yes! Several learning resources:
- [Getting Started Guide](GettingStarted.md) - Step-by-step tutorial
- [Sample scenes](sample-instlation.md) - Interactive examples
- [Parameter Settings](Parameter-Settings.md) - Complete reference
- Community tutorials and videos

### Q: What's the best way to learn Unity Toon Shader?
A: Recommended learning path:
1. Install the package and samples
2. Complete the Getting Started tutorial
3. Explore sample scenes
4. Experiment with different features
5. Study the parameter reference
6. Join the community for advanced techniques

---

*Can't find your question? Check the [GitHub repository](https://github.com/sindharta/com.unity.toonshader) or submit a new issue.*