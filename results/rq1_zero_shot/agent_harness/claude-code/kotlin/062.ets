// NAME: 101_ThermoCurve_en
// UI_TYPE: SmartHome Form
// STYLE_THEME: Cold Gradient
// LANG: en
// BASELINE_SIZE: 720x1280

@Entry
@Component
struct Index {
  @State targetTemp: number = 22;
  @State mode: string = "Cool";

  build() {
    Column() {
      // TopBar
      Row() {
        // Navigation icon - Thermostat
        Text("")
          .fontSize(28)
          .fontColor(AppTokens.Colors.primary)
          .fontFamily("Material Icons")
          .margin({ left: 12 })

        Text("ThermoCurve")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Action button - WbSunny
        Button() {
          Text("")
            .fontSize(24)
            .fontColor(AppTokens.Colors.secondary)
            .fontFamily("Material Icons")
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .margin({ right: 8 })
        .onClick(() => {
          this.targetTemp++;
        })
      }
      .width("100%")
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      // Main content
      Column() {
        Text("Target Temperature")
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.targetTemp + "°C")
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 8 })

        // Temperature control buttons
        Row() {
          Button("–")
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
            .width(60)
            .height(48)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--;
              }
            })

          Button("+")
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
            .width(60)
            .height(48)
            .margin({ left: 12 })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++;
              }
            })
        }
        .margin({ top: 12 })

        // Divider
        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)
          .width("80%")
          .opacity(0.5)
          .margin({ top: 26 })

        // Mode section
        Text("Mode")
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 26 })

        Row() {
          this.ModeButton("Cool", "", this.mode, (label: string) => {
            this.mode = label;
          })

          this.ModeButton("Heat", "", this.mode, (label: string) => {
            this.mode = label;
          })
        }
        .margin({ top: 12 })

        Text("Current Mode: " + this.mode)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 18 })
      }
      .width("100%")
      .layoutWeight(1)
      .padding(18)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  ModeButton(label: string, icon: string, current: string, onSelect: (label: string) => void) {
    Column() {
      Text(icon)
        .fontSize(32)
        .fontFamily("Material Icons")
        .fontColor(label === current ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)

      Text(label)
        .fontSize(12)
        .fontColor(label === current ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .margin({ top: 4 })
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(50)
    .backgroundColor(label === current ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .shadow({
      radius: label === current ? 8 : 4,
      color: "#1A000000",
      offsetX: 0,
      offsetY: label === current ? 4 : 2
    })
    .onClick(() => {
      onSelect(label);
    })
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = "#FF3B82F6";
    export const secondary: string = "#FF06B6D4";
    export const tertiary: string = "#FF0EA5E9";
    export const background: string = "#FFF0F9FF";
    export const surface: string = "#FFFFFFFF";
    export const surfaceVariant: string = "#FFE0F2FE";
    export const outline: string = "#FFCBD5E1";
    export const onPrimary: string = "#FFFFFFFF";
    export const onBackground: string = "#FF0F172A";
    export const onSurface: string = "#FF1E293B";
  }

  export namespace TypographyTokens {
    export const displayFontSize: number = 26;
    export const displayFontWeight: FontWeight = FontWeight.Bold;
    export const headlineFontSize: number = 18;
    export const headlineFontWeight: FontWeight = FontWeight.SemiBold;
    export const titleFontSize: number = 14;
    export const titleFontWeight: FontWeight = FontWeight.Medium;
    export const bodyFontSize: number = 12;
    export const bodyFontWeight: FontWeight = FontWeight.Normal;
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 18;
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 18;
    export const xl: number = 26;
  }
}
