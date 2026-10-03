// 101_ThermoCurve_en - SmartHome Form - Cold Gradient
// ArkTS UI Implementation

const NAME = "101_ThermoCurve_en";
const UI_TYPE = "SmartHome Form";
const STYLE_THEME = "Cold Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#3B82F6',
    secondary: '#06B6D4',
    tertiary: '#0EA5E9',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B',
  }
  static Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Normal },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  }
  static Shapes = {
    small: 8,
    medium: 12,
    large: 18,
  }
  static Spacing = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26,
  }
}

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = "Cool";

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('ThermoCurve')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .padding({ left: 12, right: 12 })
      .alignItems(VerticalAlign.Center)

      // Content
      Column() {
        Text('Target Temperature')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.sm })

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        Row() {
          Button('–') {
            if (this.targetTemp > 10) {
              this.targetTemp--;
            }
          }
          .fontSize(20)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .width(60)
          .height(60)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ right: AppTokens.Spacing.md })

          Button('+') {
            if (this.targetTemp < 35) {
              this.targetTemp++;
            }
          }
          .fontSize(20)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .width(60)
          .height(60)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .margin({ bottom: AppTokens.Spacing.xl })

        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)
          .width('80%')
          .margin({ bottom: AppTokens.Spacing.xl })

        Text('Mode')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.lg })

        Row() {
          this.ModeButton("Cool", $r('sys.symbol.wind'), "Cool")
          this.ModeButton("Heat", $r('sys.symbol.sun_max'), "Heat")
        }
        .margin({ bottom: AppTokens.Spacing.lg })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.secondary, 0.15], [AppTokens.Colors.primary, 0.2]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  ModeButton(label: string, icon: Resource, current: string) {
    Button({ type: ButtonType.Circle }) {
      Column() {
        Image(icon)
          .width(32)
          .height(32)
          .fillColor(this.mode === label ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .margin({ bottom: 4 })
        
        Text(label)
          .fontColor(this.mode === label ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(100)
    .backgroundColor(this.mode === label ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.mode = label;
    })
    .margin({ right: AppTokens.Spacing.lg })
  }
}