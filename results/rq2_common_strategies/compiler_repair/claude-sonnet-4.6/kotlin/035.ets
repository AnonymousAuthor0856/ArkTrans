import { curves } from '@kit.ArkUI';

const PRIMARY_COLOR = '#2563EB';
const SECONDARY_COLOR = '#60A5FA';
const TERTIARY_COLOR = '#93C5FD';
const BACKGROUND_COLOR = '#F8FAFC';
const SURFACE_COLOR = '#FFFFFF';
const SURFACE_VARIANT_COLOR = '#E2E8F0';
const OUTLINE_COLOR = '#CBD5E1';
const SUCCESS_COLOR = '#22C55E';
const WARNING_COLOR = '#F59E0B';
const ERROR_COLOR = '#EF4444';
const ON_PRIMARY_COLOR = '#FFFFFF';
const ON_SECONDARY_COLOR = '#1E3A8A';
const ON_TERTIARY_COLOR = '#1E40AF';
const ON_BACKGROUND_COLOR = '#0F172A';
const ON_SURFACE_COLOR = '#0F172A';

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(BACKGROUND_COLOR)

      // Main Content
      Column({ space: 14 }) {
        // K-Line Chart
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(SURFACE_COLOR)
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
        .padding(14)

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_COLOR)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(SURFACE_VARIANT_COLOR)
          .selectedColor(SECONDARY_COLOR)
          .blockColor(PRIMARY_COLOR)
          .onChange((value: number) => {
            this.progress = value;
            this.drawChart();
          })

        // Progress Bar
        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(PRIMARY_COLOR)
          .backgroundColor(SURFACE_VARIANT_COLOR)
      }
      .width('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0],
          [BACKGROUND_COLOR, 0.5],
          ['#262563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawChart() {
    const ctx = this.context;
    if (!ctx) return;

    const width = ctx.width;
    const height = ctx.height;

    ctx.clearRect(0, 0, width, height);

    const step = width / 50;
    let prevY = height / 2;

    ctx.strokeStyle = PRIMARY_COLOR;
    ctx.lineWidth = 4;
    ctx.beginPath();

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);

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