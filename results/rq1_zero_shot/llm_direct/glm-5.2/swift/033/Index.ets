// AppTokens
class AppTokens {
  static readonly colors = {
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

  static readonly typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static readonly spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly elevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

// Helper to convert ARGB hex string to ARGB integer
function hexToInt(hex: string): number {
  return parseInt(hex.replace('#', ''), 16);
}

// Helper to convert ARGB integer to RGBA string for ArkUI Color
function argbToRgba(argb: number, alpha: number = 1.0): string {
  const a = Math.floor((argb >> 24) & 0xFF) / 255.0;
  const r = (argb >> 16) & 0xFF;
  const g = (argb >> 8) & 0xFF;
  const b = argb & 0xFF;
  const finalAlpha = a === 0.0 ? alpha : a * alpha; 
  return `rgba(${r}, ${g}, ${b}, ${finalAlpha})`;
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500.0;
  goal: number = 1000.0;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTokens.typography.display.size)
          .fontWeight(AppTokens.typography.display.weight)
          .fontColor(argbToRgba(hexToInt(AppTokens.colors.onSurface)))
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.background)));

      // Main content area
      Scroll() {
        Column({ space: AppTokens.spacing.lg }) {
          // Surface Card
          Column() {
            Column() {
              Text('Current Spending')
                .fontSize(AppTokens.typography.title.size)
                .fontWeight(AppTokens.typography.title.weight)
                .fontColor(argbToRgba(hexToInt(AppTokens.colors.primary)));

              Blank();

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(AppTokens.typography.display.size)
                .fontWeight(AppTokens.typography.display.weight)
                .fontColor(argbToRgba(hexToInt(AppTokens.colors.onSurface)));

              Blank();

              // LinearProgressIndicator
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Column()
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.surfaceVariant)));
                
                // Progress
                Column()
                  .width(`${(this.spending / this.goal) * 100}%`)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.primary)));
              }
              .width('100%')
              .height(8);
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.spacing.lg)
            .justifyContent(FlexAlign.SpaceBetween);
          }
          .width('100%')
          .height(160)
          .borderRadius(AppTokens.shapes.large)
          .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.surface), 0.9))
          .shadow({
            radius: AppTokens.elevationMapping.level2.radius,
            color: `rgba(0, 0, 0, ${AppTokens.elevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.elevationMapping.level2.dy
          });

          Text('Adjust Spending')
            .fontSize(AppTokens.typography.title.size)
            .fontWeight(AppTokens.typography.title.weight)
            .fontColor(argbToRgba(hexToInt(AppTokens.colors.onSurface)));

          // Slider
          Row() {
            Column() {
              Slider({
                value: this.spending,
                min: 0,
                max: 2000,
                step: 1,
                style: SliderStyle.OutSet
              })
                .selectedColor(argbToRgba(hexToInt(AppTokens.colors.primary)))
                .trackColor(argbToRgba(hexToInt(AppTokens.colors.surfaceVariant), 0.5))
                .blockColor(argbToRgba(hexToInt(AppTokens.colors.secondary)))
                .onChange((value: number) => {
                  this.spending = value;
                });
            }
            .layoutWeight(1);
          }
          .width('100%');

          // Button
          Button('Reset', { type: ButtonType.Normal })
            .fontSize(AppTokens.typography.title.size)
            .fontWeight(AppTokens.typography.title.weight)
            .fontColor(argbToRgba(hexToInt(AppTokens.colors.onTertiary)))
            .width('100%')
            .height(48)
            .borderRadius(AppTokens.shapes.medium)
            .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.tertiary)))
            .onClick(() => {
              this.spending = 0.0;
            });
        }
        .width('100%')
        .padding(AppTokens.spacing.lg);
      }
      .layoutWeight(1)
      .backgroundColor({
        type: LinearGradientType.Linear,
        angle: 180,
        colors: [
          [argbToRgba(hexToInt(AppTokens.colors.secondary), 0.3), 0.0],
          [argbToRgba(hexToInt(AppTokens.colors.background), 1.0],
          [argbToRgba(hexToInt(AppTokens.colors.primary), 0.2), 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(argbToRgba(hexToInt(AppTokens.colors.background)));
  }
}