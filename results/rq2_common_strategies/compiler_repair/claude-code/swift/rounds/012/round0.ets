import { CanvasRenderingContext2D } from '@kit.ArkUI'

@Entry
@Component
struct FavoriteSpotsMap {
  @State markerPositionX: number = 120
  @State markerPositionY: number = 200
  @State displayedCoordinates: string = '(200, 400)'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State canvasWidth: number = 0
  @State canvasHeight: number = 400

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#FF111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#FFF9FAFB')

      // Main content area
      Stack() {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 135,
            colors: [
              ['rgba(255, 255, 255, 0.6)', 0.0],
              ['rgba(239, 246, 255, 0.5)', 0.5],
              ['rgba(255, 255, 255, 0.7)', 1.0]
            ]
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
                colors: [
                  ['rgba(255, 255, 255, 0.8)', 0.0],
                  ['rgba(239, 246, 255, 0.6)', 1.0]
                ]
              })
              .borderRadius(24)

            // Border
            Column()
              .width('100%')
              .height('100%')
              .border({ width: 1, color: '#FFD1D5DB', radius: 24 })
              .borderRadius(24)

            // Canvas with circles and marker
            Canvas(this.canvasCtx)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas()
              })
              .onAreaChange((oldArea: Area, newArea: Area) => {
                this.canvasWidth = newArea.width as number
                this.canvasHeight = newArea.height as number
                this.drawCanvas()
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
              .fontColor('#FF111827')

            Button('Save Marker')
              .width('100%')
              .height(48)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .backgroundColor('#FF60A5FA')
              .borderRadius(16)
              .onClick(() => {
                // Save marker action
              })

            // Saved markers list
            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#FF111827')

              Column({ space: 8 }) {
                Row() {
                  Circle({ width: 8, height: 8 })
                    .fill('#FF60A5FA')
                    .margin({ right: 8 })
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                  Blank()
                }
                .width('100%')

                Row() {
                  Circle({ width: 8, height: 8 })
                    .fill('#FF60A5FA')
                    .margin({ right: 8 })
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                  Blank()
                }
                .width('100%')
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
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
    .backgroundColor('#FFF9FAFB')
  }

  drawCanvas(): void {
    const ctx = this.canvasCtx
    const centerX = this.canvasWidth / 2
    const centerY = this.canvasHeight / 2

    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    // Outer circle (radius = 180)
    ctx.beginPath()
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(96, 165, 250, 0.2)'
    ctx.fill()

    // Inner circle (radius = 120)
    ctx.beginPath()
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(96, 165, 250, 0.3)'
    ctx.fill()

    // Marker outer ring (radius = 12)
    ctx.beginPath()
    ctx.arc(this.markerPositionX, this.markerPositionY, 12, 0, Math.PI * 2)
    ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)'
    ctx.lineWidth = 1
    ctx.stroke()

    // Marker solid dot (radius = 4)
    ctx.beginPath()
    ctx.arc(this.markerPositionX, this.markerPositionY, 4, 0, Math.PI * 2)
    ctx.fillStyle = '#FF60A5FA'
    ctx.fill()
  }
}
