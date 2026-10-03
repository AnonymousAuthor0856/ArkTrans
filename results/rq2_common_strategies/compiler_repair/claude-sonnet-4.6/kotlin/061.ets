import { curves } from '@kit.ArkUI';

// Color tokens
const COLOR_PRIMARY = '#111827';
const COLOR_SECONDARY = '#374151';
const COLOR_TERTIARY = '#6B7280';
const COLOR_BACKGROUND = '#F9FAFB';
const COLOR_SURFACE = '#FFFFFF';
const COLOR_SURFACE_VARIANT = '#E5E7EB';
const COLOR_OUTLINE = '#D1D5DB';
const COLOR_ON_PRIMARY = '#FFFFFF';
const COLOR_ON_SECONDARY = '#FFFFFF';
const COLOR_ON_BACKGROUND = '#111827';
const COLOR_ON_SURFACE = '#1F2937';

// Spacing tokens
const SPACING_SM = 6;
const SPACING_MD = 10;
const SPACING_LG = 14;
const SPACING_XL = 22;

interface ParcelPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  @State dragX: number = 0;
  @State dragY: number = 0;
  @State parcelPoints: ParcelPoint[] = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    const points: ParcelPoint[] = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * 400,
        y: Math.random() * 300
      });
    }
    this.parcelPoints = points;
  }

  drawCanvas() {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    this.parcelPoints.forEach((point: ParcelPoint) => {
      this.context.beginPath();
      this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
      this.context.fillStyle = COLOR_SECONDARY;
      this.context.fill();
    });

    // Draw drag circle
    this.context.beginPath();
    this.context.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    this.context.strokeStyle = COLOR_PRIMARY;
    this.context.lineWidth = 3;
    this.context.stroke();
  }

  build() {
    Column() {
      // Title
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)
        .margin({ bottom: SPACING_XL })

      // Canvas area
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width('100%')
          .height(300)
          .padding(10)
          .onReady(() => {
            this.canvasWidth = this.context.width;
            this.canvasHeight = this.context.height;
            this.drawCanvas();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                const newX = this.dragX + event.offsetX;
                const newY = this.dragY + event.offsetY;
                this.dragX = Math.max(0, Math.min(this.canvasWidth, newX));
                this.dragY = Math.max(0, Math.min(this.canvasHeight, newY));
                this.drawCanvas();
              })
          )

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontColor(COLOR_ON_SURFACE)
          .fontWeight(FontWeight.Normal)
      }
      .width('100%')
      .height(300)
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(16)
      .border({ width: 1, color: COLOR_OUTLINE, radius: 16 })
      .margin({ bottom: SPACING_XL })

      // Description text
      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(COLOR_ON_SURFACE)
        .fontWeight(FontWeight.Normal)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(SPACING_LG)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xFFE5E7EB, 0.0], [0xFFF9FAFB, 1.0]]
    })
  }
}