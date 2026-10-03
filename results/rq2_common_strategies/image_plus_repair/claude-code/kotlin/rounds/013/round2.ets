interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  outline: string;
  onSurface: string;
  onPrimary: string;
  onSecondary: string;
}

@Entry
@Component
struct RetroMusicPlayer {
  @State @Watch('redraw') knobX: number = 120;
  @State @Watch('redraw') knobY: number = 120;
  private canvasSize: number = 240;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private readonly colors: ColorTokens = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFF8E1',
    outline: '#BDBDBD',
    onSurface: '#1F1F1F',
    onPrimary: '#FFFFFF',
    onSecondary: '#1F1F1F'
  };

  redraw(): void {
    this.drawCanvas();
  }

  build() {
    Column() {
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 24, bottom: 16 })

      Stack() {
        Canvas(this.context)
          .width(this.canvasSize)
          .height(this.canvasSize)
          .onReady(() => {
            this.drawCanvas();
          })
      }
      .width(this.canvasSize)
      .height(this.canvasSize)
      .backgroundColor(this.colors.surface)
      .borderRadius(24)
      .border({ width: 3, color: this.colors.outline })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            if (event.fingerList && event.fingerList.length > 0) {
              let x: number = event.fingerList[0].localX;
              let y: number = event.fingerList[0].localY;
              x = Math.max(0, Math.min(this.canvasSize, x));
              y = Math.max(0, Math.min(this.canvasSize, y));
              this.knobX = x;
              this.knobY = y;
            }
          })
      )
      .margin({ top: 24, bottom: 24 })

      Text('Track: Summer Nights')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .margin({ bottom: 24 })

      Row() {
        Button('Play')
          .fontSize(18)
          .fontColor(this.colors.onPrimary)
          .backgroundColor(this.colors.primary)
          .borderRadius(12)
          .width(120)
          .height(48)

        Button('Pause')
          .fontSize(18)
          .fontColor(this.colors.onSecondary)
          .backgroundColor(this.colors.secondary)
          .borderRadius(12)
          .width(120)
          .height(48)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 24 })

      Text(`Knob X:${Math.round(this.knobX)} Y:${Math.round(this.knobY)}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.tertiary)

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  drawCanvas(): void {
    const centerX: number = this.canvasSize / 2;
    const centerY: number = this.canvasSize / 2;
    const radius: number = this.canvasSize / 2 - 18;

    this.context.clearRect(0, 0, this.canvasSize, this.canvasSize);

    this.context.beginPath();
    this.context.arc(centerX, centerY, radius, 0, Math.PI * 2);
    this.context.strokeStyle = this.colors.secondary;
    this.context.lineWidth = 10;
    this.context.stroke();

    this.context.beginPath();
    this.context.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.context.fillStyle = this.colors.primary;
    this.context.fill();
  }
}
