@Entry
@Component
struct Index {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E1A47')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card Container
        Column({ space: 16 }) {
          // Order ID Section
          Column() {
            Text('Order ID')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')
              .width('100%')
              .textAlign(TextAlign.Start)
            
            TextInput({ placeholder: 'Enter order number' })
              .type(InputType.Normal)
              .backgroundColor('#ECE6F8')
              .borderRadius(16)
              .height(56)
              .padding({ left: 16, right: 16 })
              .fontColor('#2E1A47')
              .placeholderColor('#2E1A4799')
              .fontSize(14)
              .border({ width: 1, color: '#D1C4E9' })
              .onChange((value: string) => {
                this.orderId = value
              })
          }

          // Issue Description Section
          Column() {
            Text('Issue Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')
              .width('100%')
              .textAlign(TextAlign.Start)

            TextArea({ placeholder: 'Describe your issue' })
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .height(120)
              .padding(16)
              .fontColor('#2E1A47')
              .placeholderColor('#2E1A4799')
              .fontSize(14)
              .border({ width: 1, color: '#D1C4E9' })
              .onChange((value: string) => {
                this.issue = value
              })
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#00000010', offsetY: 4 })

        // Submit Button
        Button('Submit Request')
          .width('100%')
          .height(56)
          .backgroundColor('#8E6BF2')
          .borderRadius(28)
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Text('Request submitted successfully!')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontSize(14)
            .fontColor('#4CAF50')
            .backgroundColor('#4CAF5026')
            .padding(12)
            .borderRadius(12)
        }

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F3F0FA')
    }.width('100%').height('100%')
  }
}