interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @State markerPosition: Point = { x: 120, y: 200 };
  @State displayedCoordinates: string = '(200, 400)';

  build() {
    Column() {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(600)
          .fontColor('#FF111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#FFF9FAFB')

      Stack() {
        Column() {
          // Map container
          Stack() {
            Canvas(this.canvasCtx)
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .border({ width: 1, color: '#FFD1D5DB' })
              .backgroundColor('#FFFFFFFF')
              .onReady(() => {
                this.drawMap();
              })
          }
          .height(400)
          .padding({ left: 16, right: 16 })

          // Bottom controls
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF111827')

            Button('Save Marker')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor('#FF60A5FA')
              .borderRadius(16)

            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(600)
                .fontColor('#FF111827')

              Column({ space: 8 }) {
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
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .padding({ left: 16, right: 16, top: 0, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.LeftTop,
        colors: [[0xFFFFFFFF, 0.0], [0xFFEFF6FF, 0.5], [0xFFFFFFFF, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }

  drawMap() {
    const ctx = this.canvasCtx;
    const centerX = 343 / 2;
    const centerY = 400 / 2;

    // Outer circle (radius = 180)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.2)';
    ctx.fill();

    // Inner circle (radius = 120)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.3)';
    ctx.fill();

    // Marker outer ring (radius = 12)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    ctx.lineWidth = 1;
    ctx.stroke();

    // Marker dot (radius = 4)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, Math.PI * 2);
    ctx.fillStyle = '#60A5FA';
    ctx.fill();
  }
}
