// MARK: - AppTokens
class AppColors {
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
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column({ space: 0 }) {
        Blank()
          .height(AppSpacing.lg)

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

        Column({ space: AppSpacing.xl }) {
          Stack() {
            Circle({ width: 280, height: 280 })
              .fill(AppColors.surfaceVariant)
              .shadow({
                radius: ElevationLevel2.radius,
                color: 'rgba(0, 0, 0, ' + ElevationLevel2.opacity.toString() + ')',
                offsetX: 0,
                offsetY: ElevationLevel2.y
              })

            Circle({ width: 180, height: 180 })
              .fill(AppColors.secondary)
              .opacity(0.4)

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

          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? AppColors.success : AppColors.error)

          Row({ space: AppSpacing.lg }) {
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

          Stack({ alignContent: Alignment.Start }) {
            Capsule()
              .fill(AppColors.surfaceVariant)
              .height(8)
              .width('100%')

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
