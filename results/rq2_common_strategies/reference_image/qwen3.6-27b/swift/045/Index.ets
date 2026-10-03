@Entry
@Component
struct AfterSaleService {
  @State orderId: string = ''
  @State issueDescription: string = ''
  @State submitted: boolean = false

  build() {
    Column() {
      // Title
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E1A47')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 16 })

      // Card Container
      Column() {
        // Order ID Section
        Column() {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2E1A47')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })

          TextInput({ placeholder: 'Enter order number' })
            .type(InputType.Normal)
            .text(this.orderId)
            .onChange((value: string) => {
              this.orderId = value
            })
            .backgroundColor('#ECE6F8')
            .borderRadius(14)
            .height(56)
            .padding({ left: 10, right: 10 })
            .fontSize(14)
            .fontColor('#2E1A47')
            .placeholderColor('#2E1A4799')
            .border({ width: 1, color: '#D1C4E9' })
        }
        .width('100%')
        .margin({ bottom: 16 })

        // Issue Description Section
        Column() {
          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2E1A47')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })

          TextArea({ placeholder: 'Describe your issue' })
            .text(this.issueDescription)
            .onChange((value: string) => {
              this.issueDescription = value
            })
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .height(120)
            .padding({ left: 10, top: 10, right: 10, bottom: 10 })
            .fontSize(14)
            .fontColor('#2E1A47')
            .placeholderColor('#2E1A4799')
            .border({ width: 1, color: '#D1C4E9' })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .shadow({ radius: 12, color: '#D1C4E933', offsetY: 4 })
      .padding(16)
      .margin({ bottom: 16 })

      // Submit Button
      Button('Submit Request')
        .type(ButtonType.Capsule)
        .backgroundColor('#8E6BF2')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height(56)
        .onClick(() => {
          this.submitted = true
        })

      // Success Message
      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(14)
          .fontColor('#4CAF50')
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor('#4CAF5026')
          .borderRadius(14)
          .padding(16)
          .margin({ top: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F3FF')
    .padding(16)
  }
}