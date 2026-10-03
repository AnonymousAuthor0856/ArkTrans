import { curves } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#FFA500',
  secondary: '#FFC107',
  tertiary: '#FFE066',
  background: '#FFFBF2',
  surface: '#FFFFFF',
  surfaceVariant: '#FFEED6',
  outline: '#F1C27D',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E',
};

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Main content
      Scroll() {
        Column({ space: 16 }) {
          // Wave chart card
          Stack() {
            Canvas(this.renderingContextForCanvas)
              .width('100%')
              .height(240)
              .borderRadius(20)
              .backgroundColor(AppColors.surface)
              .onReady(() => {
                this.drawWaveChart();
              })
          }
          .width('100%')
          .height(240)
          .borderRadius(20)
          .backgroundColor(AppColors.surface)
          .shadow({
            radius: 8,
            color: '#1E1E1E30',
            offsetX: 0,
            offsetY: 4
          })

          // Payment Progress label
          Text('Payment Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress bar
          Progress({
            value: this.paymentProgress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(8)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .style({ strokeWidth: 8 })

          // Slider
          Slider({
            value: this.paymentProgress * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor(AppColors.secondary)
            .onChange((value: number) => {
              this.paymentProgress = value / 100;
              this.drawWaveChart();
            })

          // Reset button
          Button('Reset Progress')
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(12)
            .onClick(() => {
              this.paymentProgress = 0;
              this.drawWaveChart();
            })
        }
        .padding(16)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#40FFC107', 0.0],
        ['#FFFBF2', 0.5],
        ['#40FFA500', 1.0]
      ]
    })
  }

  private renderingContextForCanvas: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));

  private drawWaveChart(): void {
    const ctx = this.renderingContextForCanvas;
    if (!ctx) return;

    const w = ctx.width;
    const h = ctx.height;

    ctx.clearRect(0, 0, w, h);

    const step = w / 20;
    let prevY = h / 2;

    ctx.strokeStyle = AppColors.primary;
    ctx.lineWidth = 5;
    ctx.beginPath();

    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);

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