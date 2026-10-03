class AppColors {
  primary: string = '#FF7043'
  secondary: string = '#FFB74D'
  tertiary: string = '#FFD180'
  background: string = '#FFF3E0'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#FFE0B2'
  outline: string = '#D7CCC8'
  success: string = '#66BB6A'
  warning: string = '#FFCA28'
  error: string = '#D32F2F'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#3E2723'
  onBackground: string = '#3E2723'
  onSurface: string = '#3E2723'
}

@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 0.45

  private readonly colors: AppColors = new AppColors()
  private readonly spacingLg: number = 16
  private readonly spacingMd: number = 10
  private readonly spacingSm: number = 6
  private readonly radiusLarge: number = 16
  private readonly radiusMedium: number = 10

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onBackground)
        .width('100%')

      Column() {
        Text('Order #25491')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .width('100%')

        Text('Estimated Delivery: 2 days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.colors.secondary)
          .width('100%')
          .margin({ top: this.spacingSm })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(10)
          .color(this.colors.primary)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(5)
          .margin({ top: this.spacingMd })

        Row() {
          Text('Processing')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.secondary)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: this.spacingSm })
      }
      .width('100%')
      .padding(this.spacingLg)
      .backgroundColor(this.colors.surface)
      .borderRadius(this.radiusLarge)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetY: 4
      })

      Column() {
        Text('Adjust Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .width('100%')

        Slider({
          value: this.progress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(this.colors.primary)
          .trackColor(this.colors.surfaceVariant)
          .selectedColor(this.colors.primary)
          .onChange((value: number) => {
            this.progress = value / 100
          })
          .margin({ top: this.spacingSm })

        Button('Mark as Delivered')
          .width('100%')
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onPrimary)
          .backgroundColor(this.colors.primary)
          .borderRadius(this.radiusMedium)
          .onClick(() => {
            this.progress = 1.0
          })
          .margin({ top: this.spacingMd })
      }
      .width('100%')
      .padding(this.spacingLg)
      .backgroundColor(this.colors.surface)
      .borderRadius(this.radiusLarge)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(this.spacingLg)
    .backgroundColor(this.colors.background)
    .justifyContent(FlexAlign.Start)
  }
}
