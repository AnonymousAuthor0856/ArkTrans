// ArkTS code converted from Kotlin Compose

const NAME = "020RemoteControlen";
const UI_TYPE = "Media";
const STYLE_THEME = "Retro Flat";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#FFFF7A00",
    secondary: "#FFFFC300",
    tertiary: "#FFFFF3C0",
    background: "#FFFFF8E7",
    surface: "#FFFFFFFF",
    surfaceVariant: "#FFFFEBC8",
    outline: "#FFBCA789",
    success: "#FF28A745",
    warning: "#FFFFC107",
    error: "#FFDC3545",
    onPrimary: "#FFFFFFFF",
    onSecondary: "#FF1E1E1E",
    onTertiary: "#FF1E1E1E",
    onBackground: "#FF1E1E1E",
    onSurface: "#FF1E1E1E",
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static Shapes = {
    small: 8,
    medium: 14,
    large: 24,
  };
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  };
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 0;
  @State knobPositionY: number = 0;
  @State powerOn: boolean = false;

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text("Retro Remote Control")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);

      // Content
      Column() {
        // Joystick Surface
        Stack() {
          // Outer Circle
          Circle()
            .width(400)
            .height(400)
            .fillColor(AppTokens.Colors.secondary)
            .opacity(0.2);

          // Knob
          Circle()
            .width(48)
            .height(48)
            .fillColor(AppTokens.Colors.primary)
            .position({ x: this.knobPositionX - 24, y: this.knobPositionY - 24 });

          // Gesture Detector
          Column()
            .width('100%')
            .height('100%')
            .gesture(
              GestureGroup(
                ParallelGesture(
                  PanGesture()
                    .onActionUpdate((event: GestureEvent) => {
                      this.knobPositionX = event.fingerList[0].localX;
                      this.knobPositionY = event.fingerList[0].localY;
                    })
                )
              )
            );
        }
        .width(280)
        .height(280)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetX: 0, offsetY: AppTokens.ElevationMapping.level1.dy });

        // Power Status Text
        Text(this.powerOn ? "Power: ON" : "Power: OFF")
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: AppTokens.Spacing.xl });

        // Buttons Row
        Row() {
          // Power Button
          Button(this.powerOn ? "Off" : "On")
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            });

          // Reset Button
          Button("Reset")
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .onClick(() => {
              this.knobPositionX = 0;
              this.knobPositionY = 0;
            });
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: AppTokens.Spacing.xl });

        // Progress Indicator
        Progress({ value: Math.round(((this.knobPositionX + this.knobPositionY) % 400) / 400 * 100), type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ top: AppTokens.Spacing.xl });
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}