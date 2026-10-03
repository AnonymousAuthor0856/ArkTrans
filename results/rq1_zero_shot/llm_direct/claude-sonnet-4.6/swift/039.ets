import { curves } from '@kit.ArkUI';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FFA500';
    export const secondary = '#FFC107';
    export const tertiary = '#FFE066';
    export const background = '#FFFBF2';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#FFEED6';
    export const outline = '#F1C27D';
    export const success = '#22C55E';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#1E1E1E';
    export const onTertiary = '#1E1E1E';
    export const onBackground = '#1E1E1E';
    export const onSurface = '#1E1E1E';
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 12;
    export const large = 20;
  }

  export namespace Spacing {
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 32;
  }
}

// MARK: - SurfaceWithCanvas Component
@Component
struct SurfaceWithCanvas {
  @Link paymentProgress: number;

  build() {
    Stack() {
      // Canvas drawing area
      Canvas(new RenderingContextSettings(true))
        .width('100%')
        .height(240)
        .onReady((context: CanvasRenderingContext2D) => {
          this.drawWave(context);
        })
        .onAreaChange(() => {})
        .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height(240)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  private drawWave(context: CanvasRenderingContext2D): void {
    const w = context.width;
    const h = context.height;
    const step = w / 20;

    context.clearRect(0, 0, w, h);
    context.beginPath();
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;

    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    context.moveTo(0, initialY);

    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      context.lineTo(x, y);
    }

    context.stroke();
  }
}

// MARK: - Root Screen
@Entry
@Component
struct RootScreen {
  @State private paymentProgress: number = 0.3;
  private canvasContext: CanvasRenderingContext2D | null = null;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Surface with Canvas
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height(240)
            .onReady(() => {
              this.drawWave();
            })
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(240)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })

        // Payment Progress Label
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        // Custom Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          // Track background
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          // Progress fill
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.primary)
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
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .blockColor(AppTokens.Colors.secondary)
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
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0;
            this.drawWave();
          })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0x40FFC107, 0.0],
          [0xFFFFBF2, 0.5],
          [0x40FFA500, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawWave(): void {
    const w = this.context.width;
    const h = this.context.height;
    const step = w / 20;

    this.context.clearRect(0, 0, w, h);
    this.context.beginPath();
    this.context.strokeStyle = AppTokens.Colors.primary;
    this.context.lineWidth = 5;

    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    this.context.moveTo(0, initialY);

    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      this.context.lineTo(x, y);
    }

    this.context.stroke();
  }
}