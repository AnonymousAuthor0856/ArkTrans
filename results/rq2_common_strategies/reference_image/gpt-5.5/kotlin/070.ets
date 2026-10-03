const NAME: string = '160*LeaseWizard*en'
const UI_TYPE: string = 'Wizard'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string =
  'primary:#A07CFF secondary:#F6B4D7 tertiary:#8DD3C7 background:#FDF8FF surface:#FFFFFF surfaceVariant:#EFE7FF outline:#C9B4E6 success:#6ED8A0 warning:#FCD277 error:#FF8899 onPrimary:#1D0F33 onSecondary:#2B0E1C onTertiary:#06231C onBackground:#1C1126 onSurface:#24132C'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'Stepper,Form,Summary'
const EXTRA: string = 'Soft pastel lease wizard with step chips and summary card'

class AppColors {
  static readonly primary: string = '#A07CFF'
  static readonly secondary: string = '#F6B4D7'
  static readonly tertiary: string = '#8DD3C7'
  static readonly background: string = '#FDF8FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EFE7FF'
  static readonly outline: string = '#C9B4E6'
  static readonly success: string = '#6ED8A0'
  static readonly warning: string = '#FCD277'
  static readonly error: string = '#FF8899'
  static readonly onPrimary: string = '#1D0F33'
  static readonly onSecondary: string = '#2B0E1C'
  static readonly onTertiary: string = '#06231C'
  static readonly onBackground: string = '#1C1126'
  static readonly onSurface: string = '#24132C'
  static readonly onSurfaceMuted: string = '#6D6076'
  static readonly primarySoft: string = '#D9CCFF'
  static readonly fieldFill: string = '#F4EEFF'
}

class AppSpacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 36
  static readonly xxxl: number = 48
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
}

interface WizardStep {
  order: number
  title: string
  description: string
}

interface SummaryItem {
  label: string
  value: string
}

interface DocumentChecklist {
  label: string
  status: string
}

@Entry
@Component
struct Index {
  @State private currentStep: number = 1
  @State private name: string = 'Avery Tenant'
  @State private contact: string = 'avery@example.com'
  @State private income: string = '$120k annual'

  private steps: WizardStep[] = [
    { order: 1, title: 'Profile', description: 'Tenant basics' },
    { order: 2, title: 'Income', description: 'Proof details' },
    { order: 3, title: 'References', description: 'Upload letters' },
    { order: 4, title: 'Summary', description: 'Confirm submission' }
  ]

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' }
  ]

  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' }
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.StepsCard()
          this.FormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.xl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private TopBar() {
    Row() {
      Circle()
        .width(30)
        .height(30)
        .fill(AppColors.surfaceVariant)

      Column() {
        Text('LeaseWizard')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(AppColors.onSurface)

        Text('Guided handoff')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onSurfaceMuted)
      }
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(30)
        .height(30)
        .fill(AppColors.primarySoft)
    }
    .width('100%')
    .height(64)
    .padding({
      left: 26,
      right: 26,
      top: 34
    })
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.background)
  }

  @Builder
  private StepsCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Steps')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(AppColors.onSurface)

      ForEach(this.steps, (step: WizardStep) => {
        this.StepRow(step)
      }, (step: WizardStep) => step.title)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .borderRadius(AppRadius.large)
    .backgroundColor(AppColors.surfaceVariant)
  }

  @Builder
  private StepRow(step: WizardStep) {
    Row({ space: AppSpacing.md }) {
      Column() {
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(step.order - 1 <= this.currentStep ? AppColors.primary : '#F3EAFE')

          Text(step.order.toString())
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(step.order - 1 <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
        }
        .width(28)
        .height(28)

        if (step.order !== this.steps.length) {
          Rect()
            .width(4)
            .height(32)
            .fill(AppColors.fieldFill)
        }
      }
      .width(28)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(AppColors.onSurface)

        Text(step.description)
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .lineHeight(18)
          .fontColor(AppColors.onSurfaceMuted)
      }
      .layoutWeight(1)

      Button(step.order - 1 <= this.currentStep ? 'Edit' : 'Go', { type: ButtonType.Normal })
        .width(66)
        .height(40)
        .borderRadius(AppRadius.small)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.currentStep = step.order - 1
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private FormCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Form')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(AppColors.onSurface)

      this.OutlinedInput('Full name', this.name, 'name')
      this.OutlinedInput('Contact', this.contact, 'contact')
      this.OutlinedInput('Income', this.income, 'income')

      Row({ space: AppSpacing.sm }) {
        Button('Back', { type: ButtonType.Normal })
          .layoutWeight(1)
          .height(44)
          .borderRadius(AppRadius.medium)
          .backgroundColor(AppColors.surfaceVariant)
          .fontColor(AppColors.onSurface)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1
            }
          })

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next', { type: ButtonType.Normal })
          .layoutWeight(1)
          .height(44)
          .borderRadius(AppRadius.medium)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .borderRadius(AppRadius.large)
    .backgroundColor(AppColors.surfaceVariant)
  }

  @Builder
  private OutlinedInput(label: string, value: string, field: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      TextInput({ text: value })
        .width('100%')
        .height(56)
        .margin({ top: 8 })
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .fontSize(15)
        .fontColor(AppColors.onSurface)
        .caretColor(AppColors.primary)
        .backgroundColor(AppColors.fieldFill)
        .borderRadius(AppRadius.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onChange((text: string) => {
          if (field === 'name') {
            this.name = text
          } else if (field === 'contact') {
            this.contact = text
          } else {
            this.income = text
          }
        })

      Text(label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor('#5E5566')
        .backgroundColor(AppColors.surfaceVariant)
        .padding({ left: 4, right: 4 })
        .position({ x: 24, y: 0 })
    }
    .width('100%')
    .height(64)
  }

  @Builder
  private SummaryCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Summary')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(AppColors.onSurface)

      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .lineHeight(20)
            .fontColor(AppColors.onSurface)

          Text(item.value)
            .fontSize(13)
            .fontWeight(FontWeight.Regular)
            .lineHeight(18)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.surfaceVariant)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }, (item: SummaryItem) => item.label)

      Column({ space: AppSpacing.xs }) {
        Text('Documents')
          .width('100%')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(AppColors.onSurface)

        ForEach(this.checklist, (doc: DocumentChecklist) => {
          Row() {
            Text(doc.label)
              .fontSize(13)
              .fontWeight(FontWeight.Regular)
              .lineHeight(18)
              .fontColor(AppColors.onSurface)

            Text(doc.status)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .lineHeight(14)
              .fontColor(AppColors.secondary)
          }
          .width('100%')
          .padding({
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs
          })
          .borderRadius(AppRadius.small)
          .backgroundColor('#F3ECFF')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
        }, (doc: DocumentChecklist) => doc.label)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .borderRadius(AppRadius.large)
    .backgroundColor(AppColors.surface)
  }
}