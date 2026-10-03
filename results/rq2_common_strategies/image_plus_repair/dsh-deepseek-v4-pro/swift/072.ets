// MARK: - 2. Color Palette
// SwiftUI `Color(hex:)` is replaced by ArkUI string color resources.
class ColorPalette {
  // Backgrounds
  static readonly rfBackground: string = '#FBF8F3'
  static readonly rfCardBg: string = '#F7F3EE'

  // Header & Summary
  static readonly rfHeaderCircle: string = '#EBE2D6'
  static readonly rfSummaryRow: string = '#EBE2D6'

  // Text
  static readonly rfTextDark: string = '#3D352E'
  static readonly rfTextGray: string = '#8A8A8E'
  static readonly rfPlaceholder: string = '#6D5F58'

  // Buttons & Borders
  static readonly rfBorder: string = '#C5B8A9'
  static readonly rfButtonBack: string = '#EBE2D6'
  static readonly rfButtonNext: string = '#B58B5A'
}

// MARK: - 1. Entry Point
@Entry
@Component
struct ReliefFundApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 3. Main Content View
@Component
struct ContentView {
  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ColorPalette.rfBackground)

      Column({ space: 0 }) {
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
        .scrollBar(BarState.Off) // showsIndicators: false
        .layoutWeight(1)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    // Requirement: Hide Status Bar
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(ColorPalette.rfHeaderCircle)
      Blank()
      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(ColorPalette.rfTextDark)
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(ColorPalette.rfTextGray)
      }
      Blank()
      Circle({ width: 48, height: 48 })
        .fill(ColorPalette.rfHeaderCircle)
    }
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct ApplicantDetailsCard {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorPalette.rfTextDark)
        .padding({ bottom: 4 })

      // Form Fields
      CustomTextField({ placeholder: 'Full name', text: $fullName, fieldHeight: 18 })
      CustomTextField({ placeholder: 'Organization', text: $organization, fieldHeight: 18 })
      CustomTextField({ placeholder: 'Contact', text: $contact, fieldHeight: 18 })

      // Using a simple text field styled to look like a text editor for this layout
      CustomTextField({ placeholder: 'Relief narrative', text: $narrative, fieldHeight: 18, alignment: Alignment.TopStart })
        .padding({ bottom: 90 })

      // Navigation Buttons
      Row({ space: 2 }) {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
        FormButton({ label: 'Next', isPrimary: true })
      }
      .padding({ top: 80 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(ColorPalette.rfCardBg)
    .borderRadius(32)
  }
}

@Component
struct SummaryCard {
  build() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorPalette.rfTextDark)

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(ColorPalette.rfCardBg)
    .borderRadius(32)
  }
}

@Component
struct CustomTextField {
  placeholder: string = ''
  @Link text: string
  fieldHeight: number = 40
  alignment: Alignment = Alignment.Start

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .fontSize(16)
      .fontColor(ColorPalette.rfTextDark)
      .padding({ left: 16, right: 16 })
      .height(this.fieldHeight)
      .backgroundColor(ColorPalette.rfBackground) // Slightly lighter than card bg
      .borderRadius(16)
      .border({ width: 1.5, color: ColorPalette.rfBorder, radius: 16 })
      .onChange((value: string) => {
        this.text = value
      })
      .onClick(() => {
        // Allows tapping entire area
      })
  }
}

@Component
struct FormButton {
  label: string = ''
  isPrimary: boolean = false

  build() {
    Button() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .padding({ top: 48, bottom: 48 })
    .width('100%')
    .constraintSize({ maxWidth: 600 })
    .backgroundColor(this.isPrimary ? ColorPalette.rfButtonNext : ColorPalette.rfButtonBack)
    .borderRadius(16)
    .onClick(() => {
      // action: {}
    })
  }
}

@Component
struct SummaryRow {
  label: string = ''
  value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorPalette.rfTextDark)
      Blank()
      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .padding(20)
    .backgroundColor(ColorPalette.rfSummaryRow)
    .borderRadius(16)
  }
}

// MARK: - 5. Helper: Hex Color Initializer
// SwiftUI's `Color(hex:)` extension is not needed in ArkTS because
// ArkUI colors accept `#RRGGBB` / `#AARRGGBB` string literals directly
// (see the `ColorPalette` class above).
