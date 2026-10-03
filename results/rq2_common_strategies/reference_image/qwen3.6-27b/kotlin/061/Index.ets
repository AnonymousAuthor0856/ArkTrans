// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct ParcelTrackerApp {
  @State dragOffset: Point = new Point(0, 0);
  @State parcelPoints: Point[] = [];
  
  aboutToAppear() {
    // Generate random parcel points
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push(new Point(
        Math.random() * 400,
        Math.random() * 300
      ));
    }
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ bottom: 22 })
      
      this.ParcelCanvas()
      
      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor('#1F2937')
        .margin({ top: 22 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ParcelCanvas() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height(300)
        .drawContent((canvas: Canvas, context: CanvasRenderingContext2D) => {
          // Draw parcel points
          this.parcelPoints.forEach(point => {
            context.beginPath();
            context.arc(point.x, point.y, 4, 0, 2 * Math.PI);
            context.fillStyle = '#374151';
            context.fill();
          });
          
          // Draw draggable circle
          context.beginPath();
          context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, 2 * Math.PI);
          context.strokeStyle = '#111827';
          context.lineWidth = 3;
          context.stroke();
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move) {
            const touchPoint = event.touches[0];
            this.dragOffset = new Point(
              Math.max(0, Math.min(400, touchPoint.x)),
              Math.max(0, Math.min(300, touchPoint.y))
            );
          }
        })
      
      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor('#1F2937')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
    }
    .width('100%')
    .height(300)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#D1D5DB' })
  }
}

// Helper class for Point coordinates
class Point {
  x: number;
  y: number;
  
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}