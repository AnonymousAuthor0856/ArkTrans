const NAME: string = "160*LeaseWizard*en";
const UI_TYPE: string = "Wizard";
const STYLE_THEME: string = "Soft Pastel";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const COLOR_PALETTE: string = "primary:#A07CFF secondary:#F6B4D7 tertiary:#8DD3C7 background:#FDF8FF surface:#FFFFFF surfaceVariant:#EFE7FF outline:#C9B4E6 success:#6ED8A0 warning:#FCD277 error:#FF8899 onPrimary:#1D0F33 onSecondary:#2B0E1C onTertiary:#06231C onBackground:#1C1126 onSurface:#24132C";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "Stepper,Form,Summary";
const EXTRA: string = "Soft pastel lease wizard with step chips and summary card";

class AppColors {
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

class AppSpacing {
  static readonly xxs: number = 4;
  static readonly xs: number = 8;
  static readonly sm: number = 12;
  static readonly md: number = 16;
  static readonly lg: number = 20;
}

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

@Entry
@Component
struct MainActivity {
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
      Blank()
        .width(30)
        .height(30)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(15)
      Column() {
        Text('LeaseWizard')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Guided handoff')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Blank()
        .width(30)
        .height(30)
        .backgroundColor('#4DA07CFF')
        .borderRadius(15)
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  StepperCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      ForEach(this.steps, (step: WizardStep, index: number) => {
        Row({ space: AppSpacing.md }) {
          Column() {
            Text(`${index + 1}`)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(index <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
              .textAlign(TextAlign.Center)
              .width(28)
              .height(28)
              .lineHeight(28)
              .backgroundColor(index <= this.currentStep ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(14)
            if (index !== this.steps.length - 1) {
              Blank()
                .width(4)
                .height(32)
                .backgroundColor(AppColors.surfaceVariant)
            }
          }
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text(step.title)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Text(step.description)
              .fontSize(13)
              .fontColor(AppColors.onSurface)
              .opacity(0.7)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button(index <= this.currentStep ? 'Edit' : 'Go')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .height(34)
            .backgroundColor(AppColors.secondary)
            .borderRadius(8)
            .onClick(() => {
              this.currentStep = index;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  FormCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Form')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      TextInput({ text: this.name, placeholder: 'Full name' })
        .onChange((value: string) => { this.name = value; })
        .width('100%')
      TextInput({ text: this.contact, placeholder: 'Contact' })
        .onChange((value: string) => { this.contact = value; })
        .width('100%')
      TextInput({ text: this.income, placeholder: 'Income' })
        .onChange((value: string) => { this.income = value; })
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Button('Back')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .height(44)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(14)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep--;
            }
          })
        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .layoutWeight(1)
          .height(44)
          .backgroundColor(AppColors.primary)
          .borderRadius(14)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep++;
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  SummaryCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(item.value)
            .fontSize(13)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(14)
      })

      Text('Documents')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ top: AppSpacing.xs })

      ForEach(this.checklist, (doc: DocumentChecklist) => {
        Row() {
          Text(doc.label)
            .fontSize(13)
            .fontColor(AppColors.onSurface)
          Text(doc.status)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .width('100%')
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#CCEFE7FF')
        .borderRadius(8)
      })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.StepperCard()
          this.FormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
