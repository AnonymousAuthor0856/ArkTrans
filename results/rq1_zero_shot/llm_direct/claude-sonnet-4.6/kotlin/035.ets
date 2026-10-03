import { curves } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#2563EB';
    export const secondary = '#60A5FA';
    export const tertiary = '#93C5FD';
    export const background = '#F8FAFC';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#E2E8F0';
    export const outline = '#CBD5E1';
    export const success = '#22C55E';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#1E3A8A';
    export const onTertiary = '#1E40AF';
    export const onBackground = '#0F172A';
    export const onSurface = '#0F172A';
  }

  export namespace Spacing {
    export const sm = 6;
    export const md = 10;
    export const lg = 14;
    export const xl = 20;
    export const xxl = 28;
  }
}

// K-Line canvas component
@Component
struct KLineChart {
  @Prop progress: number = 0.5;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawChart() {
    const width = this.ctx.width;
    const height = this.ctx.height;
    const step = width / 50;
    let prevY = height / 2;

    this.ctx.clearRect(0, 0, width, height);
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 4;
    this.ctx.beginPath();

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      this.ctx.moveTo(x - step, prevY);
      this.ctx.lineTo(x, y);
      prevY = y;
    }
    this.ctx.stroke();
  }

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawChart();
      })
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawChart() {
    const width = this.ctx.width;
    const height = this.ctx.height;
    const step = width / 50;
    let prevY = height / 2;

    this.ctx.clearRect(0, 0, width, height);
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 4;
    this.ctx.beginPath();

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      this.ctx.moveTo(x - step, prevY);
      this.ctx.lineTo(x, y);
      prevY = y;
    }
    this.ctx.stroke();
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column({ space: AppTokens.Spacing.lg }) {

        // Chart card
        Column() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 4
        })

        // Market Trend label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.secondary)
          .blockColor(AppTokens.Colors.primary)
          .onChange((value: number) => {
            this.progress = value;
            this.drawChart();
          })

        // Progress bar
        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .style({ strokeWidth: 8 })

      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['#262563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}