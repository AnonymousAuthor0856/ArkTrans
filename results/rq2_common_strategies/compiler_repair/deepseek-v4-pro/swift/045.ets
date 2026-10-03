@Entry
@Component
struct RootScreen {
  @State orderId: string = ""
  @State issue: string = ""
  @State submitted: boolean = false

  build() {
    Stack() {
      Column({ space: 16 }) {
        // Title
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF2E1A47')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card
        Column({ space: 10 }) {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF2E1A47')

          // Order ID input
          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF2E1A47')
            .placeholderColor('rgba(46,26,71,0.5)')
            .padding({ left: 10, right: 10 })
            .height(56)
            .backgroundColor('#FFECE6F8')
            .borderRadius(14)
            .border({ width: 1, color: '#FFD1C4E9' })
            .onChange((value: string) => {
              this.orderId = value
            })

          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF2E1A47')

          // Issue input (multiline approximated with height)
          TextInput({ placeholder: 'Describe your issue', text: this.issue })
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF2E1A47')
            .placeholderColor('rgba(46,26,71,0.5)')
            .padding({ left: 10, right: 10 })
            .height(120)
            .backgroundColor('#FFECE6F8')
            .borderRadius(14)
            .border({ width: 1, color: '#FFD1C4E9' })
            .onChange((value: string) => {
              this.issue = value
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(20)
        .shadow({ radius: 12, color: 'rgba(209,196,233,0.22)', offsetX: 0, offsetY: 4 })

        // Submit button
        Button() {
          Text('Submit Request')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFFFF')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FF8E6BF2')
        .borderRadius(20)
        .onClick(() => {
          this.submitted = true
        })

        // Success message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF4CAF50')
            .width('100%')
            .padding(16)
            .backgroundColor('rgba(76,175,80,0.15)')
            .borderRadius(14)
            .textAlign(TextAlign.Center)
        }

        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF5F3FF')
  }
}