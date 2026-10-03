@Entry
@Component
struct ReliefFundApp {
  @State currentStep: number = 1;
  @State name: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';
  @State selectedChip: number = 0;

  private readonly steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ];

  private readonly chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities'];

  private readonly summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ];

  // Design tokens
  private readonly colors = {
    primary: '#B58B5A',
    secondary: '#E5C48F',
    tertiary: '#8BB39B',
    background: '#F6F0E3',
    surface: '#FFFFFF',
    surfaceVariant: '#E7D7C2',
    outline: '#C3B09E',
    success: '#6FB08C',
    warning: '#E6B566',
    error: '#D96C5F',
    onPrimary: '#2D1A0D',
    onSecondary: '#2F230C',
    onTertiary: '#0E1A13',
    onBackground: '#1E130C',
    onSurface: '#2A1C12'
  };

  private readonly spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 36,
    xxxl: 48
  };

  private readonly radius = {
    small: 8,
    medium: 14,
    large: 24
  };

  @Builder
  StepIndicator(index: number, step: FormStep) {
    Row({ space: this.spacing.sm }) {
      Column({ space: 0 }) {
        Stack() {
          Circle()
            .width(26)
            .height(26)
            .fill(index <= this.currentStep ? this.colors.primary : this.colors.surfaceVariant)
          Text(`${index + 1}`)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(index <= this.currentStep ? this.colors.onPrimary : this.colors.onSurface)
        }
        if (index !== this.steps.length - 1) {
          Rect()
            .width(3)
            .height(28)
            .fill(this.colors.surfaceVariant)
        }
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: 2 }) {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
        Text(step.description)
          .fontSize(13)
          .fontColor(this.colors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Capsule }) {
        Text(index <= this.currentStep ? 'Edit' : 'Go')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .backgroundColor(this.colors.secondary)
      .fontColor(this.colors.onSecondary)
      .height(32)
      .borderRadius(this.radius.small)
      .onClick(() => {
        this.currentStep = index;
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ChipItem(index: number, label: string) {
    Text(label)
      .fontSize(15)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.colors.onSurface)
      .padding({
        left: this.spacing.md,
        right: this.spacing.md,
        top: this.spacing.xs,
        bottom: this.spacing.xs
      })
      .backgroundColor(this.selectedChip === index ? this.colors.primary + '33' : this.colors.surfaceVariant)
      .borderRadius(this.radius.small)
      .border({
        width: 1,
        color: this.selectedChip === index ? this.colors.primary : this.colors.outline,
        radius: this.radius.small
      })
      .onClick(() => {
        this.selectedChip = index;
      })
  }

  @Builder
  SummaryRow(item: SummaryItem) {
    Row() {
      Text(item.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
      Text(item.value)
        .fontSize(13)
        .fontColor(this.colors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(this.spacing.sm)
    .backgroundColor(this.colors.surfaceVariant)
    .borderRadius(this.radius.medium)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(this.colors.surfaceVariant)
        }
        .width(40)
        .height(40)
        .align(Alignment.Center)

        Column({ space: 2 }) {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(this.colors.primary + '59')
        }
        .width(40)
        .height(40)
        .align(Alignment.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: this.spacing.sm, right: this.spacing.sm })
      .backgroundColor(this.colors.surface)

      // Scrollable content
      Scroll() {
        Column({ space: this.spacing.md }) {
          // Steps Card
          Column({ space: this.spacing.sm }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)

            ForEach(this.steps, (step: FormStep, index: number) => {
              this.StepIndicator(index, step)
            }, (step: FormStep, index: number) => `${index}_${step.title}`)
          }
          .width('100%')
          .padding(this.spacing.md)
          .backgroundColor(this.colors.surface)
          .borderRadius(this.radius.large)
          .shadow({
            radius: 8,
            color: '#1E130C1F',
            offsetX: 0,
            offsetY: 4
          })

          // Focus Card
          Column({ space: this.spacing.sm }) {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)

            Row({ space: this.spacing.sm }) {
              ForEach(this.chips, (chip: string, index: number) => {
                this.ChipItem(index, chip)
              }, (chip: string, index: number) => `${index}_${chip}`)
            }
            .width('100%')
          }
          .width('100%')
          .padding(this.spacing.md)
          .backgroundColor(this.colors.surface)
          .borderRadius(this.radius.large)
          .shadow({
            radius: 4,
            color: '#1E130C1F',
            offsetX: 0,
            offsetY: 2
          })

          // Applicant details Card
          Column({ space: this.spacing.sm }) {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)

            TextInput({ text: this.name, placeholder: 'Full name' })
              .width('100%')
              .height(48)
              .backgroundColor(this.colors.surface)
              .borderRadius(this.radius.small)
              .border({ width: 1, color: this.colors.outline, radius: this.radius.small })
              .onChange((value: string) => {
                this.name = value;
              })

            TextInput({ text: this.organization, placeholder: 'Organization' })
              .width('100%')
              .height(48)
              .backgroundColor(this.colors.surface)
              .borderRadius(this.radius.small)
              .border({ width: 1, color: this.colors.outline, radius: this.radius.small })
              .onChange((value: string) => {
                this.organization = value;
              })

            TextInput({ text: this.contact, placeholder: 'Contact' })
              .width('100%')
              .height(48)
              .backgroundColor(this.colors.surface)
              .borderRadius(this.radius.small)
              .border({ width: 1, color: this.colors.outline, radius: this.radius.small })
              .onChange((value: string) => {
                this.contact = value;
              })

            TextArea({ text: this.narrative, placeholder: 'Relief narrative' })
              .width('100%')
              .height(80)
              .backgroundColor(this.colors.surface)
              .borderRadius(this.radius.small)
              .border({ width: 1, color: this.colors.outline, radius: this.radius.small })
              .onChange((value: string) => {
                this.narrative = value;
              })

            Row({ space: this.spacing.sm }) {
              Button('Back', { type: ButtonType.Normal }) {
                Text('Back')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
              }
              .layoutWeight(1)
              .height(44)
              .backgroundColor(this.colors.surfaceVariant)
              .fontColor(this.colors.onSurface)
              .borderRadius(this.radius.medium)
              .onClick(() => {
                if (this.currentStep > 0) {
                  this.currentStep -= 1;
                }
              })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next', { type: ButtonType.Normal }) {
                Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
              }
              .layoutWeight(1)
              .height(44)
              .backgroundColor(this.colors.primary)
              .fontColor(this.colors.onPrimary)
              .borderRadius(this.radius.medium)
              .onClick(() => {
                if (this.currentStep < this.steps.length - 1) {
                  this.currentStep += 1;
                }
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(this.spacing.md)
          .backgroundColor(this.colors.surface)
          .borderRadius(this.radius.large)
          .shadow({
            radius: 8,
            color: '#1E130C1F',
            offsetX: 0,
            offsetY: 4
          })

          // Summary Card
          Column({ space: this.spacing.xs }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)

            ForEach(this.summary, (item: SummaryItem) => {
              this.SummaryRow(item)
            }, (item: SummaryItem) => `${item.label}_${item.value}`)
          }
          .width('100%')
          .padding(this.spacing.md)
          .backgroundColor(this.colors.surface)
          .borderRadius(this.radius.large)
          .shadow({
            radius: 4,
            color: '#1E130C1F',
            offsetX: 0,
            offsetY: 2
          })
        }
        .width('100%')
        .padding({
          left: this.spacing.lg,
          right: this.spacing.lg,
          top: this.spacing.sm,
          bottom: this.spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}

interface FormStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}