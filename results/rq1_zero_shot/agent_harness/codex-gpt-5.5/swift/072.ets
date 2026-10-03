class ReliefColors {
  static background: string = '#FBF8F3';
  static cardBg: string = '#F7F3EE';
  static headerCircle: string = '#EBE2D6';
  static summaryRow: string = '#EBE2D6';
  static textDark: string = '#3D352E';
  static textGray: string = '#8A8A8E';
  static placeholder: string = '#6D5F58';
  static border: string = '#C5B8A9';
  static buttonBack: string = '#EBE2D6';
  static buttonNext: string = '#B58B5A';
}

@Entry
@Component
struct ContentView {
  @State private fullName: string = '';
  @State private organization: string = '';
  @State private contact: string = '';
  @State private narrative: string = '';

  @Builder
  private HeaderView() {
    Row() {
      Circle().width(48).height(48).fill(ReliefColors.headerCircle)
      Blank()
      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(ReliefColors.textDark)
        Text('Civic support intake')
          .fontSize(13)
          .fontColor(ReliefColors.textGray)
      }
      Blank()
      Circle().width(48).height(48).fill(ReliefColors.headerCircle)
    }
    .padding({ left: 24, right: 24 })
    .width('100%')
  }

  @Builder
  private CustomTextField(placeholder: string, value: string, key: string) {
    TextInput({ placeholder: placeholder, text: value })
      .fontSize(16)
      .fontColor(ReliefColors.textDark)
      .height(40)
      .padding({ left: 16, right: 16 })
      .backgroundColor(ReliefColors.background)
      .borderRadius(16)
      .border({ width: 1.5, color: ReliefColors.border })
      .onChange((text: string) => {
        if (key === 'name') {
          this.fullName = text;
        } else if (key === 'org') {
          this.organization = text;
        } else if (key === 'contact') {
          this.contact = text;
        } else {
          this.narrative = text;
        }
      })
  }

  @Builder
  private FormButton(label: string, isPrimary: boolean) {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .height(96)
      .layoutWeight(1)
      .backgroundColor(isPrimary ? ReliefColors.buttonNext : ReliefColors.buttonBack)
      .borderRadius(16)
  }

  @Builder
  private ApplicantDetailsCard() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.textDark)
        .padding({ bottom: 4 })
        .width('100%')
        .textAlign(TextAlign.Start)

      this.CustomTextField('Full name', this.fullName, 'name')
      this.CustomTextField('Organization', this.organization, 'org')
      this.CustomTextField('Contact', this.contact, 'contact')

      TextInput({ placeholder: 'Relief narrative', text: this.narrative })
        .fontSize(16)
        .fontColor(ReliefColors.textDark)
        .height(40)
        .padding({ left: 16, right: 16 })
        .backgroundColor(ReliefColors.background)
        .borderRadius(16)
        .border({ width: 1.5, color: ReliefColors.border })
        .margin({ bottom: 90 })
        .onChange((text: string) => {
          this.narrative = text;
        })

      Row({ space: 2 }) {
        this.FormButton('Back', false)
        Blank()
        this.FormButton('Next', true)
      }
      .padding({ top: 80 })
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
    .backgroundColor(ReliefColors.cardBg)
    .borderRadius(32)
  }

  @Builder
  private SummaryRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(ReliefColors.textDark)
      Blank()
      Text(value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .padding(20)
    .width('100%')
    .backgroundColor(ReliefColors.summaryRow)
    .borderRadius(16)
  }

  @Builder
  private SummaryCard() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.textDark)
        .width('100%')
        .textAlign(TextAlign.Start)
      this.SummaryRow('Requested', '$4,500')
    }
    .padding(24)
    .width('100%')
    .backgroundColor(ReliefColors.cardBg)
    .borderRadius(32)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderView()
          .padding({ top: 10, bottom: 20 })

        Scroll() {
          Column({ space: 24 }) {
            this.ApplicantDetailsCard()
            this.SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ReliefColors.background)
  }
}
