import { Color, FontSize, FontWeight, LengthUnit } from '@kit.ArkUI'

// Design Tokens
interface ColorsInterface {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const COLORS: ColorsInterface = {
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
}

interface SpacingInterface {
  xxs: number;
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

const SPACING: SpacingInterface = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 48
}

interface ShapesInterface {
  small: number;
  medium: number;
  large: number;
}

const SHAPES: ShapesInterface = {
  small: 8,
  medium: 14,
  large: 24
}

interface FormStep {
  title: string;
  description: string;
}

interface SupportChip {
  label: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

@Entry
@Component
struct ReliefFundApp {
  @State currentStep: number = 1
  @State selectedChip: number = 0
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

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

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Back)
        Button() {
          Circle({ width: 30, height: 30 })
            .fill(Color(COLORS.surfaceVariant))
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          if (this.currentStep > 0) this.currentStep--
        })

        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color(COLORS.onSurface))
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color(COLORS.onSurface).withAlpha(0.7))
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // Action Icon
        Button() {
          Circle({ width: 30, height: 30 })
            .fill(Color(COLORS.primary).withAlpha(0.35))
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
      }
      .width('100%')
      .height(60)
      .padding({ left: SPACING.lg, right: SPACING.lg })
      .backgroundColor(Color(COLORS.background))

      // Scrollable Content
      Scroll() {
        Column() {
          // Steps Card
          Column() {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color(COLORS.onSurface))
              .margin({ bottom: SPACING.sm })

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row() {
                // Stepper Line and Circle
                Column() {
                  Row() {
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? Color(COLORS.onPrimary) : Color(COLORS.onSurface))
                      .textAlign(TextAlign.Center)
                      .width(26)
                      .height(26)
                      .borderRadius(13)
                      .backgroundColor(index <= this.currentStep ? Color(COLORS.primary) : Color(COLORS.surfaceVariant))
                  }
                  .justifyContent(FlexAlign.Center)

                  if (index < this.steps.length - 1) {
                    Divider()
                      .width(3)
                      .height(28)
                      .color(Color(COLORS.surfaceVariant))
                      .margin({ top: 2, bottom: 2 })
                  }
                }
                .alignItems(HorizontalAlign.Center)

                // Step Info
                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color(COLORS.onSurface))
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(Color(COLORS.onSurface).withAlpha(0.7))
                    .margin({ top: 2 })
                }
                .layoutWeight(1)
                .margin({ left: SPACING.sm })

                // Action Button
                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(COLORS.onSecondary))
                  .backgroundColor(Color(COLORS.secondary))
                  .borderRadius(SHAPES.small)
                  .height(32)
                  .onClick(() => {
                    this.currentStep = index
                  })
              }
              .width('100%')
              .margin({ bottom: index < this.steps.length - 1 ? SPACING.md : 0 })
            })
          }
          .padding(SPACING.md)
          .backgroundColor(Color(COLORS.surface))
          .borderRadius(SHAPES.large)
          .shadow({ radius: 8, color: '#00000018', offsetY: 4 })
          .margin({ bottom: SPACING.md })

          // Focus Chips Card
          Column() {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color(COLORS.onSurface))
              .margin({ bottom: SPACING.sm })

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Button(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(COLORS.onSurface))
                  .backgroundColor(this.selectedChip === index ? Color(COLORS.primary).withAlpha(0.2) : Color(COLORS.surfaceVariant))
                  .borderWidth(1)
                  .borderColor(this.selectedChip === index ? Color(COLORS.primary) : Color(COLORS.outline))
                  .borderRadius(SHAPES.small)
                  .margin({ right: SPACING.sm, bottom: SPACING.xs })
                  .onClick(() => {
                    this.selectedChip = index
                  })
              })
            }
          }
          .padding(SPACING.md)
          .backgroundColor(Color(COLORS.surface))
          .borderRadius(SHAPES.large)
          .shadow({ radius: 4, color: '#00000012', offsetY: 2 })
          .margin({ bottom: SPACING.md })

          // Applicant Details Card
          Column() {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color(COLORS.onSurface))
              .margin({ bottom: SPACING.sm })

            TextInput({ placeholder: 'Full name' })
              .placeholderColor(Color(COLORS.onSurface).withAlpha(0.5))
              .backgroundColor(Color(COLORS.surface))
              .border({ width: 1, color: Color(COLORS.outline), radius: SHAPES.small })
              .margin({ bottom: SPACING.sm })
              .onChange((value: string) => {
                this.name = value
              })

            TextInput({ placeholder: 'Organization' })
              .placeholderColor(Color(COLORS.onSurface).withAlpha(0.5))
              .backgroundColor(Color(COLORS.surface))
              .border({ width: 1, color: Color(COLORS.outline), radius: SHAPES.small })
              .margin({ bottom: SPACING.sm })
              .onChange((value: string) => {
                this.organization = value
              })

            TextInput({ placeholder: 'Contact' })
              .placeholderColor(Color(COLORS.onSurface).withAlpha(0.5))
              .backgroundColor(Color(COLORS.surface))
              .border({ width: 1, color: Color(COLORS.outline), radius: SHAPES.small })
              .margin({ bottom: SPACING.sm })
              .onChange((value: string) => {
                this.contact = value
              })

            TextArea({ placeholder: 'Relief narrative' })
              .placeholderColor(Color(COLORS.onSurface).withAlpha(0.5))
              .backgroundColor(Color(COLORS.surface))
              .border({ width: 1, color: Color(COLORS.outline), radius: SHAPES.small })
              .height(100)
              .margin({ bottom: SPACING.md })
              .onChange((value: string) => {
                this.narrative = value
              })

            Row() {
              Button('Back')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color(COLORS.onSurface))
                .backgroundColor(Color(COLORS.surfaceVariant))
                .borderRadius(SHAPES.medium)
                .layoutWeight(1)
                .margin({ right: SPACING.sm / 2 })
                .onClick(() => {
                  if (this.currentStep > 0) this.currentStep--
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color(COLORS.onPrimary))
                .backgroundColor(Color(COLORS.primary))
                .borderRadius(SHAPES.medium)
                .layoutWeight(1)
                .margin({ left: SPACING.sm / 2 })
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) this.currentStep++
                })
            }
            .width('100%')
          }
          .padding(SPACING.md)
          .backgroundColor(Color(COLORS.surface))
          .borderRadius(SHAPES.large)
          .shadow({ radius: 8, color: '#00000018', offsetY: 4 })
          .margin({ bottom: SPACING.md })

          // Summary Card
          Column() {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color(COLORS.onSurface))
              .margin({ bottom: SPACING.sm })

            ForEach(this.summary, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(COLORS.onSurface))
                  .layoutWeight(1)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(Color(COLORS.onSurface))
              }
              .width('100%')
              .padding(SPACING.sm)
              .backgroundColor(Color(COLORS.surfaceVariant))
              .borderRadius(SHAPES.medium)
              .margin({ bottom: SPACING.xs })
            })
          }
          .padding(SPACING.md)
          .backgroundColor(Color(COLORS.surface))
          .borderRadius(SHAPES.large)
          .shadow({ radius: 4, color: '#00000012', offsetY: 2 })
          .margin({ bottom: SPACING.xxxl }) // Extra padding at bottom for scroll
        }
        .padding({ left: SPACING.lg, right: SPACING.lg, top: SPACING.sm })
      }
      .layoutWeight(1)
      .backgroundColor(Color(COLORS.background))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(COLORS.background))
  }
}