// Index.ets
const NAME: string = "101_ThermoCurve_en";
const UI_TYPE: string = "SmartHome Form";
const STYLE_THEME: string = "Cold Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFF3B82F6;
  secondary: ResourceColor = 0xFF06B6D4;
  tertiary: ResourceColor = 0xFF0EA5E9;
  background: ResourceColor = 0xFFF0F9FF;
  surface: ResourceColor = 0xFFFFFFFF;
  surfaceVariant: ResourceColor = 0xFFE0F2FE;
  outline: ResourceColor = 0xFFCBD5E1;
  onPrimary: ResourceColor = 0xFFFFFFFF;
  onBackground: ResourceColor = 0xFF0F172A;
  onSurface: ResourceColor = 0xFF1E293B;
}

class AppSpacing {
  sm: Length = 8;
  md: Length = 12;
  lg: Length = 18;
  xl: Length = 26;
}

const Colors = new AppColors();
const Spacing = new AppSpacing();

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = "Cool";

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("🌡️")
          .fontSize(24)
          .fontColor(Colors.primary)
          .margin({ left: 12, right: 12 });

        Text("ThermoCurve")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Button() {
          Text("☀️").fontSize(22).fontColor(Colors.secondary);
        }
        .backgroundColor(Colors.surfaceVariant)
        .margin({ right: 12 });
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surfaceVariant)
      .padding({ left: 4, right: 4 });

      // Content
      Column() {
        Text("Target Temperature")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ top: 20, bottom: 8 });

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
          .margin({ bottom: 16 });

        Row({ space: Spacing.md }) {
          Button() {
            Text("–")
              .fontSize(20)
              .fontColor(Colors.onPrimary);
          }
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor(Colors.primary)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp--;
            }
          });

          Button() {
            Text("+")
              .fontSize(20)
              .fontColor(Colors.onPrimary);
          }
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor(Colors.primary)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp++;
            }
          });
        }
        .margin({ bottom: 20 });

        Divider()
          .color(Colors.outline)
          .strokeWidth(1)
          .width('80%')
          .margin({ bottom: 20 });

        Text("Mode")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ bottom: 16 });

        Row({ space: Spacing.lg }) {
          this.ModeButton("Cool", "💨");
          this.ModeButton("Heat", "☀️");
        }
        .margin({ bottom: 16 });

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(Colors.onSurface);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [[0x060B6D4, 0.15], [0x3B82F6, 0.2]]
      })
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background);
  }

  @Builder
  ModeButton(label: string, icon: string) {
    Button() {
      Column() {
        Text(icon).fontSize(32).margin({ bottom: 4 });
        Text(label).fontSize(14).fontColor(this.mode === label ? Colors.onPrimary : Colors.onSurface);
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center);
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(this.mode === label ? Colors.primary : Colors.surfaceVariant)
    .onClick(() => {
      this.mode = label;
    });
  }
}