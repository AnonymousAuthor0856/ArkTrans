const NAME: string = '167*ReliefFund*en'
const UI_TYPE: string = 'Form'
const STYLE_THEME: string = 'Muted Earth'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string = 'primary:#B58B5A secondary:#E5C48F tertiary:#8BB39B background:#F6F0E3 surface:#FFFFFF surfaceVariant:#E7D7C2 outline:#C3B09E success:#6FB08C warning:#E6B566 error:#D96C5F onPrimary:#2D1A0D onSecondary:#2F230C onTertiary:#0E1A13 onBackground:#1E130C onSurface:#2A1C12'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'TextField,Stepper,CTA'
const EXTRA: string = 'Muted civic relief form with stepper chips and submit CTA'

class AppColors {
  static readonly primary: ResourceColor = '#B58B5A'
  static readonly secondary: ResourceColor = '#E5C48F'
  static readonly tertiary: ResourceColor = '#8BB39B'
  static readonly background: ResourceColor = '#F6F0E3'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E7D7C2'
  static readonly outline: ResourceColor = '#C3B09E'
  static readonly success: ResourceColor = '#6FB08C'
  static readonly warning: ResourceColor = '#E6B566'
  static readonly error: ResourceColor = '#D96C5F'
  static readonly onPrimary: ResourceColor = '#2D1A0D'
  static readonly onSecondary: ResourceColor = '#2F230C'
  static readonly onTertiary: ResourceColor = '#0E1A13'
  static readonly onBackground: ResourceColor = '#1E130C'
  static readonly onSurface: ResourceColor = '#2A1C12'
  static readonly onSurface70: ResourceColor = '#B32A1C12'
  static readonly primary20: ResourceColor = '#33B58B5A'
  static readonly primary35: ResourceColor = '#59B58B5A'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayLineHeight: number = 32
  static readonly headlineSize: number = 20
  static readonly headlineLineHeight: number = 26
  static readonly titleSize: number = 15
  static readonly titleLineHeight: number = 20
  static readonly bodySize: number = 13
  static readonly bodyLineHeight: number = 18
  static readonly labelSize: number = 11
  static readonly labelLineHeight: number = 14
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
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

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 12, 6, 0.22)
  static readonly level4: ShadowSpec = new ShadowSpec(18, 18, 8, 0.26)
  static readonly level5: ShadowSpec = new ShadowSpec(24, 24, 10, 0.3)
}

interface FormStep {
  title: string
  description: string
}

interface SupportChip {
  label: string
}

interface SummaryItem {
  label: string
  value: string
}

@Entry
@Component
struct RootScreen {
  private steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ]

  private chips: SupportChip[] = [
    { label: 'Medical' },
    { label: 'Shelter' },
    { label: 'Food' },
    { label: 'Utilities' }
  ]

  private summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ]

  @State currentStep: number = 1
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0

  @Builder
  TopBar() {
    Row() {
      Stack()
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(AppColors.surfaceVariant)
        .onClick(() => {
        })

      Column() {
        Text('ReliefFund')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(AppTypography.titleLineHeight)
          .fontColor(AppColors.onSurface)

        Text('Civic support intake')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(AppTypography.labelLineHeight)
          .fontColor(AppColors.onSurface70)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Stack()
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(AppColors.primary35)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(72)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  StepCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Steps')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(AppTypography.headlineLineHeight)
        .fontColor(AppColors.onSurface)

      ForEach(this.steps, (step: FormStep, index: number) => {
        Row({ space: AppSpacing.sm }) {
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Text(`${index + 1}`)
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .lineHeight(AppTypography.labelLineHeight)
                .fontColor(index <= this.currentStep ? AppColors.onPrimary : AppColors.onSurface)
            }
            .width(26)
            .height(26)
            .borderRadius(13)
            .backgroundColor(index <= this.currentStep ? AppColors.primary : AppColors.surfaceVariant)

            if (index !== this.steps.length - 1) {
              Stack()
                .width(3)
                .height(28)
                .backgroundColor(AppColors.surfaceVariant)
            }
          }
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text(step.title)
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(AppTypography.titleLineHeight)
              .fontColor(AppColors.onSurface)

            Text(step.description)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .lineHeight(AppTypography.bodyLineHeight)
              .fontColor(AppColors.onSurface70)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button(index <= this.currentStep ? 'Edit' : 'Go')
            .height(34)
            .padding({ left: AppSpacing.md, right: AppSpacing.md })
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppRadius.small)
            .onClick(() => {
              this.currentStep = index
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }, (step: FormStep) => step.title)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({ radius: AppElevation.level2.radius, color: '#2E000000', offsetX: 0, offsetY: AppElevation.level2.dy })
  }

  @Builder
  FocusCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(AppTypography.headlineLineHeight)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        ForEach(this.chips, (chip: SupportChip, index: number) => {
          Text(chip.label)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppTypography.titleLineHeight)
            .fontColor(AppColors.onSurface)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
            .backgroundColor(this.selectedChip === index ? AppColors.primary20 : AppColors.surfaceVariant)
            .border({
              width: 1,
              color: this.selectedChip === index ? AppColors.primary : AppColors.outline,
              radius: AppRadius.small
            })
            .onClick(() => {
              this.selectedChip = index
            })
        }, (chip: SupportChip) => chip.label)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({ radius: AppElevation.level1.radius, color: '#1F000000', offsetX: 0, offsetY: AppElevation.level1.dy })
  }

  @Builder
  ApplicantCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Applicant details')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(AppTypography.headlineLineHeight)
        .fontColor(AppColors.onSurface)

      TextInput({ text: this.name, placeholder: 'Full name' })
        .width('100%')
        .height(52)
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface70)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppRadius.small })
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        .onChange((value: string) => {
          this.name = value
        })

      TextInput({ text: this.organization, placeholder: 'Organization' })
        .width('100%')
        .height(52)
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface70)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppRadius.small })
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        .onChange((value: string) => {
          this.organization = value
        })

      TextInput({ text: this.contact, placeholder: 'Contact' })
        .width('100%')
        .height(52)
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface70)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppRadius.small })
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        .onChange((value: string) => {
          this.contact = value
        })

      TextArea({ text: this.narrative, placeholder: 'Relief narrative' })
        .width('100%')
        .height(96)
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface70)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppRadius.small })
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .onChange((value: string) => {
          this.narrative = value
        })

      Row({ space: AppSpacing.sm }) {
        Button('Back')
          .height(44)
          .layoutWeight(1)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.medium)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1
            }
          })

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .height(44)
          .layoutWeight(1)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.medium)
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
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({ radius: AppElevation.level2.radius, color: '#2E000000', offsetX: 0, offsetY: AppElevation.level2.dy })
  }

  @Builder
  SummaryCard() {
    Column({ space: AppSpacing.xs }) {
      Text('Summary')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(AppTypography.headlineLineHeight)
        .fontColor(AppColors.onSurface)

      ForEach(this.summary, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppTypography.titleLineHeight)
            .fontColor(AppColors.onSurface)

          Text(item.value)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .lineHeight(AppTypography.bodyLineHeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.medium)
      }, (item: SummaryItem) => item.label)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({ radius: AppElevation.level1.radius, color: '#1F000000', offsetX: 0, offsetY: AppElevation.level1.dy })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.StepCard()
          this.FocusCard()
          this.ApplicantCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}