import { curves } from '@kit.ArkUI';

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

interface ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
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
  };

  static Typography = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Normal,
    labelSize: 12,
    labelWeight: FontWeight.Medium,
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
    level1: { radius: 4, x: 0, y: 2, opacity: 0.12 } as ShadowSpec,
    level2: { radius: 8, x: 0, y: 4, opacity: 0.18 } as ShadowSpec,
  };
}

// MARK: - 4. Data Model

interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}

// MARK: - 5. RootScreen (Main UI)

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'A1' },
    { id: '2', x: 300, y: 400, label: 'B2' },
    { id: '3', x: 520, y: 600, label: 'C3' },
  ];
  @State scanning: boolean = false;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;
    const minDim = Math.min(this.canvasWidth, this.canvasHeight);
    const innerRadius = minDim / 2.5;

    // Draw inner circle (surfaceVariant)
    ctx.beginPath();
    ctx.arc(centerX, centerY, innerRadius, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fill();

    // Draw markers
    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
    }
  }

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Surface containing the Canvas
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.md)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: AppTokens.ElevationMapping.level2.x,
          offsetY: AppTokens.ElevationMapping.level2.y,
        })

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          // Custom Toggle
          Stack() {
            // Track
            Capsule()
              .fill(this.scanning ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
              .width(50)
              .height(30)
              .animation({
                duration: 200,
                curve: curves.interpolatingSpring(0, 1, 228, 30),
              })

            // Thumb
            Circle()
              .fill(this.scanning ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
              .width(26)
              .height(26)
              .offset({ x: this.scanning ? 10 : -10 })
              .animation({
                duration: 200,
                curve: curves.interpolatingSpring(0, 1, 228, 30),
              })
          }
          .width(50)
          .height(30)
          .onClick(() => {
            this.scanning = !this.scanning;
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button('Add Marker')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const newMarker: Marker = {
                id: Date.now().toString(),
                x: Math.random() * (580 - 80) + 80,
                y: Math.random() * (650 - 150) + 150,
                label: `N${this.markers.length + 1}`,
              };
              this.markers = [...this.markers, newMarker];
              this.drawCanvas();
            }
          })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [`${AppTokens.Colors.secondary}4D`, 0.0],
          [AppTokens.Colors.background, 0.5],
          [`${AppTokens.Colors.primary}4D`, 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}