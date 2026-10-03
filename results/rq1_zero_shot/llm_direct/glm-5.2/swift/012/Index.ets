// ContentView.ets
@Entry
@Component
struct ContentView {
  // 小蓝点实际位置在中心靠左，但坐标显示仍为(200, 400)
  @State private var markerPositionX: number = 120;
  @State private var markerPositionY: number = 200;
  @State private var displayedCoordinates: string = "(200, 400)";

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
        Column() {
          // Map Container
          Stack() {
            // Radial Gradient Background
            Column() {
              // Using a radial gradient container
            }
            .width('100%')
            .height('100%')
            .linearGradient({
              angle: 0,
              direction: GradientDirection.Center,
              colors: [['#CCFFFFFF', 0.0], ['#99EFF6FF', 1.0]]
            })
            .borderRadius(24)
            .border({ width: 1, color: '#FFD1D5DB' })

            // Canvas for drawing circles and marker
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas();
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

            Button('Save Marker') {
              // Save marker action
            }
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF60A5FA')
            .borderRadius(16)
            .margin({ bottom: 16 })

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
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.End)
      }
      .layoutWeight(1)
      .linearGradient({
        angle: 135,
        direction: GradientDirection.BottomRight,
        colors: [['#99FFFFFF', 0.0], ['#80EFF6FF', 0.5], ['#B3FFFFFF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }

  private context: RenderingContext = new RenderingContext();

  private drawCanvas() {
    const ctx = this.context;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    // Inner Circle (radius = 120)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2);
    ctx.fillStyle = '#4D93C5FD'; // 0.3 opacity
    ctx.fill();

    // Outer Circle (radius = 180)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2);
    ctx.fillStyle = '#3393C5FD'; // 0.2 opacity
    ctx.fill();

    // Marker Point Solid Circle (radius = 4)
    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 4, 0, Math.PI * 2);
    ctx.fillStyle = '#FF60A5FA';
    ctx.fill();

    // Marker Point Outer Ring (radius = 12, stroke width = 1)
    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 12, 0, Math.PI * 2);
    ctx.strokeStyle = '#4D60A5FA'; // 0.3 opacity
    ctx.lineWidth = 1;
    ctx.stroke();
  }
}