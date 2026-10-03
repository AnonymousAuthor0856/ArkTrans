// Color utility for hex values
function hexToColor(hex: number, alpha: number = 1.0): string {
  const r = (hex >> 16) & 0xFF
  const g = (hex >> 8) & 0xFF
  const b = hex & 0xFF
  return `rgba(${r}, ${g}, ${b}, ${alpha})`
}

// AppTokens - centralized design tokens
class AppTokens {
  static readonly Colors = {
    primary: '#00FF66',
    secondary: '#CCCCCC',
    tertiary: '#999999',
    background: '#000000',
    surface: '#0A0A0A',
    surfaceVariant: '#141414',
    outline: '#2A2A2A',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#E0E0E0',
    onSurface: '#E0E0E0'
  }

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Regular },
    label: { fontSize: 11, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

// MixerSlider component
@Component
struct MixerSlider {
  label: string = ''
  @Link value: number = 0

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.value = value
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// RootScreen component
@Component
struct RootScreen {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column({ space: 0 }) {
        // Top bar
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content area
        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })

          MixerSlider({ label: 'Mid', value: $mid })

          MixerSlider({ label: 'Treble', value: $treble })

          // Spacer
          Row()
            .height(AppTokens.Spacing.lg)

          // Progress indicator
          Progress({ value: this.master, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(6)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Master volume slider
          Slider({
            value: this.master,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.master = value
            })

          // Apply Settings button
          Button('Apply Settings')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// Entry point
@Entry
@Component
struct AudioMixerApp {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}