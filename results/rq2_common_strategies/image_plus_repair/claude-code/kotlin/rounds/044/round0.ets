@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 0.42

  private readonly colors = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    background: '#FFF3E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    onSurface: '#3E2723',
    onBackground: '#3E2723',
    onPrimary: '#FFFFFF'
  }

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onBackground)
        .width('100%')
        .margin({ bottom: 24 })

      // Order Card
      Column() {
        Text('Order #25491')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .width('100%')
          .margin({ bottom: 12 })

        Text('Estimated Delivery: 2 days')
          .fontSize(24)
          .fontColor(this.colors.secondary)
          .width('100%')
          .margin({ bottom: 16 })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(18)
          .color(this.colors.primary)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(9)
          .margin({ bottom: 12 })

        Row() {
          Text('Processing')
            .fontSize(20)
            .fontColor(this.colors.secondary)
            .layoutWeight(1)

          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.primary)
        }
        .width('100%')
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.colors.surface)
      .borderRadius(32)
      .shadow({
        radius: 12,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetY: 4
      })
      .margin({ bottom: 24 })

      // Adjust Progress Box
      Column() {
        Text('Adjust Progress')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .margin({ bottom: 16 })

        Slider({
          value: this.progress * 100,
          min: 0,
          max: 100,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(this.colors.primary)
          .selectedColor(this.colors.primary)
          .trackColor(this.colors.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value / 100
          })
          .margin({ bottom: 16 })

        Button('Mark as Delivered')
          .width('100%')
          .height(56)
          .fontSize(20)
          .fontColor(this.colors.onPrimary)
          .backgroundColor(this.colors.primary)
          .borderRadius(20)
          .onClick(() => {
            this.progress = 1.0
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.colors.surface)
      .borderRadius(32)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding(24)
  }
}
