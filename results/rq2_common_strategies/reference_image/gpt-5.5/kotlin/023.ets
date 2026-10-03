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

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct Index {
  @State private knobX: number = 0;
  @State private knobY: number = 0;
  @State private isRunning: boolean = false;

  private readonly canvasSize: number = 280;
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  private progressPercent(): number {
    return (((this.knobX + this.knobY) % 400) / 400) * 100;
  }

  private drawTimerDial(): void {
    const center: number = this.canvasSize / 2;

    this.canvasContext.clearRect(0, 0, this.canvasSize, this.canvasSize);

    this.canvasContext.beginPath();
    this.canvasContext.arc(center, center, 90, 0, Math.PI * 2);
    this.canvasContext.fillStyle = 'rgba(180, 227, 208, 0.4)';
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.arc(this.knobX, this.knobY, 15, 0, Math.PI * 2);
    this.canvasContext.fillStyle = AppColors.primary;
    this.canvasContext.fill();
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 30, bottom: 52 })

      Stack() {
        Canvas(this.canvasContext)
          .width(this.canvasSize)
          .height(this.canvasSize)
          .onReady(() => {
            this.drawTimerDial();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x;
                this.knobY = event.touches[0].y;
                this.drawTimerDial();
              }
            }
          })
      }
      .width(this.canvasSize)
      .height(this.canvasSize)
      .borderRadius(this.canvasSize / 2)
      .backgroundColor(AppColors.surfaceVariant)
      .clip(true)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.18)',
        offsetX: 0,
        offsetY: 4
      })

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? AppColors.success : AppColors.error)
        .margin({ top: 49, bottom: 29 })

      Row({ space: AppSpacing.lg }) {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Start')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width(90)
        .height(90)
        .borderRadius(45)
        .backgroundColor(AppColors.primary)
        .onClick(() => {
          this.isRunning = true;
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Stop')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .width(90)
        .height(90)
        .borderRadius(45)
        .backgroundColor(AppColors.tertiary)
        .onClick(() => {
          this.isRunning = false;
        })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 49 })

      Progress({
        value: this.progressPercent(),
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Center)
  }
}