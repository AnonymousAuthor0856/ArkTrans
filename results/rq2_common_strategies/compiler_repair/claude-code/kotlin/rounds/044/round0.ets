@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 0.45

  private readonly Colors = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    tertiary: '#FFD180',
    background: '#FFF3E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    outline: '#D7CCC8',
    success: '#66BB6A',
    warning: '#FFCA28',
    error: '#D32F2F',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  }

  private readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }

  private readonly Radius = {
    small: 6,
    medium: 10,
    large: 16
  }

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.Colors.onBackground)
        .width('100%')

      // Order card
      Column() {
        Text('Order #25491')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onSurface)
          .width('100%')

        Text('Estimated Delivery: 2 days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.Colors.secondary)
          .width('100%')
          .margin({ top: this.Spacing.sm })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(10)
          .color(this.Colors.primary)
          .backgroundColor(this.Colors.surfaceVariant)
          .borderRadius(5)
          .margin({ top: this.Spacing.md })

        Row() {
          Text('Processing')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.Colors.secondary)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: this.Spacing.sm })
      }
      .width('100%')
      .padding(this.Spacing.lg)
      .backgroundColor(this.Colors.surface)
      .borderRadius(this.Radius.large)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetY: 4
      })

      // Progress adjustment section
      Column() {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onSurface)
          .width('100%')

        Slider({
          value: this.progress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(this.Colors.primary)
          .trackColor(this.Colors.surfaceVariant)
          .selectedColor(this.Colors.primary)
          .onChange((value: number) => {
            this.progress = value / 100
          })
          .margin({ top: this.Spacing.sm })

        Button('Mark as Delivered')
          .width('100%')
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onPrimary)
          .backgroundColor(this.Colors.primary)
          .borderRadius(this.Radius.medium)
          .onClick(() => {
            this.progress = 1.0
          })
          .margin({ top: this.Spacing.md })
      }
      .width('100%')
      .padding(this.Spacing.lg)
      .backgroundColor(this.Colors.surface)
      .borderRadius(this.Radius.large)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(this.Spacing.lg)
    .backgroundColor(this.Colors.background)
    .justifyContent(FlexAlign.Start)
  }
}
