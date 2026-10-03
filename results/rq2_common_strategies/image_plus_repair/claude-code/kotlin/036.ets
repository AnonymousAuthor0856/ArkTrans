@Entry
@Component
struct CryptoMarketScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 24, bottom: 24 });

      Row({ space: 12 }) {
        ForEach(this.chips, (chip: string) => {
          Text(chip)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(12)
            .backgroundColor(this.selectedChip === chip ? '#FFA8A8' : '#F7F7F7')
            .border({ width: 1, color: this.selectedChip === chip ? '#FFA8A8' : '#E2E2E2' })
            .onClick(() => {
              this.selectedChip = chip;
            });
        }, (chip: string) => chip);
      }
      .margin({ bottom: 16 });

      Stack() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height(260)
          .backgroundColor('rgba(255, 168, 168, 0.08)')
          .borderRadius(20)
          .onReady(() => {
            this.drawChart();
          });
      }
      .width('100%')
      .margin({ bottom: 16 });

      Text('Price Variation')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFA8A8')
        .margin({ bottom: 12 });

      Slider({
        value: this.progress * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor('#FFA8A8')
        .trackColor('#F7F7F7')
        .selectedColor('#FFA8A8')
        .width('100%')
        .height(8)
        .onChange((value: number) => {
          this.progress = value / 100;
          this.drawChart();
        })
        .margin({ bottom: 24 });

      Row() {
        Text('Auto Update')
          .fontSize(18)
          .fontColor('#1E1E1E')
          .layoutWeight(1);

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
          .onChange((isOn: boolean) => {
            this.isAutoUpdate = isOn;
          })
          .selectedColor('#FFA8A8')
          .switchPointColor('#FFE1A8');
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#FFE1A84D', 0.0],
        ['#FFFCF5', 0.5],
        ['#A8FFE14D', 1.0]
      ]
    });
  }

  private drawChart(): void {
    const ctx = this.canvasCtx;
    const w = 380;
    const h = 260;
    const padding = 16;
    const chartW = w - padding * 2;
    const chartH = h - padding * 2;
    const steps = 30;
    const step = chartW / steps;

    ctx.clearRect(0, 0, w, h);

    ctx.strokeStyle = '#FFA8A8';
    ctx.lineWidth = 5;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    ctx.beginPath();
    for (let i = 0; i <= steps; i++) {
      const x = padding + i * step;
      const y = padding + chartH / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (chartH / 3);
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();
  }
}
