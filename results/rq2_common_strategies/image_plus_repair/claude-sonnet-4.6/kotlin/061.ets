interface ParcelPoint {
  x: number;
  y: number;
}

function generatePoints(): ParcelPoint[] {
  const points: ParcelPoint[] = [];
  for (let i = 0; i < 25; i++) {
    points.push({ x: Math.random() * 400, y: Math.random() * 300 } as ParcelPoint);
  }
  return points;
}

@Entry
@Component
struct RootScreen {
  @State dragX: number = 0;
  @State dragY: number = 0;
  private parcelPoints: ParcelPoint[] = generatePoints();
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  private drawCanvas(): void {
    this.canvasContext.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    for (let i = 0; i < this.parcelPoints.length; i++) {
      const pt: ParcelPoint = this.parcelPoints[i];
      this.canvasContext.beginPath();
      this.canvasContext.arc(pt.x, pt.y, 4, 0, Math.PI * 2);
      this.canvasContext.fillStyle = '#374151';
      this.canvasContext.fill();
    }

    this.canvasContext.beginPath();
    this.canvasContext.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    this.canvasContext.strokeStyle = '#111827';
    this.canvasContext.lineWidth = 3;
    this.canvasContext.stroke();
  }

  build() {
    Column({ space: 22 }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .width('100%')
        .width('100%')
        .textAlign(TextAlign.Center)

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width('100%')
          .height(300)
          .onReady(() => {
            this.canvasWidth = this.canvasContext.width;
            this.canvasHeight = this.canvasContext.height;
            this.drawCanvas();
          })

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontSize(12)
          .fontColor('#1F2937')
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(300)
      .height(300)
      .backgroundColor('#FFFFFF')
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .borderWidth(1)
      .borderWidth(1)
      .borderColor('#D1D5DB')
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

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontSize(12)
        .fontColor('#1F2937')
        .fontColor('#1F2937')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#E5E7EB', 0.0],
        ['#F9FAFB', 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Center)
  }
}