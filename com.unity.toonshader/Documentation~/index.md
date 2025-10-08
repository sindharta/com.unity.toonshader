# Unity Toon Shader

![An image from the toon-shaded film The Phantom Knowledge in the Scene view of the Unity Editor. A close-up of a girl raising a weapon with a ruined cityscape in the background.](images/TPK_04.png)

The **Unity Toon Shader** (UTS3) is a comprehensive set of toon shaders designed to meet the needs of creators working on cel-shaded 3D-CG animations, games, and visual effects. 

## Quick Start

- **New to Unity Toon Shader?** → [Getting Started Guide](GettingStarted.md)
- **Installing the package?** → [Installation Guide](installation.md)
- **Looking for samples?** → [Sample Installation](sample-instlation.md)
- **Need help with specific features?** → [Parameter Settings](Parameter-Settings.md)
- **Having issues?** → [Known Issues & Troubleshooting](Known-issue.md)
- **Common questions?** → [FAQ](FAQ.md)
- **Want to learn best practices?** → [Best Practices Guide](BestPractices.md)

## Key Features

The **Unity Toon Shader** provides professional-grade cel-shading capabilities with:

- **Multi-Pipeline Support**: Compatible with Built-in Render Pipeline, Universal Render Pipeline (URP), and High Definition Render Pipeline (HDRP)
- **Real-time Control**: All features adjustable in real-time within Unity Editor
- **Professional Color Design**: Independent control of light and shadow colors regardless of scene lighting
- **Advanced Effects**: Highlight, Rim Light, Emission, Angel Ring, Material Capture (MatCap), and more
- **Flexible Outline System**: Multiple outline generation methods with detailed control

## Render Pipeline Compatibility

The **Unity Toon Shader** is compatible with all Unity render pipelines, though there are some differences in the features supported by different render pipelines. Please refer to [Feature Differences](FeatureModel_en.md) for detailed compatibility information.

## About Unity Toon Shader

**Unity Toon Shader** is the successor of **Unity-chan Toon Shader ver 2.0 (UTS2)**, which was popular for years in games and animations. Unlike UTS2, which was solely for the Built-in Render Pipeline and consisted of many different shaders, UTS3:

- Supports all Unity render pipelines
- Can be installed through the [Package Manager window](https://docs.unity3d.com/Manual/upm-ui.html)
- Uses Unity's standard licensing
- Provides a unified, streamlined shader system 

## Feature of Unity Toon Shader

In animation production, color specialists specify detailed color designs for every scene. UTS can apply these color specifications written in the instructions. UTS allows  users to apply the colors of light and shadow regardless of actual light colors in the scene. This feature is essential for cel-shaded character designs. UTS allows detailed control whether the directional light color affects materials or not.

Typical color design instruction example:

![A stylized girl in a sailor uniform. A: White highlights on the hair. B: The main blonde hair color. C: Hair in shadow, with a tan color. D: Hair in darker shadow, with a darker tan color.](images/UTS4Color2.png)

- A: Highlight Color
- B: Base Color
- C: 1st Shading Color
- D: 2nd Shading Color

Three basic colors, **base color**, **1st shading color**, and **2nd shading color**, play  key roles in character design in the **Unity Toon Shader**. Please, refer to [Three Color Map and Control Map Settings](Basic.md).

Besides the three basic colors, the **Unity Toon Shader** provides wide variety of features such as [Highlight](Highlight.md), [Rim Light](Rimlight.md), [Emission](Emission.md), [Angel Ring](AngelRing.md), [Material Capture(MatCap)](MatCap.md) and some special maps.

Start to work on cel-shading from [Getting Started](GettingStarted.md).