// AppTokens.ts - Design tokens for consistent styling
export class AppTokens {
  static Colors = {
    primary: '#8B5CF6',
    secondary: '#D946EF',
    tertiary: '#3B82F6',
    background: '#F9F5FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1E9FE',
    outline: '#E3D7FE',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  static TypographyTokens = {
    display: { size: 48, weight: 'bold' },
    title: { size: 18, weight: 'medium' },
    body: { size: 14, weight: 'regular' },
    label: { size: 42, weight: 'medium' }
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 22
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static ElevationMapping = {
    level1: { elevation: 4, dy: 2, opacity: 0.14 },
    level2: { elevation: 8, dy: 6, opacity: 0.18 }
  }
}

// RootScreen.ets - Main UI component
@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0
  @State syncProgress: number = 0.3

  build() {
    Column() {
      // Navigation bar equivalent
      Row() {
        Text('Subtitle Editor')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area
      Column({ space: AppTokens.Spacing.xl }) {
        // Sample subtitle card
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        // Font size display
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontColor(AppTokens.Colors.onSurface)

        // Slider for font size
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1
        })
        .width('100%')
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.fontSize = value
        })

        // Sync progress label
        Text('Sync Progress')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontColor(AppTokens.Colors.onSurface)

        // Progress indicator
        Row() {
          Row()
            .width(`${this.syncProgress * 100}%`)
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(3)

        // Action buttons
        Row({ space: AppTokens.Spacing.md }) {
          // Sync + button
          Button('Sync +') {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          }
          .width('45%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.size)

          // Sync - button
          Button('Sync -') {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          }
          .width('45%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.title.size)
        }
        .width('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}