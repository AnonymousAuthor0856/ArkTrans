// Index.ets
const NAME = "034BillCalendaren";
const UI_TYPE = "Finance";
const STYLE_THEME = "Gradient Flow";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokensColors {
  primary: ResourceColor = 0xFF06B6D4;
  secondary: ResourceColor = 0xFF3B82F6;
  tertiary: ResourceColor = 0xFF8B5CF6;
  background: ResourceColor = 0xFFF0F9FF;
  surface: ResourceColor = 0xFFFFFFFF;
  surfaceVariant: ResourceColor = 0xFFE0F2FE;
  outline: ResourceColor = 0xFFBAE6FD;
  success: ResourceColor = 0xFF22C55E;
  warning: ResourceColor = 0xFFFACC15;
  error: ResourceColor = 0xFFEF4444;
  onPrimary: ResourceColor = 0xFFFFFFFF;
  onSecondary: ResourceColor = 0xFFFFFFFF;
  onTertiary: ResourceColor = 0xFFFFFFFF;
  onBackground: ResourceColor = 0xFF0F172A;
  onSurface: ResourceColor = 0xFF0F172A;
}

class AppTokens {
  static Colors: AppTokensColors = new AppTokensColors();
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class ElevationMapping {
  static level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  static level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 };
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500;
  goal: number = 1000;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Bill Calendar")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Content
      Column() {
        // Surface Card
        Column() {
          Text("Current Spending")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary);

          Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 8, bottom: 8 });

          // Linear Progress Indicator
          Row() {
            Row()
              .width(`${(this.spending / this.goal) * 100}%`)
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4);
          }
          .width('100%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4);
        }
        .width('100%')
        .padding(16)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(20)
        .shadow({ radius: ElevationMapping.level2.radius, color: `rgba(0,0,0,${ElevationMapping.level2.opacity})`, offsetX: 0, offsetY: ElevationMapping.level2.dy })
        .margin({ bottom: 16 });

        Text("Adjust Spending")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 8 });

        // Slider
        Row() {
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.spending = value;
            });
        }
        .width('100%')
        .margin({ bottom: 16 });

        // Reset Button
        Button("Reset")
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(12)
          .onClick(() => {
            this.spending = 0;
          });
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary as number, 0.3],
          [AppTokens.Colors.background as number, 1.0],
          [AppTokens.Colors.primary as number, 0.2]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}