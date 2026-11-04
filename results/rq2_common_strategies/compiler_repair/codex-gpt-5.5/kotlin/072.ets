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

class ReliefColors {
  static readonly primary: string = '#B58B5A';
  static readonly secondary: string = '#E5C48F';
  static readonly background: string = '#F6F0E3';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E7D7C2';
  static readonly outline: string = '#C3B09E';
  static readonly onPrimary: string = '#2D1A0D';
  static readonly onSecondary: string = '#2F230C';
  static readonly onSurface: string = '#2A1C12';
}

@Entry
@Component
struct Index {
  @State currentStep: number = 1;
  @State name: string = '';
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

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(30)
        .height(30)
        .fill(ReliefColors.surfaceVariant)

      Column() {
        Text('ReliefFund')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(ReliefColors.onSurface)
        Text('Civic support intake')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B32A1C12')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(30)
        .height(30)
        .fill('#59B58B5A')
    }
    .width('100%')
    .height(66)
    .padding({ left: 20, right: 20 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ReliefColors.background)
  }

  @Builder
  StepRow(step: FormStep, index: number) {
    Row() {
      Column() {
        Text((index + 1).toString())
          .width(26)
          .height(26)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(index <= this.currentStep ? ReliefColors.onPrimary : ReliefColors.onSurface)
          .textAlign(TextAlign.Center)
          .backgroundColor(index <= this.currentStep ? ReliefColors.primary : ReliefColors.surfaceVariant)
          .borderRadius(13)
        if (index !== this.steps.length - 1) {
          Text('')
            .width(3)
            .height(28)
            .backgroundColor(ReliefColors.surfaceVariant)
        }
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(ReliefColors.onSurface)
        Text(step.description)
          .fontSize(13)
          .fontColor('#B32A1C12')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })

      Button(index <= this.currentStep ? 'Edit' : 'Go')
        .fontSize(11)
        .fontColor(ReliefColors.onSecondary)
        .backgroundColor(ReliefColors.secondary)
        .borderRadius(8)
        .onClick(() => {
          this.currentStep = index;
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StepsCard() {
    Column() {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })
      ForEach(this.steps, (step: FormStep, index: number) => {
        this.StepRow(step, index)
      }, (step: FormStep) => step.title)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ReliefColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  FocusCard() {
    Column() {
      Text('Focus')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })
      Row() {
        ForEach(this.chips, (chip: SupportChip, index: number) => {
          Button(chip.label)
            .height(38)
            .fontSize(15)
            .fontColor(ReliefColors.onSurface)
            .backgroundColor(this.selectedChip === index ? '#33B58B5A' : ReliefColors.surfaceVariant)
            .borderRadius(8)
            .border({ width: 1, color: this.selectedChip === index ? ReliefColors.primary : ReliefColors.outline })
            .margin({ right: index === this.chips.length - 1 ? 0 : 8 })
            .onClick(() => {
              this.selectedChip = index;
            })
        }, (chip: SupportChip) => chip.label)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ReliefColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  FormField(label: string, value: string, tall: boolean = false) {
    TextInput({ placeholder: label, text: value })
      .width('100%')
      .height(tall ? 96 : 54)
      .fontSize(14)
      .fontColor(ReliefColors.onSurface)
      .backgroundColor(ReliefColors.surface)
      .borderRadius(12)
      .border({ width: 1, color: ReliefColors.outline })
      .onChange((text: string) => {
        if (label === 'Full name') {
          this.name = text;
        } else if (label === 'Organization') {
          this.organization = text;
        } else if (label === 'Contact') {
          this.contact = text;
        } else {
          this.narrative = text;
        }
      })
  }

  @Builder
  ApplicantCard() {
    Column() {
      Text('Applicant details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })
      this.FormField('Full name', this.name)
      Column() { this.FormField('Organization', this.organization) }.margin({ top: 12 })
      Column() { this.FormField('Contact', this.contact) }.margin({ top: 12 })
      Column() { this.FormField('Relief narrative', this.narrative, true) }.margin({ top: 12 })

      Row() {
        Button('Back')
          .height(44)
          .fontSize(15)
          .fontColor(ReliefColors.onSurface)
          .backgroundColor(ReliefColors.surfaceVariant)
          .borderRadius(14)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1;
            }
          })
        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .height(44)
          .fontSize(15)
          .fontColor(ReliefColors.onPrimary)
          .backgroundColor(ReliefColors.primary)
          .borderRadius(14)
          .layoutWeight(1)
          .margin({ left: 12 })
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1;
            }
          })
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ReliefColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ReliefColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })
      ForEach(this.summary, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(ReliefColors.onSurface)
            .layoutWeight(1)
          Text(item.value)
            .fontSize(13)
            .fontColor(ReliefColors.onSurface)
        }
        .width('100%')
        .padding(12)
        .backgroundColor(ReliefColors.surfaceVariant)
        .borderRadius(14)
        .margin({ bottom: 8 })
      }, (item: SummaryItem) => item.label)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ReliefColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.StepsCard()
          Column() { this.FocusCard() }.margin({ top: 16 })
          Column() { this.ApplicantCard() }.margin({ top: 16 })
          Column() { this.SummaryCard() }.margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 36 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ReliefColors.background)
  }
}
