interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct ParcelTracker {
  @State dragOffset: Point = { x: 0, y: 0 }
  private parcelPoints: Point[] = []

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push({ x: Math.random() * 400, y: Math.random() * 300 })
    }
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
        CustomCanvas({
          parcelPoints: this.parcelPoints,
          dragOffset: this.dragOffset
        })
          .width('100%')
          .height(300)
          .padding({ left: 10, right: 10, top: 10, bottom: 10 })
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  let newX = Math.max(0, Math.min(400, this.dragOffset.x + event.offsetX))
                  let newY = Math.max(0, Math.min(300, this.dragOffset.y + event.offsetY))
                  this.dragOffset = { x: newX, y: newY }
                }
              })
          )

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
          .position({ x: '50%', y: '50%' })
          .translate({ x: '-50%', y: '-50%' })
      }
      .width('100%')
      .height(300)
      .backgroundColor('#FFF')
      .borderRadius(16)
      .border({ width: 1, color: '#D1D5DB', radius: 16 })

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

@Component
struct CustomCanvas {
  @Prop parcelPoints: Point[]
  @Prop dragOffset: Point

  build() {
    Canvas()
      .width('100%')
      .height('100%')
      .onReady((context: CanvasRenderingContext2D, canvas: CanvasRenderingContext2D.Canvas) => {
        // Draw parcel points
        this.parcelPoints.forEach(p => {
          context.beginPath()
          context.arc(p.x, p.y, 4, 0, 2 * Math.PI)
          context.fillStyle = '#374151'
          context.fill()
        })

        // Draw drag circle
        context.beginPath()
        context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, 2 * Math.PI)
        context.strokeStyle = '#111827'
        context.lineWidth = 3
        context.stroke()
      })
  }
}