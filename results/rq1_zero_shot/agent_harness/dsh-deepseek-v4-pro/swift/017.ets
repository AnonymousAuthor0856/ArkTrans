// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: "#00FF66",
    secondary: "#CCCCCC",
    tertiary: "#999999",
    background: "#000000",
    surface: "#0A0A0A",
    surfaceVariant: "#141414",
    outline: "#2A2A2A",
    success: "#22C55E",
    warning: "#F59E0B",
    error: "#EF4444",
    onPrimary: "#000000",
    onSecondary: "#FFFFFF",
    onTertiary: "#FFFFFF",
    onBackground: "#E0E0E0",
    onSurface: "#E0E0E0",
  };

  static readonly TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

// MARK: - MixerSlider Component
@Component
struct MixerSlider {
  label: string = "";
  @Link value: number;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(this.label + " " + Math.round(this.value * 100).toString() + "%")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Slider({ value: this.value, min: 0, max: 1, style: SliderStyle.OutSet })
        .width("100%")
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .onChange((v: number) => {
          this.value = v;
        })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Stack() {
      // Full screen background color
      Stack() {
      }
      .width("100%")
      .height("100%")
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        Text("Audio Mixer Terminal")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width("100%")
          .textAlign(TextAlign.Center)
          .padding({ top: 19, bottom: 19 })
          .height(64)
          .backgroundColor(AppTokens.Colors.background)

        // Content area
        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: "Bass", value: $this.bass })
          MixerSlider({ label: "Mid", value: $this.mid })
          MixerSlider({ label: "Treble", value: $this.treble })

          Blank()
            .height(AppTokens.Spacing.lg)

          Progress({ value: this.master, total: 1.0, type: ProgressType.Linear })
            .width("100%")
            .height(6)
            .color(AppTokens.Colors.primary)

          Text("Master Volume " + Math.round(this.master * 100).toString() + "%")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width("100%")
            .textAlign(TextAlign.Start)

          Slider({ value: this.master, min: 0, max: 1, style: SliderStyle.OutSet })
            .width("100%")
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.primary)
            .onChange((v: number) => {
              this.master = v;
            })

          Button() {
            Text("Apply Settings")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width("100%")
              .padding({ top: 16, bottom: 16 })
          }
          .width("100%")
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {})
        }
        .padding(AppTokens.Spacing.lg)
        .width("100%")
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width("100%")
      .height("100%")
    }
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
