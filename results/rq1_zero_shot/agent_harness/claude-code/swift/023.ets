import prompt from '@ohos.prompt';

// MARK: - AppTokens
class AppColors {
  static primary: Color = Color.rgb(255, 143, 171);
  static secondary: Color = Color.rgb(180, 227, 208);
  static tertiary: Color = Color.rgb(255, 214, 165);
  static background: Color = Color.rgb(255, 252, 249);
  static surface: Color = Color.rgb(255, 255, 255);
  static surfaceVariant: Color = Color.rgb(253, 226, 228);
  static outline: Color = Color.rgb(252, 194, 215);
  static success: Color = Color.rgb(74, 222, 128);
  static warning: Color = Color.rgb(250, 204, 21);
  static error: Color = Color.rgb(251, 113, 133);
  static onPrimary: Color = Color.rgb(255, 255, 255);
  static onSecondary: Color = Color.rgb(30, 30, 30);
  static onTertiary: Color = Color.rgb(30, 30, 30);
  static onBackground: Color = Color.rgb(30, 30, 30);
  static onSurface: Color = Color.rgb(30, 30, 30);
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
}

class ElevationLevel2 {
  static radius: number = 8;
  static y: number = 4;
  static opacity: number = 0.18;
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isRunning: boolean = false;
  private centerX: number = 140;
  private centerY: number = 140;
  private trackRadius: number = 90;

  aboutToAppear(): void {
    this.knobX = this.centerX + this.trackRadius;
    this.knobY = this.centerY;
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column({ space: 0 }) {
        // Top spacer
        Blank()
          .height(AppSpacing.lg)

        // Title bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.background)

        // Main content
        Column({ space: AppSpacing.xl }) {
          // Timer Circle with two concentric circles and draggable knob
          Stack() {
            // Outer circle (background)
            Circle({ width: 280, height: 280 })
              .fill(AppColors.surfaceVariant)
              .shadow({
                radius: ElevationLevel2.radius,
                color: `rgba(0, 0, 0, ${ElevationLevel2.opacity})`,
                offsetX: 0,
                offsetY: ElevationLevel2.y
              })

            // Middle circle (secondary)
            Circle({ width: 180, height: 180 })
              .fill(AppColors.secondary)
              .opacity(0.4)

            // Knob (draggable)
            Circle({ width: 60, height: 60 })
              .fill(AppColors.primary)
              .translate({ x: this.knobX - this.centerX, y: this.knobY - this.centerY })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    const vectorX: number = event.offsetX + (this.knobX - this.centerX);
                    const vectorY: number = event.offsetY + (this.knobY - this.centerY);
                    const distance: number = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
                    if (distance > 0) {
                      const normalizedX: number = vectorX / distance;
                      const normalizedY: number = vectorY / distance;
                      this.knobX = this.centerX + normalizedX * this.trackRadius;
                      this.knobY = this.centerY + normalizedY * this.trackRadius;
                    }
                  })
              )
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? AppColors.success : AppColors.error)

          // Start/Stop Buttons
          Row({ space: AppSpacing.lg }) {
            // Start Button
            Button('Start')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
              .width(90)
              .height(90)
              .backgroundColor(AppColors.primary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = true;
              })

            // Stop Button
            Button('Stop')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSecondary)
              .width(90)
              .height(90)
              .backgroundColor(AppColors.tertiary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = false;
              })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Capsule()
              .fill(AppColors.surfaceVariant)
              .height(8)
              .width('100%')

            // Progress (approximately 40%)
            Capsule()
              .fill(AppColors.primary)
              .height(8)
              .width('40%')
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .width('100%')
        }
        .padding({ top: AppSpacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
