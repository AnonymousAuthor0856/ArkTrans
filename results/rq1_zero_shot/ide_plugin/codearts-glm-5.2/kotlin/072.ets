const AppColors = {
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
  onSurface: '#2A1C12',
  onSurfaceAlpha70: '#B32A1C12',
  primaryAlpha35: '#59B58B5A',
  primaryAlpha20: '#33B58B5A',
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

class FormStep {
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

@Entry
@Component
struct RootScreen {
  @State currentStep: number = 1
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0
  private steps: FormStep[] = [
    new FormStep('Identity', 'Applicant basics'),
    new FormStep('Impact', 'Community reach'),
    new FormStep('Needs', 'Immediate relief'),
    new FormStep('Summary', 'Confirm details'),
  ]
  private chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities']
  private summary: SummaryItem[] = [
    new SummaryItem('Requested', '$4,500'),
    new SummaryItem('Households', '36'),
    new SummaryItem('Region', 'North loop'),
    new SummaryItem('Urgency', '48h'),
  ]

  @Builder
  StepRowBuilder(index: number, step: FormStep) {
    Row() {
      Column() {
        Text(`${index + 1}`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(index <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
          .width(26)
          .height(26)
          .backgroundColor(index <= this.currentStep ? AppColors.primary : AppColors.surfaceVariant)
          .borderRadius(13)
          .textAlign(TextAlign.Center)

        if (index < this.steps.length - 1) {
          Column() {}
            .width(3)
            .height(28)
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
      .margin({ left: AppSpacing.sm })

      Button(index <= this.currentStep ? 'Edit' : 'Go') {
        Text(index <= this.currentStep ? 'Edit' : 'Go')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .height(30)
        .onClick(() => {
          this.currentStep = index
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  ChipBuilder(chip: string, index: number) {
    Text(chip)
      .fontSize(15)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(this.selectedChip === index ? AppColors.primaryAlpha20 : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .borderWidth(1)
      .borderColor(this.selectedChip === index ? AppColors.primary : AppColors.outline)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .onClick(() => {
        this.selectedChip = index
      })
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

  build() {
    Column() {
      Row() {
        Column() {}
          .width(30)
          .height(30)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(15)

        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('Civic support intake')
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
          .backgroundColor(AppColors.primaryAlpha35)
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

            ForEach(this.steps, (step: FormStep, index: number) => {
              this.StepRowBuilder(index, step)
            }, (step: FormStep) => step.title)
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)

          Column() {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            Row() {
              ForEach(this.chips, (chip: string, index: number) => {
                this.ChipBuilder(chip, index)
              }, (chip: string) => chip)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })

          Column() {
            Text('Applicant details')
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
              .onChange((value: string) => { this.name = value })

            TextInput({ text: this.organization, placeholder: 'Organization' })
              .width('100%')
              .height(48)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => { this.organization = value })

            TextInput({ text: this.contact, placeholder: 'Contact' })
              .width('100%')
              .height(48)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => { this.contact = value })

            TextArea({ text: this.narrative, placeholder: 'Relief narrative' })
              .width('100%')
              .height(80)
              .borderWidth(1)
              .borderColor(AppColors.outline)
              .borderRadius(AppShapes.small)
              .backgroundColor(AppColors.surface)
              .margin({ top: AppSpacing.sm })
              .onChange((value: string) => { this.narrative = value })

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
                .onClick(() => { if (this.currentStep > 0) this.currentStep -= 1 })

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
                .onClick(() => { if (this.currentStep < this.steps.length - 1) this.currentStep += 1 })
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

            ForEach(this.summary, (item: SummaryItem) => {
              this.SummaryRowBuilder(item)
            }, (item: SummaryItem) => item.label)
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}