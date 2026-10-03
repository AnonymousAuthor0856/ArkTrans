// AppTokens
const primaryColor: string = '#2563EB';
const secondaryColor: string = '#60A5FA';
const backgroundColor: string = '#F8FAFC';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E2E8F0';
const onSurfaceColor: string = '#0F172A';

const spacingLg: number = 14;
const shapesLarge: number = 16;

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  drawChart(): void {
    const ctx = this.canvasContext;
    const width: number = ctx.width;
    const height: number = ctx.height;

    ctx.clearRect(0, 0, width, height);

    const padding: number = spacingLg;
    const drawWidth: number = width - padding * 2;
    const drawHeight: number = height - padding * 2;
    const step: number = drawWidth / 50.0;

    ctx.beginPath();
    ctx.strokeStyle = primaryColor;
    ctx.lineWidth = 4;
    ctx.lineJoin = 'round';
    ctx.lineCap = 'round';

    for (let i: number = 0; i <= 50; i++) {
      const x: number = padding + i * step;
      const y: number = padding + drawHeight / 2.0 +
        Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (drawHeight / 3.0);

      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }

    ctx.stroke();
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Stack() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(onSurfaceColor)
      }
      .width('100%')
      .height(56)
      .backgroundColor(backgroundColor)
      .alignContent(Alignment.Center)

      // Main Content
      Column({ space: spacingLg }) {
        // Chart Card
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .borderRadius(shapesLarge)
            .backgroundColor(surfaceColor)
            .shadow({
              radius: 8,
              color: '#301F0F172A',
              offsetX: 0,
              offsetY: 4
            })

          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(spacingLg)
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(shapesLarge)
        .clip(true)

        // Market Trend Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(primaryColor)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(surfaceVariantColor)
          .selectedColor(primaryColor)
          .blockColor(surfaceColor)
          .onChange((value: number) => {
            this.progress = value;
            this.drawChart();
          })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(surfaceVariantColor)

          Row()
            .width(`${this.progress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(primaryColor)
        }
        .width('100%')
        .height(8)
      }
      .padding(spacingLg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0],
          [backgroundColor, 0.5],
          ['#262563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}