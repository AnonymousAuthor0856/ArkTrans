// MARK: - AppTokens Interfaces
interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

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
  } as ColorToken,
  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  } as ShapeToken,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as SpacingToken
}

// MARK: - MixerSlider Component
@Component
struct MixerSlider {
  @Link value: number
  @Prop label: string

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Slider({ value: this.value, min: 0, max: 1 })
        .width('100%')
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
    }
    .alignItems(HorizontalAlign.Start)
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
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(64)
          .backgroundColor(AppTokens.Colors.background)

        // Content Area
        Column() {
          MixerSlider({ value: $bass, label: "Bass" })
          MixerSlider({ value: $mid, label: "Mid" })
          MixerSlider({ value: $treble, label: "Treble" })

          // Spacer equivalent
          Blank().height(AppTokens.Spacing.lg)

          // LinearProgressIndicator equivalent
          Progress({ value: this.master, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(6)
            .color(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
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
          Button({ type: ButtonType.Capsule }) {
            Text("Apply Settings")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
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
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct AudioMixerApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}