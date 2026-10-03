interface DrawPoint {
  x: number;
  y: number;
  color: string;
}

const COLOR_PRIMARY: string = '#FFEF476F';
const COLOR_SECONDARY: string = '#FFFFD166';
const COLOR_TERTIARY: string = '#FF06D6A0';
const COLOR_BACKGROUND: string = '#FFFFFCF2';
const COLOR_SURFACE: string = '#FFFFFFFF';
const COLOR_ON_PRIMARY: string = '#FFFFFFFF';
const COLOR_ON_SECONDARY: string = '#FF1E1E1E';
const COLOR_ON_TERTIARY: string = '#FF1E1E1E';
const COLOR_ON_SURFACE: string = '#FF1E1E1E';

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = COLOR_PRIMARY;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;
  private topBarHeight: number = 54;
  private bottomBarHeight: number = 68;
  private fabBottomMargin: number = 24;

  private redrawCanvas(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    for (const point of this.points) {
      this.context.beginPath();
      this.context.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
      this.context.fillStyle = point.color;
      this.context.fill();
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BACKGROUND)

      // Drawing Canvas
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .margin({
          top: this.topBarHeight,
          bottom: Math.max(this.bottomBarHeight, this.fabSize + this.fabBottomMargin)
        })
        .onReady(() => {
          this.redrawCanvas();
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            const touch = event.touches[0];
            const newPoint: DrawPoint = {
              x: touch.x,
              y: touch.y,
              color: this.currentColor
            };
            this.points = [...this.points, newPoint];
            this.redrawCanvas();
          }
        })

      // Top Bar
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor(COLOR_BACKGROUND)
      .alignItems(VerticalAlign.Center)

      // Bottom Color Bar
      Column() {
        Row({ space: 12 }) {
          Button('Red')
            .fontSize(14)
            .fontColor(COLOR_ON_PRIMARY)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = COLOR_PRIMARY;
            })

          Button('Yellow')
            .fontSize(14)
            .fontColor(COLOR_ON_SECONDARY)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(COLOR_SECONDARY)
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = COLOR_SECONDARY;
            })

          Button('Green')
            .fontSize(14)
            .fontColor(COLOR_ON_TERTIARY)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(COLOR_TERTIARY)
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = COLOR_TERTIARY;
            })
        }
        .width('100%')
        .padding(12)
        .backgroundColor(COLOR_SURFACE)
        .shadow({
          radius: 4,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('100%')
      .position({ x: 0, y: '100%' })
      .translate({ y: -this.bottomBarHeight })

      // FAB - Clear Button
      Column() {
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(this.fabSize / 2)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .onClick(() => {
            this.points = [];
            this.redrawCanvas();
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
      .padding({ right: 24 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -(this.bottomBarHeight + this.fabSize + 8) })
    }
    .width('100%')
    .height('100%')
  }
}