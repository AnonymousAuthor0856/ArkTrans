```arkts
@Entry
@Component
struct RootScreen {
  @State private fontSize: number = 23.0
  @State private syncProgress: number = 0.3

  private static readonly COLORS = {
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

  private static readonly SPACING = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  private static readonly SHAPES = {
    small: 8,
    medium: 14,
    large: 22
  }

  private static readonly ELEVATION = {
    level1: { radius: 4, dy: 2, opacity: 0.14 },
    level2: { radius: 8, dy: 6, opacity: 0.18 }
  }

  build() {
    Column() {
      Column({ space: RootScreen.SPACING.xl }) {
        // Sample subtitle line display
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize)
          .fontColor(RootScreen.COLORS.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(200)
          .backgroundColor(RootScreen.COLORS.surface)
          .borderRadius(RootScreen.SHAPES.large)
          .shadow({
            radius: RootScreen.ELEVATION.level2.radius,
            color: `rgba(0, 0, 0, ${RootScreen.ELEVATION.level2.opacity})`,
            offsetY: RootScreen.ELEVATION.level2.dy
          })

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(RootScreen.COLORS.onSurface)

        // Slider for font size adjustment
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          style: SliderStyle.OutSet
        })
          .selectedColor(RootScreen.COLORS.primary)
          .trackColor(RootScreen.COLORS.surfaceVariant)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(RootScreen.COLORS.onSurface)

        // Linear progress indicator
        Progress({
          value: this.syncProgress,
          total: 1.0,
          type: ProgressType.Linear
        })
          .color(RootScreen.COLORS.primary)
          .backgroundColor(RootScreen.COLORS.surfaceVariant)
          .width('100%')
          .height(6)

        // Row with two buttons
        Row({ space: RootScreen.SPACING.md }) {
          // Sync + Button
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RootScreen.COLORS.onPrimary)
            .width('50%')
            .height(48)
            .backgroundColor(RootScreen.COLORS.primary)
            .borderRadius(RootScreen.SHAPES.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
            })

          // Sync - Button
          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RootScreen.COLORS.onSecondary)
            .width('50%')
            .height(48)
            .backgroundColor(RootScreen.COLORS.secondary)
            .borderRadius(RootScreen.SHAPES.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
            })
        }
        .width('100%')
      }
      .padding(RootScreen.SPACING.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [RootScreen.COLORS.surfaceVariant, 0.0],
          [RootScreen.COLORS.background, 0.5],
          [RootScreen.COLORS.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RootScreen.COLORS.background)
  }
}