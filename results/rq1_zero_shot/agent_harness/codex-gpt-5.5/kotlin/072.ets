const NAME: string = "167*ReliefFund*en";
const UI_TYPE: string = "Form";
const STYLE_THEME: string = "Muted Earth";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const COLOR_PALETTE: string = "primary:#B58B5A secondary:#E5C48F tertiary:#8BB39B background:#F6F0E3 surface:#FFFFFF surfaceVariant:#E7D7C2 outline:#C3B09E success:#6FB08C warning:#E6B566 error:#D96C5F onPrimary:#2D1A0D onSecondary:#2F230C onTertiary:#0E1A13 onBackground:#1E130C onSurface:#2A1C12";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "TextField,Stepper,CTA";
const EXTRA: string = "Muted civic relief form with stepper chips and submit CTA";

class AppColors {
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

class AppSpacing {
  static readonly xs: number = 8;
  static readonly sm: number = 12;
  static readonly md: number = 16;
  static readonly lg: number = 20;
}

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

@Entry
@Component
struct MainActivity {
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
    new SupportChip('Medical'), new SupportChip('Shelter'), new SupportChip('Food'), new SupportChip('Utilities')
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
      Blank().width(30).height(30).backgroundColor(AppColors.surfaceVariant).borderRadius(15)
      Column() {
        Text('ReliefFund')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Civic support intake')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Blank().width(30).height(30).backgroundColor('#59B58B5A').borderRadius(15)
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

      ForEach(this.steps, (step: FormStep, index: number) => {
        Row({ space: AppSpacing.sm }) {
          Column() {
            Text(`${index + 1}`)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(index <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
              .textAlign(TextAlign.Center)
              .width(26)
              .height(26)
              .lineHeight(26)
              .backgroundColor(index <= this.currentStep ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(13)
            if (index !== this.steps.length - 1) {
              Blank().width(3).height(28).backgroundColor(AppColors.surfaceVariant)
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
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  @Builder
  FocusCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      Row({ space: AppSpacing.sm }) {
        ForEach(this.chips, (chip: SupportChip, index: number) => {
          Text(chip.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
            .backgroundColor(this.selectedChip === index ? '#33B58B5A' : AppColors.surfaceVariant)
            .borderRadius(8)
            .border({ width: 1, color: this.selectedChip === index ? AppColors.primary : AppColors.outline })
            .onClick(() => {
              this.selectedChip = index;
            })
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  DetailsCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Applicant details')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      TextInput({ text: this.name, placeholder: 'Full name' })
        .onChange((value: string) => { this.name = value; })
        .width('100%')
      TextInput({ text: this.organization, placeholder: 'Organization' })
        .onChange((value: string) => { this.organization = value; })
        .width('100%')
      TextInput({ text: this.contact, placeholder: 'Contact' })
        .onChange((value: string) => { this.contact = value; })
        .width('100%')
      TextArea({ text: this.narrative, placeholder: 'Relief narrative' })
        .onChange((value: string) => { this.narrative = value; })
        .height(96)
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
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  @Builder
  SummaryCard() {
    Column({ space: AppSpacing.xs }) {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      ForEach(this.summary, (item: SummaryItem) => {
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
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.StepperCard()
          this.FocusCard()
          this.DetailsCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
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
