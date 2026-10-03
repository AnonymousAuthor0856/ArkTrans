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

      Card() {
        Column() {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2E1A47')
            .margin({ bottom: 10 })

          TextInput({ placeholder: 'Enter order number' })
            .type(InputType.Normal)
            .backgroundColor('#ECE6F8')
            .borderRadius(14)
            .height(50)
            .onChange((value: string) => { this.orderId = value })

          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2E1A47')
            .margin({ top: 16, bottom: 10 })

          TextArea({ placeholder: 'Describe your issue' })
            .backgroundColor('#ECE6F8')
            .borderRadius(14)
            .height(120)
            .onChange((value: string) => { this.issue = value })
        }
        .padding(16)
      }
      .width('100%')
      .borderRadius(20)
      .shadow({ radius: 12, color: '#D3C1FF', offsetX: 0, offsetY: 4 })
      .margin({ bottom: 16 })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor('#8E6BF2')
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(20)
        .onClick(() => { this.submitted = true })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontColor('#4CAF50')
            .fontSize(14)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#4CAF501A')
        .borderRadius(14)
        .padding(16)
        .margin({ top: 16 })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F3FF')
  }
}