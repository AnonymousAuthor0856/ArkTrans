@Entry
@Component
struct AfterSalePage {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  private readonly tokenPrimary: string = '#FF8E6BF2'
  private readonly tokenSecondary: string = '#FFD3C1FF'
  private readonly tokenTertiary: string = '#FFB39DDB'
  private readonly tokenBackground: string = '#FFF5F3FF'
  private readonly tokenSurface: string = '#FFFFFFFF'
  private readonly tokenSurfaceVariant: string = '#FFECE6F8'
  private readonly tokenOutline: string = '#FFD1C4E9'
  private readonly tokenSuccess: string = '#FF4CAF50'
  private readonly tokenOnPrimary: string = '#FFFFFFFF'
  private readonly tokenOnSecondary: string = '#FF2E1A47'
  private readonly tokenOnBackground: string = '#FF2E1A47'
  private readonly tokenOnSurface: string = '#FF2E1A47'

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.tokenOnBackground)
        .width('100%')
        .margin({ bottom: 16 })

      Column() {
        Text('Order ID')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.tokenOnSurface)
          .width('100%')
          .margin({ bottom: 10 })

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .width('100%')
          .height(48)
          .backgroundColor(this.tokenSurfaceVariant)
          .borderRadius(14)
          .padding({ left: 12, right: 12 })
          .fontColor(this.tokenOnSurface)
          .placeholderColor(this.tokenOnSurface + '80')
          .onChange((value: string) => {
            this.orderId = value
          })
          .margin({ bottom: 16 })

        Text('Issue Description')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.tokenOnSurface)
          .width('100%')
          .margin({ bottom: 10 })

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .width('100%')
          .height(120)
          .backgroundColor(this.tokenSurfaceVariant)
          .borderRadius(14)
          .padding(12)
          .fontColor(this.tokenOnSurface)
          .placeholderColor(this.tokenOnSurface + '80')
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.tokenSurface)
      .borderRadius(20)
      .shadow({
        radius: 12,
        color: this.secondaryColor,
        offsetY: 4,
        fill: false
      })
      .margin({ bottom: 16 })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor(this.primaryColor)
        .fontColor(this.onPrimaryColor)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(20)
        .onClick(() => {
          this.submitted = true
        })
        .margin({ bottom: 16 })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.successColor)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.successColor + '26')
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.backgroundColor)
  }
}
