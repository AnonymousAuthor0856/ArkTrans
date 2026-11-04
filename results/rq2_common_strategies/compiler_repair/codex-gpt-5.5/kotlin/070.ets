class WizardStep {
  title: string;
  description: string;

  constructor(title: string, description: string) {
    this.title = title;
    this.description = description;
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

class DocumentChecklist {
  label: string;
  status: string;

  constructor(label: string, status: string) {
    this.label = label;
    this.status = status;
  }
}

class LeaseColors {
  static readonly primary: string = '#A07CFF';
  static readonly secondary: string = '#F6B4D7';
  static readonly background: string = '#FDF8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EFE7FF';
  static readonly outline: string = '#C9B4E6';
  static readonly onPrimary: string = '#1D0F33';
  static readonly onSecondary: string = '#2B0E1C';
  static readonly onSurface: string = '#24132C';
}

@Entry
@Component
struct Index {
  @State currentStep: number = 1;
  @State name: string = 'Avery Tenant';
  @State contact: string = 'avery@example.com';
  @State income: string = '$120k annual';
  private steps: WizardStep[] = [
    new WizardStep('Profile', 'Tenant basics'),
    new WizardStep('Income', 'Proof details'),
    new WizardStep('References', 'Upload letters'),
    new WizardStep('Summary', 'Confirm submission')
  ];
  private summaryItems: SummaryItem[] = [
    new SummaryItem('Lease start', 'Aug 12'),
    new SummaryItem('Monthly', '$2,450'),
    new SummaryItem('Deposit', '$2,450'),
    new SummaryItem('Pets', '2 approved')
  ];
  private checklist: DocumentChecklist[] = [
    new DocumentChecklist('ID verification', 'Uploaded'),
    new DocumentChecklist('Employment letter', 'Pending'),
    new DocumentChecklist('Credit report', 'Synced')
  ];

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(30)
        .height(30)
        .fill(LeaseColors.surfaceVariant)

      Column() {
        Text('LeaseWizard')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(LeaseColors.onSurface)
        Text('Guided handoff')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B324132C')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(30)
        .height(30)
        .fill('#4DA07CFF')
    }
    .width('100%')
    .height(66)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(LeaseColors.background)
  }

  @Builder
  StepRow(step: WizardStep, index: number) {
    Row() {
      Column() {
        Text((index + 1).toString())
          .width(28)
          .height(28)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(index <= this.currentStep ? LeaseColors.onPrimary : LeaseColors.onSurface)
          .backgroundColor(index <= this.currentStep ? LeaseColors.primary : LeaseColors.surfaceVariant)
          .borderRadius(14)
          .textAlign(TextAlign.Center)
        if (index !== this.steps.length - 1) {
          Text('')
            .width(4)
            .height(32)
            .backgroundColor(LeaseColors.surfaceVariant)
        }
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(LeaseColors.onSurface)
        Text(step.description)
          .fontSize(13)
          .fontColor('#B324132C')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      Button(index <= this.currentStep ? 'Edit' : 'Go')
        .fontSize(11)
        .fontColor(LeaseColors.onSecondary)
        .backgroundColor(LeaseColors.secondary)
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
        .fontColor(LeaseColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.steps, (step: WizardStep, index: number) => {
        this.StepRow(step, index)
      }, (step: WizardStep) => step.title)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(LeaseColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  FormField(label: string, value: string) {
    TextInput({ placeholder: label, text: value })
      .width('100%')
      .height(54)
      .fontSize(14)
      .fontColor(LeaseColors.onSurface)
      .backgroundColor(LeaseColors.surface)
      .borderRadius(12)
      .border({ width: 1, color: LeaseColors.outline })
      .onChange((text: string) => {
        if (label === 'Full name') {
          this.name = text;
        } else if (label === 'Contact') {
          this.contact = text;
        } else {
          this.income = text;
        }
      })
  }

  @Builder
  FormCard() {
    Column() {
      Text('Form')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(LeaseColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })

      this.FormField('Full name', this.name)
      Column() { this.FormField('Contact', this.contact) }.margin({ top: 12 })
      Column() { this.FormField('Income', this.income) }.margin({ top: 12 })

      Row() {
        Button('Back')
          .height(44)
          .fontSize(15)
          .fontColor(LeaseColors.onSurface)
          .backgroundColor(LeaseColors.surfaceVariant)
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
          .fontColor(LeaseColors.onPrimary)
          .backgroundColor(LeaseColors.primary)
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
    .backgroundColor(LeaseColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(LeaseColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(LeaseColors.onSurface)
            .layoutWeight(1)
          Text(item.value)
            .fontSize(13)
            .fontColor(LeaseColors.onSurface)
        }
        .width('100%')
        .padding(12)
        .backgroundColor(LeaseColors.surfaceVariant)
        .borderRadius(14)
        .margin({ bottom: 12 })
      }, (item: SummaryItem) => item.label)

      Text('Documents')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(LeaseColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })

      ForEach(this.checklist, (doc: DocumentChecklist) => {
        Row() {
          Text(doc.label)
            .fontSize(13)
            .fontColor(LeaseColors.onSurface)
            .layoutWeight(1)
          Text(doc.status)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(LeaseColors.secondary)
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor('#CCEFE7FF')
        .borderRadius(8)
        .margin({ bottom: 8 })
      }, (doc: DocumentChecklist) => doc.label)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(LeaseColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.StepsCard()
          Column() { this.FormCard() }.margin({ top: 16 })
          Column() { this.SummaryCard() }.margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 36 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LeaseColors.background)
  }
}
