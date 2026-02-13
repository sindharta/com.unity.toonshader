# Changelog
All notable changes to this package will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-01

### Added
- Initial release of Unity Toon Shader 2D
- **Toon/2D** shader with full 2D toon shading features
- **Toon/Sprite** shader optimized for sprite rendering
- Multi-step toon shading (base, 1st shade, 2nd shade)
- UV-based rim lighting for 2D sprites
- Highlight effects with customizable power and threshold
- Animated emission with scrolling and pulsing
- 2D lighting system integration
- Support for URP 2D Renderer
- Sprite atlas compatibility
- UI element support
- Sample materials and documentation

### Features
- **Core Toon Shading**: Multi-level toon shading with smooth transitions
- **2D Lighting Integration**: Proper response to URP 2D lights and shadows
- **Rim Lighting**: Edge lighting effects calculated from sprite boundaries
- **Highlights**: Specular-like effects for enhanced visual appeal
- **Emission Effects**: Both static and animated emission with various animation modes
- **Performance Optimized**: Simplified calculations for 2D rendering
- **Mobile Friendly**: Optimized for mobile platforms and WebGL

### Conversion from 3D Version
- Removed 3D-specific features (MatCap, Outline, Tessellation, Normal Mapping)
- Simplified lighting model for 2D sprites
- Added UV-based effects instead of view-dependent calculations
- Optimized for sprite rendering workflows
- Enhanced compatibility with 2D animation systems

### Compatibility
- Unity 2021.3 or later
- Universal Render Pipeline 10.0.0 or later
- All platforms supported by URP
- 2D Renderer required for full functionality

### Documentation
- Comprehensive README with usage instructions
- Conversion notes explaining differences from 3D version
- Sample materials demonstrating various effects
- Performance optimization guidelines
- Troubleshooting guide

### Known Limitations
- Requires URP 2D Renderer for optimal functionality
- Some advanced 3D features not available in 2D version
- Outline effects need to be achieved through alternative methods

## Future Releases

### Planned Features
- Additional 2D-specific effects
- Enhanced animation support
- More sample content
- Performance improvements
- Additional platform optimizations