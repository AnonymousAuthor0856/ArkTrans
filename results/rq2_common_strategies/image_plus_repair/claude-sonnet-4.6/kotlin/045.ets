@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E1A47')
        .width('100%')

      Column({ space: 10 }) {
        Text('Order ID')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .width('100%')

        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .placeholderColor('#802E1A47')
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .borderWidth({ bottom: 2 })
          .borderColor('#D1C4E9')
          .fontColor('#2E1A47')
          .fontSize(14)
          .width('100%')
          .height(56)
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E1A47')
          .width('100%')

        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .placeholderColor('#802E1A47')
          .backgroundColor('#ECE6F8')
          .borderRadius(14)
          .borderWidth({ bottom: 2 })
          .borderColor('#D1C4E9')
          .fontColor('#2E1A47')
          .fontSize(14)
          .width('100%')
          .height(120)
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .shadow({
        radius: 12,
        color: '#38D3C1FF',
        offsetX: 0,
        offsetY: 4
      })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .backgroundColor('#8E6BF2')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(20)
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontColor('#4CAF50')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(16)
        .backgroundColor('#264CAF50')
        .borderRadius(14)
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F3FF')
    .alignItems(HorizontalAlign.Start)
  }
}