@Entry
@Component
struct AfterSaleService {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  private primaryColor: string = '#FF8E6BF2'
  private secondaryColor: string = '#FFD3C1FF'
  private tertiaryColor: string = '#FFB39DDB'
  private bgColor: string = '#FFF5F3FF'
  private surfaceColor: string = '#FFFFFFFF'
  private surfaceVariantBg: string = '#FFECE6F8'
  private borderColor: string = '#FFD1C4E9'
  private onBgColor: string = '#FF2E1A47'
  private onSurfaceColor: string = '#FF2E1A47'
  private successColor: string = '#FF4CAF50'
  private placeholderColor: string = '#802E1A47'

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onBgColor)
        .width('100%')
        .margin({ top: 24, bottom: 24 })

      Column() {
        Text('Order ID')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .width('100%')
          .margin({ top: 16, bottom: 12 })

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .width('100%')
          .height(100)
          .backgroundColor(this.surfaceVariantBg)
          .borderRadius(28)
          .placeholderColor(this.placeholderColor)
          .fontColor(this.onSurfaceColor)
          .fontSize(28)
          .padding({ left: 24, right: 24 })
          .onChange((val: string) => {
            this.orderId = val
          })

        Text('Issue Description')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .width('100%')
          .margin({ top: 20, bottom: 12 })

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .width('100%')
          .height(220)
          .backgroundColor(this.surfaceVariantBg)
          .borderRadius(28)
          .placeholderColor(this.placeholderColor)
          .fontColor(this.onSurfaceColor)
          .fontSize(28)
          .padding(24)
          .onChange((val: string) => {
            this.issue = val
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.surfaceColor)
      .borderRadius(40)
      .shadow({
        radius: 24,
        color: 'rgba(142, 107, 242, 0.22)',
        offsetX: 0,
        offsetY: 8
      })

      Button('Submit Request', { type: ButtonType.Normal })
        .width('100%')
        .height(112)
        .backgroundColor(this.primaryColor)
        .fontColor(Color.White)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .borderRadius(40)
        .margin({ top: 32 })
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(28)
            .fontColor(this.successColor)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('rgba(76, 175, 80, 0.15)')
        .borderRadius(28)
        .margin({ top: 24 })
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .padding(32)
    .backgroundColor(this.bgColor)
  }
}
