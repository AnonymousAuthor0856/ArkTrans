import { window } from '@kit.ArkUI';

class RFColor {
  static readonly BACKGROUND: string = '#FBF8F3';
  static readonly CARD_BG: string = '#F7F3EE';
  static readonly HEADER_CIRCLE: string = '#EBE2D6';
  static readonly SUMMARY_ROW: string = '#EBE2D6';
  static readonly TEXT_DARK: string = '#3D352E';
  static readonly TEXT_GRAY: string = '#8A8A8E';
  static readonly PLACEHOLDER: string = '#BFC0C2';
  static readonly BORDER: string = '#C5B8A9';
  static readonly BUTTON_BACK: string = '#EBE2D6';
  static readonly BUTTON_NEXT: string = '#B58B5A';
}

@Entry
@Component
struct ReliefFundPage {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((mainWindow: window.Window) => {
      mainWindow.setWindowSystemBarEnable([]);
      mainWindow.setWindowLayoutFullScreen(true);
    }).catch(() => {
    });
  }

  build() {
    Stack() {
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
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(RFColor.BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RFColor.BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill(RFColor.HEADER_CIRCLE)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .lineHeight(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(RFColor.TEXT_DARK)

        Text('Civic support intake')
          .fontSize(13)
          .lineHeight(18)
          .fontWeight(FontWeight.Regular)
          .fontColor(RFColor.TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(48)
        .height(48)
        .fill(RFColor.HEADER_CIRCLE)
    }
    .width('100%')
    .height(48)
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct ApplicantDetailsCard {
  @State private fullName: string = '';
  @State private organization: string = '';
  @State private contact: string = '';
  @State private narrative: string = '';

  build() {
    Column() {
      Text('Applicant details')
        .fontSize(22)
        .lineHeight(31)
        .fontWeight(FontWeight.Bold)
        .fontColor(RFColor.TEXT_DARK)
        .margin({ bottom: 20 })

      CustomTextField({ placeholder: 'Full name', text: $fullName })
        .margin({ bottom: 17 })

      CustomTextField({ placeholder: 'Organization', text: $organization })
        .margin({ bottom: 17 })

      CustomTextField({ placeholder: 'Contact', text: $contact })
        .margin({ bottom: 17 })

      CustomTextField({ placeholder: 'Relief narrative', text: $narrative })

      Blank()
        .layoutWeight(1)

      Row() {
        FormButton({ label: 'Back', isPrimary: false })

        Blank()
          .width(12)

        FormButton({ label: 'Next', isPrimary: true })
      }
      .width('100%')
      .height(113)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height(514)
    .padding(24)
    .backgroundColor(RFColor.CARD_BG)
    .borderRadius(32)
  }
}

@Component
struct SummaryCard {
  build() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .lineHeight(31)
        .fontWeight(FontWeight.Bold)
        .fontColor(RFColor.TEXT_DARK)

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
    .backgroundColor(RFColor.CARD_BG)
    .borderRadius(32)
  }
}

@Component
struct CustomTextField {
  placeholder: string = '';
  @Link text: string;

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .width('100%')
      .height(18)
      .fontSize(16)
      .fontWeight(FontWeight.Regular)
      .fontColor(RFColor.TEXT_DARK)
      .placeholderColor(RFColor.PLACEHOLDER)
      .placeholderFont({ size: 16, weight: FontWeight.Regular })
      .caretColor(RFColor.TEXT_DARK)
      .backgroundColor(RFColor.BACKGROUND)
      .borderRadius(16)
      .border({ width: 1.5, color: RFColor.BORDER })
      .padding({ left: 16, right: 16, top: 0, bottom: 0 })
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
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .height(113)
    .backgroundColor(this.isPrimary ? RFColor.BUTTON_NEXT : RFColor.BUTTON_BACK)
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
        .fontColor(RFColor.TEXT_DARK)

      Blank()
        .layoutWeight(1)

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(RFColor.SUMMARY_ROW)
    .borderRadius(16)
  }
}