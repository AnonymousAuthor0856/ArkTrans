import { promptAction } from '@kit.ArkUI';

interface ColorTokens {
  background: string;
  surface: string;
  primary: string;
  primaryText: string;
  muted: string;
  outline: string;
  soft: string;
  headerDot: string;
  fieldText: string;
}

const COLORS: ColorTokens = {
  background: '#F6F0E3',
  surface: '#FCFAF7',
  primary: '#B58B5A',
  primaryText: '#2D1A0D',
  muted: '#6B625A',
  outline: '#C3B09E',
  soft: '#E7D7C2',
  headerDot: '#E5D5BC',
  fieldText: '#4D4A56'
};

@Entry
@Component
struct ReliefFundPage {
  @State currentStep: number = 1;
  @State name: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  private fieldHeight: number = 112;

  private showMessage(message: string): void {
    promptAction.showToast({ message: message });
  }

  @Builder
  private headerDot(color: string): void {
    Circle()
      .width(60)
      .height(60)
      .fill(color);
  }

  @Builder
  private formField(label: string, value: string, onChange: (value: string) => void, multiline: boolean = false): void {
    TextInput({ text: value, placeholder: label })
      .width('100%')
      .height(multiline ? 208 : this.fieldHeight)
      .padding({ left: 30, right: 24, top: multiline ? 24 : 0, bottom: multiline ? 24 : 0 })
      .fontSize(32)
      .fontColor(COLORS.fieldText)
      .placeholderColor(COLORS.fieldText)
      .placeholderFont({ size: 32 })
      .backgroundColor(COLORS.surface)
      .border({ width: 2, color: COLORS.outline, radius: 16 })
      .textAlign(TextAlign.Start)
      .maxLines(multiline ? 5 : 1)
      .onChange((text: string) => {
        onChange(text);
      });
  }

  @Builder
  private summaryRow(label: string, value: string): void {
    Row() {
      Text(label)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.primaryText);
      Blank();
      Text(value)
        .fontSize(26)
        .fontColor(COLORS.primaryText);
    }
    .width('100%')
    .height(72)
    .padding({ left: 24, right: 24 })
    .borderRadius(28)
    .backgroundColor(COLORS.soft)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Scroll() {
      Column() {
        Row() {
          this.headerDot(COLORS.headerDot);
          Blank();
          Column() {
            Text('ReliefFund')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.primaryText);
            Text('Civic support intake')
              .margin({ top: 2 })
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.muted);
          }
          .alignItems(HorizontalAlign.Center);
          Blank();
          this.headerDot(COLORS.headerDot);
        }
        .width('100%')
        .height(116)
        .padding({ left: 26, right: 26 })
        .alignItems(VerticalAlign.Center);

        Column() {
          Text('Applicant details')
            .width('100%')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.primaryText)
            .margin({ bottom: 42 });

          this.formField('Full name', this.name, (value: string) => {
            this.name = value;
          });

          this.formField('Organization', this.organization, (value: string) => {
            this.organization = value;
          });

          this.formField('Contact', this.contact, (value: string) => {
            this.contact = value;
          });

          this.formField('Relief narrative', this.narrative, (value: string) => {
            this.narrative = value;
          }, true);

          Row() {
            Button('Back')
              .layoutWeight(1)
              .height(80)
              .fontSize(30)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.primaryText)
              .backgroundColor(COLORS.soft)
              .borderRadius(40)
              .onClick(() => {
                if (this.currentStep > 0) {
                  this.currentStep -= 1;
                }
              });

            Button(this.currentStep === 3 ? 'Submit' : 'Next')
              .layoutWeight(1)
              .height(80)
              .fontSize(30)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.primaryText)
              .backgroundColor(COLORS.primary)
              .borderRadius(40)
              .onClick(() => {
                if (this.currentStep < 3) {
                  this.currentStep += 1;
                } else {
                  this.showMessage('Relief request submitted');
                }
              });
          }
          .width('100%')
          .height(80)
          .margin({ top: 32 });
        }
        .width('100%')
        .padding({ left: 32, right: 32, top: 36, bottom: 40 })
        .borderRadius(48)
        .backgroundColor(COLORS.surface);

        Column() {
          Text('Summary')
            .width('100%')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.primaryText)
            .margin({ bottom: 24 });

          this.summaryRow('Requested', '$4,500');
          this.summaryRow('Households', '36');
          this.summaryRow('Region', 'North loop');
          this.summaryRow('Urgency', '48h');
        }
        .width('100%')
        .padding({ left: 32, right: 32, top: 34, bottom: 36 })
        .margin({ top: 32 })
        .borderRadius(48)
        .backgroundColor(COLORS.surface);
      }
      .width('100%')
      .padding({ bottom: 36 })
      .backgroundColor(COLORS.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    .scrollBar(BarState.Off);
  }
}
