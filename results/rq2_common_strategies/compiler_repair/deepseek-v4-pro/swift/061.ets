@Entry
@Component
struct ParcelTrackerApp {
  @State dragOffsetX: number = 100
  @State dragOffsetY: number = 100
  @State parcelPoints: Point[] = []

  private generateRandomPoints(width: number, height: number): Point[] {
    let points: Point[] = []
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height
      })
    }
    return points
  }

  aboutToAppear() {
    let canvasWidth = 300 - 20 // effective width after padding
    let canvasHeight = 300 - 20
    this.parcelPoints = this.generateRandomPoints(canvasWidth, canvasHeight)
    this.dragOffsetX = Math.random() * (canvasWidth - 40) + 20
    this.dragOffsetY = Math.random() * (canvasHeight - 40) + 20
  }

  build() {
    Column({ space: 22 }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#111827')

      // ParcelCanvas equivalent
      Stack({ alignContent: Alignment.Center }) {
        // Container with border
        Column()
          .width('100%')
          .height(300)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#D1D5DB' })
          .padding(10)
          .position({ x: 0, y: 0 })

        // Draw parcel points as small circles
        ForEach(this.parcelPoints, (point: Point) => {
          Column()
            .width(8)
            .height(8)
            .backgroundColor('#38BDF8')
            .borderRadius(4)
            .position({ x: point.x, y: point.y })
        })

        // Draggable circle (static representation)
        Column()
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 3, color: '#111827' })
          .position({ x: this.dragOffsetX - 20, y: this.dragOffsetY - 20 })

        // Hint text
        Text('Drag to locate parcel')
          .fontSize(12)
          .foregroundColor('#1F2937')
      }
      .width('100%')
      .height(300)

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .foregroundColor('#1F2937')
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .backgroundColor('#F9FAFB')
  }
}

interface Point {
  x: number
  y: number
}