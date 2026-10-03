// AppTokens
class Colors {
  static primary: string = '#FF8FAB';
  static secondary: string = '#B4E3D0';
  static tertiary: string = '#FFD6A5';
  static background: string = '#FFFCF9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FDE2E4';
  static outline: string = '#FCC2D7';
  static success: string = '#4ADE80';
  static warning: string = '#FACC15';
  static error: string = '#FB7185';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onBackground: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

class Spacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
}

@Entry
@Component
struct RootScreen {
  @State knobAngle: number = 0;
  @State isRunning: boolean = false;

  private trackRadius: number = 90;
  private centerX: number = 140;
  private centerY: number = 140;

  getKnobX(): number {
    const rad = (this.knobAngle * Math.PI) / 180;
    return this.centerX + this.trackRadius * Math.cos(rad);
  }

  getKnobY(): number {
    const rad = (this.knobAngle * Math.PI) / 180;
    return this.centerY + this.trackRadius * Math.sin(rad);
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)

      Column({ space: 0 }) {
        // Spacer top
        Column()
          .height(Spacing.lg)

        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Colors.background)

        // Main Content
        Column({ space: Spacing.xl }) {

          // Timer Circle
          Stack() {
            // Outer circle (background)
            Circle()
              .width(280)
              .height(280)
              .fill(Colors.surfaceVariant)
              .shadow({
                radius: 8,
                color: '#2E000000',
                offsetX: 0,
                offsetY: 4
              })

            // Middle circle (secondary)
            Circle()
              .width(180)
              .height(180)
              .fill('#66B4E3D0')

            // Knob (draggable)
            Circle()
              .width(60)
              .height(60)
              .fill(Colors.primary)
              .position({
                x: this.getKnobX() - 30,
                y: this.getKnobY() - 30
              })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    const dx = event.offsetX + this.getKnobX() - this.centerX;
                    const dy = event.offsetY + this.getKnobY() - this.centerY;
                    const angle = Math.atan2(dy, dx) * (180 / Math.PI);
                    this.knobAngle = angle;
                  })
              )
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? Colors.success : Colors.error)

          // Start/Stop Buttons
          Row({ space: Spacing.lg }) {
            // Start Button
            Button() {
              Text('Start')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.onPrimary)
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(Colors.primary)
            .onClick(() => {
              this.isRunning = true;
            })

            // Stop Button
            Button() {
              Text('Stop')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.onSecondary)
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(Colors.tertiary)
            .onClick(() => {
              this.isRunning = false;
            })
          }
          .justifyContent(FlexAlign.Center)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.surfaceVariant)

            // Progress (~40%)
            Row()
              .width('40%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.primary)
          }
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg })

        }
        .width('100%')
        .padding({ top: Spacing.lg })
        .alignItems(HorizontalAlign.Center)

      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}