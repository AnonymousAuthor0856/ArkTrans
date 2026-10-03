const NAME: string = '160*LeaseWizard*en'
const UI_TYPE: string = 'Wizard'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string = 'primary:#A07CFF secondary:#F6B4D7 tertiary:#8DD3C7 background:#FDF8FF surface:#FFFFFF surfaceVariant:#EFE7FF outline:#C9B4E6 success:#6ED8A0 warning:#FCD277 error:#FF8899 onPrimary:#1D0F33 onSecondary:#2B0E1C onTertiary:#06231C onBackground:#1C1126 onSurface:#24132C'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'Stepper,Form,Summary'
const EXTRA: string = 'Soft pastel lease wizard with step chips and summary card'

interface WizardStep {
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

class Colors {
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
}

class Spacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 36
  static readonly xxxl: number = 48
}

class Radius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
}

@Entry
@Component
struct LeaseWizard {
  @State currentStep: number = 1
  @State name: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'
  @State income: string = '$120k annual'

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
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
        Column({ space: Spacing.md }) {
          this.StepsCard()
          this.FormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.md,
          bottom: Spacing.xl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Stack()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .stateEffect(false)
      .onClick(() => {
      })

      Column() {
        Text('LeaseWizard')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(Colors.onSurface)

        Text('Guided handoff')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor('rgba(36, 19, 44, 0.70)')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Button() {
        Stack()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('rgba(160, 124, 255, 0.30)')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .stateEffect(false)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(72)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.background)
  }

  @Builder
  StepsCard() {
    Column({ space: Spacing.sm }) {
      Text('Steps')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(Colors.onSurface)

      ForEach(this.steps, (step: WizardStep, index: number) => {
        this.StepRow(step, index)
      }, (step: WizardStep, index: number) => `${index}-${step.title}`)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  StepRow(step: WizardStep, index: number) {
    Row({ space: Spacing.md }) {
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Text(`${index + 1}`)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .lineHeight(14)
            .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)

        if (index !== this.steps.length - 1) {
          Blank()
            .width(4)
            .height(32)
            .backgroundColor(Colors.surfaceVariant)
        }
      }
      .width(28)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(Colors.onSurface)

        Text(step.description)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .lineHeight(18)
          .fontColor('rgba(36, 19, 44, 0.70)')
      }
      .layoutWeight(1)

      Button() {
        Text(index <= this.currentStep ? 'Edit' : 'Go')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(Colors.onSecondary)
      }
      .height(36)
      .padding({ left: 14, right: 14 })
      .borderRadius(Radius.small)
      .backgroundColor(Colors.secondary)
      .onClick(() => {
        this.currentStep = index
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FormCard() {
    Column({ space: Spacing.sm }) {
      Text('Form')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(Colors.onSurface)

      TextInput({ text: this.name, placeholder: 'Full name' })
        .width('100%')
        .height(52)
        .fontSize(13)
        .fontColor(Colors.onSurface)
        .placeholderColor('rgba(36, 19, 44, 0.55)')
        .backgroundColor(Colors.surface)
        .border({ width: 1, color: Colors.outline })
        .borderRadius(Radius.medium)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.name = value
        })

      TextInput({ text: this.contact, placeholder: 'Contact' })
        .width('100%')
        .height(52)
        .fontSize(13)
        .fontColor(Colors.onSurface)
        .placeholderColor('rgba(36, 19, 44, 0.55)')
        .backgroundColor(Colors.surface)
        .border({ width: 1, color: Colors.outline })
        .borderRadius(Radius.medium)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.contact = value
        })

      TextInput({ text: this.income, placeholder: 'Income' })
        .width('100%')
        .height(52)
        .fontSize(13)
        .fontColor(Colors.onSurface)
        .placeholderColor('rgba(36, 19, 44, 0.55)')
        .backgroundColor(Colors.surface)
        .border({ width: 1, color: Colors.outline })
        .borderRadius(Radius.medium)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.income = value
        })

      Row({ space: Spacing.sm }) {
        Button() {
          Text('Back')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .lineHeight(20)
            .fontColor(Colors.onSurface)
        }
        .height(44)
        .layoutWeight(1)
        .borderRadius(Radius.medium)
        .backgroundColor(Colors.surfaceVariant)
        .onClick(() => {
          if (this.currentStep > 0) {
            this.currentStep -= 1
          }
        })

        Button() {
          Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .lineHeight(20)
            .fontColor(Colors.onPrimary)
        }
        .height(44)
        .layoutWeight(1)
        .borderRadius(Radius.medium)
        .backgroundColor(Colors.primary)
        .onClick(() => {
          if (this.currentStep < this.steps.length - 1) {
            this.currentStep += 1
          }
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  SummaryCard() {
    Column({ space: Spacing.sm }) {
      Text('Summary')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(26)
        .fontColor(Colors.onSurface)

      ForEach(this.summaryItems, (item: SummaryItem) => {
        this.SummaryRow(item)
      }, (item: SummaryItem) => item.label)

      Column({ space: Spacing.xs }) {
        Text('Documents')
          .width('100%')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .lineHeight(20)
          .fontColor(Colors.onSurface)

        ForEach(this.checklist, (doc: DocumentChecklist) => {
          this.DocumentRow(doc)
        }, (doc: DocumentChecklist) => doc.label)
      }
      .width('100%')
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  SummaryRow(item: SummaryItem) {
    Row() {
      Text(item.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .lineHeight(20)
        .fontColor(Colors.onSurface)

      Text(item.value)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .lineHeight(18)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .padding(Spacing.sm)
    .borderRadius(Radius.medium)
    .backgroundColor(Colors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  DocumentRow(doc: DocumentChecklist) {
    Row() {
      Text(doc.label)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .lineHeight(18)
        .fontColor(Colors.onSurface)

      Text(doc.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .lineHeight(14)
        .fontColor(Colors.secondary)
    }
    .width('100%')
    .padding({
      left: Spacing.sm,
      right: Spacing.sm,
      top: Spacing.xs,
      bottom: Spacing.xs
    })
    .borderRadius(Radius.small)
    .backgroundColor('rgba(239, 231, 255, 0.80)')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}