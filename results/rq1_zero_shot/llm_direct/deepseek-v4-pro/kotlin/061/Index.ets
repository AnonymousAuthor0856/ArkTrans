import { randomUUID } from '@ohos.util';

@Entry
@Component
struct ParcelTrackerApp {
  @State dragOffsetX: number = 0;
  @State dragOffsetY: number = 0;
  @State parcelPoints: Array<[number, number]> = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push([Math.random() * 400, Math.random() * 300]);
    }
  }

  build() {
    Column() {
      Column() {
        Text('Parcel Tracker')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 22 })

        Column() {
          Stack() {
            Canvas(this.canvasRenderer)
              .width('100%')
              .height(280)
              .onReady(() => {
                this.canvasWidth = 360;
                this.canvasHeight = 280;
              })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    this.dragOffsetX = Math.max(0, Math.min(this.canvasWidth, this.dragOffsetX + event.offsetX));
                    this.dragOffsetY = Math.max(0, Math.min(this.canvasHeight, this.dragOffsetY + event.offsetY));
                  })
              )

            Text('Drag to locate parcel')
              .fontSize(12)
              .fontColor('#1F2937')
          }
          .width('100%')
          .height(300)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#D1D5DB' })
          .padding(10)
        }

        Text('Visualize parcel movements and positions.')
          .fontSize(12)
          .fontColor('#1F2937')
          .margin({ top: 22 })
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        angle: 180,
        colors: [['#E5E7EB', 0.0], ['#F9FAFB', 1.0]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  private canvasRenderer = (context: CanvasRenderingContext2D) => {
    context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const point = this.parcelPoints[i];
      context.beginPath();
      context.arc(point[0], point[1], 4, 0, Math.PI * 2);
      context.fillStyle = '#374151';
      context.fill();
    }

    // Draw drag circle
    context.beginPath();
    context.arc(this.dragOffsetX, this.dragOffsetY, 20, 0, Math.PI * 2);
    context.strokeStyle = '#111827';
    context.lineWidth = 3;
    context.stroke();
  };
}