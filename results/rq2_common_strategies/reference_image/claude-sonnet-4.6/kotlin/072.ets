/*
 * ReliefFund — ArkTS/ArkUI port of the Kotlin Compose reference screen.
 * Target: entry/src/main/ets/pages/Index.ets  (register "pages/Index" in main_pages.json)
 *
 * Rendered layout @ 720x1280 baseline (ASCII wireframe / "screenshot"):
 *  ┌──────────────────────────────────────────────┐
 *  │ (o)        ReliefFund             (o)        │  <- TopBar, surface #FFFFFF, h=64
 *  │        Civic support intake                  │
 *  ├──────────────────────────────────────────────┤  page bg #F6F0E3
 *  │ ╭──────── Steps ───────────────────────────╮ │
 *  │ │ ① Identity  Applicant basics     [Edit]  │ │
 *  │ │ │                                        │ │
 *  │ │ ② Impact    Community reach      [Edit]  │ │
 *  │ ╰──────────────────────────────────────────╯ │
 *  │ ╭──────── Focus ───────────────────────────╮ │
 *  │ │ [Medical] [Shelter] [Food] [Utilities]   │ │
 *  │ ╰──────────────────────────────────────────╯ │
 *  │ ╭──────── Applicant details ───────────────╮ │
 *  │ │ ┌──────────────────────────────────────┐ │ │
 *  │ │ │ Full name                            │ │ │
 *  │ │ └──────────────────────────────────────┘ │ │
 *  │ │ ┌ Organization ┐ ┌ Contact ┐             │ │
 *  │ │ ┌ Relief narrative (multiline) ┐         │ │
 *  │ │ [   Back   ] [   Next   ]                │ │
 *  │ ╰──────────────────────────────────────────╯ │
 *  │ ╭──────── Summary ─────────────────────────╮ │
 *  │ │ [ Requested                    $4,500 ]  │ │
 *  │ ╰──────────────────────────────────────────╯ │
 *  └──────────────────────────────────────────────┘
 */

const NAME: string = '167*ReliefFund*en'
const UI_TYPE: string = 'Form'
const STYLE_THEME: string = 'Muted Earth'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'TextField,Stepper,CTA'

/** Immutable design tokens lifted from the Compose DesignTokens object. */
class Palette {
  static readonly primary: string = '#B58B5A'
  static readonly secondary: string = '#E5C48F'
  static readonly tertiary: string = '#8BB39B'
  static readonly background: string = '#F6F0E3'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E7D7C2'
  static readonly outline: string = '#C3B09E'
  static readonly success: string = '#6FB08C'
  static readonly warning: string = '#E6B566'
  static readonly error: string = '#D96C5F'
  static readonly onPrimary: string = '#2D1A0D'
  static readonly onSecondary: string = '#2F230C'
  static readonly onTertiary: string = '#0E1A13'
  static readonly onBackground: string = '#1E130C'
  static readonly onSurface: string = '#2A1C12'
  /** onSurface @ 70% — ArkUI uses #AARRGGBB ordering. */
  static readonly onSurfaceMuted: string = '#B32A1C12'
  /** primary @ 20% */
  static readonly primarySoft: string = '#33B58B5A'
  /** primary @ 35% */
  static readonly primarySofter: string = '#59B58B5A'
  static readonly elevationTint: string = '#1F000000'
  static readonly elevationTintStrong: string = '#2E000000'
}

class FontSize {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 15
  static readonly body: number = 13
  static readonly label: number = 11
}

class Radius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
  static readonly circle: number = 15
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

interface FormStep {
  title: string
  description: string
}

interface SummaryItem {
  label: string
  value: string
}

@Entry
@Component
struct ReliefFund {
  /** Mirrors `mutableStateOf(1)` — screen opens on the "Applicant details" step. */
  @State currentStep: number = 1
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0

  private steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ]

  private chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities']

  private summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ]

  // ---------------------------------------------------------------- TopBar

  @Builder
  TopBar() {
    Row() {
      Row()
        .width(30)
        .height(30)
        .borderRadius(Radius.circle)
        .backgroundColor(Palette.surfaceVariant)

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(FontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(Palette.onSurface)
        Text('Civic support intake')
          .fontSize(FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(Palette.onSurfaceMuted)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Row()
        .width(30)
        .height(30)
        .borderRadius(Radius.circle)
        .backgroundColor(Palette.primarySofter)
    }
    .width('100%')
    .height(64)
    .padding({ left: Spacing.lg, right: Spacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Palette.surface)
  }

  // ----------------------------------------------------------- Steps card

  @Builder
  StepsCard() {
    Column({ space: Spacing.sm }) {
      Text('Steps')
        .fontSize(FontSize.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onSurface)

      ForEach(this.steps, (step: FormStep, index: number) => {
        Row({ space: Spacing.sm }) {
          // Stepper rail: numbered dot + connector
          Column() {
            Row() {
              Text((index + 1).toString())
                .fontSize(FontSize.label)
                .fontWeight(FontWeight.Medium)
                .fontColor(index <= this.currentStep ? Palette.onPrimary : Palette.onSurface)
            }
            .width(26)
            .height(26)
            .borderRadius(13)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(index <= this.currentStep ? Palette.primary : Palette.surfaceVariant)

            if (index !== this.steps.length - 1) {
              Row()
                .width(3)
                .height(28)
                .backgroundColor(Palette.surfaceVariant)
            }
          }
          .alignItems(HorizontalAlign.Center)

          Column({ space: 2 }) {
            Text(step.title)
              .fontSize(FontSize.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(Palette.onSurface)
            Text(step.description)
              .fontSize(FontSize.body)
              .fontColor(Palette.onSurfaceMuted)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button() {
            Text(index <= this.currentStep ? 'Edit' : 'Go')
              .fontSize(FontSize.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(Palette.onSecondary)
          }
          .height(30)
          .padding({ left: Spacing.sm, right: Spacing.sm })
          .backgroundColor(Palette.secondary)
          .borderRadius(Radius.small)
          .onClick(() => {
            this.currentStep = index
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }, (step: FormStep, index: number) => `${index}-${step.title}`)
    }
    .width('100%')
    .padding(Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Palette.surface)
    .borderRadius(Radius.large)
    .shadow({ radius: 8, color: Palette.elevationTint, offsetX: 0, offsetY: 4 })
  }

  // ----------------------------------------------------------- Focus card

  @Builder
  FocusCard() {
    Column({ space: Spacing.sm }) {
      Text('Focus')
        .fontSize(FontSize.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onSurface)

      Row({ space: Spacing.sm }) {
        ForEach(this.chips, (chip: string, index: number) => {
          Row() {
            Text(chip)
              .fontSize(FontSize.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(Palette.onSurface)
          }
          .padding({
            left: Spacing.md,
            right: Spacing.md,
            top: Spacing.xs,
            bottom: Spacing.xs
          })
          .backgroundColor(this.selectedChip === index ? Palette.primarySoft : Palette.surfaceVariant)
          .border({
            width: 1,
            color: this.selectedChip === index ? Palette.primary : Palette.outline,
            radius: Radius.small
          })
          .onClick(() => {
            this.selectedChip = index
          })
        }, (chip: string, index: number) => `${chip}-${index}`)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Palette.surface)
    .borderRadius(Radius.large)
    .shadow({ radius: 4, color: Palette.elevationTint, offsetX: 0, offsetY: 2 })
  }

  // ------------------------------------------------- Applicant details card

  @Builder
  FieldInput(placeholder: string, value: string, onText: (text: string) => void) {
    TextInput({ placeholder: placeholder, text: value })
      .placeholderColor(Palette.onSurfaceMuted)
      .placeholderFont({ size: FontSize.body, weight: FontWeight.Normal })
      .fontSize(FontSize.body)
      .fontColor(Palette.onSurface)
      .caretColor(Palette.primary)
      .height(56)
      .width('100%')
      .padding({ left: Spacing.md, right: Spacing.md })
      .backgroundColor(Palette.surface)
      .borderRadius(Radius.medium)
      .border({ width: 1, color: Palette.outline })
      .onChange((text: string) => {
        onText(text)
      })
  }

  @Builder
  DetailsCard() {
    Column({ space: Spacing.sm }) {
      Text('Applicant details')
        .fontSize(FontSize.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onSurface)

      this.FieldInput('Full name', this.fullName, (text: string) => {
        this.fullName = text
      })

      this.FieldInput('Organization', this.organization, (text: string) => {
        this.organization = text
      })

      this.FieldInput('Contact', this.contact, (text: string) => {
        this.contact = text
      })

      TextArea({ placeholder: 'Relief narrative', text: this.narrative })
        .placeholderColor(Palette.onSurfaceMuted)
        .placeholderFont({ size: FontSize.body, weight: FontWeight.Normal })
        .fontSize(FontSize.body)
        .fontColor(Palette.onSurface)
        .caretColor(Palette.primary)
        .height(120)
        .width('100%')
        .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.sm, bottom: Spacing.sm })
        .backgroundColor(Palette.surface)
        .borderRadius(Radius.medium)
        .border({ width: 1, color: Palette.outline })
        .onChange((text: string) => {
          this.narrative = text
        })

      Row({ space: Spacing.sm }) {
        Button() {
          Text('Back')
            .fontSize(FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(Palette.onSurface)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(Palette.surfaceVariant)
        .borderRadius(Radius.medium)
        .onClick(() => {
          if (this.currentStep > 0) {
            this.currentStep -= 1
          }
        })

        Button() {
          Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
            .fontSize(FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(Palette.onPrimary)
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor(Palette.primary)
        .borderRadius(Radius.medium)
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
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Palette.surface)
    .borderRadius(Radius.large)
    .shadow({ radius: 8, color: Palette.elevationTint, offsetX: 0, offsetY: 4 })
  }

  // --------------------------------------------------------- Summary card

  @Builder
  SummaryCard() {
    Column({ space: Spacing.xs }) {
      Text('Summary')
        .fontSize(FontSize.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onSurface)
        .margin({ bottom: Spacing.xxs })

      ForEach(this.summary, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(Palette.onSurface)
          Text(item.value)
            .fontSize(FontSize.body)
            .fontColor(Palette.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(Spacing.sm)
        .backgroundColor(Palette.surfaceVariant)
        .borderRadius(Radius.medium)
      }, (item: SummaryItem) => item.label)
    }
    .width('100%')
    .padding(Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Palette.surface)
    .borderRadius(Radius.large)
    .shadow({ radius: 4, color: Palette.elevationTint, offsetX: 0, offsetY: 2 })
  }

  // -------------------------------------------------------------- Root

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: Spacing.md }) {
          this.StepsCard()
          this.FocusCard()
          this.DetailsCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.sm,
          bottom: Spacing.xl
        })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Palette.background)
  }
}