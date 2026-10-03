const NAME: string = '034BillCalendaren'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Gradient Flow'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#06B6D4'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#8B5CF6'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Column() {
          Text('Current Spending')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Text(`$${Math.trunc(this.spending)} / $${Math.trunc(this.goal)}`)
            .fontSize(AppTypographyTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Progress({
            value: Math.min(Math.max(this.spending / this.goal, 0), 1) * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(8)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(4)
            .style({ strokeWidth: 8 })
        }
        .width('100%')
        .height(160)
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(15,23,42,0.18)',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })

        Text('Adjust Spending')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1
        })
          .width('100%')
          .blockColor(AppColors.secondary)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .onChange((value: number) => {
            this.spending = value
          })

        Button({ type: ButtonType.Normal }) {
          Text('Reset')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
        }
        .width('100%')
        .height(48)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.tertiary)
        .onClick(() => {
          this.spending = 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(59,130,246,0.3)', 0.0],
          [AppColors.background, 0.5],
          ['rgba(6,182,212,0.2)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}