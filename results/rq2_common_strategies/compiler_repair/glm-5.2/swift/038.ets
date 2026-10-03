// Index.ets
// Converted from SwiftUI to ArkTS

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

// Helper function to convert hex color to ARGB format
function hexToColor(hex: number): ResourceColor {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

// Helper function to convert hex color with opacity to ARGB format
function hexToColorWithOpacity(hex: number, opacity: number): ResourceColor {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  const alpha = Math.round(opacity * 255);
  return `#${alpha.toString(16).padStart(2, '0')}${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

// Data structure for shadow specifications
interface ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;
}

// Data structure for Typography
interface TypographySpec {
  size: number;
  weight: FontWeight;
}

// Data structure for Colors
interface ColorsSpec {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

// Data structure for Typography Tokens
interface TypographyTokensSpec {
  display: TypographySpec;
  title: TypographySpec;
  body: TypographySpec;
  label: TypographySpec;
}

// Data structure for Shapes
interface ShapesSpec {
  small: number;
  medium: number;
  large: number;
}

// Data structure for Spacing
interface SpacingSpec {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

// Data structure for Elevation Mapping
interface ElevationMappingSpec {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

// Centralized design tokens
class AppTokens {
  static readonly Colors: ColorsSpec = {
    primary: hexToColor(0xFF06B6D4),
    secondary: hexToColor(0xFF3B82F6),
    tertiary: hexToColor(0xFF8B5CF6),
    background: hexToColor(0xFFF0F9FF),
    surface: hexToColor(0xFFFFFFFF),
    surfaceVariant: hexToColor(0xFFE0F2FE),
    outline: hexToColor(0xFFBAE6FD),
    success: hexToColor(0xFF22C55E),
    warning: hexToColor(0xFFFACC15),
    error: hexToColor(0xFFEF4444),
    onPrimary: hexToColor(0xFFFFFFFF),
    onSecondary: hexToColor(0xFFFFFFFF),
    onTertiary: hexToColor(0xFFFFFFFF),
    onBackground: hexToColor(0xFF0F172A),
    onSurface: hexToColor(0xFF0F172A)
  };

  static readonly Typography: TypographyTokensSpec = {
    display: { size: 28, weight: FontWeight.Bold } as TypographySpec,
    title: { size: 18, weight: FontWeight.Medium } as TypographySpec,
    body: { size: 14, weight: FontWeight.Regular } as TypographySpec,
    label: { size: 12, weight: FontWeight.Medium } as TypographySpec
  };

  static readonly Shapes: ShapesSpec = {
    small: 6,
    medium: 12,
    large: 20
  };

  static readonly Spacing: SpacingSpec = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly Elevation: ElevationMappingSpec = {
    level1: { radius: 4, x: 0, y: 2, opacity: 0.12 } as ShadowSpec,
    level2: { radius: 8, x: 0, y: 4, opacity: 0.18 } as ShadowSpec
  };
}

// MARK: - 2. Data Model

interface Marker {
  x: number;
  y: number;
  label: string;
}

// MARK: - 3. Main Entry Point

@Entry
@Component
struct InvoiceScannerApp {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: "A1" } as Marker,
    { x: 300, y: 400, label: "B2" } as Marker,
    { x: 520, y: 600, label: "C3" } as Marker
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top Bar
      Text("Invoice Scanner")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Surface containing the Canvas
        SurfaceView({
          shapeCornerRadius: AppTokens.Shapes.large,
          surfaceBackgroundColor: hexToColorWithOpacity(0xFFFFFFFF, 0.9),
          shadowSpec: AppTokens.Elevation.level2
        }) {
          // Canvas equivalent
          CanvasArea({ markers: this.markers })
            .padding(AppTokens.Spacing.md)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(400)

        // Scanning Active Row
        Row() {
          Text("Scanning Active")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()
          
          // Custom Toggle
          CustomToggle({
            isOn: $scanning,
            checkedThumbColor: AppTokens.Colors.secondary,
            uncheckedThumbColor: AppTokens.Colors.outline,
            checkedTrackColor: AppTokens.Colors.secondary,
            uncheckedTrackColor: AppTokens.Colors.surfaceVariant
          })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })

        // Add Marker Button
        Button(this.scanning ? "Add Marker" : "Scanning Inactive", { type: ButtonType.Normal })
          .onClick(() => {
            if (this.scanning) {
              const newMarker: Marker = {
                x: Math.random() * (580 - 80) + 80,
                y: Math.random() * (650 - 150) + 150,
                label: `N${this.markers.length + 1}`
              };
              this.markers.push(newMarker);
            }
          })
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [hexToColorWithOpacity(0xFF3B82F6, 0.3), 0],
          [AppTokens.Colors.background, 0.5],
          [hexToColorWithOpacity(0xFF06B6D4, 0.3), 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 4. SurfaceView Component

@Component
struct SurfaceView {
  @Prop shapeCornerRadius: number;
  @Prop surfaceBackgroundColor: ResourceColor;
  @Prop shadowSpec: ShadowSpec;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.surfaceBackgroundColor)
    .borderRadius(this.shapeCornerRadius)
    .shadow({
      radius: this.shadowSpec.radius,
      color: hexToColorWithOpacity(0x000000, this.shadowSpec.opacity),
      offsetX: this.shadowSpec.x,
      offsetY: this.shadowSpec.y
    })
    .clip(true)
  }
}

// MARK: - 5. Canvas Area Component

@Component
struct CanvasArea {
  @Prop markers: Marker[];
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas();
      })
  }

  private drawCanvas() {
    const canvas = this.context;
    const w = canvas.width;
    const h = canvas.height;
    const centerX = w / 2;
    const centerY = h / 2;
    const radius = Math.min(w, h) / 2.5;

    // Clear canvas
    canvas.clearRect(0, 0, w, h);

    // Draw inner circle (surfaceVariant)
    canvas.fillStyle = AppTokens.Colors.surfaceVariant as string;
    canvas.beginPath();
    canvas.arc(centerX, centerY, radius, 0, Math.PI * 2);
    canvas.fill();

    // Draw markers
    for (const marker of this.markers) {
      canvas.fillStyle = AppTokens.Colors.primary as string;
      canvas.beginPath();
      canvas.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      canvas.fill();
    }
  }
}

// MARK: - 6. Custom Toggle Component

@Component
struct CustomToggle {
  @Link isOn: boolean;
  @Prop checkedThumbColor: ResourceColor;
  @Prop uncheckedThumbColor: ResourceColor;
  @Prop checkedTrackColor: ResourceColor;
  @Prop uncheckedTrackColor: ResourceColor;

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      // Track
      Row()
        .width(50)
        .height(30)
        .borderRadius(15)
        .backgroundColor(this.isOn ? this.checkedTrackColor : this.uncheckedTrackColor)
        .animation({ duration: 200, curve: Curve.EaseInOut })

      // Thumb
      Circle()
        .width(26)
        .height(26)
        .margin(2)
        .fill(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(50)
    .height(30)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}