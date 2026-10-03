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
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFCF2')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Canvas Area
      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFCF2')
          .onReady(() => {
            this.redrawCanvas();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move || event.type === TouchType.Down) {
              const touch = event.touches[0];
              const newPoint: DrawPoint = {
                x: touch.x,
                y: touch.y,
                color: this.currentColor
              };
              this.points.push(newPoint);
              this.canvasContext.fillStyle = this.currentColor;
              this.canvasContext.beginPath();
              this.canvasContext.arc(touch.x, touch.y, 10, 0, Math.PI * 2);
              this.canvasContext.fill();
            }
          })

        // FAB Clear Button
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF1E1E1E')
          .backgroundColor('#FFFFD166')
          .borderRadius(28)
          .width(72)
          .height(56)
          .onClick(() => {
            this.points = [];
            this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
            this.canvasContext.fillStyle = '#FFFFFCF2';
            this.canvasContext.fillRect(0, 0, this.canvasContext.width, this.canvasContext.height);
          })
          .position({ x: '80%', y: '80%' })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Button('Red')
          .fontSize(14)
          .fontColor('#FFFFFFFF')
          .backgroundColor('#FFEF476F')
          .borderRadius(6)
          .height(40)
          .padding({ left: 16, right: 16 })
          .onClick(() => {
            this.currentColor = '#FFEF476F';
          })

        Button('Yellow')
          .fontSize(14)
          .fontColor('#FF1E1E1E')
          .backgroundColor('#FFFFD166')
          .borderRadius(6)
          .height(40)
          .padding({ left: 16, right: 16 })
          .onClick(() => {
            this.currentColor = '#FFFFD166';
          })

        Button('Green')
          .fontSize(14)
          .fontColor('#FF1E1E1E')
          .backgroundColor('#FF06D6A0')
          .borderRadius(6)
          .height(40)
          .padding({ left: 16, right: 16 })
          .onClick(() => {
            this.currentColor = '#FF06D6A0';
          })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFFFF')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding(12)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFCF2')
  }

  redrawCanvas() {
    this.canvasContext.fillStyle = '#FFFFFCF2';
    this.canvasContext.fillRect(0, 0, this.canvasContext.width, this.canvasContext.height);
    for (const point of this.points) {
      this.canvasContext.fillStyle = point.color;
      this.canvasContext.beginPath();
      this.canvasContext.arc(point.x, point.y, 10, 0, Math.PI * 2);
      this.canvasContext.fill();
    }
  }
}