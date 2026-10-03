@Entry
@Component
struct Index {
  @State orderId: string = ''
  @State orderIdIsFocused: boolean = false
  @State issue: string = ''
  @State issueIsFocused: boolean = false
  @State submitted: boolean = false

  build() {
    Stack() {
      Column({ space: 12 }) {
        Text('After-Sale Service')
          .fontColor('#2E1A47')
          .fontSize(28)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column() {
          Text('Order ID')
            .fontColor('#2E1A47')
            .fontSize(18)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('Enter order number')
              .padding({ top: (56 - 14) / 2, bottom: (56 - 14) / 2, left: 8, right: 8 })
              .fontColor('#2E1A47')
              .opacity(0.5)
              .fontSize(14)

            TextInput({ text: this.orderId })
              .backgroundColor('#ECE6F8')
              .height(56)
              .borderRadius(8)
              .border({ width: 1, color: this.orderIdIsFocused ? '#8E6BF2' : '#D1C4E9', radius: 8 })
              .padding({ left: 8, right: 8 })
              .fontColor('#2E1A47')
              .fontSize(14)
              .onChange((value: string) => {
                this.orderId = value
              })
              .onFocus(() => {
                this.orderIdIsFocused = true
              })
              .onBlur(() => {
                this.orderIdIsFocused = false
              })
          }

          Text('Issue Description')
            .fontColor('#2E1A47')
            .fontSize(18)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('Describe your issue')
              .padding({ top: 8, bottom: 8, left: 8, right: 8 })
              .fontColor('#2E1A47')
              .opacity(0.5)
              .fontSize(14)

            TextArea({ text: this.issue, placeholder: '' })
              .backgroundColor('#ECE6F8')
              .height(120)
              .borderRadius(8)
              .border({ width: 1, color: this.issueIsFocused ? '#8E6BF2' : '#D1C4E9', radius: 8 })
              .padding({ top: 8, bottom: 8, left: 8, right: 8 })
              .fontColor('#2E1A47')
              .fontSize(14)
              .onChange((value: string) => {
                this.issue = value
              })
              .onFocus(() => {
                this.issueIsFocused = true
              })
              .onBlur(() => {
                this.issueIsFocused = false
              })
          }
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
        .padding(16)
        .width('100%')

        Button('Submit Request')
          .type(ButtonType.Capsule)
          .backgroundColor('#8E6BF2')
          .height(56)
          .width('100%')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Text('Request submitted successfully!')
            .textAlign(TextAlign.Center)
            .borderRadius(8)
            .backgroundColor('#4CAF50')
            .opacity(0.15)
            .padding(12)
            .width('100%')
            .fontColor('#4CAF50')
            .fontSize(14)
        }

        Blank()
      }
      .padding(12)
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}