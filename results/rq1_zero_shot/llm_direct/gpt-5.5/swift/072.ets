import { window } from '@kit.ArkUI';

const RF = {
  background: '#FBF8F3',
  cardBg: '#F7F3EE',
  headerCircle: '#EBE2D6',
  summaryRow: '#EBE2D6',
  textDark: '#3D352E',
  textGray: '#8A8A8E',
  placeholder: '#6D5F58',
  border: '#C5B8A9',
  buttonBack: '#EBE2D6',
  buttonNext: '#B58B5A'
};

@Entry
@Component
struct ReliefFundApp {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowSystemBarEnable(['navigation']);
      win.setWindowLayoutFullScreen(true);
    });
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
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
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RF.background)
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(RF.headerCircle)

      Blank()

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(RF.textDark)

        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(RF.textGray)
      }

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(RF.headerCircle)
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
        .fontColor(RF.textDark)
        .margin({ bottom: 4 })

      CustomTextField({
        placeholder: 'Full name',
        text: $fullName,
        heightValue: 18
      })

      CustomTextField({
        placeholder: 'Organization',
        text: $organization,
        heightValue: 18
      })

      CustomTextField({
        placeholder: 'Contact',
        text: $contact,
        heightValue: 18
      })

      CustomTextField({
        placeholder: 'Relief narrative',
        text: $narrative,
        heightValue: 18
      })
        .margin({ bottom: 90 })

      Row({ space: 2 }) {
        FormButton({
          label: 'Back',
          isPrimary: false
        })

        Blank()

        FormButton({
          label: 'Next',
          isPrimary: true
        })
      }
      .width('100%')
      .margin({ top: 80 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
    .backgroundColor(RF.cardBg)
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
        .fontColor(RF.textDark)

      SummaryRow({
        label: 'Requested',
        value: '$4,500'
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
    .backgroundColor(RF.cardBg)
    .borderRadius(32)
  }
}

@Component
struct CustomTextField {
  placeholder: string = '';
  @Link text: string;
  heightValue: number = 40;

  build() {
    TextInput({
      placeholder: this.placeholder,
      text: this.text
    })
      .onChange((value: string) => {
        this.text = value;
      })
      .width('100%')
      .height(this.heightValue)
      .fontSize(16)
      .fontColor(RF.textDark)
      .placeholderColor(RF.placeholder)
      .padding({ left: 16, right: 16 })
      .backgroundColor(RF.background)
      .borderRadius(16)
      .border({
        width: 1.5,
        color: RF.border
      })
  }
}

@Component
struct FormButton {
  label: string = '';
  isPrimary: boolean = false;

  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .padding({ top: 48, bottom: 48 })
    }
    .constraintSize({ maxWidth: 600 })
    .backgroundColor(this.isPrimary ? RF.buttonNext : RF.buttonBack)
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
        .fontColor(RF.textDark)

      Blank()

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(RF.summaryRow)
    .borderRadius(16)
  }
}