class AppColors {
  static readonly primary: ResourceColor = '#06B6D4'
  static readonly secondary: ResourceColor = '#3B82F6'
  static readonly tertiary: ResourceColor = '#8B5CF6'
  static readonly background: ResourceColor = '#F0F9FF'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E0F2FE'
  static readonly outline: ResourceColor = '#BAE6FD'
  static readonly success: ResourceColor = '#22C55E'
  static readonly warning: ResourceColor = '#FACC15'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#FFFFFF'
  static readonly onBackground: ResourceColor = '#0F172A'
  static readonly onSurface: ResourceColor = '#0F172A'
}

class TypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class ShapeTokens {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class SpacingTokens {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

class AppTokens {
  static readonly Colors = AppColors
  static readonly TypographyTokens = TypographyTokens
  static readonly Shapes = ShapeTokens
  static readonly Spacing = SpacingTokens
  static readonly ElevationMapping = ElevationMapping
}

@Entry
@Component
struct BillCalendarApp {
  @State private spending: number = 500
  private readonly goal: number = 1000

  build() {
    Column() {
      Stack() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Column() {
            Text('Current Spending')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)

            Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
              .fontSize(AppTokens.TypographyTokens.displaySize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSurface)

            Progress({
              value: this.spending,
              total: this.goal,
              type: ProgressType.Linear
            })
              .width('100%')
              .height(8)
              .color(AppTokens.Colors.primary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)
          }
          .width('100%')
          .height(160)
          .padding(AppTokens.Spacing.lg)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('rgba(255, 255, 255, 0.9)')
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: 'rgba(0, 0, 0, 0.18)',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.spending = value
            })

          Button() {
            Text('Reset')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onTertiary)
          }
          .width('100%')
          .height(48)
          .type(ButtonType.Normal)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .onClick(() => {
            this.spending = 0
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(59, 130, 246, 0.3)', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(6, 182, 212, 0.2)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}