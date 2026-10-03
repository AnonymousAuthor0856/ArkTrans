@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 120;
  @State knobY: number = 120;
  private canvasSize: number = 240;

  private readonly colors = {
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

  build() {
    Column() {
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 24, bottom: 16 })

      Stack() {
        Stack() {
          Canvas(this)
            .width(this.canvasSize)
            .height(this.canvasSize)
            .onReady((ctx: CanvasRenderingContext2D) => {
              this.drawCanvas(ctx);
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
              let x = event.localX;
              let y = event.localY;
              x = Math.max(0, Math.min(this.canvasSize, x));
              y = Math.max(0, Math.min(this.canvasSize, y));
              this.knobX = x;
              this.knobY = y;
            })
        )
      }
      .width('100%')
      .margin({ top: 24, bottom: 24 })
      .justifyContent(FlexAlign.Center)

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

  drawCanvas(ctx: CanvasRenderingContext2D) {
    const centerX = this.canvasSize / 2;
    const centerY = this.canvasSize / 2;
    const radius = this.canvasSize / 2 - 18;

    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.strokeStyle = this.colors.secondary;
    ctx.lineWidth = 10;
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fillStyle = this.colors.primary;
    ctx.fill();
  }
}
