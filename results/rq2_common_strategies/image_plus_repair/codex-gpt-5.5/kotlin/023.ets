const BG_COLOR: string = '#FFFCF9';
const TEXT_COLOR: string = '#1E1E1E';
const PRIMARY_COLOR: string = '#FF8FAB';
const SECONDARY_COLOR: string = '#B4E3D0';
const TERTIARY_COLOR: string = '#FFD6A5';
const SURFACE_VARIANT: string = '#FDE2E4';
const SUCCESS_COLOR: string = '#4ADE80';
const ERROR_COLOR: string = '#FB7185';

@Entry
@Component
struct PomodoroTimer {
  @State private isRunning: boolean = false;
  @State private knobX: number = 0;
  @State private knobY: number = 0;

  private progressValue(): number {
    const raw: number = (this.knobX + this.knobY) % 400;
    return raw < 0 ? raw + 400 : raw;
  }

  private updateKnob(event: GestureEvent): void {
    const x: number = event.fingerList[0]?.localX ?? 140;
    const y: number = event.fingerList[0]?.localY ?? 140;
    const dx: number = x - 140;
    const dy: number = y - 140;
    const distance: number = Math.sqrt(dx * dx + dy * dy);
    const limit: number = 110;
    if (distance > limit) {
      this.knobX = 140 + (dx / distance) * limit;
      this.knobY = 140 + (dy / distance) * limit;
    } else {
      this.knobX = x;
      this.knobY = y;
    }
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_COLOR)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 32, bottom: 58 });

      Stack() {
        Circle()
          .width(560)
          .height(560)
          .fill(SURFACE_VARIANT)
          .shadow({
            radius: 8,
            color: '#28000000',
            offsetX: 0,
            offsetY: 4
          });

        Circle()
          .width(360)
          .height(360)
          .fill(SECONDARY_COLOR)
          .opacity(0.4);

        Circle()
          .width(60)
          .height(60)
          .fill(PRIMARY_COLOR)
          .position({
            x: this.knobX - 30,
            y: this.knobY - 30
          });
      }
      .width(560)
      .height(560)
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.updateKnob(event);
          })
      );

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? SUCCESS_COLOR : ERROR_COLOR)
        .margin({ top: 48, bottom: 48 });

      Row() {
        Button('Start')
          .width(180)
          .height(180)
          .fontSize(20)
          .fontColor('#FFFFFFFF')
          .backgroundColor(PRIMARY_COLOR)
          .borderRadius(90)
          .onClick(() => {
            this.isRunning = true;
          });

        Button('Stop')
          .width(180)
          .height(180)
          .fontSize(20)
          .fontColor(TEXT_COLOR)
          .backgroundColor(TERTIARY_COLOR)
          .borderRadius(90)
          .margin({ left: 32 })
          .onClick(() => {
            this.isRunning = false;
          });
      }
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 48 });

      Progress({
        value: this.progressValue(),
        total: 400,
        type: ProgressType.Linear
      })
        .width('calc(100% - 64vp)')
        .height(8)
        .color(PRIMARY_COLOR)
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(4);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG_COLOR)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .padding({ left: 16, right: 16 });
  }
}
