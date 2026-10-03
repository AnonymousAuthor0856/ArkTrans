// Index.ets

const NAME: string = "020RemoteControlen";
const UI_TYPE: string = "Media";
const STYLE_THEME: string = "Retro Flat";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class ShadowSpec {
  elevation: number = 0;
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppTokens {
  static primary: string = "#FFFF7A00";
  static secondary: string = "#FFFFC300";
  static tertiary: string = "#FFFFF3C0";
  static background: string = "#FFFFF8E7";
  static surface: string = "#FFFFFFFF";
  static surfaceVariant: string = "#FFFFEBC8";
  static outline: string = "#FFBCA789";
  static success: string = "#FF28A745";
  static warning: string = "#FFFFC107";
  static error: string = "#FFDC3545";
  static onPrimary: string = "#FFFFFFFF";
  static onSecondary: string = "#FF1E1E1E";
  static onTertiary: string = "#FF1E1E1E";
  static onBackground: string = "#FF1E1E1E";
  static onSurface: string = "#FF1E1E1E";

  static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

interface OffsetPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: OffsetPoint = { x: 0, y: 0 };
  @State powerOn: boolean = false;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Retro Remote Control")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.background)

      // Content
      Column() {
        // Joystick Surface
        Stack() {
          Circle()
            .fill(AppTokens.secondary)
            .opacity(0.2)
            .width(280)
            .height(280)

          Circle()
            .fill(AppTokens.primary)
            .width(48)
            .height(48)
            .position({ x: this.knobPosition.x - 24, y: this.knobPosition.y - 24 })
        }
        .width(280)
        .height(280)
        .borderRadius(24)
        .backgroundColor(AppTokens.surfaceVariant)
        .shadow({ radius: 15, color: '#66000000', offsetX: 2, offsetY: 4 })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.canvasWidth = newValue.width as number;
          this.canvasHeight = newValue.height as number;
        })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.knobPosition = { x: event.fingerList[0].localX, y: event.fingerList[0].localY };
            })
            .onActionUpdate((event: GestureEvent) => {
              this.knobPosition = { x: event.fingerList[0].localX, y: event.fingerList[0].localY };
            })
        )

        Text(this.powerOn ? "Power: ON" : "Power: OFF")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppTokens.success : AppTokens.error)
          .margin({ top: 24 })

        Row() {
          Button(this.powerOn ? "Off" : "On")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onPrimary)
            .backgroundColor(AppTokens.primary)
            .width(80)
            .height(80)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          Button("Reset")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSecondary)
            .backgroundColor(AppTokens.secondary)
            .width(80)
            .height(80)
            .borderRadius(40)
            .onClick(() => {
              this.knobPosition = { x: 0, y: 0 };
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        // Linear Progress Indicator
        Row() {
          Column() {
            // Empty column to simulate track background
          }
          .width('100%')
          .height(6)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(3)

          Column() {
            // Empty column to simulate progress
          }
          .width(`${Math.abs((this.knobPosition.x + this.knobPosition.y) % 400) / 400 * 100}%`)
          .height(6)
          .backgroundColor(AppTokens.primary)
          .borderRadius(3)
          .position({ x: 0, y: 0 })
        }
        .width('100%')
        .height(6)
        .margin({ top: 24 })
        .clip(true)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(AppTokens.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}