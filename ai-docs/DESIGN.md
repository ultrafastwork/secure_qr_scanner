# QR Scanner App - Flutter UI Design Specification

## Design System Overview

This is a **modern, gradient-heavy mobile app** with a dark theme. The design emphasizes **glassmorphism effects** (frosted glass appearance with blur and transparency) and **vibrant purple/violet/fuchsia gradients** against a pure black background.

## Color Palette

### Primary Colors
- **Base Background**: Pure black (#000000)
- **Gradient Colors**: 
  - Violet: #7C3AED (violet-600), #8B5CF6 (violet-500)
  - Fuchsia: #C026D3 (fuchsia-600), #D946EF (fuchsia-500)
  - Purple: #7E22CE (purple-700), #A855F7 (purple-400)

### Glassmorphism Colors
- White with 5% opacity (#FFFFFF0D) - subtle glass
- White with 10% opacity (#FFFFFF1A) - standard glass
- White with 15% opacity (#FFFFFF26) - hover state glass
- White with 20% opacity (#FFFFFF33) - active/pressed glass

### Text Colors
- Primary text: White (#FFFFFF)
- Secondary/subtitle text: White at 60% opacity (#FFFFFF99)
- Tertiary/disabled text: White at 40% opacity (#FFFFFF66)

### Icon Accent Colors
- Violet-400: #A78BFA
- Fuchsia-400: #E879F9
- Purple-400: #C084FC

## Typography

- **App Title**: 16sp, bold weight, white
- **Hero Title ("Ready to Scan")**: 20sp, bold weight, white
- **Button Text**: 16sp, semibold (600 weight), white
- **Menu Item Title**: 16sp, semibold, white
- **Menu Item Subtitle**: 12sp, regular (400 weight), white 60%
- **Bottom Nav Text**: 12sp, medium (500 weight), white
- **Footer Text**: 12sp, regular, white 40%

## Home Screen Layout

### Background Layers (Stack from bottom to top)
1. **Base**: Solid black container
2. **Gradient overlay**: LinearGradient from top-left to bottom-right with colors [violet-600, fuchsia-600, purple-700] at 20% opacity
3. **Blur layer**: BackdropFilter with ImageFilter.blur(sigmaX: 40, sigmaY: 40)

### Header Section
**Positioned at top with 20px padding all around**

- **Left side**: Row with 8px gap
  - App icon container: 36x36px, borderRadius 12px, LinearGradient [violet-500, fuchsia-500]
    - Contains QR code icon (white, 20x20px) centered
  - App name text: "QR Scanner", white, 16sp, bold

- **Right side**: Settings button
  - Size: 36x36px circular (borderRadius 18px)
  - Background: white 10% opacity with blur effect
  - Icon: Settings/gear icon, white, 16x16px
  - Hover/tap: Increase to white 20% opacity

### Hero/Center Section
**Vertically and horizontally centered**

#### Main Icon Display
- **Glow effect layer** (positioned behind):
  - Size: 144x144px
  - BorderRadius: 24px
  - LinearGradient [violet-500, fuchsia-500]
  - Heavy blur: ImageFilter.blur(sigmaX: 40, sigmaY: 40)
  - Opacity: 40%

- **Main icon container** (on top of glow):
  - Size: 144x144px
  - BorderRadius: 24px
  - LinearGradient [violet-500, fuchsia-500]
  - Box shadow: violet glow with offset (0, 8), blur 24px
  - Contains scan/focus icon (white, 80x80px) centered

- **Title text**: "Ready to Scan"
  - Positioned 24px below icon
  - White, 20sp, bold, center-aligned

#### Action Buttons (32px below title)
**Three buttons stacked vertically with 8px gap between each, max-width ~400px**

1. **Primary Button - Scan QR Code**:
   - Height: 56px, full width, borderRadius 16px
   - Background: LinearGradient left-to-right [violet-500, fuchsia-500]
   - Content: Row centered with 8px gap
     - QR icon (white, 20x20px)
     - Text "Scan QR Code" (white, 16sp, semibold)
   - Hover: Add violet shadow (0, 4, blur 20, violet-500 50% opacity)
   - Tap: Scale to 98%

2. **Secondary Button - Scan Barcode**:
   - Same dimensions as primary
   - Background: white 10% with backdrop blur
   - Content: Barcode icon (white, 20x20px) + "Scan Barcode" text
   - Hover: white 15% background
   - Tap: Scale to 98%

3. **Tertiary Button - Scan from Gallery**:
   - Same dimensions and style as secondary button
   - Content: Image/gallery icon (white, 20x20px) + "Scan from Gallery" text

### Bottom Navigation
**Fixed at bottom with 20px horizontal padding, 24px bottom padding**

**Row of 3 pill-shaped buttons, centered, with 8px gap**

Each button has:
- Height: 36px
- Horizontal padding: 16px, vertical padding: 8px
- BorderRadius: 18px (fully rounded)
- Background: white 5% with backdrop blur
- Hover: white 10%
- Tap: Scale to 95%

Buttons (left to right):
1. **Generate**: Sparkles icon (violet-400, 16x16px) + "Generate" text (white, 12sp, medium)
2. **History**: History/clock icon (fuchsia-400, 16x16px) + "History" text
3. **More**: Settings icon (purple-400, 16x16px) + "More" text

## Menu Screen Layout

### Background
- **Overlay**: Black 95% opacity covering entire screen
- **Blur**: BackdropFilter with ImageFilter.blur(sigmaX: 20, sigmaY: 20)
- **Animation**: Fade in over 200ms

### Header (20px padding all around)
- **Left**: "Menu" text (white, 20sp, bold)
- **Right**: Close button
  - Size: 40x40px circular (borderRadius 20px)
  - Background: white 10% with tap-to-white 20%
  - Icon: X/close icon (white, 20x20px)

### Menu Items List
**Vertical ListView with 8px spacing between items, 20px horizontal padding**

#### Featured Item (Scan QR Code)
- Height: 80px, full width, borderRadius 16px
- Background: LinearGradient left-to-right [violet-600, fuchsia-600]
- Padding: 20px all around
- Hover: Add violet shadow glow

**Layout** (Row with space-between):
- **Left section** (Row with 12px gap):
  - Icon container: 40x40px, borderRadius 12px, white 20%
    - Scan icon (white, 20x20px) centered
  - Text column (left-aligned):
    - Title: "Scan QR Code" (white, 16sp, semibold)
    - Subtitle: "Open camera scanner" (white 60%, 12sp)

- **Right section**:
  - Chevron-right icon (white 60%, 20x20px)
  - On hover: Changes to full white

#### Standard Menu Items (4 items)
Same layout as featured item but with different styling:
- Background: white 5% with backdrop blur
- Hover: white 10%
- Icon container: white 10% (darker than featured)
- Chevron: white 40% (changes to white 60% on hover)

**Items in order:**
1. **Scan Barcode**
   - Icon: Barcode icon
   - Subtitle: "EAN, UPC, Code128, etc"

2. **Generate QR**
   - Icon: Sparkles icon
   - Subtitle: "Create custom QR codes"

3. **History**
   - Icon: History/clock icon
   - Subtitle: "View past scans"

4. **Settings**
   - Icon: Settings/gear icon
   - Subtitle: "Preferences & theme"

### Footer
**At bottom of menu, 20px padding**
- Top border: white 10%, 1px height
- Text: "QR Scanner v0.3.3" (white 40%, 12sp, center-aligned)

## Key Design Patterns for Flutter Implementation

### Glassmorphism Effect
Use `BackdropFilter` with `ImageFilter.blur()` combined with semi-transparent white containers:
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
  ),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: // your content
  ),
)
```

### Gradient Backgrounds
Use `LinearGradient` for buttons and containers:
```dart
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
)
```

### Glow Effects
Create glow by positioning a blurred duplicate behind the element:
```dart
Stack(
  children: [
    // Glow layer
    Container(
      width: 144,
      height: 144,
      decoration: BoxDecoration(
        gradient: LinearGradient(...),
        borderRadius: BorderRadius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(color: Colors.transparent),
      ),
    ),
    // Main element on top
    Container(...),
  ],
)
```

### Interactive States
Use `InkWell` or `GestureDetector` with `AnimatedContainer` or `TweenAnimationBuilder` for scale effects:
- Hover: Change background opacity
- Tap: Scale to 0.98 or 0.95
- Transition duration: 150-200ms

### Border Radius Values
- Small (pills, small buttons): 18px (full rounded for height 36px)
- Medium (buttons, cards): 16px
- Large (icons, containers): 12px
- Extra large (hero icon): 24px

### Spacing System
- Tiny gap: 8px
- Small gap: 12px
- Medium gap: 16px
- Large gap: 20px
- Extra large gap: 24px or 32px

## Suggested Flutter Packages

1. **flutter_svg** - For icon rendering if using SVG icons
2. **google_fonts** - For custom font if needed (or use system font with FontWeight variations)
3. **animations** - For smooth page transitions
4. **lucide_icons_flutter** or **phosphor_flutter** - Icon packages similar to lucide-react

## Animation Notes

- **Menu open**: Fade in over 200ms with ease-out curve
- **Button press**: Scale animation 150ms
- **Hover effects**: Opacity transitions 150ms
- All animations should use Flutter's Curves.easeOut or Curves.easeInOut

## Responsive Considerations

- Max width for action buttons: ~400px centered
- Maintain consistent padding on all screen sizes
- Menu should cover full screen on mobile
- Bottom navigation should be fixed at bottom (SafeArea aware)