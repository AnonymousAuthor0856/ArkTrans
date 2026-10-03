const Colors = {
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

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

@Entry
@Component
struct Index {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State isRunning: boolean = false;

  drawTimer() {
    const ctx = this.context;
    const w = ctx.width;
    const h = ctx.height;
    ctx.clearRect(0, 0, w, h);
    ctx.fillStyle = 'rgba(180, 227, 208, 0.4)';
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 180, 0, 2 * Math.PI);
    ctx.fill();
    ctx.fillStyle = Colors.primary;
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 30, 0, 2 * Math.PI);
    ctx.fill();
  }

  build() {
    Column() {
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

      Column() {
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawTimer();
            })
            .onTouch((event: TouchEvent) => {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x;
                this.knobY = event.touches[0].y;
                this.drawTimer();
              }
            })
        }
        .width(280)
        .height(280)
        .borderRadius(140)
        .backgroundColor(Colors.surfaceVariant)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? Colors.success : Colors.error)

        Row({ space: Spacing.lg }) {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .onClick(() => {
              this.isRunning = true;
            })
          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(Colors.tertiary)
            .fontColor(Colors.onSecondary)
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .alignItems(VerticalAlign.Center)

        Progress({ value: ((this.knobX + this.knobY) % 400) / 4, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .space(Spacing.xl)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
