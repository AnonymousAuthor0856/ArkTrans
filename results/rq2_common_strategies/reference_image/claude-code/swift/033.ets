// AppTokens - Design system tokens
class AppTokens {
  static Colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
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
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500;
  private goal: number = 1000;

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area
      Scroll() {
        Column() {
          // Surface Card
          Stack({ alignContent: Alignment.TopStart }) {
            Column() {
              Text('Current Spending')
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.primary)

              Blank()

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(AppTokens.TypographyTokens.display.size)
                .fontWeight(AppTokens.TypographyTokens.display.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              // Linear Progress Indicator
              Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
                .width('100%')
                .height(8)
                .color(AppTokens.Colors.primary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
          }
          .width('100%')
          .height(160)
          .backgroundColor('rgba(255, 255, 255, 0.9)')
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.18)',
            offsetY: 4,
          })

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg })

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet,
          })
            .width('100%')
            .blockColor(Color.White)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.spending = value;
            })
            .margin({ top: AppTokens.Spacing.lg })

          // Reset Button
          Button('Reset', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0;
            })
            .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .background(this.gradientBackground())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  gradientBackground() {
    Column()
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [
          ['rgba(59, 130, 246, 0.3)', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(6, 182, 212, 0.2)', 1.0],
        ],
        direction: GradientDirection.Bottom,
      })
  }
}
