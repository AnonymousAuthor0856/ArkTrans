import { Canvas, CanvasRenderingContext2D, RenderingContextSettings } from '@ohos.arkui.component';

@Entry
@Component
struct ContentView {
  @State markerPosition: { x: number; y: number } = { x: 120, y: 200 };
  @State displayedCoordinates: string = '(200, 400)';

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

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
            colors: [
              ['rgba(255,255,255,0.6)', 0.0],
              ['rgba(239,246,255,0.5)', 0.5],
              ['rgba(255,255,255,0.7)', 1.0]
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
              .borderRadius(24)
              .radialGradient({
                center: [0.5, 0.5],
                radius: '60%',
                colors: [
                  ['rgba(255,255,255,0.8)', 0.0],
                  ['rgba(239,246,255,0.6)', 1.0]
                ]
              })

            // Border
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .border({ width: 1, color: '#D1D5DB' })

            // Canvas for circles and marker
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas();
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
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 8 }) {
                Row() {
                  Circle()
                    .fill('#60A5FA')
                    .width(8)
                    .height(8)
                    .margin({ right: 8 })
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')

                Row() {
                  Circle()
                    .fill('#60A5FA')
                    .width(8)
                    .height(8)
                    .margin({ right: 8 })
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 0, bottom: 24 })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  drawCanvas() {
    const ctx = this.canvasContext;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    ctx.clearRect(0, 0, width, height);

    // Inner circle (radius = 120)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.3)';
    ctx.fill();

    // Outer circle (radius = 180)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.2)';
    ctx.fill();

    // Marker solid circle (radius = 4)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, Math.PI * 2);
    ctx.fillStyle = '#60A5FA';
    ctx.fill();

    // Marker outer ring (radius = 12, stroke width = 1)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96,165,250,0.3)';
    ctx.lineWidth = 1;
    ctx.stroke();
  }
}