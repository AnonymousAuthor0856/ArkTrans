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
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E1A47')

        Column() {
          Column({ space: 10 }) {
            Text('Order ID')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')

            TextInput({ placeholder: 'Enter order number' })
              .placeholderColor('#9C8FA5')
              .backgroundColor('#EBE4F6')
              .borderRadius(16)
              .height(48)
              .padding({ left: 16, right: 16 })
              .onChange((value: string) => {
                this.orderId = value
              })

            Text('Issue Description')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E1A47')

            TextInput({ placeholder: 'Describe your issue' })
              .placeholderColor('#9C8FA5')
              .backgroundColor('#EBE4F6')
              .borderRadius(16)
              .height(120)
              .padding({ left: 16, top: 16, bottom: 16 })
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
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 4 })

        Button('Submit Request')
          .width('100%')
          .height(56)
          .backgroundColor('#8B5CF6')
          .borderRadius(28)
          .fontColor('#FFFFFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
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
          .borderRadius(12)
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