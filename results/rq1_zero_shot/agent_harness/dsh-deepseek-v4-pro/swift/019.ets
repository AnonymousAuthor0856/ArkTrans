// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: "#8B5CF6",
    secondary: "#D946EF",
    tertiary: "#3B82F6",
    background: "#F9F5FF",
    surface: "#FFFFFF",
    surfaceVariant: "#F1E9FE",
    outline: "#E3D7FE",
    success: "#22C55E",
    warning: "#FACC15",
    error: "#EF4444",
    onPrimary: "#FFFFFF",
    onSecondary: "#FFFFFF",
    onTertiary: "#FFFFFF",
    onBackground: "#1E1E1E",
    onSurface: "#1E1E1E",
  };

  static readonly TypographyTokens = {
    display: { size: 48, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 42, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly ElevationMapping = {
    level1: { elevation: 4, dy: 2, opacity: 0.14 },
    level2: { elevation: 8, dy: 6, opacity: 0.18 },
  };
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Navigation() {
      Column({ space: AppTokens.Spacing.xl }) {
        // Surface for the sample subtitle line
        Stack() {
          Text("Sample Subtitle Line")
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
            .width("100%")
            .height("100%")
            .textAlign(TextAlign.Center)
        }
        .width("100%")
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation,
          color: "#0000002E",
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text("Font Size: " + Math.round(this.fontSize).toString() + "sp")
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Slider({ value: this.fontSize, min: 16, max: 48, style: SliderStyle.OutSet })
          .width("100%")
          .selectedColor(AppTokens.Colors.primary)
          .onChange((v: number) => {
            this.fontSize = v;
          })

        Text("Sync Progress")
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
          .width("100%")
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Row({ space: AppTokens.Spacing.md }) {
          Button() {
            Text("Sync +")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width("100%")
              .height("100%")
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
          })

          Button() {
            Text("Sync -")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width("100%")
              .height("100%")
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress - 0.1, 0.0);
          })
        }
        .width("100%")
      }
      .padding(AppTokens.Spacing.lg)
      .width("100%")
      .height("100%")
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
    .title("Subtitle Editor", { titleMode: NavigationTitleMode.Mini })
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
