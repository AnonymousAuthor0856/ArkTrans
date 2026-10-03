interface ColorTokens {
  primary: ResourceStr;
  secondary: ResourceStr;
  tertiary: ResourceStr;
  background: ResourceStr;
  surface: ResourceStr;
  surfaceVariant: ResourceStr;
  outline: ResourceStr;
  success: ResourceStr;
  warning: ResourceStr;
  error: ResourceStr;
  onPrimary: ResourceStr;
  onSecondary: ResourceStr;
  onTertiary: ResourceStr;
  onBackground: ResourceStr;
  onSurface: ResourceStr;
}

@Entry
@Component
struct PomodoroTimer {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isRunning: boolean = false;
  private canvasSize: number = 280;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private colors: ColorTokens = {
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
    onSurface: '#1E1E1E'
  };

  aboutToAppear(): void {
    this.knobPositionX = this.canvasSize / 2;
    this.knobPositionY = this.canvasSize / 2;
  }

  private drawCanvas(): void {
    const centerX: number = this.canvasSize / 2;
    const centerY: number = this.canvasSize / 2;

    this.ctx.clearRect(0, 0, this.canvasSize, this.canvasSize);
    this.ctx.beginPath();
    this.ctx.arc(centerX, centerY, 180, 0, Math.PI * 2);
    this.ctx.fillStyle = 'rgba(180, 227, 208, 0.4)';
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.arc(this.knobPositionX, this.knobPositionY, 30, 0, Math.PI * 2);
    this.ctx.fillStyle = this.colors.primary as string;
    this.ctx.fill();
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 16, bottom: 24 });

      Stack() {
        Circle()
          .width(this.canvasSize)
          .height(this.canvasSize)
          .fill(this.colors.surfaceVariant)
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.18)',
            offsetY: 4
          });

        Canvas(this.ctx)
          .width(this.canvasSize)
          .height(this.canvasSize)
          .onReady(() => {
            this.drawCanvas();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                const x: number = event.offsetX + this.canvasSize / 2;
                const y: number = event.offsetY + this.canvasSize / 2;
                const clampedX: number = Math.max(0, Math.min(this.canvasSize, x));
                const clampedY: number = Math.max(0, Math.min(this.canvasSize, y));
                this.knobPositionX = clampedX;
                this.knobPositionY = clampedY;
                this.drawCanvas();
              })
          );
      }
      .width(this.canvasSize)
      .height(this.canvasSize)
      .margin({ bottom: 24 });

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? this.colors.success : this.colors.error)
        .margin({ bottom: 24 });

      Row() {
        Button('Start')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.primary)
          .fontColor(this.colors.onPrimary)
          .margin({ right: 16 })
          .onClick(() => {
            this.isRunning = true;
          });

        Button('Stop')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.tertiary)
          .fontColor(this.colors.onSecondary)
          .onClick(() => {
            this.isRunning = false;
          });
      }
      .margin({ bottom: 24 });

      Progress({
        value: ((this.knobPositionX + this.knobPositionY) % 400) / 400 * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start);
  }
}
