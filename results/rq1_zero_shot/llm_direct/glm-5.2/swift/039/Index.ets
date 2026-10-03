// AppTokens.ets
// Unified UI tokens for colors, typography, shapes, spacing, and shadows

export class AppTokens {
  static Colors = {
    primary: '#FFA500',
    secondary: '#FFC107',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 6.0,
    medium: 12.0,
    large: 20.0,
  };

  static Spacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0,
  };

  static ShadowSpec = class {
    radius: number;
    dy: number;
    opacity: number;

    constructor(radius: number, dy: number, opacity: number) {
      this.radius = radius;
      this.dy = dy;
      this.opacity = opacity;
    }
  };

  static ElevationMapping = {
    level1: new AppTokens.ShadowSpec(4, 2, 0.12),
    level2: new AppTokens.ShadowSpec(8, 4, 0.18),
  };
}

// Helper function to convert hex color to rgba string for opacity
function hexToRgba(hex: string, opacity: number): string {
  const r = parseInt(hex.slice(1, 3), 16);
  const g = parseInt(hex.slice(3, 5), 16);
  const b = parseInt(hex.slice(5, 7), 16);
  return `rgba(${r}, ${g}, ${b}, ${opacity})`;
}

// CustomLinearProgressIndicator.ets
// Custom linear progress indicator component

@Component
export struct CustomLinearProgressIndicator {
  progress: number = 0.0;
  color: ResourceColor = Color.White;
  trackColor: ResourceColor = Color.Gray;
  height: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Background track
      Column()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.height / 2)

      // Progress bar
      Column()
        .width(`${this.progress * 100}%`)
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.height / 2)
    }
    .width('100%')
    .height(this.height)
  }
}

// SurfaceWithCanvas.ets
// Surface area containing Canvas drawing

@Component
export struct SurfaceWithCanvas {
  @Link paymentProgress: number;

  build() {
    Stack() {
      // Surface background and shadow
      Column()
        .width('100%')
        .height(240)
        .backgroundColor(hexToRgba(AppTokens.Colors.surface, 0.9))
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: hexToRgba('#000000', AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

      // Canvas drawing area
      Canvas(this)
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.lg)
        .onReady(() => this.draw())
    }
    .width('100%')
  }

  private draw() {
    const context = this.getCanvasContext();
    const w = context.width;
    const h = context.height;
    const step = w / 20; // 20 steps

    context.beginPath();
    
    // Calculate initial Y coordinate for x=0 and move to that point
    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    context.moveTo(0, initialY);

    // Draw subsequent line segments, starting from i=1
    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      context.lineTo(x, y);
    }
    
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;
    context.stroke();
  }
}

// RootScreen.ets
// Root view of the application

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3; // Payment progress state

  build() {
    Column() {
      // Top Bar
      Text('Installment Plan')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64)
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center)

      // Main content area
      Column({ space: AppTokens.Spacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: this.paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant,
          height: 8
        })
          .width('100%')

        // Custom Slider
        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value;
          })

        Button('Reset Progress')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0; // Reset progress
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [hexToRgba(AppTokens.Colors.secondary, 0.25), 0.0],
          [AppTokens.Colors.background, 0.5],
          [hexToRgba(AppTokens.Colors.primary, 0.25), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}