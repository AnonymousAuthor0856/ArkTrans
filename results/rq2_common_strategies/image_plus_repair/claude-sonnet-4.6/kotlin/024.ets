import { drawing } from '@kit.ArkGraphics2D';

interface DrawPoint {
  x: number;
  y: number;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = '#FFEF476F';
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFCF2')

      // Canvas Area
      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.canvasContext)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor('#FFFFFCF2')
          .onReady(() => {
            this.redraw();
          })
          .gesture(
            PanGesture({ fingers: 1, direction: PanDirection.All, distance: 0 })
              .onActionStart((event: GestureEvent) => {
                const x = event.offsetX;
                const y = event.offsetY;
                this.points.push({ x, y, color: this.currentColor });
                this.redraw();
              })
              .onActionUpdate((event: GestureEvent) => {
                const x = event.offsetX;
                const y = event.offsetY;
                this.points.push({ x, y, color: this.currentColor });
                this.redraw();
              })
          )

        // FAB Clear Button
        Button('Clear')
          .width(64)
          .height(64)
          .borderRadius(32)
          .backgroundColor('#FFFFD166')
          .fontColor('#FF1E1E1E')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 16, right: 16 })
          .onClick(() => {
            this.points = [];
            this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
          })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Row() {
        Button('Red')
          .layoutWeight(1)
          .height(48)
          .borderRadius(6)
          .backgroundColor('#FFEF476F')
          .fontColor('#FFFFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 8, right: 4 })
          .onClick(() => {
            this.currentColor = '#FFEF476F';
          })

        Button('Yellow')
          .layoutWeight(1)
          .height(48)
          .borderRadius(6)
          .backgroundColor('#FFFFD166')
          .fontColor('#FF1E1E1E')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            this.currentColor = '#FFFFD166';
          })

        Button('Green')
          .layoutWeight(1)
          .height(48)
          .borderRadius(6)
          .backgroundColor('#FF06D6A0')
          .fontColor('#FF1E1E1E')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 4, right: 8 })
          .onClick(() => {
            this.currentColor = '#FF06D6A0';
          })
      }
      .width('100%')
      .height(72)
      .padding({ top: 12, bottom: 12 })
      .backgroundColor('#FFFFFFFF')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 4, color: '#1F000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFCF2')
  }

  private redraw() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    for (const pt of this.points) {
      ctx.beginPath();
      ctx.arc(pt.x, pt.y, 10, 0, Math.PI * 2);
      ctx.fillStyle = pt.color;
      ctx.fill();
    }
  }
}