@Entry
@Component
struct StockKLinePage {
  @State progress: number = 0.5;

  build() {
    Column() {
      Stack() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF0F172A')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFF8FAFC')

      Column() {
        Stack() {
          KLineCanvas({ progress: this.progress })
        }
        .width('100%')
        .height(260)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: '#2E0F172A',
          offsetY: 4
        })

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF2563EB')
          .margin({ top: 14 })

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor('#FFFFFFFF')
          .selectedColor('#FF2563EB')
          .trackColor('#FFCBD5E1')
          .width('100%')
          .height(44)
          .onChange((value: number) => {
            this.progress = value;
          })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .color('#FF2563EB')
          .backgroundColor('#FFE2E8F0')
          .borderRadius(4)
          .width('100%')
          .height(8)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .background(this.gradientBg())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }

  @Builder
  gradientBg() {
    LinearGradient({
      colors: ['#2660A5FA', '#FFF8FAFC', '#262563EB'],
      direction: GradientDirection.Bottom
    })
  }
}

@Component
struct KLineCanvas {
  @Prop progress: number = 0.5;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .padding(14)
      .onReady(() => {
        this.canvasWidth = this.ctx.width;
        this.canvasHeight = this.ctx.height;
        this.drawWave();
      })
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.canvasWidth = newValue.width;
        this.canvasHeight = newValue.height;
        if (this.canvasWidth > 0 && this.canvasHeight > 0) {
          this.drawWave();
        }
      })
  }

  aboutToUpdate(): void {
    if (this.canvasWidth > 0 && this.canvasHeight > 0) {
      this.drawWave();
    }
  }

  private drawWave(): void {
    const w = this.canvasWidth;
    const h = this.canvasHeight;
    const step = w / 50.0;
    const midY = h / 2.0;
    const amplitude = h / 3.0;

    this.ctx.clearRect(0, 0, w, h);
    this.ctx.beginPath();
    this.ctx.strokeStyle = '#FF2563EB';
    this.ctx.lineWidth = 4;
    this.ctx.lineCap = 'round';
    this.ctx.lineJoin = 'round';

    this.ctx.moveTo(0, midY);

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = midY + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * amplitude;
      this.ctx.lineTo(x, y);
    }

    this.ctx.stroke();
  }
}
