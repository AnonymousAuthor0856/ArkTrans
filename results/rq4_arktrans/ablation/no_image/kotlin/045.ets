@Entry
@Component
struct Index {
  @State orderId: string = ""
  @State issue: string = ""
  @State submitted: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('After-Sale Service')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E1A47')

        Column() {
          Column({ space: 10 }) {
            Text('Order ID')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')

            TextInput({ placeholder: 'Enter order number' })
              .width('100%')
              .backgroundColor('#F5F3FF')
              .borderRadius(8)
              .padding(12)
              .onChange((value: string) => {
                this.orderId = value
              })

            Text('Issue Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')

            TextInput({ placeholder: 'Describe your issue' })
              .width('100%')
              .height(120)
              .backgroundColor('#F5F3FF')
              .borderRadius(8)
              .padding(12)
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.issue = value
              })
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        Button('Submit Request')
          .width('100%')
          .height(56)
          .backgroundColor('#6750A4')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Request submitted successfully!')
              .fontColor('#4CAF50')
              .fontSize(16)
          }
          .width('100%')
          .backgroundColor('#E8F5E9')
          .borderRadius(8)
          .padding(16)
        }
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F5F3FF')
    }
    .width('100%')
    .height('100%')
  }
}