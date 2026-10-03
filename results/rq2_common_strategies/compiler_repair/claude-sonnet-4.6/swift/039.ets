// AppTokens
const PRIMARY_COLOR = '#FFA500';
const SECONDARY_COLOR = '#FFC107';
const TERTIARY_COLOR = '#FFE066';
const BACKGROUND_COLOR = '#FFFBF2';
const SURFACE_COLOR = '#FFFFFF';
const SURFACE_VARIANT_COLOR = '#FFEED6';
const ON_TERTIARY_COLOR = '#1E1E1E';
const ON_SURFACE_COLOR = '#1E1E1E';

const SPACING_LG = 16;
const SHAPE_MEDIUM = 12;
const SHAPE_LARGE = 20;

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  drawWave() {
    const context = this.canvasContext;
    const w = context.width;
    const h = context.height;
    const step = w / 20;

    context.clearRect(0, 0, w, h);
    context.beginPath();
    context.strokeStyle = PRIMARY_COLOR;
    context.lineWidth = 5;
    context.lineJoin = 'round';
    context.lineCap = 'round';

    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    context.moveTo(0, initialY);

    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      context.lineTo(x, y);
    }
    context.stroke();
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE_COLOR)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(BACKGROUND_COLOR)

      // Main Content
      Column({ space: SPACING_LG }) {
        // Surface with Canvas
        Stack() {
          // Background surface
          Column()
            .width('100%')
            .height(240)
            .borderRadius(SHAPE_LARGE)
            .backgroundColor(SURFACE_COLOR)
            .shadow({
              radius: 8,
              color: '#1F000000',
              offsetX: 0,
              offsetY: 4
            })

          // Canvas drawing
          Canvas(this.canvasContext)
            .width('100%')
            .height(240)
            .borderRadius(SHAPE_LARGE)
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(240)

        // Payment Progress Label
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_COLOR)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(SURFACE_VARIANT_COLOR)

          // Progress
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(PRIMARY_COLOR)
        }
        .width('100%')
        .height(8)

        // Slider
        Slider({
          value: this.paymentProgress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(SURFACE_VARIANT_COLOR)
          .selectedColor(PRIMARY_COLOR)
          .blockColor(SECONDARY_COLOR)
          .onChange((value: number) => {
            this.paymentProgress = value / 100;
            this.drawWave();
          })

        // Reset Button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_TERTIARY_COLOR)
          .backgroundColor(TERTIARY_COLOR)
          .borderRadius(SHAPE_MEDIUM)
          .onClick(() => {
            this.paymentProgress = 0.0;
            this.drawWave();
          })
      }
      .padding(SPACING_LG)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#40FFC107', 0.0],
          [BACKGROUND_COLOR, 0.5],
          ['#40FFA500', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}