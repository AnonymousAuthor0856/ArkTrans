// Translated from SwiftUI (072.swift) to ArkTS / ArkUI

// MARK: - Color Palette
const RF_BACKGROUND = '#FBF8F3';
const RF_CARD_BG = '#F7F3EE';
const RF_HEADER_CIRCLE = '#EBE2D6';
const RF_SUMMARY_ROW = '#EBE2D6';
const RF_TEXT_DARK = '#3D352E';
const RF_TEXT_GRAY = '#8A8A8E';
const RF_PLACEHOLDER = '#6D5F58';
const RF_BORDER = '#C5B8A9';
const RF_BUTTON_BACK = '#EBE2D6';
const RF_BUTTON_NEXT = '#B58B5A';

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            ApplicantDetailsCard()
            SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RF_BACKGROUND)
    // .statusBar(hidden: true)
  }
}

// MARK: - Components

@Component
struct HeaderView {
  build() {
    Row() {
      Blank().width(48).height(48).backgroundColor(RF_HEADER_CIRCLE).borderRadius(24)
      Blank()
      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(RF_TEXT_DARK)
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(RF_TEXT_GRAY)
      }
      Blank()
      Blank().width(48).height(48).backgroundColor(RF_HEADER_CIRCLE).borderRadius(24)
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
        .fontColor(RF_TEXT_DARK)
        .padding({ bottom: 4 })

      // Form Fields
      CustomTextField({ placeholder: 'Full name', text: $this.fullName, height: 18 })
      CustomTextField({ placeholder: 'Organization', text: $this.organization, height: 18 })
      CustomTextField({ placeholder: 'Contact', text: $this.contact, height: 18 })
      CustomTextField({ placeholder: 'Relief narrative', text: $this.narrative, height: 18 })
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
    .backgroundColor(RF_CARD_BG)
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
        .fontColor(RF_TEXT_DARK)

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(RF_CARD_BG)
    .borderRadius(32)
  }
}

@Component
struct CustomTextField {
  @Prop placeholder: string = ''
  @Link text: string
  @Prop height: number = 40

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .fontSize(16)
      .fontColor(RF_TEXT_DARK)
      .padding({ left: 16, right: 16 })
      .height(this.height)
      .backgroundColor(RF_BACKGROUND)
      .borderRadius(16)
      .border({ width: 1.5, color: RF_BORDER })
      .onChange((value: string) => {
        this.text = value
      })
  }
}

@Component
struct FormButton {
  @Prop label: string = ''
  @Prop isPrimary: boolean = false

  build() {
    Button() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ top: 48, bottom: 48 })
        .width('100%')
        .backgroundColor(this.isPrimary ? RF_BUTTON_NEXT : RF_BUTTON_BACK)
        .borderRadius(16)
    }
    .onClick(() => {})
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
        .fontColor(RF_TEXT_DARK)
      Blank()
      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .padding(20)
    .backgroundColor(RF_SUMMARY_ROW)
    .borderRadius(16)
  }
}
