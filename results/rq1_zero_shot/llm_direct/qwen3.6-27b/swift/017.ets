import { UIAppearance } from '@kit.ArkUI'

// MARK: - AppTokens
// Centralized definitions for colors, typography, shapes, and spacing.
const AppTokens = {
  Colors: {
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
  },
  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

// MARK: - MixerSlider Component
@Component
struct MixerSlider {
  @Link value: number
  label: string

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .fontColor(AppTokens.Colors.onSurface)
      
      Slider({ value: this.value, min: 0, max: 1 })
        .width('100%')
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
    }
    .alignItems(HorizontalAlign.Start)
    .spacing(AppTokens.Spacing.xs)
  }
}

// MARK: - RootScreen
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

      Column() {
        // Top Bar
        Text("Audio Mixer Terminal")
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(64)
          .backgroundColor(AppTokens.Colors.background)

        // Content Area
        Column() {
          MixerSlider({ value: $this.bass, label: "Bass" })
          MixerSlider({ value: $this.mid, label: "Mid" })
          MixerSlider({ value: $this.treble, label: "Treble" })

          // Spacer equivalent
          Blank().height(AppTokens.Spacing.lg)

          // LinearProgressIndicator equivalent
          Progress({ value: this.master, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(6)
            .color(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Master volume Slider
          Slider({ value: this.master, min: 0, max: 1 })
            .width('100%')
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.primary)

          // Apply Settings Button
          Button("Apply Settings") {
            // Action
          }
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1) // Fill remaining space
        .backgroundColor(AppTokens.Colors.background)
      }
    }
    .width('100%')
    .height('100%')
    .statusBarContentMode(StatusBarContentMode.DarkContent) // Adjust based on background color if needed, usually LightContent for dark bg
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct AudioMixerApp {
  build() {
    RootScreen()
  }
}