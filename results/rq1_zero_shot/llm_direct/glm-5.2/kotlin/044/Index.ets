// Build configuration: compileSdkVersion 12, minSdkVersion 12, ArkTS 3.2.0+
// Compatible with HarmonyOS NEXT (API 12+)
// Dependencies: @ohos.arkui (built-in)

const NAME = "058*OrderTracking*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Retro Flat";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#FF7043",
    secondary: "#FFB74D",
    tertiary: "#FFD180",
    background: "#FFF3E0",
    surface: "#FFFFFF",
    surfaceVariant: "#FFE0B2",
    outline: "#D7CCC8",
    success: "#66BB6A",
    warning: "#FFCA28",
    error: "#D32F2F",
    onPrimary: "#FFFFFF",
    onSecondary: "#3E2723",
    onBackground: "#3E2723",
    onSurface: "#3E2723"
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  };
  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text("Order Tracking")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.lg });

        Column() {
          Text("Order #25491")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          Text("Estimated Delivery: 2 days")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .margin({ bottom: AppTokens.Spacing.md });

          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .height(10)
            .borderRadius(5)
            .margin({ bottom: AppTokens.Spacing.md });

          Row() {
            Text("Processing")
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.secondary);

            Blank();

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.primary);
          }
          .width("100%");
        }
        .width("100%")
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .margin({ bottom: AppTokens.Spacing.lg });

        Column() {
          Text("Adjust Progress")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          Slider({
            value: this.progress,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.progress = value;
            })
            .width("100%")
            .margin({ bottom: AppTokens.Spacing.md });

          Button("Mark as Delivered")
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width("100%")
            .onClick(() => {
              this.progress = 1.0;
            });
        }
        .width("100%")
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large);
      }
      .width("100%")
      .height("100%")
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background);
  }
}