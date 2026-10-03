const PRIMARY = '#FF8FAB';
const SECONDARY = '#B4E3D0';
const TERTIARY = '#FFD6A5';
const BACKGROUND = '#FFFCF9';
const SURFACE = '#FFFFFF';
const SURFACE_VARIANT = '#FDE2E4';
const OUTLINE = '#FCC2D7';
const SUCCESS = '#4ADE80';
const WARNING = '#FACC15';
const ERROR = '#FB7185';
const ON_PRIMARY = '#FFFFFF';
const ON_SECONDARY = '#1E1E1E';
const ON_TERTIARY = '#1E1E1E';
const ON_BACKGROUND = '#1E1E1E';
const ON_SURFACE = '#1E1E1E';

@Entry
@Component
struct PomodoroTimerPage {
  @State private knobX: number = 0;
  @State private knobY: number = 0;
  @State private isRunning: boolean = false;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private getProgress(): number {
    return ((this.knobX + this.knobY) % 400) / 400 * 100;
  }

  private drawKnob(): void {
    this.context.clearRect(0, 0, 280, 280);
    this.context.beginPath();
    this.context.arc(140, 140, 180, 0, Math.PI * 2);
    this.context.fillStyle = 'rgba(180, 227, 208, 0.4)';
    this.context.fill();
    this.context.beginPath();
    this.context.arc(this.knobX, this.knobY, 30, 0, Math.PI * 2);
    this.context.fillStyle = PRIMARY;
    this.context.fill();
  }

  build() {
    Column() {
      Column() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(BACKGROUND)

      Column() {
        Canvas(this.context)
          .width(280)
          .height(280)
          .borderRadius(140)
          .clip(true)
          .backgroundColor(SURFACE_VARIANT)
          .onReady(() => {
            this.drawKnob();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.fingerList[0].localX;
                this.knobY = event.fingerList[0].localY;
                this.drawKnob();
              })
          )

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? SUCCESS : ERROR)
          .margin({ top: 24 })

        Row() {
          Button() {
            Text('Start')
              .fontColor(ON_PRIMARY)
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(PRIMARY)
          .margin({ right: 16 })
          .onClick(() => {
            this.isRunning = true;
          })

          Button() {
            Text('Stop')
              .fontColor(ON_SECONDARY)
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(TERTIARY)
          .onClick(() => {
            this.isRunning = false;
          })
        }
        .margin({ top: 24 })

        Progress({ value: this.getProgress(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(PRIMARY)
          .backgroundColor(SURFACE_VARIANT)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
