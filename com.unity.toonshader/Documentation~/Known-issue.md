# Known Issues and Troubleshooting

This page documents known issues with the Unity Toon Shader and provides solutions for common problems.

## 🎬 Recording and Export Issues

### AOV Image Sequence Recorder
**Issue**: The Unity Toon Shader [Outline](Outline.md) isn't automatically disabled when recording with [AOV Image Sequence Recorder](https://docs.unity3d.com/Packages/com.unity.recorder@4.0/manual/RecorderAOV.html).

**Solution**: Manually disable [Outline](Outline.md#outline) in Material Inspectors when outputting AOV Images.

## 🔧 Render Pipeline Issues

### Universal Render Pipeline (URP)
**Issue**: Outlines don't appear when using [Universal Render Pipeline](https://docs.unity3d.com/Manual/com.unity.render-pipelines.universal.html).

**Solution**: Set [Depth Priming Mode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@16.0/manual/urp-universal-renderer.html#rendering) to **Disabled** in your URP Renderer settings.

<canvas class="image-comparison" role="img" aria-label="A chibi-style character model, and the Inspector window for the Univeral Renderer Data asset. On the left, Depth Priming is set to Auto and the model has no outline. When Depth Priming is set to Disabled, the model has an outline.">
    <img src="images/DepthPrimingModeAuto.png" title="Depth Priming Mode set to Auto">
    <img src="images/DepthPrimingModeDisabled.png" title="Depth Priming Mode set to Disabled">
</canvas>
<br />Drag the slider to compare the images.

## 🎨 Visual Issues

### Shader Compilation Errors
**Issue**: Shader compilation fails with errors.

**Solutions**:
- Ensure you're using a supported Unity version (2021.3.19+)
- Check that your render pipeline is properly configured
- Verify the package is correctly installed
- Try reimporting the package

### Incorrect Colors or Lighting
**Issue**: Colors appear washed out or lighting looks wrong.

**Solutions**:
- Set your project to use **Linear Color Space** in Project Settings
- Check that your scene has proper lighting setup
- Verify material settings are correct
- Ensure textures are imported with correct settings

### Outlines Not Appearing
**Issue**: Character outlines are missing or incorrect.

**Solutions**:
- For URP: Disable Depth Priming Mode (see above)
- Check that Outline is enabled in material settings
- Verify Outline Width is set to a value greater than 0
- Ensure the material is using a Toon shader variant

### Performance Issues
**Issue**: Poor performance with Unity Toon Shader.

**Solutions**:
- Use URP for better mobile performance
- Reduce texture resolutions
- Limit the number of active shader features
- Use LOD (Level of Detail) systems for distant objects

## 🔧 Installation Issues

### Package Installation Fails
**Issue**: Unable to install the Unity Toon Shader package.

**Solutions**:
- Ensure Git is installed on your system
- Check your internet connection
- Try clearing Unity's package cache
- Restart Unity Editor
- Use the Git URL method as an alternative

### Samples Not Loading
**Issue**: Sample scenes don't appear after installation.

**Solutions**:
- Manually import samples from Package Manager
- Check that you have the correct render pipeline configured
- Verify sample files are in the correct location
- Try reimporting the package

## 🎯 Feature-Specific Issues

### Material Capture (MatCap) Issues
**Issue**: MatCap effects don't work correctly.

**Solutions**:
- Ensure MatCap texture is properly imported
- Check UV mapping on your model
- Verify MatCap settings are enabled
- Try different MatCap blending modes

### Emission Animation Problems
**Issue**: Emission animations don't play or appear incorrect.

**Solutions**:
- Check animation settings in material
- Verify texture import settings
- Ensure proper UV mapping
- Check animation speed and mode settings

### Tessellation Issues
**Issue**: Tessellation doesn't work or causes errors.

**Solutions**:
- Ensure you're using a supported render pipeline (Built-in or HDRP)
- Check that your graphics card supports tessellation
- Verify tessellation settings are properly configured
- Try reducing tessellation levels

## 🆘 Getting Help

If you're still experiencing issues:

1. **Check the GitHub Repository**: Visit the [Unity Toon Shader GitHub](https://github.com/sindharta/com.unity.toonshader) for the latest issues and solutions

2. **Review System Requirements**: Ensure your system meets the [minimum requirements](System-Requirements.md)

3. **Check Feature Compatibility**: Review [feature differences](FeatureModel_en.md) for your render pipeline

4. **Community Support**: Join discussions on the GitHub repository or Unity forums

5. **Report New Issues**: If you find a new issue, please report it on the GitHub repository with:
   - Unity version
   - Render pipeline used
   - Steps to reproduce
   - Screenshots or error messages

## 📝 Issue Reporting Template

When reporting issues, please include:

```
**Unity Version**: 
**Render Pipeline**: 
**Package Version**: 
**Platform**: 
**Issue Description**: 
**Steps to Reproduce**: 
**Expected Behavior**: 
**Actual Behavior**: 
**Screenshots/Logs**: 
```

---

*This page is regularly updated. Check back for new issues and solutions.*
