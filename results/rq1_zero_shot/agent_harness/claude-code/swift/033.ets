// MARK: - AppTokens
// Translates SwiftUI's AppTokens struct to ArkTS namespace
namespace AppTokens {
  export class Colors {
    static readonly primary: string = '#FF06B6D4'
    static readonly secondary: string = '#FF3B82F6'
    static readonly tertiary: string = '#FF8B5CF6'
    static readonly background: string = '#FFF0F9FF'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFE0F2FE'
    static readonly outline: string = '#FFBAE6FD'
    static readonly success: string = '#FF22C55E'
    static readonly warning: string = '#FFFACC15'
    static readonly error: string = '#FFEF4444'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FFFFFFFF'
    static readonly onTertiary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF0F172A'
    static readonly onSurface: string = '#FF0F172A'
  }

  export class TypographyTokens {
    // display: 28sp, bold
    static readonly displaySize: number = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold
    // title: 18sp, medium
    static readonly titleSize: number = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium
    // body: 14sp, regular
    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Normal
    // label: 12sp, medium
    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  export class Shapes {
    static readonly small: number = 6
    static readonly medium: number = 12
    static readonly large: number = 20
  }

  export class Spacing {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export class ElevationMapping {
    static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
    static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - LinearProgress Component
// Custom linear progress indicator mimicking LinearProgressIndicator
@Component
struct LinearProgressView {
  @Link progress: number
  total: number = 1000
  tint: string = AppTokens.Colors.primary
  track: string = AppTokens.Colors.surfaceVariant

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(this.track)
        .borderRadius(4)

      // Progress
      Row()
        .width(`${(this.progress / this.total) * 100}%`)
        .height(8)
        .backgroundColor(this.tint)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      // Top Bar equivalent (CenterAlignedTopAppBar)
      Stack() {
        // Top app bar background
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)

        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)

      // Main content area (Scroll + Column)
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card
          Stack({ alignContent: Alignment.TopStart }) {
            // Card background with shadow
            Row()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .opacity(0.9)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level2.radius,
                color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
                offsetY: AppTokens.ElevationMapping.level2.dy,
                offsetX: 0
              })

            // Card content
            Column({ space: 0 }) {
              Text('Current Spending')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.primary)

              Blank()

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(AppTokens.TypographyTokens.displaySize)
                .fontWeight(AppTokens.TypographyTokens.displayWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              // LinearProgressIndicator equivalent
              LinearProgressView({ progress: $spending, total: this.goal,
                tint: AppTokens.Colors.primary,
                track: AppTokens.Colors.surfaceVariant
              })
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
          }
          .width('100%')
          .height(160)

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.spending = value
            })
            .width('100%')

          // Reset Button
          Button('Reset', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .background(this.gradientBackground())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  private gradientBackground() {
    // Brush.verticalGradient equivalent
    Column()
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary + '4D', 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary + '33', 1.0]
        ]
      })
  }
}
