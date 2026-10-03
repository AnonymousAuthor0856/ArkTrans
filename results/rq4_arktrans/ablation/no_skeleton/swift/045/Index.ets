@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E1A47')
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: 10 }) {
        Text('Order ID')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ placeholder: 'Enter order number' })
          .placeholderColor('#6B5B95')
          .placeholderFont({ size: 14, weight: FontWeight.Normal })
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .height(56)
          .width('100%')
          .onChange((value: string) => { this.orderId = value })

        Text('Issue Description')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .width('100%')
          .textAlign(TextAlign.Start)

        TextArea({ placeholder: 'Describe your issue' })
          .placeholderColor('#6B5B95')
          .placeholderFont({ size: 14, weight: FontWeight.Normal })
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .height(120)
          .width('100%')
          .onChange((value: string) => { this.issue = value })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(20)
      .shadow({ radius: 12, color: '#33D1C4E9', offsetY: 4 })

      Button('Submit Request')
        .type(ButtonType.Capsule)
        .backgroundColor('#8E6BF2')
        .fontColor('#FFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .height(56)
        .width('100%')
        .onClick(() => { this.submitted = true })

      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#4CAF50')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(16)
          .backgroundColor('#1E4CAF50')
          .borderRadius(14)
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F3FF')
  }
}