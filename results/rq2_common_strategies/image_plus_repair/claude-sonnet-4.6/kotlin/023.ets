import { display } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State isRunning: boolean = false;

  private readonly colorPrimary = '#FFFF8FAB';
  private readonly colorSecondary = '#FFB4E3D0';
  private readonly colorTertiary = '#FFFFD6A5';
  private readonly colorBackground = '#FFFFFCF9';
  private readonly colorSurfaceVariant = '#FFFDE2E4';
  private readonly colorSuccess = '#FF4ADE80';
  private readonly colorError = '#FFFB7185';
  private readonly colorOnPrimary = '#FFFFFFFF';
  private readonly colorOnSecondary = '#FF1E1E1E';
  private readonly colorOnSurface = '#FF1E1E1E';

  private circleSize: number = 280;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorBackground)

      // Main Content
      Column({ space: 24 }) {
        // Circle Canvas Area
        Stack() {
          // Outer circle (surfaceVariant background)
          Circle({ width: this.circleSize, height: this.circleSize })
            .fill(this.colorSurfaceVariant)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })

          // Inner decorative circle (secondary with alpha)
          Circle({ width: 240, height: 240 })
            .fill('#66B4E3D0')

          // Draggable knob
          Circle({ width: 60, height: 60 })
            .fill(this.colorPrimary)
            .position({
              x: this.knobX - 30,
              y: this.knobY - 30
            })
        }
        .width(this.circleSize)
        .height(this.circleSize)
        .clip(true)
        .borderRadius(this.circleSize / 2)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move || event.type === TouchType.Down) {
            const touch = event.touches[0];
            const clampedX = Math.max(0, Math.min(touch.x, this.circleSize));
            const clampedY = Math.max(0, Math.min(touch.y, this.circleSize));
            this.knobX = clampedX;
            this.knobY = clampedY;
          }
        })

        // Focus Mode Status Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? this.colorSuccess : this.colorError)

        // Start / Stop Buttons
        Row({ space: 16 }) {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(this.colorPrimary)
            .fontColor(this.colorOnPrimary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.isRunning = true;
            })

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(this.colorTertiary)
            .fontColor(this.colorOnSecondary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .alignItems(VerticalAlign.Center)

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(this.colorSurfaceVariant)

          // Progress fill
          Row()
            .width(`${Math.min(((this.knobX + this.knobY) % 400) / 400 * 100, 100)}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(this.colorPrimary)
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}