const NAME: string = '059*AfterSale*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Clay Morph'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#8E6BF2'
  static readonly secondary: string = '#D3C1FF'
  static readonly tertiary: string = '#B39DDB'
  static readonly background: string = '#F5F3FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#ECE6F8'
  static readonly outline: string = '#D1C4E9'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FFB300'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#2E1A47'
  static readonly onBackground: string = '#2E1A47'
  static readonly onSurface: string = '#2E1A47'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18)
  static readonly level2: ShadowSpec = new ShadowSpec(8, 12, 4, 0.22)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 20, 8, 0.26)
}

class AppTokens {
  static readonly Colors = AppColors
  static readonly TypographyTokens = AppTypographyTokens
  static readonly Shapes = AppShapes
  static readonly Spacing = AppSpacing
  static readonly ElevationMapping = AppElevationMapping
}

@Entry
@Component
struct RootScreen {
  @State private orderId: string = ''
  @State private issue: string = ''
  @State private submitted: boolean = false

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('After-Sale Service')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')

      Column({ space: AppTokens.Spacing.md }) {
        Text('Order ID')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        TextInput({
          placeholder: 'Enter order number',
          text: this.orderId
        })
          .width('100%')
          .height(52)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(46, 26, 71, 0.5)')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md
          })
          .border({
            width: 1,
            color: AppTokens.Colors.outline
          })
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        TextArea({
          placeholder: 'Describe your issue',
          text: this.issue
        })
          .width('100%')
          .height(120)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(46, 26, 71, 0.5)')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
          .border({
            width: 1,
            color: AppTokens.Colors.outline
          })
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: 'rgba(211, 193, 255, 0.45)',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Button('Submit Request')
        .width('100%')
        .height(56)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.success)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('rgba(76, 175, 80, 0.15)')
        .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}