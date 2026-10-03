@Entry
@Component
struct ReliefFundApp {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderView()
          .margin({ top: 10, bottom: 20 })

        Scroll() {
          Column({ space: 24 }) {
            ApplicantDetailsCard()
            SummaryCard()
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
    .backgroundColor(RfColors.rfBackground)
  }
}

// MARK: - Color Palette
class RfColors {
  static readonly rfBackground: string = '#FBF8F3'
  static readonly rfCardBg: string = '#F7F3EE'
  static readonly rfHeaderCircle: string = '#EBE2D6'
  static readonly rfSummaryRow: string = '#EBE2D6'
  static readonly rfTextDark: string = '#3D352E'
  static readonly rfTextGray: string = '#8A8A8E'
  static readonly rfPlaceholder: string = '#6D5F58'
  static readonly rfBorder: string = '#C5B8A9'
  static readonly rfButtonBack: string = '#EBE2D6'
  static readonly rfButtonNext: string = '#B58B5A'
}

// MARK: - Header
@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(RfColors.rfHeaderCircle)

      Blank()

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(RfColors.rfTextDark)

        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(RfColors.rfTextGray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(RfColors.rfHeaderCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - Applicant Details Card
@Component
struct ApplicantDetailsCard {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Column() {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(RfColors.rfTextDark)
        .margin({ bottom: 20 })
        .alignSelf(ItemAlign.Start)

      CustomTextField({ placeholder: 'Full name', text: $fullName, fieldHeight: 50 })

      CustomTextField({ placeholder: 'Organization', text: $organization, fieldHeight: 50 })

      CustomTextField({ placeholder: 'Contact', text: $contact, fieldHeight: 50 })

      CustomTextField({ placeholder: 'Relief narrative', text: $narrative, fieldHeight: 108, multiLine: true })
        .margin({ bottom: 90 })

      Row({ space: 2 }) {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
        FormButton({ label: 'Next', isPrimary: true })
      }
      .width('100%')
      .margin({ top: 80 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(RfColors.rfCardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Summary Card
@Component
struct SummaryCard {
  build() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(RfColors.rfTextDark)
        .alignSelf(ItemAlign.Start)

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(RfColors.rfCardBg)
    .borderRadius(32)
  }
}

// MARK: - Custom TextField
@Component
struct CustomTextField {
  placeholder: string = ''
  @Link text: string
  fieldHeight: number = 50
  multiLine: boolean = false

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .placeholderColor(RfColors.rfPlaceholder)
      .fontSize(16)
      .fontColor(RfColors.rfTextDark)
      .width('100%')
      .height(this.fieldHeight)
      .padding({ left: 16, right: 16 })
      .backgroundColor(RfColors.rfBackground)
      .borderRadius(16)
      .border({ width: 1.5, color: RfColors.rfBorder })
      .onChange((value: string) => {
        this.text = value
      })
  }
}

// MARK: - Form Button
@Component
struct FormButton {
  label: string = ''
  isPrimary: boolean = false

  build() {
    Button(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .width('45%')
      .height(96)
      .backgroundColor(this.isPrimary ? RfColors.rfButtonNext : RfColors.rfButtonBack)
      .borderRadius(16)
      .onClick(() => {})
  }
}

// MARK: - Summary Row
@Component
struct SummaryRow {
  label: string = ''
  value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(RfColors.rfTextDark)

      Blank()

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor(RfColors.rfSummaryRow)
    .borderRadius(16)
  }
}
