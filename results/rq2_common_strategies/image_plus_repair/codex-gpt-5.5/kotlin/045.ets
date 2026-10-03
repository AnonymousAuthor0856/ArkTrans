@Entry
@Component
struct AfterSaleServicePage {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  cPrimary: string = '#8E6BF2'
  cPageBg: string = '#F5F3FF'
  cSurface: string = '#FFFFFF'
  cSurfaceVariant: string = '#ECE6F8'
  cOutline: string = '#D1C4E9'
  cOnSurface: string = '#2E1A47'
  cPlaceholder: string = '#9184A6'
  cSuccess: string = '#4CAF50'

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cOnSurface)
        .width('100%')
        .margin({ top: 34, bottom: 36 })

      Column() {
        Text('Order ID')
          .fontSize(25)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)
          .width('100%')
          .margin({ bottom: 21 })

        TextInput({ text: this.orderId, placeholder: 'Enter order number' })
          .height(110)
          .width('100%')
          .fontSize(31)
          .fontColor(this.cOnSurface)
          .placeholderColor(this.cPlaceholder)
          .backgroundColor(this.cSurfaceVariant)
          .borderRadius(26)
          .padding({ left: 32, right: 28 })
          .border({ width: { bottom: 2 }, color: this.cOutline })
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)
          .width('100%')
          .margin({ top: 22, bottom: 22 })

        TextArea({ text: this.issue, placeholder: 'Describe your issue' })
          .height(239)
          .width('100%')
          .fontSize(30)
          .fontColor(this.cOnSurface)
          .placeholderColor(this.cPlaceholder)
          .backgroundColor(this.cSurfaceVariant)
          .borderRadius(26)
          .padding({ left: 32, right: 28, top: 31, bottom: 24 })
          .border({ width: { bottom: 2 }, color: this.cOutline })
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 32, bottom: 32 })
      .backgroundColor(this.cSurface)
      .borderRadius(32)
      .shadow({
        radius: 18,
        color: '#2BD1C4E9',
        offsetX: 9,
        offsetY: 8
      })
      .margin({ bottom: 32 })

      Button() {
        Text('Submit Request')
          .fontSize(33)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
        .width('100%')
        .height(112)
        .backgroundColor(this.cPrimary)
        .borderRadius(37)
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Text('Request submitted successfully!')
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontSize(22)
          .fontColor(this.cSuccess)
          .backgroundColor('#264CAF50')
          .borderRadius(14)
          .padding(24)
          .margin({ top: 24 })
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor(this.cPageBg)
  }
}
