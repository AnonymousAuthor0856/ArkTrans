@Entry
@Component
struct InstallmentPlanPage {
  @State paymentProgress: number = 0.3;

  private primaryColor: string = '#FFA500';
  private secondaryColor: string = '#FFC107';
  private tertiaryColor: string = '#FFE066';
  private backgroundColor: string = '#FFFBF2';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#FFEED6';
  private onSurfaceColor: string = '#1E1E1E';

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Column() {
        // Wave chart surface
        Stack() {
          this.WaveChart()
        }
        .width('100%')
        .height(240)
        .backgroundColor(this.surfaceColor)
        .opacity(0.9)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: 4
        })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryColor)
          .margin({ top: 16 })

        // Linear progress indicator
        Progress({ value: this.paymentProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(this.primaryColor)
          .backgroundColor(this.surfaceVariantColor)
          .borderRadius(4)
          .margin({ top: 12 })

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
          .margin({ top: 8 })
          .onChange((value: number) => {
            this.paymentProgress = value;
          })

        // Reset button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .backgroundColor(this.tertiaryColor)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .background(this.backgroundGradient())
  }

  @Builder
  backgroundGradient(): void {
    // Simulating vertical gradient: secondary(0.25) -> background -> primary(0.25)
    // Using linear gradient
  }

  @Builder
  WaveChart() {
    Canvas(this.waveSettings)
      .width('100%')
      .height('100%')
      .padding(16)
      .onReady(() => {
        this.drawWave();
      })
  }

  private waveSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private drawWave(): void {
    const ctx = this.waveSettings;
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
    let prevY = h / 2;
    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * PI / 5 + this.paymentProgress * PI) * (h / 3);
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
      prevY = y;
    }
    ctx.stroke();
  }
}
