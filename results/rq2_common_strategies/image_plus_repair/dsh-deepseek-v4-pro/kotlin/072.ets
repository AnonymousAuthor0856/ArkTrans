class FormStep {
  title: string;
  description: string;
  constructor(title: string, description: string) {
    this.title = title;
    this.description = description;
  }
}

class SupportChip {
  label: string;
  constructor(label: string) {
    this.label = label;
  }
}

class SummaryItem {
  label: string;
  value: string;
  constructor(label: string, value: string) {
    this.label = label;
    this.value = value;
  }
}

const PRIMARY: string = '#B58B5A';
const SECONDARY: string = '#E5C48F';
const TERTIARY: string = '#8BB39B';
const BACKGROUND: string = '#F6F0E3';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E7D7C2';
const OUTLINE: string = '#C3B09E';
const ON_PRIMARY: string = '#2D1A0D';
const ON_SECONDARY: string = '#2F230C';
const ON_SURFACE: string = '#2A1C12';
const ON_SURFACE_DIM: string = '#B32A1C12';
const PRIMARY_SOFT: string = '#33B58B5A';
const PRIMARY_FAINT: string = '#59B58B5A';

@Entry
@Component
struct ReliefFundPage {
  @State currentStep: number = 1;
  @State fullName: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';
  @State selectedChip: number = 0;

  private steps: FormStep[] = [
    new FormStep('Identity', 'Applicant basics'),
    new FormStep('Impact', 'Community reach'),
    new FormStep('Needs', 'Immediate relief'),
    new FormStep('Summary', 'Confirm details')
  ];
  private chips: SupportChip[] = [
    new SupportChip('Medical'),
    new SupportChip('Shelter'),
    new SupportChip('Food'),
    new SupportChip('Utilities')
  ];
  private summary: SummaryItem[] = [
    new SummaryItem('Requested', '$4,500'),
    new SummaryItem('Households', '36'),
    new SummaryItem('Region', 'North loop'),
    new SummaryItem('Urgency', '48h')
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
            .textAlign(TextAlign.Center)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE_DIM)
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)

        Row() {
          Blank()
            .width(30)
            .height(30)
            .borderRadius(15)
            .backgroundColor(SURFACE_VARIANT)
          Blank()
          Blank()
            .width(30)
            .height(30)
            .borderRadius(15)
            .backgroundColor(PRIMARY_FAINT)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Scroll() {
        Column() {
          Column() {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 12 })

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row() {
                Column() {
                  Stack() {
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? ON_PRIMARY : ON_SURFACE)
                  }
                  .width(26)
                  .height(26)
                  .borderRadius(13)
                  .backgroundColor(index <= this.currentStep ? PRIMARY : SURFACE_VARIANT)

                  if (index !== this.steps.length - 1) {
                    Blank()
                      .width(3)
                      .height(28)
                      .backgroundColor(SURFACE_VARIANT)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ON_SURFACE)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(ON_SURFACE_DIM)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 12 })

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontColor(ON_SECONDARY)
                  .backgroundColor(SECONDARY)
                  .borderRadius(8)
                  .height(36)
                  .onClick(() => { this.currentStep = index })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 12 })
            }, (step: FormStep, index: number) => `${index}_${step.title}`)
          }
          .width('100%')
          .backgroundColor(SURFACE)
          .borderRadius(24)
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 16 })

          Column() {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 12 })

            Row() {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Text(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(this.selectedChip === index ? PRIMARY_SOFT : SURFACE_VARIANT)
                  .borderRadius(8)
                  .border({ width: 1, color: this.selectedChip === index ? PRIMARY : OUTLINE })
                  .onClick(() => { this.selectedChip = index })
                  .margin({ right: 12 })
              }, (chip: SupportChip, index: number) => `${index}_${chip.label}`)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor(SURFACE)
          .borderRadius(24)
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 16 })

          Column() {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 12 })

            TextInput({ placeholder: 'Full name', text: this.fullName })
              .onChange((value: string) => { this.fullName = value })
              .width('100%')
              .height(44)
              .fontSize(13)
              .fontColor(ON_SURFACE)
              .placeholderColor(OUTLINE)
              .borderRadius(8)
              .border({ width: 1, color: OUTLINE })
              .backgroundColor(SURFACE)
              .margin({ bottom: 12 })

            TextInput({ placeholder: 'Organization', text: this.organization })
              .onChange((value: string) => { this.organization = value })
              .width('100%')
              .height(44)
              .fontSize(13)
              .fontColor(ON_SURFACE)
              .placeholderColor(OUTLINE)
              .borderRadius(8)
              .border({ width: 1, color: OUTLINE })
              .backgroundColor(SURFACE)
              .margin({ bottom: 12 })

            TextInput({ placeholder: 'Contact', text: this.contact })
              .onChange((value: string) => { this.contact = value })
              .width('100%')
              .height(44)
              .fontSize(13)
              .fontColor(ON_SURFACE)
              .placeholderColor(OUTLINE)
              .borderRadius(8)
              .border({ width: 1, color: OUTLINE })
              .backgroundColor(SURFACE)
              .margin({ bottom: 12 })

            TextArea({ placeholder: 'Relief narrative', text: this.narrative })
              .onChange((value: string) => { this.narrative = value })
              .width('100%')
              .height(80)
              .fontSize(13)
              .fontColor(ON_SURFACE)
              .placeholderColor(OUTLINE)
              .borderRadius(8)
              .border({ width: 1, color: OUTLINE })
              .backgroundColor(SURFACE)
              .margin({ bottom: 12 })

            Row() {
              Button('Back')
                .fontSize(15)
                .fontColor(ON_SURFACE)
                .backgroundColor(SURFACE_VARIANT)
                .borderRadius(14)
                .height(44)
                .layoutWeight(1)
                .onClick(() => { if (this.currentStep > 0) { this.currentStep -= 1 } })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .fontSize(15)
                .fontColor(ON_PRIMARY)
                .backgroundColor(PRIMARY)
                .borderRadius(14)
                .height(44)
                .layoutWeight(1)
                .margin({ left: 12 })
                .onClick(() => { if (this.currentStep < this.steps.length - 1) { this.currentStep += 1 } })
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(SURFACE)
          .borderRadius(24)
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 16 })

          Column() {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 4 })

            ForEach(this.summary, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(ON_SURFACE)
              }
              .width('100%')
              .backgroundColor(SURFACE_VARIANT)
              .borderRadius(14)
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 4 })
            }, (item: SummaryItem, index: number) => `${index}_${item.label}`)
          }
          .width('100%')
          .backgroundColor(SURFACE)
          .borderRadius(24)
          .padding(16)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
