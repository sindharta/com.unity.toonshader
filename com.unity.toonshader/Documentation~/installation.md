# Installation

The **Unity Toon Shader** is a preview package that can be installed through Unity's Package Manager. Follow these steps to install it in your project.

## System Requirements

- **Unity Version**: 2021.3.19 or later
- **Git**: Must be installed on your system
- **Render Pipeline**: Built-in, URP, or HDRP (choose one based on your project needs)

## Installation Steps

### Method 1: Package Manager (Recommended)

1. **Open Package Manager**
   - In Unity, go to `Window` → `Package Manager`

2. **Add Package by Name**
   - Click the **+** button in the top-left corner
   - Select **Add package by name**
   - In Unity 2020.x, choose **Add package from git URL**

3. **Enter Package Name**
   - Type: `com.unity.toonshader`
   - Click **Add**

4. **Wait for Installation**
   - Unity will download and install the package
   - The process may take a few minutes depending on your internet connection

### Method 2: Specify Version

To install a specific version, use the format:
```
com.unity.toonshader@0.12.0-preview
```

### Method 3: Git URL (Alternative)

If the above methods don't work, you can install directly from the Git repository:
```
https://github.com/sindharta/com.unity.toonshader.git
```

## Post-Installation

After installation:

1. **Install Samples** (Optional but recommended)
   - See [Sample Installation Guide](sample-instlation.md) for detailed instructions
   - Samples provide example scenes and materials for each render pipeline

2. **Configure Render Pipeline**
   - Make sure your project is set up for your chosen render pipeline
   - See [System Requirements](System-Requirements.md) for compatibility details

3. **Start Creating**
   - Follow the [Getting Started Guide](GettingStarted.md) to begin using the shader

## Troubleshooting

### Common Issues

**Package not found**: Ensure you have the correct Unity version and internet connection.

**Git not found**: Install Git from [git-scm.com](https://git-scm.com/) and restart Unity.

**Installation fails**: Try clearing Unity's package cache and restarting the Editor.

### Getting Help

If you encounter issues:
- Check the [Known Issues](Known-issue.md) page
- Review the [System Requirements](System-Requirements.md)
- Visit the [Unity Toon Shader GitHub repository](https://github.com/sindharta/com.unity.toonshader) for community support
