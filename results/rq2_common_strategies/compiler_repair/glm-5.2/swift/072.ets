// Color Palette Helper
function hexToColor(hex: string): ResourceColor {
  const cleanedHex = hex.replace('#', '');
  const r = parseInt(cleanedHex.substring(0, 2), 16);
  const g = parseInt(cleanedHex.substring(2, 4), 16);
  const b = parseInt(cleanedHex.substring(4, 6), 16);
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

// Colors
const rfBackground = hexToColor('FBF8F3');
const rfCardBg = hexToColor('F7F3EE');
const rfHeaderCircle = hexToColor('EBE2D6');
const rfSummaryRow = hexToColor('EBE2D6');
const rfTextDark = hexToColor('3D352E');
const rfTextGray = hexToColor('8A8A8E');
const rfPlaceholder = hexToColor('6D5F58');
const rfBorder = hexToColor('C5B8A9');
const rfButtonBack = hexToColor('EBE2D6');
const rfButtonNext = hexToColor('B58B5A');

@Entry
@Component
struct ContentView {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(rfBackground)

      Column() {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Main Form Card
            ApplicantDetailsCard()

            // Summary Card
            SummaryCard()
          }
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
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 }).fill(rfHeaderCircle)

      Blank()

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(rfTextDark)
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(rfTextGray)
      }

      Blank()

      Circle({ width: 48, height: 48 }).fill(rfHeaderCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct ApplicantDetailsCard {
  @State fullName: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  build() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(rfTextDark)
        .padding({ bottom: 4 })
        .alignSelf(ItemAlign.Start)

      // Form Fields
      CustomTextField({ placeholder: 'Full name', text: this.fullName, inputHeight: 48 })
      CustomTextField({ placeholder: 'Organization', text: this.organization, inputHeight: 48 })
      CustomTextField({ placeholder: 'Contact', text: this.contact, inputHeight: 48 })

      // Narrative Field
      Column() {
        CustomTextField({ placeholder: 'Relief narrative', text: this.narrative, inputHeight: 110 })
      }
      .padding({ bottom: 90 })

      // Navigation Buttons
      Row({ space: 2 }) {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
        FormButton({ label: 'Next', isPrimary: true })
      }
      .width('100%')
      .padding({ top: 80 })
    }
    .padding(24)
    .backgroundColor(rfCardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SummaryCard {
  build() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(rfTextDark)

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .padding(24)
    .backgroundColor(rfCardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CustomTextField {
  @Link text: string;
  placeholder: string = '';
  inputHeight: number = 40;

  build() {
    TextInput({ text: this.text, placeholder: this.placeholder })
      .type(this.inputHeight > 60 ? InputType.Normal : InputType.Normal) // Maps roughly to axis logic
      .fontSize(16)
      .fontColor(rfTextDark)
      .placeholderColor(rfPlaceholder)
      .padding({ left: 16, right: 16 })
      .height(this.inputHeight)
      .backgroundColor(rfBackground)
      .borderRadius(16)
      .border({ width: 1.5, color: rfBorder })
      .onChange((value: string) => {
        this.text = value;
      })
  }
}

@Component
struct FormButton {
  label: string = '';
  isPrimary: boolean = false;

  build() {
    Button(this.label, { type: ButtonType.Normal }) {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .height(48)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.isPrimary ? rfButtonNext : rfButtonBack)
    .borderRadius(16)
  }
}

@Component
struct SummaryRow {
  label: string = '';
  value: string = '';

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(rfTextDark)

      Blank()

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(rfSummaryRow)
    .borderRadius(16)
  }
}