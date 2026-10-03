interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onSurface: string;
}

const COLORS: AppColors = {
  primary: '#2563EB',
  secondary: '#60A5FA',
  tertiary: '#93C5FD',
  background: '#F8FAFC',
  surface: '#F2F6FF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  onSurface: '#0F172A'
};

@Entry
@Component
struct StockKLinePage {
  @State private progress: number = 0.5;

  private readonly chartWidth: number = 636;
  private readonly chartHeight: number = 488;
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(this.canvasSettings);

  private drawChart(): void {
    const context = this.canvasContext;
    const step = this.chartWidth / 50;
    const amplitude = this.chartHeight / 3;
    let previousY = this.chartHeight / 2;

    context.clearRect(0, 0, this.chartWidth, this.chartHeight);
    context.beginPath();
    context.strokeStyle = COLORS.primary;
    context.lineWidth = 4;
    context.lineCap = 'butt';
    context.lineJoin = 'round';

    for (let index = 0; index <= 50; index++) {
      const x = index * step;
      const y = this.chartHeight / 2 + Math.sin(index * Math.PI / 8 + this.progress * Math.PI) * amplitude;
      context.moveTo(x - step, previousY);
      context.lineTo(x, y);
      previousY = y;
    }

    context.stroke();
  }

  build() {
    Column() {
      Text('Stock K-Line')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 31, bottom: 62 });

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width(this.chartWidth)
          .height(this.chartHeight)
          .onReady(() => {
            this.drawChart();
          });
      }
      .width('100%')
      .height(517)
      .padding({ left: 14, right: 14, top: 15, bottom: 14 })
      .backgroundColor(COLORS.surface)
      .borderRadius(32)
      .shadow({
        radius: 18,
        color: '#11000000',
        offsetX: 0,
        offsetY: 7
      });

      Text('Market Trend')
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 29, bottom: 24 });

      Slider({
        value: this.progress,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .blockColor(COLORS.primary)
        .selectedColor(COLORS.secondary)
        .trackColor(COLORS.surfaceVariant)
        .blockSize({ width: 8, height: 88 })
        .trackThickness(31)
        .showTips(false)
        .showSteps(false)
        .width('100%')
        .height(62)
        .onChange((value: number) => {
          this.progress = value;
          this.drawChart();
        });

      Progress({
        value: this.progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(16)
        .color(COLORS.primary)
        .backgroundColor(COLORS.surfaceVariant)
        .borderRadius(8)
        .margin({ top: 28 });

      Blank()
        .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding({ left: 28, right: 28 })
    .backgroundColor(COLORS.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#DBEAFE', 0.0],
        [COLORS.background, 0.52],
        ['#DBEAFE', 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start);
  }
}
