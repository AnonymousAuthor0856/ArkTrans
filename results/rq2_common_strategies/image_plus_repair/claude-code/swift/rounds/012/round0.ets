@Entry
@Component
struct Index {
  @State markerPosition: { x: number; y: number } = { x: 120, y: 200 };
  @State displayedCoordinates: string = '(200, 400)';

  build() {
    Column() {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#FF111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#FFF9FAFB')

      Stack() {
        // Background gradient area
        Column() {
          // Map container
          Stack() {
            Canvas(this.mapCanvas)
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .border({ width: 1, color: '#FFD1D5DB' })
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
                .fontWeight(FontWeight.SemiBold)
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
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.LeftTop,
        colors: [[0x99FFFFFF, 0.0], [0x80EFF6FF, 0.5], [0xB3FFFFFF, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }

  private mapCanvas = new CanvasContext2D(0, 0);

  aboutToAppear() {
    this.mapCanvas.width = 343;
    this.mapCanvas.height = 400;
  }

  onReady() {
    this.drawMap();
  }

  @Builder
  Canvas(ctx: CanvasRenderingContext2D) {
    Text('').onReady(() => this.drawMap())
  }

  drawMap() {
    const ctx = this.mapCanvas;
    const centerX = ctx.width / 2;
    const centerY = ctx.height / 2;

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

    // Marker outer ring (radius = 12, stroke width = 1)
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
