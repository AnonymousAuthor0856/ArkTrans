// AppTokens
const PRIMARY_COLOR: string = '#FFEF476F';
const SECONDARY_COLOR: string = '#FFFFD166';
const TERTIARY_COLOR: string = '#FF06D6A0';
const BACKGROUND_COLOR: string = '#FFFFFCF2';
const SURFACE_COLOR: string = '#FFFFFFFF';
const ON_PRIMARY_COLOR: string = '#FFFFFFFF';
const ON_SECONDARY_COLOR: string = '#FF1E1E1E';
const ON_TERTIARY_COLOR: string = '#FF1E1E1E';
const ON_SURFACE_COLOR: string = '#FF1E1E1E';

const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;

const SHAPE_SMALL_RADIUS: number = 6;
const SHAPE_MEDIUM_RADIUS: number = 10;
const SHAPE_LARGE_RADIUS: number = 16;

interface DrawPoint {
  x: number;
  y: number;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = PRIMARY_COLOR;

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;
  private topBarHeight: number = 54;
  private bottomBarHeight: number = 68;
  private fabBottomMargin: number = SPACING_XL;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawPoints(): void {
    this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
    for (const point of this.points) {
      this.canvasContext.beginPath();
      this.canvasContext.fillStyle = point.color;
      this.canvasContext.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
      this.canvasContext.fill();
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(BACKGROUND_COLOR)

      // Drawing Canvas
      Column() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .backgroundColor('transparent')
          .onReady(() => {
            this.drawPoints();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              const touch = event.touches[0];
              const newPoint: DrawPoint = {
                x: touch.x,
                y: touch.y,
                color: this.currentColor
              };
              this.points.push(newPoint);
              this.drawPoints();
            }
          })
      }
      .width('100%')
      .height('100%')
      .padding({
        top: this.topBarHeight,
        bottom: Math.max(this.bottomBarHeight, this.fabSize + this.fabBottomMargin)
      })

      // Top Bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE_COLOR)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: SPACING_MD, bottom: SPACING_MD })
          .backgroundColor(BACKGROUND_COLOR)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .height('100%')

      // Bottom Color Bar
      Column() {
        Row({ space: SPACING_MD }) {
          Button('Red')
            .fontSize(14)
            .fontColor(ON_PRIMARY_COLOR)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(PRIMARY_COLOR)
            .borderRadius(SHAPE_SMALL_RADIUS)
            .onClick(() => {
              this.currentColor = PRIMARY_COLOR;
            })

          Button('Yellow')
            .fontSize(14)
            .fontColor(ON_SECONDARY_COLOR)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(SECONDARY_COLOR)
            .borderRadius(SHAPE_SMALL_RADIUS)
            .onClick(() => {
              this.currentColor = SECONDARY_COLOR;
            })

          Button('Green')
            .fontSize(14)
            .fontColor(ON_TERTIARY_COLOR)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(TERTIARY_COLOR)
            .borderRadius(SHAPE_SMALL_RADIUS)
            .onClick(() => {
              this.currentColor = TERTIARY_COLOR;
            })
        }
        .width('100%')
        .padding(SPACING_MD)
        .backgroundColor(SURFACE_COLOR)
        .shadow({
          radius: 4,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // FAB - Clear Button
      Column() {
        Row() {
          Blank()
          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SECONDARY_COLOR)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(SECONDARY_COLOR)
            .borderRadius(this.fabSize / 2)
            .shadow({
              radius: 4,
              color: '#1F000000',
              offsetX: 0,
              offsetY: 2
            })
            .margin({
              right: SPACING_XL,
              bottom: this.fabBottomMargin
            })
            .onClick(() => {
              this.points = [];
              this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}