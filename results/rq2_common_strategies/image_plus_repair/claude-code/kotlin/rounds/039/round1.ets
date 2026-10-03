@Entry
@Component
struct InstallmentPlanPage {
  @State paymentProgress: number = 0.3;
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private primaryColor: string = '#FFA500';
  private secondaryColor: string = '#FFC107';
  private tertiaryColor: string = '#FFE066';
  private backgroundColor: string = '#FFFBF2';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#FFEED6';
  private onSurfaceColor: string = '#1E1E1E';

  aboutToAppear(): void {
    this.drawWave();
  }

  private drawWave(): void {
    const ctx = this.canvasCtx;
    const w = 328;
    const h = 208;
    const step = w / 20;
    const PI = Math.PI;

    ctx.clearRect(0, 0, w, h);
    ctx.strokeStyle = this.primaryColor;
    ctx.lineWidth = 5;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    ctx.beginPath();
    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * PI / 5 + this.paymentProgress * PI) * (h / 3);
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
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 32, bottom: 32 })
        .backgroundColor(this.backgroundColor)

      Column() {
        // Wave chart surface
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
        .height(480)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(40)
        .shadow({
          radius: 16,
          color: 'rgba(0, 0, 0, 0.08)',
          offsetY: 8
        })

        Text('Payment Progress')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryColor)
          .margin({ top: 32 })

        // Linear progress indicator
        Progress({ value: this.paymentProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(16)
          .color(this.primaryColor)
          .backgroundColor(this.surfaceVariantColor)
          .borderRadius(8)
          .margin({ top: 24 })

        // Slider
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
          .margin({ top: 16 })
          .onChange((value: number) => {
            this.paymentProgress = value;
            this.drawWave();
          })

        // Reset button
        Button('Reset Progress')
          .width('100%')
          .height(96)
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .backgroundColor(this.tertiaryColor)
          .borderRadius(24)
          .margin({ top: 32 })
          .onClick(() => {
            this.paymentProgress = 0;
            this.drawWave();
          })
      }
      .width('100%')
      .padding(32)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.primaryColor + '40', 0.0],
        [this.backgroundColor, 0.5],
        [this.secondaryColor + '40', 1.0]
      ]
    })
  }
}
