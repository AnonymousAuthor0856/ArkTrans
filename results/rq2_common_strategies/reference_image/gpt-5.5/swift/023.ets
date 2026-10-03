class AppColors {
  static readonly primary: string = '#FF8FAB';
  static readonly secondary: string = '#B4E3D0';
  static readonly secondary40: string = '#66B4E3D0';
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
  static readonly titleSize: number = 20;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1Y: number = 2;
  static readonly level1Color: string = '#1F000000';

  static readonly level2Radius: number = 8;
  static readonly level2Y: number = 4;
  static readonly level2Color: string = '#2E000000';
}

@Entry
@Component
struct RootScreen {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State dragStartX: number = 140;
  @State dragStartY: number = 140;
  @State isRunning: boolean = false;

  build() {
    Stack() {
      Column() {
        Blank()
          .height(AppSpacing.lg)

        Row() {
          Text('Pomodoro Timer')
            .fontSize(AppTypography.displaySize)
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
                radius: AppElevation.level2Radius,
                color: AppElevation.level2Color,
                offsetX: 0,
                offsetY: AppElevation.level2Y
              })

            Circle({ width: 180, height: 180 })
              .fill(AppColors.secondary40)

            Circle({ width: 60, height: 60 })
              .fill(AppColors.primary)
              .position({
                x: this.knobX - 30,
                y: this.knobY - 30
              })
              .gesture(
                PanGesture({ fingers: 1, direction: PanDirection.All })
                  .onActionStart((event?: GestureEvent) => {
                    this.dragStartX = this.knobX;
                    this.dragStartY = this.knobY;
                  })
                  .onActionUpdate((event?: GestureEvent) => {
                    if (!event) {
                      return;
                    }

                    const centerX: number = 140;
                    const centerY: number = 140;
                    const trackRadius: number = 90;

                    const candidateX: number = this.dragStartX + event.offsetX;
                    const candidateY: number = this.dragStartY + event.offsetY;

                    const vectorX: number = candidateX - centerX;
                    const vectorY: number = candidateY - centerY;
                    const distance: number = Math.sqrt(vectorX * vectorX + vectorY * vectorY);

                    if (distance > 0.001) {
                      this.knobX = centerX + vectorX / distance * trackRadius;
                      this.knobY = centerY + vectorY / distance * trackRadius;
                    }
                  })
              )
          }
          .width(280)
          .height(280)

          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? AppColors.success : AppColors.error)

          Row({ space: AppSpacing.lg }) {
            Stack() {
              Circle({ width: 90, height: 90 })
                .fill(AppColors.primary)

              Text('Start')
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onPrimary)
            }
            .width(90)
            .height(90)
            .onClick(() => {
              this.isRunning = true;
            })

            Stack() {
              Circle({ width: 90, height: 90 })
                .fill(AppColors.tertiary)

              Text('Stop')
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSecondary)
            }
            .width(90)
            .height(90)
            .onClick(() => {
              this.isRunning = false;
            })
          }
          .justifyContent(FlexAlign.Center)

          Stack({ alignContent: Alignment.TopStart }) {
            Row() {
            }
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppColors.surfaceVariant)

            Row() {
            }
            .width('40%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppColors.primary)
          }
          .width('91.5%')
          .height(8)
        }
        .width('100%')
        .margin({ top: AppSpacing.lg })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}