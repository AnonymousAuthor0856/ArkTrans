// AppTokens.ets
// Holds all the design tokens (colors, typography, shapes, spacing, elevation)
export class AppTokens {
  static Colors = {
    primary: '#FF8B5CF6',
    secondary: '#FFD946EF',
    tertiary: '#FF3B82F6',
    background: '#FFF9F5FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1E9FE',
    outline: '#FFE3D7FE',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
  }

  static TypographyTokens = {
    display: { size: 48, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 42, weight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 4, dy: 2, opacity: 0.14 },
    level2: { elevation: 8, dy: 6, opacity: 0.18 },
  }
}

// LinearProgressIndicator.ets
// Custom component to mimic SwiftUI's ProgressView with linear style
@Component
export struct LinearProgressIndicator {
  private progress: number = 0.0
  private progressColor: string = AppTokens.Colors.primary
  private trackColor: string = AppTokens.Colors.surfaceVariant

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track Background
      Column()
        .width('100%')
        .height(6)
        .backgroundColor(this.trackColor)
        .borderRadius(3)

      // Progress Fill
      Column()
        .width(`${this.progress * 100}%`)
        .height(6)
        .backgroundColor(this.progressColor)
        .borderRadius(3)
        .animation({ duration: 250, curve: Curve.EaseInOut })
    }
    .width('100%')
    .height(6)
    .clip(true)
  }
}

// RootScreen.ets
// Translates the main UI content from the Kotlin Composable / SwiftUI View.
@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0
  @State syncProgress: number = 0.3

  build() {
    Column() {
      // NavigationBar equivalent
      Row() {
        Text('Subtitle Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Main Content Column
      Column({ space: AppTokens.Spacing.xl }) {
        // Surface equivalent for the sample subtitle line display
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)

        // Slider for font size adjustment
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.primary)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)

        // LinearProgressIndicator equivalent
        LinearProgressIndicator({
          progress: this.syncProgress,
          progressColor: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant
        })

        // Row equivalent for the two buttons
        Row({ space: AppTokens.Spacing.md }) {
          // "Sync +" Button
          Button('Sync +', { type: ButtonType.Normal })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
            })

          // "Sync -" Button
          Button('Sync -', { type: ButtonType.Normal })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
            })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0]
        ]
      })
      .padding({ bottom: 50 })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.All])
  }
}