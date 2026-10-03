class AppTokens {
  static readonly Colors = {
    primary: '#FFFF7042',
    secondary: '#FFFFB84C',
    tertiary: '#FFFFD180',
    background: '#FFFFF2E0',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFE0B3',
    outline: '#FFD6CCC7',
    success: '#FF66BB6B',
    warning: '#FFFCAC29',
    error: '#FFD42E2E',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF3D2623',
    onBackground: '#FF3D2623',
    onSurface: '#FF3D2623',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')

          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(10)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(5)

          Row() {
            Text('Processing')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.secondary)
              .layoutWeight(1)

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#26000000', offsetY: 4 })

        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          Slider({
            value: this.progress,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.progress = value
            })

          Button('Mark as Delivered')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(40)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}