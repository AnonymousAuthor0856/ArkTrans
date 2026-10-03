const PRIMARY: string = '#B58B5A';
const SECONDARY: string = '#E5C48F';
const TERTIARY: string = '#8BB39B';
const BACKGROUND: string = '#F6F0E3';
const SURFACE: string = '#FFFCF7';
const SURFACE_WHITE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E7D7C2';
const OUTLINE: string = '#C3B09E';
const ON_PRIMARY: string = '#2D1A0D';
const ON_SECONDARY: string = '#2F230C';
const ON_BACKGROUND: string = '#1E130C';
const ON_SURFACE: string = '#2A1C12';
const MUTED_TEXT: string = '#6B5C51';

interface SummaryItem {
  label: string;
  value: string;
}

@Entry
@Component
struct Index {
  @State currentStep: number = 1;
  @State name: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  private readonly summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ];

  @Builder
  AppBar() {
    Stack() {
      Row() {
        Stack()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(SURFACE_VARIANT)

        Stack()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#E1D1BA')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 13, right: 13 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('ReliefFund')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .lineHeight(20)

        Text('Civic support intake')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(MUTED_TEXT)
          .lineHeight(14)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(SURFACE_WHITE)
  }

  @Builder
  FormInput(placeholder: string, value: string, onValueChange: (value: string) => void) {
    TextInput({ placeholder: placeholder, text: value })
      .width('100%')
      .height(56)
      .fontSize(16)
      .fontColor('#4F4B55')
      .placeholderColor('#4F4B55')
      .placeholderFont({ size: 16, weight: FontWeight.Regular })
      .backgroundColor(SURFACE)
      .border({ width: 1, color: OUTLINE })
      .borderRadius(8)
      .padding({ left: 16, right: 16 })
      .caretColor(PRIMARY)
      .onChange((text: string) => {
        onValueChange(text);
      })
  }

  @Builder
  NarrativeInput() {
    TextArea({ placeholder: 'Relief narrative', text: this.narrative })
      .width('100%')
      .height(104)
      .fontSize(16)
      .fontColor('#4F4B55')
      .placeholderColor('#4F4B55')
      .placeholderFont({ size: 16, weight: FontWeight.Regular })
      .backgroundColor(SURFACE)
      .border({ width: 1, color: OUTLINE })
      .borderRadius(8)
      .padding({ left: 16, right: 16, top: 14, bottom: 14 })
      .caretColor(PRIMARY)
      .onChange((text: string) => {
        this.narrative = text;
      })
  }

  @Builder
  ApplicantDetailsCard() {
    Column() {
      Text('Applicant details')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .lineHeight(26)
        .margin({ bottom: 20 })

      this.FormInput('Full name', this.name, (value: string) => {
        this.name = value;
      })

      this.FormInput('Organization', this.organization, (value: string) => {
        this.organization = value;
      })

      this.FormInput('Contact', this.contact, (value: string) => {
        this.contact = value;
      })

      this.NarrativeInput()

      Row({ space: 12 }) {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Back')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
        }
        .height(40)
        .layoutWeight(1)
        .borderRadius(14)
        .backgroundColor('#EADDC9')
        .onClick(() => {
          if (this.currentStep > 0) {
            this.currentStep -= 1;
          }
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text(this.currentStep === 3 ? 'Submit' : 'Next')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_PRIMARY)
        }
        .height(40)
        .layoutWeight(1)
        .borderRadius(14)
        .backgroundColor(PRIMARY)
        .onClick(() => {
          if (this.currentStep < 3) {
            this.currentStep += 1;
          }
        })
      }
      .width('100%')
      .margin({ top: 14 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 18, bottom: 20 })
    .borderRadius(24)
    .backgroundColor(SURFACE)
  }

  @Builder
  SummaryRow(item: SummaryItem) {
    Row() {
      Text(item.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
        .layoutWeight(1)

      Text(item.value)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(ON_SURFACE)
    }
    .width('100%')
    .height(56)
    .padding({ left: 12, right: 12 })
    .borderRadius(14)
    .backgroundColor(SURFACE_VARIANT)
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .lineHeight(26)
        .margin({ bottom: 8 })

      ForEach(this.summary, (item: SummaryItem) => {
        this.SummaryRow(item)
      }, (item: SummaryItem) => item.label)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 18, bottom: 18 })
    .borderRadius(24)
    .backgroundColor(SURFACE)
  }

  build() {
    Column() {
      this.AppBar()

      Scroll() {
        Column({ space: 16 }) {
          this.ApplicantDetailsCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}