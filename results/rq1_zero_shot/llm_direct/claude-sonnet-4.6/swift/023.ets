import { display } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FCC2D7',
    success: '#4ADE80',
    warning: '#FACC15',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  },
};

@Entry
@Component
struct RootScreen {
  @State knobAngle: number = 0; // angle in degrees
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
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Spacer top
        Column()
          .height(AppTokens.Spacing.lg)

        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

        // Main Content
        Column({ space: AppTokens.Spacing.xl }) {

          // Timer Circle
          Stack() {
            // Outer circle
            Circle()
              .width(280)
              .height(280)
              .fill(AppTokens.Colors.surfaceVariant)
              .shadow({
                radius: 8,
                color: '#2E000000',
                offsetX: 0,
                offsetY: 4,
              })

            // Middle circle
            Circle()
              .width(180)
              .height(180)
              .fill('#66B4E3D0')

            // Knob (draggable)
            Circle()
              .width(60)
              .height(60)
              .fill(AppTokens.Colors.primary)
              .position({
                x: this.getKnobX() - 30,
                y: this.getKnobY() - 30,
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
            .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Start/Stop Buttons
          Row({ space: AppTokens.Spacing.lg }) {
            // Start Button
            Button('Start')
              .fontSize(14)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = true;
              })

            // Stop Button
            Button('Stop')
              .fontSize(14)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = false;
              })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)

            // Progress (~40%)
            Row()
              .width('40%')
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}