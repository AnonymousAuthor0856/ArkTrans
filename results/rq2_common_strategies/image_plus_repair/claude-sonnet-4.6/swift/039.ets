import { drawing } from '@kit.ArkGraphics2D';

// AppTokens - using individual constants instead of object literals
const COLOR_PRIMARY: string = '#FFA500';
const COLOR_SECONDARY: string = '#FFC107';
const COLOR_TERTIARY: string = '#FFE066';
const COLOR_BACKGROUND: string = '#FFFBF2';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#FFEED6';
const COLOR_OUTLINE: string = '#F1C27D';
const COLOR_SUCCESS: string = '#22C55E';
const COLOR_WARNING: string = '#F59E0B';
const COLOR_ERROR: string = '#EF4444';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#1E1E1E';
const COLOR_ON_TERTIARY: string = '#1E1E1E';
const COLOR_ON_BACKGROUND: string = '#1E1E1E';
const COLOR_ON_SURFACE: string = '#1E1E1E';

const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;
const SPACING_XXL: number = 32;

const SHAPE_SMALL: number = 6;
const SHAPE_MEDIUM: number = 12;
const SHAPE_LARGE: number = 20;

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawWave(): void {
    const ctx: CanvasRenderingContext2D = this.canvasContext;
    const w: number = ctx.width;
    const h: number = ctx.height;

    ctx.clearRect(0, 0, w, h);

    const step: number = w / 20;
    const padding: number = SPACING_LG;

    ctx.beginPath();
    ctx.strokeStyle = COLOR_PRIMARY;
    ctx.lineWidth = 5;
    ctx.lineJoin = 'round';
    ctx.lineCap = 'round';

    const drawH: number = h - padding * 2;
    const offsetY: number = padding;

    const initialY: number = drawH / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (drawH / 3) + offsetY;
    ctx.moveTo(padding, initialY);

    for (let i: number = 1; i <= 20; i++) {
      const x: number = i * step - padding;
      const y: number = drawH / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (drawH / 3) + offsetY;
      ctx.lineTo(x, y);
    }

    ctx.stroke();
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(COLOR_BACKGROUND)

      // Main Content
      Column({ space: SPACING_LG }) {
        // Surface with Canvas
        Stack() {
          // Background surface
          Column()
            .width('100%')
            .height(240)
            .borderRadius(SHAPE_LARGE)
            .backgroundColor(COLOR_SURFACE)
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
          .fontColor(COLOR_PRIMARY)

        // Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(COLOR_SURFACE_VARIANT)

          // Progress
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(COLOR_PRIMARY)
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
          .trackColor(COLOR_SURFACE_VARIANT)
          .selectedColor(COLOR_PRIMARY)
          .blockColor(COLOR_SECONDARY)
          .blockSize({ width: 28, height: 28 })
          .trackThickness(4)
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
          .fontColor(COLOR_ON_TERTIARY)
          .backgroundColor(COLOR_TERTIARY)
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
          [COLOR_BACKGROUND, 0.5],
          ['#40FFA500', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}