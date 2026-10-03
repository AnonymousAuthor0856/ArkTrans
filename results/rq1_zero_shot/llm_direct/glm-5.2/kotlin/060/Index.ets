// 093_UnitConverter_en.ets
/**
 * Modern Blue - Tools Messenger
 * Baseline: 720x1280
 * Lang: en
 */

const NAME = "093_UnitConverter_en";
const UI_TYPE = "Tools Messenger";
const STYLE_THEME = "Modern Blue";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#2563EB",
    secondary: "#38BDF8",
    tertiary: "#60A5FA",
    background: "#F8FAFC",
    surface: "#FFFFFF",
    surfaceVariant: "#E2E8F0",
    outline: "#CBD5E1",
    onPrimary: "#FFFFFF",
    onSecondary: "#0F172A",
    onTertiary: "#FFFFFF",
    onBackground: "#0F172A",
    onSurface: "#1E293B"
  };
  static Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Normal },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20
  };
}

@Entry
@Component
struct RootScreen {
  @State active: string = "Length";
  private markers: string[] = ["Length", "Weight", "Temperature", "Speed"];

  build() {
    Column() {
      Text("Unit Converter")
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg });

      // Map Area
      Column() {
        Text("Unit Map Visualization")
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
        Text(`Active Unit: ${this.active}`)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md });
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(AppTokens.Spacing.lg)
      .margin({ bottom: AppTokens.Spacing.lg });

      // Markers
      ForEach(this.markers, (marker: string) => {
        Column() {
          Text(marker)
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text("Tap to convert")
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height(80)
        .backgroundColor(this.active === marker ? "#4D38BDF8" : AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .padding(AppTokens.Spacing.md)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: AppTokens.Spacing.lg });
      });

      // Buttons
      Row() {
        ForEach(this.markers, (marker: string) => {
          Button(marker)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(this.active === marker ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .backgroundColor(this.active === marker ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .onClick(() => {
              this.active = marker;
            })
            .margin({ right: AppTokens.Spacing.md });
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [["#2638BDF8", 0.0], ["#262563EB", 1.0]]
    })
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center);
  }
}