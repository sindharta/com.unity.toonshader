# Three Color Map and Control Map Settings

The **Three Color Map and Control Map Settings** form the foundation of cel-shading in the **Unity Toon Shader**. These settings allow you to control the rendering of light and shadow areas independently from the actual scene lighting, giving you complete artistic control over your character's appearance.

## Key Concepts

- **Base Map**: The main color/texture for unshaded areas
- **1st Shading Map**: The color/texture for lighter shadow areas  
- **2nd Shading Map**: The color/texture for darker shadow areas
- **Shadow Control Maps**: Textures that define where shadows appear

This system allows you to create professional cel-shaded characters with precise control over lighting, regardless of the actual light colors in your scene. For advanced lighting control, see [Scene Light Effectiveness Settings](SceneLight.md).

* [Three Basic Color Maps](#Three-basic-color-maps)
  * [Base Map](#base-map)
    * [Apply to 1st Shading Map](#apply-to-1st-shading-map)
  * [1st Shading map](#1st-shading-map)
    * [Apply to 2nd Shading Map](#apply-to-2nd-shading-map)
  * [2nd Shading Map](#2nd-shading-map)
  * [Example of Three Color Map Operation](#example-of-Three-color-map-operation) 
<br><br>


* [Shadow Control Maps](#shadow-control-maps)
  * [1st Shading Position Map](#1st-shading-map)
  * [2nd Shading Position Map](#2nd-shading-map)
  * [Example of Shadow Control Map Application](#example-of-shadow-control-map-application)
<br><br>

## Three Basic Color Maps

The three basic color maps work together to create the fundamental cel-shading effect. Each map represents a different lighting condition on your character.

### Base Map
**Base Color**: Texture(sRGB) × Color(RGB) - Default: White

The Base Map represents the color of areas that receive full lighting (unshaded areas). This is typically the brightest and most vibrant version of your character's colors. 

|  Base Color Map (Face) | (Hair) | Result  |
| ---- | ---- |---- |
| <img alt="A yellow texture map with different-colored areas for skin, ears, eyes, cheeks, and other parts of a face." src="images/yuko_face3_main.png" height="256">  | <img alt="A grey texture map with two brown areas for cat-like ears, and lighter grey brushstrokes for parts of the hair." src="images/yuko_hair.png" height="256"> |<img alt="A chibi-style face with yellow skin, grey hair, brown cat ears, large eyes, and rosy cheeks." src="images/YukoFace.png" height="256">  |


#### Apply to 1st Shading Map
When enabled, this option uses the **Base Map** texture for the **1st Shading Map** as well. This is useful when you want to use the same texture but with different colors for the shading effect. When checked, the 1st Shading Map texture slot is disabled.

### 1st Shading Map
**1st Shading Color**: Texture(sRGB) × Color(RGB) - Default: White

The 1st Shading Map represents the color of areas in lighter shadows. This is typically a darker, more muted version of your base colors.

|   **1st Shading Map** (Face) | (Hair) | Result  |
| ---- | ---- | ---- |
| <img alt="A similar texture map to the base map, but the background is now tan." src="images/yuko_face3_B.png" height="256">   | <img alt="A similar hair map to the base map, but the background is darker, and the brushstrokes have a blue gradient." src="images/yuko_hairB.png" height="256"> |<img alt="The chibi-style face, now with shadows at the bottom of the hair and face, and over the eyes." src="images/YukoFace1stShadingMap.png" height="256">  |


#### Apply to 2nd Shading Map
When enabled, this option uses either the **Base Map** or **1st Shading Map** texture for the **2nd Shading Map**. This allows you to reuse existing textures with different colors for the darkest shadow areas. When checked, the 2nd Shading Map texture slot is disabled.

### 2nd Shading Map
**2nd Shading Color**: Texture(sRGB) × Color(RGB) - Default: White

The 2nd Shading Map represents the color of areas in the darkest shadows. This is typically the darkest, most saturated version of your colors, often with a slight color shift (like adding blue or purple tones).

|  **2nd Shading Map** (Face)  | (Hair) | Result  |
| ---- | ---- | ---- |
| <img alt="A similar texture map to the base map, but the background is now a dark orange." src="images/yuko_face3_C.png" height="256">   | <img alt="A similar hair map to the base map, but the background is even darker." src="images/yuko_hairC.png" height="256"> |<img alt="The chibi-style face, now with darker shadows at the edges of the hair." src="images/YukoFace2ndShadingMap.png" height="256">  |


## Shadow Control Maps

Shadow Control Maps allow you to define exactly where shadows appear on your character, giving you precise control over the lighting regardless of the actual light direction in your scene.

### 1st Shading Position Map
**1st Position Map**: Texture(linear)

This grayscale texture defines where the 1st shading color appears. White areas will show the 1st shading color, while black areas will remain in the base color. Gray values create smooth transitions between the two.

### 2nd Shading Position Map  
**2nd Position Map**: Texture(linear)

This grayscale texture defines where the 2nd shading color (darkest shadows) appears. White areas will show the 2nd shading color, while black areas will remain in the 1st shading color or base color.


<br><br>
## Example of Shadow Control Map Application
| Base Map | 1st Shading Map | Shading Position Map |
| ---- | ---- | ---- |
| <img alt="A UV map texture that contains all the parts of a chibi-style character model." src="images/utc_all2_light.png" height="256"> |<img alt="The same UV map but some areas have a darker color." src="images/utc_all2_dark.png" height="256"> |<img alt="A mostly white texture, with 3 black hair shapes." src="images/utc_all2_offsetdark.png" height="256"> |

No Shadow Control Maps:
![A chibi-style character model with rabbit ears. In the Inspector window, the 1st Shading Position Map and 2nd Shading Position Map properties are empty.](images/ShadowControlMap0.png)

1st Shading Position Map:
![The same model. In the Inspector window, the 1st Shading Position Map property is set to the shading position map texture.](images/ShadowControlMap1.png)

2nd Shading Position Map:
![The same model. In the Inspector window, the 2nd Shading Position Map property is set to the shading position map texture.](images/ShadowControlMap2.png)

Both:
![The same model. In the Inspector window, both the 1st Shading Position Map and 2nd Shading Position Map properties are set to the shading position map texture. ](images/ShadowControlMap3.png)
