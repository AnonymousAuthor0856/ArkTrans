const COLOR_PRIMARY: string = '#EF476F';
const COLOR_SECONDARY: string = '#FFD166';
const COLOR_TERTIARY: string = '#06D6A0';
const COLOR_BACKGROUND: string = '#FFFCF2';
const COLOR_SURFACE: string = '#FFF8E1';
const COLOR_OUTLINE: string = '#BDBDBD';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#1F1F1F';
const COLOR_ON_SURFACE: string = '#1F1F1F';

@Entry
@Component
struct RootScreen {
  @State knobX: number = 300;
  @State knobY: number = 300;
  private gestureStartX: number = 0;
  private gestureStartY: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas(): void {
    const canvasSize: number = 280;
    const ctx: CanvasRenderingContext2D = this.ctx;
    ctx.clearRect(0, 0, canvasSize, canvasSize);
    ctx.beginPath();
    ctx.strokeStyle = COLOR_SECONDARY;
    ctx.lineWidth = 12;
    ctx.arc(canvasSize / 2, canvasSize / 2, canvasSize / 2 - 20, 0, Math.PI * 2);
    ctx.stroke();
    ctx.beginPath();
    ctx.fillStyle = COLOR_PRIMARY;
    ctx.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2);
    ctx.fill();
  }

  build() {
    Column() {
      Row() {
        Text('Retro Music Player')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      Column() {
        Stack() {
          Canvas(this.ctx)
            .width(280)
            .height(280)
            .onReady(() => {
              this.drawCanvas();
            })
        }
        .width(280)
        .height(280)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(16)
        .border({ width: 3, color: COLOR_OUTLINE })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.gestureStartX = this.knobX;
              this.gestureStartY = this.knobY;
            })
            .onActionUpdate((event: GestureEvent) => {
              this.knobX = this.gestureStartX + event.offsetX;
              this.knobY = this.gestureStartY + event.offsetY;
              this.drawCanvas();
            })
        )

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Row() {
          Button('Play')
            .type(ButtonType.Normal)
            .width(120)
            .height(48)
            .borderRadius(12)
            .backgroundColor(COLOR_PRIMARY)
            .fontColor(COLOR_ON_PRIMARY)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Button('Pause')
            .type(ButtonType.Normal)
            .width(120)
            .height(48)
            .borderRadius(12)
            .backgroundColor(COLOR_SECONDARY)
            .fontColor(COLOR_ON_SECONDARY)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Text(`Knob X:${Math.floor(this.knobX)} Y:${Math.floor(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_TERTIARY)

        Blank()
          .height(32)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
