//
//  ContentView.swift
//  InvoiceScanner
//
//  Created by YourName on 2023/10/27.
//

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

// Extension to initialize Color from a hex value (0xFFRRGGBB)
// ArkTS represents colors as hex strings ('#AARRGGBB'), so the original
// 0xFFRRGGBB values are used directly without a custom initializer.

// Extension to create a circular path for Canvas
// ArkTS draws circles directly via CanvasRenderingContext2D.arc(); see RootScreen.

// Data structure for shadow specifications
class ShadowSpec {
  readonly radius: number;   // Blur radius
  readonly x: number;        // X offset
  readonly y: number;        // Y offset
  readonly opacity: number;  // Shadow color opacity

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

interface AppTokensType {
  Colors: ColorTokens;
  TypographyTokens: TypographyTokens;
  Shapes: ShapeTokens;
  Spacing: SpacingTokens;
  ElevationMapping: ElevationTokens;
}

// Centralized design tokens for easy modification and consistency
const AppTokens: AppTokensType = {
  Colors: {
    primary: '#FF06B6D4',
    secondary: '#FF3B82F6',
    tertiary: '#FF8B5CF6',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal }, // FontWeight.Normal -> .regular
    label: { size: 12, weight: FontWeight.Medium },
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 20,
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
  ElevationMapping: {
    // Mapping Compose's ShadowSpec to SwiftUI's shadow(color:radius:x:y:)
    // Compose: ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
    // SwiftUI: shadow(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
    // We use Compose's 'radius' as SwiftUI's blur radius, and 'dy' as SwiftUI's y-offset.
    level1: new ShadowSpec(4, 0, 2, 0.12),
    level2: new ShadowSpec(8, 0, 4, 0.18),
  },
};

// Helper: blend a base '#FFRRGGBB' color with the given opacity (0..1)
// into an '#AARRGGBB' color string, mirroring SwiftUI's Color.opacity(_:).
function withAlpha(color: string, opacity: number): string {
  const alpha: number = Math.round(opacity * 255);
  const hexDigits: string = '0123456789ABCDEF';
  const a: string = hexDigits.charAt(Math.floor(alpha / 16)) + hexDigits.charAt(alpha % 16);
  return '#' + a + color.substring(3);
}

// MARK: - 2. Custom Toggle Style for precise visual matching

@Component
struct InvoiceScannerToggleStyle {
  @Link isOn: boolean;
  @Prop checkedThumbColor: string = '#FFFFFFFF';
  @Prop uncheckedThumbColor: string = '#FFFFFFFF';
  @Prop checkedTrackColor: string = '#FFFFFFFF';
  @Prop uncheckedTrackColor: string = '#FFFFFFFF';

  build() {
    // Equivalent to SwiftUI's ZStack(alignment: isOn ? .trailing : .leading)
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      // Capsule (track)
      Row()
        .width(50)
        .height(30) // Standard switch size
        .borderRadius(15)
        .backgroundColor(this.isOn ? this.checkedTrackColor : this.uncheckedTrackColor)
        .animation({ duration: 200, curve: Curve.EaseInOut })

      // Circle (thumb)
      Circle()
        .width(26)
        .height(26) // Standard thumb size
        .fill(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .margin({ left: 2, right: 2 }) // Padding inside the capsule to center the thumb
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(50)
    .height(30)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

// MARK: - 3. Helper Views for reusability and clarity

// Equivalent to Compose's Surface for styling a background with shadow and rounded corners
@Component
struct SurfaceView {
  @Prop shapeCornerRadius: number = 0;
  @Prop bgColor: string = '#FFFFFFFF';
  @Prop shadowRadius: number = 0;
  @Prop shadowX: number = 0;
  @Prop shadowY: number = 0;
  @Prop shadowOpacity: number = 0;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .backgroundColor(this.bgColor)
    .borderRadius(this.shapeCornerRadius)
    .shadow({
      radius: this.shadowRadius,
      color: withAlpha('#FF000000', this.shadowOpacity),
      offsetX: this.shadowX,
      offsetY: this.shadowY,
    })
    .clip(true) // Clip content to the rounded corners
  }
}

// Equivalent to Compose's Box with fillMaxSize() and Alignment.Center
@Component
struct BoxView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 4. Data Model

class Marker {
  readonly id: string; // Required for ForEach in SwiftUI
  x: number;
  y: number;
  label: string;
  static nextId: number = 0;

  constructor(x: number, y: number, label: string) {
    this.id = 'marker-' + (Marker.nextId++);
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - 5. RootScreen (Main UI)

@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3'),
  ];
  @State scanning: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column({ space: 0 }) { // Main VStack to stack TopBar and Content, spacing 0 to ensure no gap
      // Top Bar (Equivalent to Compose's CenterAlignedTopAppBar)
      Text('Invoice Scanner')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg }) // Vertical padding for the title within the top bar
        .backgroundColor(AppTokens.Colors.background) // Top bar background color

      // Main Content Area (Equivalent to Compose's Column with gradient background)
      Column({ space: AppTokens.Spacing.lg }) {
        // Surface containing the Canvas
        Column() {
        SurfaceView({
          shapeCornerRadius: AppTokens.Shapes.large,
          bgColor: withAlpha(AppTokens.Colors.surface, 0.9),
          shadowRadius: AppTokens.ElevationMapping.level2.radius,
          shadowX: AppTokens.ElevationMapping.level2.x,
          shadowY: AppTokens.ElevationMapping.level2.y,
          shadowOpacity: AppTokens.ElevationMapping.level2.opacity,
        }) {
          BoxView() { // Equivalent to Compose's Box with fillMaxSize()
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .padding(AppTokens.Spacing.md) // Padding inside the surface for the canvas
              .onReady(() => {
                const centerX: number = this.context.width / 2;
                const centerY: number = this.context.height / 2;
                const minDim: number = Math.min(this.context.width, this.context.height);
                // Draw inner circle (surfaceVariant)
                this.context.fillStyle = AppTokens.Colors.surfaceVariant;
                this.context.beginPath();
                this.context.arc(centerX, centerY, minDim / 2.5, 0, 2 * Math.PI);
                this.context.fill();
                // Draw markers
                this.context.fillStyle = AppTokens.Colors.primary;
                for (let i = 0; i < this.markers.length; i++) {
                  const marker: Marker = this.markers[i];
                  this.context.beginPath();
                  this.context.arc(marker.x, marker.y, 12, 0, 2 * Math.PI);
                  this.context.fill();
                }
              })
          }
        }
        }
        .width('100%') // Surface fills width
        .height(400) // Fixed height for the surface

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          InvoiceScannerToggleStyle({
            isOn: $scanning,
            checkedThumbColor: AppTokens.Colors.secondary,
            uncheckedThumbColor: AppTokens.Colors.outline,
            checkedTrackColor: AppTokens.Colors.secondary,
            uncheckedTrackColor: AppTokens.Colors.surfaceVariant, // Based on visual, light blueish
          })
        }
        .width('100%') // HStack fills width

        // Add Marker Button
        Button() {
          Text('Add Marker')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48) // fillMaxWidth().height(48.dp)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary) // containerColor
            .borderRadius(AppTokens.Shapes.medium) // shape
        }
        .width('100%')
        .onClick(() => {
          if (this.scanning) {
            const randomX: number = Math.random() * (580 - 80) + 80; // Random.nextInt(80, 580).toFloat()
            const randomY: number = Math.random() * (650 - 150) + 150; // Random.nextInt(150, 650).toFloat()
            this.markers.push(new Marker(randomX, randomY, 'N' + (this.markers.length + 1)));
          }
        })
      }
      .padding(AppTokens.Spacing.lg) // Padding for the main content column
      .width('100%')
      .layoutWeight(1) // Make content fill remaining space
      .linearGradient({
        direction: GradientDirection.Bottom, // Vertical gradient background
        colors: [
          [withAlpha(AppTokens.Colors.secondary, 0.3), 0.0],
          [AppTokens.Colors.background, 0.5],
          [withAlpha(AppTokens.Colors.primary, 0.3), 1.0],
        ],
      })
    }
    .expandSafeArea() // Make the entire view ignore safe areas (full screen)
    // statusBarHidden(true): hide the status bar
    // (ArkTS has no direct page modifier for this; use window system bar properties instead.)
  }
}

// MARK: - 6. App Entry Point

@Entry
@Component
struct InvoiceScannerApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}

// MARK: - 7. Preview Provider

@Component
struct RootScreen_Previews {
  build() {
    Column() {
      RootScreen()
    }
  }
}
