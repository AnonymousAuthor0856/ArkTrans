/**
 * ReliefFund — Civic support intake
 * HarmonyOS / ArkTS (ArkUI declarative) port of the SwiftUI source.
 *
 * Module: entry/src/main/ets/pages/Index.ets
 *
 * Status-bar hiding (SwiftUI `.statusBar(hidden: true)`):
 *   in EntryAbility.onWindowStageCreate():
 *     windowClass.setWindowSystemBarEnable([]);
 */

// ---------------------------------------------------------------------------
// Palette (SwiftUI `Color(hex:)` extension -> plain ARGB hex strings)
// ---------------------------------------------------------------------------
const RF_BACKGROUND: string = '#FBF8F3';
const RF_CARD_BG: string = '#F7F3EE';
const RF_HEADER_CIRCLE: string = '#EBE2D6';
const RF_SUMMARY_ROW: string = '#EBE2D6';
const RF_TEXT_DARK: string = '#3D352E';
const RF_TEXT_GRAY: string = '#8A8A8E';
const RF_PLACEHOLDER: string = '#6D5F58';
const RF_BORDER: string = '#C5B8A9';
const RF_BUTTON_BACK: string = '#EBE2D6';
const RF_BUTTON_NEXT: string = '#B58B5A';

// ---------------------------------------------------------------------------
// Entry point  (ContentView)
// ---------------------------------------------------------------------------
@Entry
@Component
struct ContentView {
  build() {
    Column() {
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
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RF_BACKGROUND)
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------
@Component
struct HeaderView {
  build() {
    Row() {
      // Leading decorative circle
      Column()
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(RF_HEADER_CIRCLE)

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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Trailing decorative circle
      Column()
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(RF_HEADER_CIRCLE)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24 })
  }
}

// ---------------------------------------------------------------------------
// Applicant details card
// ---------------------------------------------------------------------------
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
        .fontColor(RF_TEXT_DARK)
        .margin({ bottom: 4 })

      RfField({ placeholder: 'Full name', text: $fullName })
      RfField({ placeholder: 'Organization', text: $organization })
      RfField({ placeholder: 'Contact', text: $contact })
      RfField({ placeholder: 'Relief narrative', text: $narrative })
        .margin({ bottom: 90 })

      Row({ space: 2 }) {
        Column() {
          FormButton({ label: 'Back', isPrimary: false })
        }
        .layoutWeight(1)

        Column() {
          FormButton({ label: 'Next', isPrimary: true })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 80 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(RF_CARD_BG)
    .borderRadius(32)
  }
}

// ---------------------------------------------------------------------------
// Summary card
// ---------------------------------------------------------------------------
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
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(RF_CARD_BG)
    .borderRadius(32)
  }
}

// ---------------------------------------------------------------------------
// Styled text field
// ---------------------------------------------------------------------------
@Component
struct RfField {
  placeholder: string = '';
  @Link text: string;

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .type(InputType.Normal)
      .placeholderColor(RF_PLACEHOLDER)
      .placeholderFont({ size: 16, weight: FontWeight.Regular })
      .fontSize(16)
      .fontColor(RF_TEXT_DARK)
      .caretColor(RF_BUTTON_NEXT)
      .width('100%')
      .height(40)
      .padding({ left: 16, right: 16 })
      .backgroundColor(RF_BACKGROUND)
      .borderRadius(20)
      .borderWidth(1.5)
      .borderColor(RF_BORDER)
      .onChange((value: string) => {
        this.text = value;
      })
  }
}

// ---------------------------------------------------------------------------
// Primary / secondary action button
// ---------------------------------------------------------------------------
@Component
struct FormButton {
  label: string = '';
  isPrimary: boolean = false;

  build() {
    Button() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .type(ButtonType.Normal)
    .stateEffect(true)
    .width('100%')
    .height(64)
    .borderRadius(16)
    .backgroundColor(this.isPrimary ? RF_BUTTON_NEXT : RF_BUTTON_BACK)
    .onClick(() => {
      // Navigation hook — wire to router.pushUrl() as needed.
    })
  }
}

// ---------------------------------------------------------------------------
// Summary row
// ---------------------------------------------------------------------------
@Component
struct SummaryRow {
  label: string = '';
  value: string = '';

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
        .fontColor(Color.Black)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(20)
    .backgroundColor(RF_SUMMARY_ROW)
    .borderRadius(16)
  }
}