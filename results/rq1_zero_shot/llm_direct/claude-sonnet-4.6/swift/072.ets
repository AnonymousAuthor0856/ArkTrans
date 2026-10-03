import { router } from '@kit.ArkUI';

// MARK: - Color Palette
const rfBackground = '#FBF8F3';
const rfCardBg = '#F7F3EE';
const rfHeaderCircle = '#EBE2D6';
const rfSummaryRow = '#EBE2D6';
const rfTextDark = '#3D352E';
const rfTextGray = '#8A8A8E';
const rfBorder = '#C5B8A9';
const rfButtonBack = '#EBE2D6';
const rfButtonNext = '#B58B5A';
const rfBackground2 = '#FBF8F3';

// MARK: - Header Component
@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .fill(rfHeaderCircle)
        .width(48)
        .height(48)

      Blank()

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(rfTextDark)

        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(rfTextGray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Circle()
        .fill(rfHeaderCircle)
        .width(48)
        .height(48)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Custom TextField Component
@Component
struct CustomTextField {
  @Prop placeholder: string = '';
  @Link text: string;
  fieldHeight: number = 40;
  isMultiline: boolean = false;

  build() {
    if (this.isMultiline) {
      TextArea({ placeholder: this.placeholder, text: this.text })
        .fontSize(16)
        .fontColor(rfTextDark)
        .placeholderColor(rfTextDark)
        .placeholderFont({ size: 16 })
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .height(120)
        .width('100%')
        .backgroundColor(rfBackground2)
        .borderRadius(16)
        .border({ width: 1.5, color: rfBorder, radius: 16 })
        .onChange((value: string) => {
          this.text = value;
        })
    } else {
      TextInput({ placeholder: this.placeholder, text: this.text })
        .fontSize(16)
        .fontColor(rfTextDark)
        .placeholderColor(rfTextDark)
        .placeholderFont({ size: 16 })
        .padding({ left: 16, right: 16 })
        .height(this.fieldHeight > 0 ? 48 : 48)
        .width('100%')
        .backgroundColor(rfBackground2)
        .borderRadius(16)
        .border({ width: 1.5, color: rfBorder, radius: 16 })
        .onChange((value: string) => {
          this.text = value;
        })
    }
  }
}

// MARK: - Form Button Component
@Component
struct FormButton {
  @Prop label: string = '';
  @Prop isPrimary: boolean = false;
  onClickAction: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .padding({ top: 16, bottom: 16 })
      .width('48%')
      .backgroundColor(this.isPrimary ? rfButtonNext : rfButtonBack)
      .borderRadius(16)
      .onClick(() => {
        this.onClickAction();
      })
  }
}

// MARK: - Summary Row Component
@Component
struct SummaryRow {
  @Prop label: string = '';
  @Prop value: string = '';

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
        .fontColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor(rfSummaryRow)
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Applicant Details Card
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
        .width('100%')
        .margin({ bottom: 4 })

      CustomTextField({
        placeholder: 'Full name',
        text: $fullName,
        fieldHeight: 48,
        isMultiline: false
      })

      CustomTextField({
        placeholder: 'Organization',
        text: $organization,
        fieldHeight: 48,
        isMultiline: false
      })

      CustomTextField({
        placeholder: 'Contact',
        text: $contact,
        fieldHeight: 48,
        isMultiline: false
      })

      CustomTextField({
        placeholder: 'Relief narrative',
        text: $narrative,
        fieldHeight: 120,
        isMultiline: true
      })

      Row() {
        FormButton({
          label: 'Back',
          isPrimary: false,
          onClickAction: () => {}
        })

        Blank()

        FormButton({
          label: 'Next',
          isPrimary: true,
          onClickAction: () => {}
        })
      }
      .width('100%')
      .margin({ top: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
    .backgroundColor(rfCardBg)
    .borderRadius(32)
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
        .fontColor(rfTextDark)
        .width('100%')

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .width('100%')
    .backgroundColor(rfCardBg)
    .borderRadius(32)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  build() {
    Column() {
      // Header
      HeaderView()
        .margin({ top: 10, bottom: 20 })

      // Scrollable Content
      Scroll() {
        Column({ space: 24 }) {
          ApplicantDetailsCard()
          SummaryCard()
        }
        .padding({ left: 16, right: 16, bottom: 40 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(rfBackground)
    .alignItems(HorizontalAlign.Start)
  }
}