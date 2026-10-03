@Entry
@Component
struct ParcelTracker {
  @State dragOffset: { x: number, y: number } = { x: 0, y: 0 }
  private parcelPoints: { x: number, y: number }[] = []

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
        Canvas(this)
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

class Canvas extends Component {
  private context: CanvasRenderingContext2D | null = null

  constructor(private parent: ParcelTracker) {
    super()
  }

  aboutToAppear() {
    // Note: In actual ArkTS implementation, you would use the canvas component's getContext method
    // This is a simplified structure to fix compilation errors. 
    // The drawing logic should be handled within the canvas component's draw callback or similar mechanism.
  }

  build() {
    CanvasRenderingContext2D()
      .drawImage((ctx: CanvasRenderingContext2D) => {
        // Draw parcel points
        this.parent.parcelPoints.forEach(p => {
          ctx.beginPath()
          ctx.arc(p.x, p.y, 4, 0, 2 * Math.PI)
          ctx.fillStyle = '#374151'
          ctx.fill()
        })

        // Draw drag circle
        ctx.beginPath()
        ctx.arc(this.parent.dragOffset.x, this.parent.dragOffset.y, 20, 0, 2 * Math.PI)
        ctx.strokeStyle = '#111827'
        ctx.lineWidth = 3
        ctx.stroke()
      })
  }
}