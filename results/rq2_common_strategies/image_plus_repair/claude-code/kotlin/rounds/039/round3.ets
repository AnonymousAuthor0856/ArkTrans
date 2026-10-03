@Entry
@Component
struct InstallmentPlanPage {
  @State paymentProgress: number = 0.3;
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private readonly primaryColor: string = '#FFA500';
  private readonly secondaryColor: string = '#FFC107';
  private readonly tertiaryColor: string = '#FFE066';
  private readonly backgroundColor: string = '#FFFBF2';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#FFEED6';
  private readonly onSurfaceColor: string = '#1E1E1E';

  aboutToAppear(): void {
    this.drawWave();
  }

  private drawWave(): void {
    const ctx = this.canvasCtx;
    const w: number = 360;
    const h: number = 208;
    const step: number = w / 20;
    const PI: number = Math.PI;

    ctx.clearRect(0, 0, w, h);
    ctx.strokeStyle = this.primaryColor;
    ctx.lineWidth = 5;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    ctx.beginPath();
    for (let i = 0; i <= 20; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * PI / 5 + this.paymentProgress * PI) * (h / 3);
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Column() {
        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .padding(16)
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(20)

        Text('Payment Progress')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryColor)
          .margin({ top: 16 })

        Progress({ value: this.paymentProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(this.primaryColor)
          .backgroundColor(this.surfaceVariantColor)
          .borderRadius(4)
          .margin({ top: 12 })

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(this.secondaryColor)
          .selectedColor(this.primaryColor)
          .trackColor(this.surfaceVariantColor)
          .width('100%')
          .margin({ top: 8 })
          .onChange((value: number) => {
            this.paymentProgress = value;
            this.drawWave();
          })

        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .backgroundColor(this.tertiaryColor)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.paymentProgress = 0;
            this.drawWave();
          })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.secondaryColor + '40', 0.0],
        [this.backgroundColor, 0.5],
        [this.primaryColor + '40', 1.0]
      ]
    })
    .backgroundColor(this.backgroundColor)
  }
}
