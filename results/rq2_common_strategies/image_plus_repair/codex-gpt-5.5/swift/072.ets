const RF_BACKGROUND: string = '#FBF8F3'
const RF_CARD_BACKGROUND: string = '#F7F3EE'
const RF_HEADER_CIRCLE: string = '#EBE2D6'
const RF_TEXT_DARK: string = '#3D352E'
const RF_TEXT_GRAY: string = '#8A8A8E'
const RF_BORDER: string = '#C5B8A9'
const RF_BUTTON_BACK: string = '#EBE2D6'
const RF_BUTTON_NEXT: string = '#B58B5A'

@Entry
@Component
struct ReliefFundApp {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Stack() {
      Scroll() {
        Column({ space: 24 }) {
          this.header()
          this.applicantCard()
          this.summaryCard()
        }
        .width('100%')
        .padding({ left: 32, right: 32, bottom: 40 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .backgroundColor(RF_BACKGROUND)
    .width('100%')
    .height('100%')
  }

  @Builder
  header() {
    Row() {
      Blank()
        .width(96)
        .height(96)
        .borderRadius(48)
        .backgroundColor(RF_HEADER_CIRCLE)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(RF_TEXT_DARK)
          .textAlign(TextAlign.Center)

        Text('Civic support intake')
          .fontSize(26)
          .fontColor(RF_TEXT_GRAY)
          .textAlign(TextAlign.Center)
      }

      Blank()
        .layoutWeight(1)

      Blank()
        .width(96)
        .height(96)
        .borderRadius(48)
        .backgroundColor(RF_HEADER_CIRCLE)
    }
    .width('100%')
    .padding({ top: 20, left: 16, right: 16, bottom: 20 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  applicantCard() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor(RF_TEXT_DARK)
        .margin({ bottom: 12 })

      this.textField('Full name', this.fullName, (value: string) => {
        this.fullName = value
      })

      this.textField('Organization', this.organization, (value: string) => {
        this.organization = value
      })

      this.textField('Contact', this.contact, (value: string) => {
        this.contact = value
      })

      Column() {
        this.textField('Relief narrative', this.narrative, (value: string) => {
          this.narrative = value
        })
      }
      .width('100%')
      .margin({ bottom: 90 })

      Row({ space: 24 }) {
        this.formButton('Back', false)
        this.formButton('Next', true)
      }
      .width('100%')
      .height(226)
      .margin({ top: 0 })
    }
    .width('100%')
    .height(1027)
    .padding({ top: 52, left: 48, right: 48, bottom: 48 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(RF_CARD_BACKGROUND)
    .borderRadius(64)
  }

  @Builder
  textField(placeholder: string, value: string, onChange: (value: string) => void) {
    TextInput({ placeholder: placeholder, text: value })
      .fontSize(30)
      .fontColor(RF_TEXT_DARK)
      .placeholderColor('#B9B5B3')
      .padding({ left: 32, right: 20 })
      .height(38)
      .width('100%')
      .backgroundColor(RF_BACKGROUND)
      .borderRadius(19)
      .border({ width: 3, color: RF_BORDER })
      .onChange((nextValue: string) => {
        onChange(nextValue)
      })
  }

  @Builder
  formButton(label: string, primary: boolean) {
    Button(label)
      .fontSize(30)
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Medium)
      .height(226)
      .layoutWeight(1)
      .backgroundColor(primary ? RF_BUTTON_NEXT : RF_BUTTON_BACK)
      .borderRadius(32)
      .onClick(() => {
        if (primary) {
          this.narrative = this.narrative
        }
      })
  }

  @Builder
  summaryCard() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor(RF_TEXT_DARK)

      Row() {
        Text('Requested')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(RF_TEXT_DARK)

        Blank()
          .layoutWeight(1)

        Text('$4,500')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .height(80)
      .padding({ left: 32, right: 32 })
      .backgroundColor(RF_HEADER_CIRCLE)
      .borderRadius(32)
    }
    .width('100%')
    .padding(48)
    .backgroundColor(RF_CARD_BACKGROUND)
    .borderRadius(64)
  }
}
