// Index.ets

interface MarkerPosition {
  x: number;
  y: number;
}

interface CenterPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct ContentView {
  // 小蓝点实际位置在中心靠左，但坐标显示仍为(200, 400)
  @State markerPosition: MarkerPosition = { x: 120, y: 200 };
  @State displayedCoordinates: string = "(200, 400)";
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#FFF9FAFB')

      // Main Content Area
      Stack() {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 135,
            colors: [
              ['#FFFFFFFF', 0.6],
              ['#FFEFF6FF', 0.5],
              ['#FFFFFFFF', 0.7]
            ]
          })

        Column() {
          Blank()

          // Map Container
          Stack() {
            // Radial Gradient Background
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .linearGradient({
                angle: 0,
                colors: [
                  ['#FFFFFFFF', 0.8],
                  ['#FFEFF6FF', 0.6]
                ]
              })

            // Border
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .border({ width: 1, color: '#FFD1D5DB' })

            // Canvas Drawing
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                const center: CenterPoint = { 
                  x: this.context.width / 2, 
                  y: this.context.height / 2 
                };

                // Inner Circle (radius = 120)
                this.context.beginPath();
                this.context.arc(center.x, center.y, 120, 0, Math.PI * 2);
                this.context.fillStyle = '#4D93C5FD'; // 0.3 opacity
                this.context.fill();

                // Outer Circle (radius = 180)
                this.context.beginPath();
                this.context.arc(center.x, center.y, 180, 0, Math.PI * 2);
                this.context.fillStyle = '#3393C5FD'; // 0.2 opacity
                this.context.fill();

                // Marker Solid Circle (radius = 4)
                this.context.beginPath();
                this.context.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, Math.PI * 2);
                this.context.fillStyle = '#FF60A5FA';
                this.context.fill();

                // Marker Outer Ring (radius = 12, stroke width = 1)
                this.context.beginPath();
                this.context.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, Math.PI * 2);
                this.context.strokeStyle = '#4D60A5FA'; // 0.3 opacity
                this.context.lineWidth = 1;
                this.context.stroke();
              })
          }
          .height(400)
          .padding({ left: 16, right: 16 })

          // Bottom Control Area
          Column() {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF111827')
              .margin({ bottom: 16 })

            Button('Save Marker')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor('#FF60A5FA')
              .borderRadius(16)

            // Saved Markers List
            Column() {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FF111827')
                .margin({ bottom: 12 })

              Column() {
                Row() {
                  Circle({ width: 8, height: 8 })
                    .fill('#FF60A5FA')
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                    .margin({ left: 8 })
                  Blank()
                }
                .width('100%')
                .margin({ bottom: 8 })

                Row() {
                  Circle({ width: 8, height: 8 })
                    .fill('#FF60A5FA')
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                    .margin({ left: 8 })
                  Blank()
                }
                .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 8 })
          }
          .padding({ left: 16, right: 16, bottom: 24 })
        }
        .height('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#FFF9FAFB')
    }
    .height('100%')
  }
}