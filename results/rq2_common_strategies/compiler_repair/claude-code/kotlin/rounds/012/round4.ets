@Entry
@Component
struct FavoritesGrid {
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Column() {
      this.TopBar()
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          this.MapCanvas()
        }
        .width('100%')
        .layoutWeight(1)

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
            .fontColor(Color.White)
            .backgroundColor('#FF60A5FA')
            .borderRadius(16)
            .margin({ top: 12 })
            .onClick(() => {})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Left,
        colors: [
          ['rgba(255, 255, 255, 0.6)', 0.0],
          ['rgba(239, 246, 255, 0.5)', 0.5],
          ['rgba(255, 255, 255, 0.7)', 1.0]
        ]
      })
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
        .fontWeight(600)
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
      Canvas(this.ctx)
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

  private drawMap(): void {
    const width = this.ctx.width;
    const height = this.ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    this.ctx.beginPath();
    this.ctx.arc(centerX, centerY, 220, 0, Math.PI * 2);
    this.ctx.fillStyle = 'rgba(147, 197, 253, 0.3)';
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.arc(centerX, centerY, 340, 0, Math.PI * 2);
    this.ctx.fillStyle = 'rgba(147, 197, 253, 0.2)';
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.arc(this.markerPositionX, this.markerPositionY, 14, 0, Math.PI * 2);
    this.ctx.fillStyle = '#FF60A5FA';
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.arc(this.markerPositionX, this.markerPositionY, 30, 0, Math.PI * 2);
    this.ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    this.ctx.lineWidth = 3;
    this.ctx.stroke();
  }
}
