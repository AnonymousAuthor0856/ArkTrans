import window from '@ohos.window';

@Entry
@Component
struct ContentView {
  @State private markerX: number = 120;
  @State private markerY: number = 200;
  @State private displayedCoordinates: string = '(200, 400)';

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  private drawMap(): void {
    const width: number = this.canvasContext.width;
    const height: number = this.canvasContext.height;

    if (width <= 0 || height <= 0) {
      return;
    }

    const centerX: number = width / 2;
    const centerY: number = height / 2;

    this.canvasContext.clearRect(0, 0, width, height);

    this.canvasContext.beginPath();
    this.canvasContext.arc(centerX, centerY, 120, 0, Math.PI * 2);
    this.canvasContext.fillStyle = 'rgba(147, 197, 253, 0.3)';
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.arc(centerX, centerY, 180, 0, Math.PI * 2);
    this.canvasContext.fillStyle = 'rgba(147, 197, 253, 0.2)';
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.arc(this.markerX, this.markerY, 4, 0, Math.PI * 2);
    this.canvasContext.fillStyle = '#60A5FA';
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.arc(this.markerX, this.markerY, 12, 0, Math.PI * 2);
    this.canvasContext.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    this.canvasContext.lineWidth = 1;
    this.canvasContext.stroke();
  }

  build() {
    Column({ space: 0 }) {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F9FAFB')

      Stack() {
        Column({ space: 0 }) {
          Blank()

          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height(400)
              .onReady(() => {
                this.drawMap();
              })
              .onAreaChange(() => {
                this.drawMap();
              })
          }
          .width('100%')
          .height(400)
          .borderRadius(24)
          .clip(true)
          .radialGradient({
            center: ['50%', '50%'],
            radius: 120,
            colors: [
              ['rgba(255, 255, 255, 0.8)', 0],
              ['rgba(239, 246, 255, 0.6)', 1]
            ]
          })
          .border({
            width: 1,
            color: '#D1D5DB',
            radius: 24
          })
          .margin({ left: 16, right: 16 })

          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Button('Save Marker')
              .width('100%')
              .height(48)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .backgroundColor('#60A5FA')
              .borderRadius(16)
              .onClick(() => {
              })

            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#111827')

              Column({ space: 8 }) {
                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')

                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#111827')
                    .margin({ left: 8 })

                  Blank()
                }
                .width('100%')

                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')

                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#111827')
                    .margin({ left: 8 })

                  Blank()
                }
                .width('100%')
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 8 })
          }
          .width('100%')
          .padding({
            left: 16,
            right: 16,
            top: 0,
            bottom: 24
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.RightBottom,
        colors: [
          ['rgba(255, 255, 255, 0.6)', 0],
          ['rgba(239, 246, 255, 0.5)', 0.5],
          ['rgba(255, 255, 255, 0.7)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}