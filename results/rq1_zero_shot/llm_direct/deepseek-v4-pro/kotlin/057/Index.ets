@Entry
@Component
struct RootScreen {
  @State private var isDark: boolean = false

  private readonly primaryColor: string = '#2563EB'
  private readonly secondaryColor: string = '#38BDF8'
  private readonly tertiaryColor: string = '#60A5FA'
  private readonly backgroundColor: string = '#F8FAFC'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly surfaceVariantColor: string = '#E2E8F0'
  private readonly outlineColor: string = '#CBD5E1'
  private readonly onPrimaryColor: string = '#FFFFFF'
  private readonly onSecondaryColor: string = '#0F172A'
  private readonly onBackgroundColor: string = '#0F172A'
  private readonly onSurfaceColor: string = '#1E293B'

  @Builder
  TopBar() {
    Row() {
      Row() {
        Button() {
          Text('<')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimaryColor)
        }
        .width(24)
        .height(24)
        .backgroundColor(this.primaryColor)
        .borderRadius(12)
        .padding(0)
        .margin({ left: 16, top: 8 })

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ left: 8, top: 8 })
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Button() {
        Text('?')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSecondaryColor)
      }
      .width(24)
      .height(24)
      .backgroundColor(this.secondaryColor)
      .borderRadius(12)
      .padding(0)
      .margin({ right: 16, top: 8 })
    }
    .width('100%')
    .height(56)
    .backgroundColor(this.surfaceColor)
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Column() {
          Text('😴')
            .fontSize(48)
            .width(160)
            .height(160)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.surfaceColor)
            .borderRadius(80)
            .border({ width: 2, color: this.outlineColor, radius: 80 })
            .margin({ top: 36 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 24 })
          .textAlign(TextAlign.Center)
          .width('100%')

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.onSurfaceColor)
          .margin({ top: 12, left: 24, right: 24 })
          .textAlign(TextAlign.Center)
          .width('100%')

        Button('Sign In')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimaryColor)
          .backgroundColor(this.primaryColor)
          .borderRadius(16)
          .width('80%')
          .height(52)
          .margin({ top: 36 })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[this.secondaryColor, 0.15], [this.primaryColor, 0.1]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}