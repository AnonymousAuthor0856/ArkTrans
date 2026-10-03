// AppTokens - Design system tokens
class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF93C5FD',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E3A8A',
    onTertiary: '#FF1E40AF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 4.0,
    medium: 8.0,
    large: 16.0
  }

  static readonly Spacing = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  }

  static readonly Elevation = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18 }
  }
}

// Helper function to convert hex color to ARGB with opacity
function hexWithOpacity(hex: string, opacity: number): string {
  const alpha = Math.round(opacity * 255).toString(16).padStart(2, '0').toUpperCase();
  return alpha + hex.slice(2);
}

// Main Page Component
@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.5;

  build() {
    Column() {
      // Top App Bar
      Stack() {
        Text('Stock K-Line')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ top: 30 }) // Status bar space

      // Main Content Area
      Column() {
        // Chart Surface Card
        Stack() {
          // Canvas for K-Line drawing
          Canvas(this)
            .width('100%')
            .height('100%')
            .onReady((context: CanvasRenderingContext2D) => {
              this.drawChart(context)
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: hexWithOpacity(AppTokens.Colors.onBackground, AppTokens.Elevation.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.Elevation.level2.dy
        })
        .padding(AppTokens.Spacing.lg)

        Text('Market Trend')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.primary)
          .onChange((value: number) => {
            this.progress = value
          })

        // Linear Progress Indicator
        Row() {
          // Track background
          Stack() {
            // Progress fill
            Stack() {
            }
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
          }
          .width('100%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)
        }
        .width('100%')
        .height(8)
        .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [hexWithOpacity(AppTokens.Colors.secondary, 0.15), 0.0],
          [AppTokens.Colors.background, 0.5],
          [hexWithOpacity(AppTokens.Colors.primary, 0.15), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawChart(context: CanvasRenderingContext2D) {
    const width = context.canvas.width;
    const height = context.canvas.height;
    const step = width / 50.0;
    
    context.beginPath();
    context.moveTo(0, height / 2.0);
    
    // Draw sine wave
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      context.lineTo(x, y);
    }
    
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 4;
    context.lineCap = 'round';
    context.lineJoin = 'round';
    context.stroke();
  }
}