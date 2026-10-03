// 051*InstallmentPlan*en
// UI Type: Finance
// Style Theme: Warm Gradient
// Language: en
// Baseline Size: 720x1280

class AppTokens {
  static readonly Colors = {
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

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  @State private paymentProgress: number = 0.3;

  private getProgressPercent(): string {
    return `${Math.round(this.paymentProgress * 100)}%`;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Installment Plan')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);

      // Content Area
      Scroll() {
        Column() {
          // Chart Card
          Column() {
            // Canvas Chart
            Canvas(this) {
              const w = this.context.size.width;
              const h = this.context.size.height;
              const step = w / 20;
              let prevY = h / 2;
              const context = this.context;
              
              for (let i = 0; i <= 20; i++) {
                const x = i * step;
                const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
                
                if (i > 0) {
                  context.beginPath();
                  context.moveTo(x - step, prevY);
                  context.lineTo(x, y);
                  context.lineWidth = 5;
                  context.strokeStyle = AppTokens.Colors.primary;
                  context.stroke();
                }
                prevY = y;
              }
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg);
          }
          .width('100%')
          .height(240)
          .padding(0)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          });

          // Payment Progress Title
          Text('Payment Progress')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.lg });

          // Linear Progress Indicator
          Row() {
            // Track
            Column() {
              // Active Track
              Column() {
              }
              .width(`${this.paymentProgress * 100}%`)
              .height('100%')
              .backgroundColor(AppTokens.Colors.primary);
            }
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.surfaceVariant);
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm });

          // Slider
          Row() {
            // Inactive Track
            Stack({ alignContent: Alignment.Start }) {
              Column()
                .width('100%')
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.surfaceVariant);

              // Active Track
              Column()
                .width(`${this.paymentProgress * 100}%`)
                .height(4)
                .borderRadius(2)
                .backgroundColor(AppTokens.Colors.primary);

              // Thumb
              Column()
                .width(20)
                .height(20)
                .borderRadius(10)
                .backgroundColor(AppTokens.Colors.secondary)
                .margin({ left: `${this.paymentProgress * 100}%` })
                .markAnchor({ x: -10, y: -8 });
            }
            .width('100%')
            .height(20)
            .alignItems(VerticalAlign.Center)
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  const parentOffset = event.target.area.position;
                  this.updateProgress(event.fingers[0].localX, parentOffset.width);
                })
                .onActionUpdate((event: GestureEvent) => {
                  const parentOffset = event.target.area.position;
                  this.updateProgress(event.fingers[0].localX, parentOffset.width);
                })
            );
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md });

          // Reset Button
          Button('Reset Progress')
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              this.paymentProgress = 0;
            });
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.25],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.25]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }

  private updateProgress(localX: number, width: number) {
    let progress = localX / width;
    if (progress < 0) progress = 0;
    if (progress > 1) progress = 1;
    this.paymentProgress = progress;
  }
}