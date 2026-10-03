const AppColors = {
  primary: '#A07CFF',
  secondary: '#F6B4D7',
  tertiary: '#8DD3C7',
  background: '#FDF8FF',
  surface: '#FFFFFF',
  surfaceVariant: '#EFE7FF',
  outline: '#C9B4E6',
  success: '#6ED8A0',
  warning: '#FCD277',
  error: '#FF8899',
  onPrimary: '#1D0F33',
  onSecondary: '#2B0E1C',
  onTertiary: '#06231C',
  onBackground: '#1C1126',
  onSurface: '#24132C',
  onSurfaceAlpha70: '#B324132C',
  primaryAlpha30: '#4DA07CFF',
  surfaceVariantAlpha80: '#CCEFE7FF',
}

const AppSpacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 48,
}

const AppShapes = {
  small: 8,
  medium: 14,
  large: 24,
}

class WizardStep {
  title: string = ''
  description: string = ''
  constructor(title: string, description: string) {
    this.title = title
    this.description = description
  }
}

class SummaryItem {
  label: string = ''
  value: string = ''
  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

class DocumentChecklist {
  label: string = ''
  status: string = ''
  constructor(label: string, status: string) {
    this.label = label
    this.status = status
  }
}

@Entry
@Component
struct RootScreen {
  @State currentStep: number = 1
  @State name: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'
  @State income: string = '$120k annual'
  private steps: WizardStep[] = [
    new WizardStep('Profile', 'Tenant basics'),
    new WizardStep('Income', 'Proof details'),
    new WizardStep('References', 'Upload letters'),
    new WizardStep('Summary', 'Confirm submission'),
  ]
  private summaryItems: SummaryItem[] = [
    new SummaryItem('Lease start', 'Aug 12'),
    new SummaryItem('Monthly', '$2,450'),
    new SummaryItem('Deposit', '$2,450'),
    new SummaryItem('Pets', '2 approved'),
  ]
  private checklist: DocumentChecklist[] = [
    new DocumentChecklist('ID verification', 'Uploaded'),
    new DocumentChecklist('Employment letter', 'Pending'),
    new DocumentChecklist('Credit report', 'Synced'),
  ]

  @Builder
  StepRowBuilder(index: number, step: WizardStep) {
    Row() {
      Column() {
        Text(`${index + 1}`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(index <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
          .width(28)
          .height(28)
          .backgroundColor(index <= this.currentStep ? AppColors.primary : AppColors.surfaceVariant)
          .borderRadius(14)
          .textAlign(TextAlign.Center)

        if (index < this.steps.length - 1) {
          Column() {}
            .width(4)
            .height(32)
            .backgroundColor(AppColors.surfaceVariant)
            .margin({ top: AppSpacing.xxs })
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
          .fontColor(AppColors.onSurfaceAlpha70)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })

      Button(index <= this.currentStep ? 'Edit' : 'Go') {
        Text(index <= this.currentStep ? 'Edit' : 'Go')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .height(32)
        .onClick(() => {
          this.currentStep = index
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  SummaryRowBuilder(item: SummaryItem) {
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
    .borderRadius(AppShapes.medium)
  }

  @Builder
  ChecklistRowBuilder(doc: DocumentChecklist) {
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
    .backgroundColor(AppColors.surfaceVariantAlpha80)
    .borderRadius(AppShapes.small)
  }

  build() {
    Column() {
      Row() {
        Column() {}
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
            .fontColor(AppColors.onSurfaceAlpha70)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {}
          .width(30)
          .height(30)
          .backgroundColor(AppColors.primaryAlpha30)
          .borderRadius(15)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

      Scroll() {
        Column() {
          Column() {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            ForEach(this.steps, (step: WizardStep, index: number) => {
              this.StepRowBuilder(index, step)
            }, (step: WizardStep) => step.title)
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })

          Column() {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            TextInput({ text: this.name, placeholder: 'Full name' })
              .width('100%')
              .height(48)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => {
                this.name = value
              })

            TextInput({ text: this.contact, placeholder: 'Contact' })
              .width('100%')
              .height(48)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => {
                this.contact = value
              })

            TextInput({ text: this.income, placeholder: 'Income' })
              .width('100%')
              .height(48)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => {
                this.income = value
              })

            Row() {
              Button('Back') {
                Text('Back')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
              }
                .type(ButtonType.Normal)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.medium)
                .layoutWeight(1)
                .height(44)
                .onClick(() => {
                  if (this.currentStep > 0) this.currentStep -= 1
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next') {
                Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
                .type(ButtonType.Normal)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.medium)
                .layoutWeight(1)
                .height(44)
                .margin({ left: AppSpacing.sm })
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) this.currentStep += 1
                })
            }
            .width('100%')
            .margin({ top: AppSpacing.sm })
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })

          Column() {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            ForEach(this.summaryItems, (item: SummaryItem) => {
              this.SummaryRowBuilder(item)
            }, (item: SummaryItem) => item.label)

            Text('Documents')
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .margin({ top: AppSpacing.xs })

            ForEach(this.checklist, (doc: DocumentChecklist) => {
              this.ChecklistRowBuilder(doc)
            }, (doc: DocumentChecklist) => doc.label)
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}