// ReliefFund - Civic support intake
// Converted from SwiftUI to ArkTS

@Entry
@Component
struct ReliefFundApp {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FBF8F3')

      Column() {
        // Header
        Row() {
          Circle()
            .width(48)
            .height(48)
            .fill('#EBE2D6')

          Column() {
            Text('ReliefFund')
              .fontSize(19)
              .fontWeight(FontWeight.Bold)
              .fontColor('#3D352E')
            Text('Civic support intake')
              .fontSize(13)
              .fontWeight(FontWeight.Regular)
              .fontColor('#8A8A8E')
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)

          Circle()
            .width(48)
            .height(48)
            .fill('#EBE2D6')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 10, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column() {
            // Applicant Details Card
            this.ApplicantDetailsCard()

            // Summary Card
            this.SummaryCard()
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ApplicantDetailsCard() {
    Column() {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')
        .margin({ bottom: 4 })
        .width('100%')
        .textAlign(TextAlign.Start)

      // Full name
      TextInput({ placeholder: 'Full name', text: this.fullName })
        .fontSize(16)
        .fontColor('#3D352E')
        .placeholderColor('#6D5F58')
        .placeholderFont({ size: 24 })
        .width('100%')
        .height(48)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FBF8F3')
        .borderRadius(24)
        .border({ width: 1.5, color: '#C5B8A9' })
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.fullName = value
        })

      // Organization
      TextInput({ placeholder: 'Organization', text: this.organization })
        .fontSize(16)
        .fontColor('#3D352E')
        .placeholderColor('#6D5F58')
        .placeholderFont({ size: 24 })
        .width('100%')
        .height(48)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FBF8F3')
        .borderRadius(24)
        .border({ width: 1.5, color: '#C5B8A9' })
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.organization = value
        })

      // Contact
      TextInput({ placeholder: 'Contact', text: this.contact })
        .fontSize(16)
        .fontColor('#3D352E')
        .placeholderColor('#6D5F58')
        .placeholderFont({ size: 24 })
        .width('100%')
        .height(48)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FBF8F3')
        .borderRadius(24)
        .border({ width: 1.5, color: '#C5B8A9' })
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.contact = value
        })

      // Relief narrative
      TextArea({ placeholder: 'Relief narrative', text: this.narrative })
        .fontSize(16)
        .fontColor('#3D352E')
        .placeholderColor('#6D5F58')
        .placeholderFont({ size: 24 })
        .width('100%')
        .height(48)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FBF8F3')
        .borderRadius(24)
        .border({ width: 1.5, color: '#C5B8A9' })
        .margin({ bottom: 90 })
        .onChange((value: string) => {
          this.narrative = value
        })

      // Navigation Buttons
      Row() {
        Button('Back')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .backgroundColor('#EBE2D6')
          .borderRadius(24)
          .height(120)
          .layoutWeight(1)
          .margin({ right: 6 })

        Button('Next')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .backgroundColor('#B58B5A')
          .borderRadius(24)
          .height(120)
          .layoutWeight(1)
          .margin({ left: 6 })
      }
      .width('100%')
      .margin({ top: 0 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')
        .margin({ bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Start)

      // Summary Row
      Row() {
        Text('Requested')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3D352E')

        Blank()

        Text('$4,500')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#EBE2D6')
      .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}
