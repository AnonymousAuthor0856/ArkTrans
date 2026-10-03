@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Section
        Row() {
          Circle().width(60).height(60).fill('#EAE1D8')
          Column() {
            Text('ReliefFund').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#333333')
            Text('Civic support intake').fontSize(14).fontColor('#757575').margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          
          Circle().width(60).height(60).fill('#EAE1D8')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 20, bottom: 20 })

        // Main Card Container
        Column({ space: 16 }) {
          // Title
          Text('Applicant details')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 4 })

          // Input Fields
          this.InputField('Full name')
          this.InputField('Organization')
          this.InputField('Contact')
          this.InputField('Relief narrative')

          // Spacer to push buttons down
          Blank()

          // Buttons Row
          Row({ space: 16 }) {
            Button('Back')
              .backgroundColor('#EAE1D8')
              .borderRadius(20)
              .height(120)
              .layoutWeight(1)
              .fontColor('#000000')
              .fontSize(18)
            
            Button('Next')
              .backgroundColor('#B89262')
              .borderRadius(20)
              .height(120)
              .layoutWeight(1)
              .fontColor('#000000')
              .fontSize(18)
          }
          .width('100%')
          .margin({ top: 20 })

        }
        .width('100%')
        .padding(24)
        .backgroundColor('#F9F5F0')
        .borderRadius(32)
        .margin({ top: 10 })
        .layoutWeight(1)

        // Summary Preview (Bottom cut off card)
        Column() {
          Text('Summary')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)
            .margin({ top: 24, left: 24 })
        }
        .width('100%')
        .height(100)
        .backgroundColor('#F9F5F0')
        .borderRadius({ topLeft: 32, topRight: 32 })
        .margin({ top: 20 })

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FDFBF7')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  InputField(placeholder: string) {
    TextInput({ placeholder: placeholder })
      .placeholderColor('#C5B8A9')
      .backgroundColor('#FBF8F3')
      .borderRadius(16)
      .height(44)
      .margin({ bottom: 12 })
      .padding({ left: 16 })
      .fontSize(16)
      .fontColor('#333333')
      .border({ width: 1.5, color: '#C5B8A9' })
  }
}