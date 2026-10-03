// AppTokens
class AppColors {
  static readonly primary: string = '#FF8FAB';
  static readonly secondary: string = '#B4E3D0';
  static readonly tertiary: string = '#FFD6A5';
  static readonly background: string = '#FFFCF9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FDE2E4';
  static readonly outline: string = '#FCC2D7';
  static readonly success: string = '#4ADE80';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#FB7185';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 30;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 20;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#2E000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

@Component
struct RootScreen {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isRunning: boolean = false;
  screenWidth: number = 360;

  build() {
    Column() {
      // Top Bar with less space above
      Blank().height(AppSpacing.lg)

      Row() {
        Text('Pomodoro Timer')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Main Content
      Column() {
        // Timer Circle with two concentric circles
        Stack() {
          Circle()
            .fill(AppColors.surfaceVariant)
            .width(280)
            .height(280)
            .shadow({ radius: AppShadows.level2Radius, color: AppShadows.level2Color, offsetX: 0, offsetY: AppShadows.level2Dy })

          Circle()
            .fill('#66B4E3D0')
            .width(180)
            .height(180)

          Circle()
            .fill(AppColors.primary)
            .width(60)
            .height(60)
            .position({ x: this.knobX - 30, y: this.knobY - 30 })
        }
        .width(280)
        .height(280)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            const centerX = 140;
            const centerY = 140;
            const vectorX = event.touches[0].x - centerX;
            const vectorY = event.touches[0].y - centerY;
            const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
            if (distance > 0) {
              const trackRadius = 90;
              this.knobX = centerX + (vectorX / distance) * trackRadius;
              this.knobY = centerY + (vectorY / distance) * trackRadius;
            }
          }
        })

        // Focus Mode Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error)

        // Start/Stop Buttons
        Row() {
          Button({ type: ButtonType.Normal }) {
            Text('Start')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width(90)
          .height(90)
          .backgroundColor(AppColors.primary)
          .borderRadius(45)
          .onClick(() => {
            this.isRunning = true;
          })

          Blank().width(AppSpacing.lg)

          Button({ type: ButtonType.Normal }) {
            Text('Stop')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSecondary)
          }
          .width(90)
          .height(90)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(45)
          .onClick(() => {
            this.isRunning = false;
          })
        }
        .justifyContent(FlexAlign.Center)

        // Progress Bar - fixed to match original design (approx 40% filled)
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(4)
          Row()
            .width((this.screenWidth - 64) * 0.4)
            .height(8)
            .backgroundColor(AppColors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      }
      .alignItems(HorizontalAlign.Center)
      .space(AppSpacing.xl)
      .padding({ top: AppSpacing.lg })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
