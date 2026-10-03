@Entry
@Component
struct AfterSaleService {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E1A47')
        .margin({ bottom: 16 })

      Column() {
        Text('Order ID')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .margin({ bottom: 10 })

        TextInput({ placeholder: 'Enter order number' })
          .placeholderColor('#9B8CB3')
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .height(50)
          .margin({ bottom: 10 })
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .margin({ bottom: 10 })

        TextArea({ placeholder: 'Describe your issue' })
          .placeholderColor('#9B8CB3')
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .height(120)
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(20)
      .shadow({ radius: 12, color: '#D1C4E9', offsetX: 0, offsetY: 4 })
      .margin({ bottom: 16 })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor('#8E6BF2')
        .fontColor('#FFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(20)
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontColor('#4CAF50')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#4CAF50')
        .opacity(0.15)
        .borderRadius(14)
        .padding(16)
        .margin({ top: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F3FF')
  }
}