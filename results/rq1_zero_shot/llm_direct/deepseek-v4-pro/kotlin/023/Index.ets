import { display, window } from '@kit.ArkUI';

@Entry
@Component
struct PomodoroTimerApp {
  @State private knobX: number = 0;
  @State private knobY: number = 0;
  @State private isRunning: boolean = false;
  @State private progressValue: number = 0;

  // AppTokens Colors
  private primary: string = '#FF8FAB';
  private secondary: string = '#B4E3D0';
  private tertiary: string = '#FFD6A5';
  private background: string = '#FFFCF9';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#FDE2E4';
  private outline: string = '#FCC2D7';
  private success: string = '#4ADE80';
  private warning: string = '#FACC15';
  private error: string = '#FB7185';
  private onPrimary: string = '#FFFFFF';
  private onSecondary: string = '#1E1E1E';
  private onTertiary: string = '#1E1E1E';
  private onBackground: string = '#1E1E1E';
  private onSurface: string = '#1E1E1E';

  aboutToAppear() {
    window.getLastWindow(window.getMainWindowSync().getUIContext()).then((win) => {
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor(this.background)

      // Main Content
      Column() {
        // Timer Circle Surface
        Stack() {
          // Outer circle
          Circle()
            .width(280)
            .height(280)
            .fill(this.surfaceVariant)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })

          // Inner decorative circle
          Circle()
            .width(240)
            .height(240)
            .fill(this.secondary)
            .opacity(0.4)

          // Draggable knob
          Circle()
            .width(60)
            .height(60)
            .fill(this.primary)
            .position({ x: this.knobX, y: this.knobY })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.knobX = event.offsetX - 30;
                  this.knobY = event.offsetY - 30;
                  this.progressValue = ((this.knobX + this.knobY) % 400) / 400;
                })
            )
        }
        .width(280)
        .height(280)
        .margin({ top: 24 })

        // Status Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? this.success : this.error)
          .margin({ top: 24 })

        // Buttons Row
        Row() {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(this.primary)
            .fontColor(this.onPrimary)
            .fontSize(14)
            .onClick(() => {
              this.isRunning = true;
            })

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(this.tertiary)
            .fontColor(this.onSecondary)
            .fontSize(14)
            .margin({ left: 16 })
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .margin({ top: 24 })
        .justifyContent(FlexAlign.Center)

        // Progress Indicator
        Progress({ value: this.progressValue, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(this.primary)
          .backgroundColor(this.surfaceVariant)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}