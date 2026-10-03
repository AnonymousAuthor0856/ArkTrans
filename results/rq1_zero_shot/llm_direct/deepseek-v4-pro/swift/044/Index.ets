@Entry
@Component
struct OrderTrackingScreen {
  @State private var progress: number = 0.42

  // Color tokens
  private readonly primaryColor: string = '#FF7042'
  private readonly secondaryColor: string = '#FFB84D'
  private readonly tertiaryColor: string = '#FFD180'
  private readonly backgroundColor: string = '#FFF2E0'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly surfaceVariantColor: string = '#FFE0B3'
  private readonly outlineColor: string = '#D6CCCC'
  private readonly successColor: string = '#66BA6B'
  private readonly warningColor: string = '#FFC929'
  private readonly errorColor: string = '#D42E2E'
  private readonly onPrimaryColor: string = '#FFFFFF'
  private readonly onSecondaryColor: string = '#3D2624'
  private readonly onBackgroundColor: string = '#3D2624'
  private readonly onSurfaceColor: string = '#3D2624'

  // Spacing tokens
  private readonly spacingSm: number = 6
  private readonly spacingMd: number = 10
  private readonly spacingLg: number = 16
  private readonly spacingXl: number = 24

  // Shape tokens
  private readonly shapeSmall: number = 6
  private readonly shapeMedium: number = 10
  private readonly shapeLarge: number = 16

  @Builder
  CustomSlider(activeColor: string, inactiveColor: string, thumbColor: string) {
    Stack({ alignContent: Alignment.Start }) {
      // Inactive track
      Row()
        .width('100%')
        .height(10)
        .backgroundColor(inactiveColor)
        .borderRadius(5)

      // Active track
      Row()
        .width(`${this.progress * 100}%`)
        .height(10)
        .backgroundColor(activeColor)
        .borderRadius(5)

      // Thumb
      Circle()
        .width(20)
        .height(20)
        .fill(thumbColor)
        .position({ x: `${this.progress * 100}%`, y: 5 })
        .translate({ x: -10, y: -5 })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.updateSliderValue(event)
            })
            .onActionUpdate((event: GestureEvent) => {
              this.updateSliderValue(event)
            })
        )
    }
    .width('100%')
    .height(20)
  }

  private updateSliderValue(event: GestureEvent) {
    const sliderWidth = 300 // Approximate width, will be refined
    const touchX = event.fingerList[0].localX
    const newValue = Math.min(Math.max(0, touchX / sliderWidth), 1)
    this.progress = newValue
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      // Main content
      Column({ space: this.spacingLg }) {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order info card
        Column({ space: this.spacingMd }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.secondaryColor)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress bar
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(10)
              .backgroundColor(this.surfaceVariantColor)
              .borderRadius(5)

            Row()
              .width(`${this.progress * 100}%`)
              .height(10)
              .backgroundColor(this.primaryColor)
              .borderRadius(5)
          }
          .width('100%')
          .height(10)

          // Progress text
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.secondaryColor)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primaryColor)
          }
          .width('100%')
        }
        .padding(this.spacingLg)
        .backgroundColor(this.surfaceColor)
        .borderRadius(this.shapeLarge)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4
        })

        // Adjust progress section
        Column({ space: this.spacingMd }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .width('100%')
            .textAlign(TextAlign.Center)

          this.CustomSlider(
            this.primaryColor,
            this.surfaceVariantColor,
            this.primaryColor
          )

          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimaryColor)
            .padding({ top: this.spacingMd, bottom: this.spacingMd })
            .width('100%')
            .backgroundColor(this.primaryColor)
            .borderRadius(this.shapeMedium)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .padding(this.spacingLg)
        .backgroundColor(this.surfaceColor)
        .borderRadius(this.shapeLarge)
      }
      .padding(this.spacingLg)
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}