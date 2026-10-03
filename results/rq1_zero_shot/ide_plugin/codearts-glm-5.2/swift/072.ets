class RfColors {
  static readonly background: string = '#FFFBF8F3'
  static readonly cardBg: string = '#FFF7F3EE'
  static readonly headerCircle: string = '#FFEBE2D6'
  static readonly summaryRow: string = '#FFEBE2D6'
  static readonly textDark: string = '#FF3D352E'
  static readonly textGray: string = '#FF8A8A8E'
  static readonly placeholder: string = '#FF6D5F58'
  static readonly border: string = '#FFC5B8A9'
  static readonly buttonBack: string = '#FFEBE2D6'
  static readonly buttonNext: string = '#FFB58B5A'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        HeaderView()

        Scroll() {
          Column() {
            ApplicantDetailsCard()
            SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
    }
    .backgroundColor(RfColors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(RfColors.headerCircle)

      Blank()

      Column() {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(RfColors.textDark)
        Text('Civic support intake')
          .fontSize(13)
          .fontColor(RfColors.textGray)
      }
      .margin({ top: 2, bottom: 2 })

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(RfColors.headerCircle)
    }
    .padding({ left: 24, right: 24 })
    .margin({ top: 10, bottom: 20 })
  }
}

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
        .fontColor(RfColors.textDark)
        .margin({ bottom: 20 })

      CustomTextField({ placeholder: 'Full name', text: this.fullName })
      CustomTextField({ placeholder: 'Organization', text: this.organization })
      CustomTextField({ placeholder: 'Contact', text: this.contact })

      CustomTextField({ placeholder: 'Relief narrative', text: this.narrative })
        .margin({ bottom: 90 })

      Row() {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
        FormButton({ label: 'Next', isPrimary: true })
      }
      .margin({ top: 80 })
    }
    .padding(24)
    .backgroundColor(RfColors.cardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SummaryCard {
  build() {
    Column() {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(RfColors.textDark)
        .margin({ bottom: 16 })

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .padding(24)
    .backgroundColor(RfColors.cardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CustomTextField {
  @Prop placeholder: string = ''
  @Prop text: string = ''

  build() {
    TextInput({ text: this.text, placeholder: this.placeholder })
      .fontSize(16)
      .fontColor(RfColors.textDark)
      .placeholderColor(RfColors.placeholder)
      .padding({ left: 16, right: 16 })
      .height(18)
      .backgroundColor(RfColors.background)
      .borderRadius(16)
      .border({ width: 1.5, color: RfColors.border })
  }
}

@Component
struct FormButton {
  @Prop label: string = ''
  @Prop isPrimary: boolean = false

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#FF000000')
      .textAlign(TextAlign.Center)
      .padding({ top: 48, bottom: 48 })
      .width(160)
      .backgroundColor(this.isPrimary ? RfColors.buttonNext : RfColors.buttonBack)
      .borderRadius(16)
  }
}

@Component
struct SummaryRow {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(RfColors.textDark)
      Blank()
      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF000000')
    }
    .padding(20)
    .backgroundColor(RfColors.summaryRow)
    .borderRadius(16)
  }
}