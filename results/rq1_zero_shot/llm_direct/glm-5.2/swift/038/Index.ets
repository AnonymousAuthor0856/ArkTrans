// InvoiceScanner.ets
import drawing from '@ohos.graphics.drawing';
import { ColorSpace } from '@ohos.graphics.color';

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

class ColorHelper {
  static fromHex(hex: number): number {
    const r = (hex >> 16) & 0xFF;
    const g = (hex >> 8) & 0xFF;
    const b = hex & 0xFF;
    return (0xFF << 24) | (r << 16) | (g << 8) | b;
  }
}

class ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

class AppTokens {
  static Colors = {
    primary: ColorHelper.fromHex(0xFF06B6D4),
    secondary: ColorHelper.fromHex(0xFF3B82F6),
    tertiary: ColorHelper.fromHex(0xFF8B5CF6),
    background: ColorHelper.fromHex(0xFFF0F9FF),
    surface: ColorHelper.fromHex(0xFFFFFFFF),
    surfaceVariant: ColorHelper.fromHex(0xFFE0F2FE),
    outline: ColorHelper.fromHex(0xFFBAE6FD),
    success: ColorHelper.fromHex(0xFF22C55E),
    warning: ColorHelper.fromHex(0xFFFACC15),
    error: ColorHelper.fromHex(0xFFEF4444),
    onPrimary: ColorHelper.fromHex(0xFFFFFFFF),
    onSecondary: ColorHelper.fromHex(0xFFFFFFFF),
    onTertiary: ColorHelper.fromHex(0xFFFFFFFF),
    onBackground: ColorHelper.fromHex(0xFF0F172A),
    onSurface: ColorHelper.fromHex(0xFF0F172A),
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static ElevationMapping = {
    level1: new ShadowSpec(4, 0, 2, 0.12),
    level2: new ShadowSpec(8, 0, 4, 0.18),
  };
}

// MARK: - 4. Data Model

class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - 5. RootScreen (Main UI)

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, "A1"),
    new Marker(300, 400, "B2"),
    new Marker(520, 600, "C3")
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top Bar
      Text("Invoice Scanner")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center);

      // Main Content Area
      Column() {
        // Surface containing the Canvas
        Stack() {
          Canvas(this.markers)
            .width('100%')
            .height('100%')
            .onReady((context: CanvasRenderingContext2D) => {
              const width = context.canvas.width;
              const height = context.canvas.height;
              const minDim = Math.min(width, height);
              const centerX = width / 2;
              const centerY = height / 2;
              const radius = minDim / 2.5;

              // Draw inner circle (surfaceVariant)
              context.fillStyle = `#${(AppTokens.Colors.surfaceVariant & 0xFFFFFF).toString(16).padStart(6, '0')}`;
              context.beginPath();
              context.arc(centerX, centerY, radius, 0, Math.PI * 2);
              context.fill();

              // Draw markers
              context.fillStyle = `#${(AppTokens.Colors.primary & 0xFFFFFF).toString(16).padStart(6, '0')}`;
              for (const marker of this.markers) {
                context.beginPath();
                context.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
                context.fill();
              }
            })
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.md);
        }
        .width('100%')
        .height(400)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: AppTokens.ElevationMapping.level2.x,
          offsetY: AppTokens.ElevationMapping.level2.y
        });

        // Scanning Active Row
        Row() {
          Text("Scanning Active")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface);

          Blank();

          // Custom Toggle
          Stack() {
            // Track
            Stack()
              .width(50)
              .height(30)
              .borderRadius(15)
              .backgroundColor(this.scanning ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
              .animation({ duration: 200, curve: Curve.EaseInOut });

            // Thumb
            Stack()
              .width(26)
              .height(26)
              .borderRadius(13)
              .backgroundColor(this.scanning ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
              .position({ x: this.scanning ? 22 : 2, y: 2 })
              .animation({ duration: 200, curve: Curve.EaseInOut });
          }
          .width(50)
          .height(30)
          .onClick(() => {
            this.scanning = !this.scanning;
          });
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg });

        // Add Marker Button
        Button(this.scanning ? "Add Marker" : "Add Marker (Disabled)")
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(this.scanning ? AppTokens.Colors.primary : AppTokens.Colors.outline)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ top: AppTokens.Spacing.lg })
          .enabled(this.scanning)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.floor(Math.random() * (580 - 80 + 1)) + 80;
              const newY = Math.floor(Math.random() * (650 - 150 + 1)) + 150;
              const newLabel = `N${this.markers.length + 1}`;
              this.markers.push(new Marker(newX, newY, newLabel));
            }
          });
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.3]
        ]
      });
    }
    .width('100%')
    .height('100%');
  }
}