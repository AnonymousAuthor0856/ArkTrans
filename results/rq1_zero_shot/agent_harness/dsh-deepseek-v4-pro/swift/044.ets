// MARK: - AppTokens
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF7042',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B3',
    outline: '#D6CCC7',
    success: '#66BA6B',
    warning: '#FFC929',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2624',
    onBackground: '#3D2624',
    onSurface: '#3D2624'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 6.0, medium: 10.0, large: 16.0
  }

  static readonly Spacing: NumberTokens = {
    sm: 6.0, md: 10.0, lg: 16.0, xl: 24.0
  }
}

// MARK: - CustomSlider
@Component
struct CustomSlider {
  @Link value: number
  activeColor: string = ''
  inactiveColor: string = ''
  thumbColor: string = ''
  trackHeight: number = 10
  thumbDiameter: number = 20

  build() {
    Slider({ value: this.value, min: 0, max: 1, style: SliderStyle.OutSet })
      .trackColor(this.inactiveColor)
      .selectedColor(this.activeColor)
      .blockColor(this.thumbColor)
      .trackThickness(this.trackHeight)
      .onChange((v: number) => {
        this.value = v
      })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct Index {
  @State progress: number = 0.42

  build() {
    Stack() {
      // 背景色铺满整个屏幕。
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // 订单信息卡片
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 进度条
          Progress({ value: this.progress, total: 1.0, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .height(10)

          // 进度文本
          Row() {
            Text('Processing')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.secondary)

            Blank()

            Text(Math.floor(this.progress * 100).toString() + '%')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4
        })

        // 进度调整区域
        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $this.progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary
          })

          Button('Mark as Delivered')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}
