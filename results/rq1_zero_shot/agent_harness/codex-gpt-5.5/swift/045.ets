@Entry
@Component
struct RootScreen {
  @State private orderId: string = '';
  @State private issue: string = '';
  @State private submitted: boolean = false;

  @Builder
  FormCard() {
    Column() {
      Text('Order ID')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2E1A47')
      TextInput({ text: this.orderId, placeholder: 'Enter order number' })
        .fontSize(14)
        .fontColor('#2E1A47')
        .placeholderColor('#802E1A47')
        .backgroundColor('#ECE6F8')
        .border({ width: 1, color: '#D1C4E9', radius: 14 })
        .borderRadius(14)
        .height(56)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10 })
        .onChange((value: string) => {
          this.orderId = value;
        })

      Text('Issue Description')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2E1A47')
        .margin({ top: 10 })
      TextArea({ text: this.issue, placeholder: 'Describe your issue' })
        .fontSize(14)
        .fontColor('#2E1A47')
        .placeholderColor('#802E1A47')
        .backgroundColor('#ECE6F8')
        .border({ width: 1, color: '#D1C4E9', radius: 14 })
        .borderRadius(14)
        .height(120)
        .padding({ left: 10, right: 10, top: 10, bottom: 10 })
        .margin({ top: 10 })
        .onChange((value: string) => {
          this.issue = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 12, color: '#38D1C4E9', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E1A47')
        .width('100%')
      this.FormCard()
        .margin({ top: 16 })
      Button('Submit Request')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#8E6BF2')
        .width('100%')
        .height(56)
        .borderRadius(20)
        .margin({ top: 16 })
        .onClick(() => {
          this.submitted = true;
        })
      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(14)
          .fontColor('#4CAF50')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding(16)
          .backgroundColor('#264CAF50')
          .borderRadius(14)
          .margin({ top: 16 })
      }
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F3FF')
  }
}
