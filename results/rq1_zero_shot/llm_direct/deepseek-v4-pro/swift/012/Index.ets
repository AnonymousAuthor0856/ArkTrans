@Entry
@Component
struct ContentView {
  @State private var markerPosition: [number, number] = [120, 200]
  @State private var displayedCoordinates: string = '(200, 400)'

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F9FAFB')

      // Main content area
      Stack() {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 135,
            colors: [['#FFFFFF', 0.6], ['#EFF6FF', 0.5], ['#FFFFFF', 0.7]]
          })

        Column() {
          Blank()

          // Map container
          Stack() {
            // Radial gradient background
            Column()
              .width('100%')
              .height('100%')
              .radialGradient({
                center: ['50%', '50%'],
                radius: 120,
                colors: [['#FFFFFF', 0.8], ['#EFF6FF', 0.6]]
              })
              .borderRadius(24)

            // Border
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .border({ width: 1, color: '#D1D5DB' })

            // Canvas for circles and marker
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMapElements()
              })
          }
          .width('100%')
          .height(400)
          .padding({ left: 16, right: 16 })

          // Bottom control area
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Button('Save Marker')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor('#60A5FA')
              .borderRadius(16)
              .onClick(() => {
                // Save marker action
              })

            // Saved markers list
            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              Column({ space: 8 }) {
                Row({ space: 8 }) {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')

                Row({ space: 8 }) {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  private drawMapElements() {
    // Draw inner circle (radius = 120)
    this.context.fillStyle = 'rgba(147, 197, 253, 0.3)'
    this.context.beginPath()
    this.context.arc(200, 200, 120, 0, 2 * Math.PI)
    this.context.fill()

    // Draw outer circle (radius = 180)
    this.context.fillStyle = 'rgba(147, 197, 253, 0.2)'
    this.context.beginPath()
    this.context.arc(200, 200, 180, 0, 2 * Math.PI)
    this.context.fill()

    // Draw marker solid circle (radius = 4)
    this.context.fillStyle = '#60A5FA'
    this.context.beginPath()
    this.context.arc(this.markerPosition[0], this.markerPosition[1], 4, 0, 2 * Math.PI)
    this.context.fill()

    // Draw marker outer circle (radius = 12, stroke width = 1)
    this.context.strokeStyle = 'rgba(96, 165, 250, 0.3)'
    this.context.lineWidth = 1
    this.context.beginPath()
    this.context.arc(this.markerPosition[0], this.markerPosition[1], 12, 0, 2 * Math.PI)
    this.context.stroke()
  }
}