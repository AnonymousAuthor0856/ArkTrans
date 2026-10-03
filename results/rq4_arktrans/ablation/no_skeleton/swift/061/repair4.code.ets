import { canvas } from '@kit.ArkGraphics';
import { UIContext, GestureEvent } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State dragOffset: Point = new Point(100, 100)
  @State parcelPoints: Point[] = []

  aboutToAppear() {
    // Initialize random points for the canvas
    const width = 300; // Approximate effective width based on layout
    const height = 300; // Fixed height of canvas
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push(new Point(
        Math.random() * (width - 20) + 10,
        Math.random() * (height - 20) + 10
      ));
    }
    // Initial drag position
    this.dragOffset = new Point(
      Math.random() * (width - 40) + 20,
      Math.random() * (height - 40) + 20
    );
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')

      Stack() {
        Canvas(this.getUIContext(), { drawImage: (ctx: canvas.CanvasRenderingContext2D, size: Size) => {
            // Draw Parcel Points
            for (const point of this.parcelPoints) {
              ctx.beginPath();
              ctx.arc(point.x, point.y, 4, 0, 2 * Math.PI);
              ctx.fillStyle = '#374151';
              ctx.fill();
            }

            // Draw Drag Circle
            ctx.beginPath();
            ctx.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, 2 * Math.PI);
            ctx.strokeStyle = '#111827';
            ctx.lineWidth = 3;
            ctx.stroke();
          }
        })
          .width('100%')
          .height('100%')
          .padding(10)

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontColor('#1F2937')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .border({ width: 1, color: '#D1D5DB' })
      .gesture(
        PanGesture()
          .onActionUpdate((event?: GestureEvent) => {
            if (event) {
              let newX = event.offsetX + 100; // Offset adjustment based on padding/centering logic approximation
              let newY = event.offsetY + 100;
              
              // Boundary checks (approximate based on 300x300 container with 10px padding and 20px radius)
              const minX = 20;
              const maxX = 280;
              const minY = 20;
              const maxY = 280;

              this.dragOffset = new Point(
                Math.max(minX, Math.min(maxX, newX)),
                Math.max(minY, Math.min(maxY, newY))
              );
            }
          })
      )

      Blank()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor('#1F2937')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      angle: 90,
      colors: [['#E5E7EB', 0], ['#F9FAFB', 1]]
    })
  }
}