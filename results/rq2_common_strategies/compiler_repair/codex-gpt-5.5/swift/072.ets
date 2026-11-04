class ReliefColors {
  static background: string = '#FBF8F3'
  static cardBg: string = '#F7F3EE'
  static headerCircle: string = '#EBE2D6'
  static summaryRow: string = '#EBE2D6'
  static textDark: string = '#3D352E'
  static textGray: string = '#8A8A8E'
  static placeholder: string = '#6D5F58'
  static border: string = '#C5B8A9'
  static buttonBack: string = '#EBE2D6'
  static buttonNext: string = '#B58B5A'
}

@Entry
@Component
struct Index {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  @Builder
  HeaderView() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill(ReliefColors.headerCircle)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(ReliefColors.textDark)
        Text('Civic support intake')
          .fontSize(13)
          .fontColor(ReliefColors.textGray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(48)
        .height(48)
        .fill(ReliefColors.headerCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 10, bottom: 20 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CustomTextField(placeholder: string, value: string, kind: number) {
    TextInput({ placeholder: placeholder, text: value })
      .fontSize(16)
      .fontColor(ReliefColors.textDark)
      .placeholderColor(ReliefColors.placeholder)
      .height(42)
      .padding({ left: 16, right: 16 })
      .backgroundColor(ReliefColors.background)
      .border({ width: 1.5, color: ReliefColors.border, radius: 16 })
      .onChange((text: string) => {
        if (kind === 0) {
          this.fullName = text
        } else if (kind === 1) {
          this.organization = text
        } else if (kind === 2) {
          this.contact = text
        } else {
          this.narrative = text
        }
      })
  }

  @Builder
  NarrativeField() {
    TextArea({ placeholder: 'Relief narrative', text: this.narrative })
      .fontSize(16)
      .fontColor(ReliefColors.textDark)
      .placeholderColor(ReliefColors.placeholder)
      .height(108)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(ReliefColors.background)
      .border({ width: 1.5, color: ReliefColors.border, radius: 16 })
      .onChange((text: string) => {
        this.narrative = text
      })
  }

  @Builder
  FormButton(label: string, isPrimary: boolean) {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .height(96)
      .layoutWeight(1)
      .backgroundColor(isPrimary ? ReliefColors.buttonNext : ReliefColors.buttonBack)
      .borderRadius(16)
  }

  @Builder
  ApplicantDetailsCard() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.textDark)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 4 })

      this.CustomTextField('Full name', this.fullName, 0)
      this.CustomTextField('Organization', this.organization, 1)
      this.CustomTextField('Contact', this.contact, 2)
      Column() {
        this.NarrativeField()
      }
      .width('100%')
      .margin({ bottom: 90 })

      Row({ space: 2 }) {
        this.FormButton('Back', false)
        Blank()
          .layoutWeight(0.1)
        this.FormButton('Next', true)
      }
      .width('100%')
      .margin({ top: 80 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(ReliefColors.cardBg)
    .borderRadius(32)
  }

  @Builder
  SummaryCard() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.textDark)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row() {
        Text('Requested')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(ReliefColors.textDark)
        Blank()
          .layoutWeight(1)
        Text('$4,500')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .padding(20)
      .backgroundColor(ReliefColors.summaryRow)
      .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(ReliefColors.cardBg)
    .borderRadius(32)
  }

  build() {
    Stack() {
      Column() {
        this.HeaderView()

        Scroll() {
          Column({ space: 24 }) {
            this.ApplicantDetailsCard()
            this.SummaryCard()
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ReliefColors.background)
  }
}
