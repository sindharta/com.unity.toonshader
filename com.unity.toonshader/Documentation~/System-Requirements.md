# System Requirements and Compatibility

## Unity Editor Requirements

### Minimum Requirements
- **Unity Version**: 2021.3.19 or later
- **Git**: Must be installed on your system for package installation
- **Operating System**: Windows 10+, macOS 10.15+, or Linux Ubuntu 18.04+

### Recommended Requirements
- **Unity Version**: 2022.3 LTS or later
- **RAM**: 8GB minimum, 16GB recommended
- **Graphics Card**: DirectX 11 compatible or OpenGL 3.3+ compatible
- **Storage**: 2GB free space for package and samples

## Render Pipeline Compatibility

The **Unity Toon Shader** is compatible with all Unity render pipelines:

| Render Pipeline | Support Level | Notes |
|----------------|---------------|-------|
| **Built-in Render Pipeline** | ✅ Full Support | All features available |
| **Universal Render Pipeline (URP)** | ✅ Full Support | All features available |
| **High Definition Render Pipeline (HDRP)** | ✅ Full Support | All features available |

> **Note**: While all render pipelines are supported, there are some differences in feature availability. See [Feature Differences](FeatureModel_en.md) for detailed compatibility information.

## Color Space Recommendations

**Linear Color Space** is strongly recommended for the best visual results. To set this up:

1. Go to `Edit` → `Project Settings`
2. Navigate to `XR Plug-in Management` → `Player`
3. Set **Color Space** to **Linear**

## Unity Version Compatibility

| Package Version | Supported Unity Versions | Notes |
|-----------------|--------------------------|-------|
| 0.7.x           | 2019.4 - 2022.3          | Legacy support |
| 0.8.x           | 2020.3.25 - 2022.3       | Legacy support |
| 0.9.x           | 2020.3.45 or later       | Legacy support |
| 0.10.x          | 2020.3.45 or later       | Legacy support |
| 0.11.x          | 2021.3.19 or later       | Current support |
| 0.12.x          | 2021.3.19 or later       | Latest version |

## Hardware Requirements

### Minimum Hardware
- **CPU**: Intel Core i3 or AMD equivalent
- **RAM**: 4GB
- **Graphics**: DirectX 11 compatible GPU
- **Storage**: 1GB free space

### Recommended Hardware
- **CPU**: Intel Core i5 or AMD Ryzen 5
- **RAM**: 16GB
- **Graphics**: Dedicated GPU with 2GB+ VRAM
- **Storage**: SSD with 5GB+ free space

## Platform Support

The Unity Toon Shader supports all platforms that Unity supports:

- **Desktop**: Windows, macOS, Linux
- **Mobile**: iOS, Android
- **Console**: PlayStation, Xbox, Nintendo Switch
- **Web**: WebGL
- **VR/AR**: Oculus, HTC Vive, HoloLens

## Performance Considerations

### Optimizing for Mobile
- Use lower resolution textures
- Limit the number of active features
- Consider using URP for better mobile performance
- Test on target devices regularly

### Optimizing for Console
- Use HDRP for maximum visual quality
- Take advantage of tessellation features where supported
- Optimize texture memory usage

## Troubleshooting

### Common Issues

**Shader compilation errors**: Ensure you're using a supported Unity version and have the correct render pipeline configured.

**Performance issues**: Check your hardware meets the minimum requirements and consider reducing shader complexity.

**Visual artifacts**: Verify you're using Linear color space and have proper lighting setup.

### Getting Support

If you encounter issues:
- Check the [Known Issues](Known-issue.md) page
- Review the [Feature Differences](FeatureModel_en.md) for your render pipeline
- Visit the [Unity Toon Shader GitHub repository](https://github.com/sindharta/com.unity.toonshader) for community support
