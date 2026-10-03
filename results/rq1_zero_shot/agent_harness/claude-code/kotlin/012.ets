@Entry
@Component
struct FavoritesGrid {
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;

  private aboutToAppear(): void {
  }

  build() {
    Column() {
      this.TopBar()
      Stack({ alignContent: Alignment.Center }) {
        this.MapCanvas()
        Column() {
          Text(`Spot Coordinates: (${Math.round(this.markerPositionX)}, ${Math.round(this.markerPositionY)})`)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#FF111827')
          Button('Save Marker')
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFFFF')
            .backgroundColor('#FF60A5FA')
            .borderRadius(16)
            .margin({ top: 12 })
            .onClick(() => {})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.LeftRight,
        colors: [
          ['rgba(255, 255, 255, 0.6)', 0.0],
          ['rgba(239, 246, 255, 0.5)', 0.5],
          ['rgba(255, 255, 255, 0.7)', 1.0]
        ]
      })
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }

  @Builder
  TopBar() {
    Row() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#FF111827')
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFF9FAFB')
  }

  @Builder
  MapCanvas() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasSettings)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawMap();
        })
    }
    .width('100%')
    .height(400)
    .radialGradient({
      center: [0.5, 0.5],
      radius: 0.8,
      colors: [
        ['rgba(255, 255, 255, 0.8)', 0.0],
        ['rgba(239, 246, 255, 0.6)', 1.0]
      ]
    })
    .border({
      width: 1,
      color: '#FFD1D5DB',
      radius: 24
    })
    .borderRadius(24)
  }

  private canvasSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private drawMap(): void {
    const ctx = this.canvasSettings;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    ctx.beginPath();
    ctx.arc(centerX, centerY, 220, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.3)';
    ctx.fill();

    ctx.beginPath();
    ctx.arc(centerX, centerY, 340, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.2)';
    ctx.fill();

    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 14, 0, Math.PI * 2);
    ctx.fillStyle = '#FF60A5FA';
    ctx.fill();

    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 30, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    ctx.lineWidth = 3;
    ctx.stroke();
  }
}
