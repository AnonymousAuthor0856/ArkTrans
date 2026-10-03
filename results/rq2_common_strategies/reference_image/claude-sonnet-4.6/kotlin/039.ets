/**
 * Installment Plan — ArkTS / ArkUI port of the Compose screen.
 * Target: HarmonyOS NEXT (API 11+), DevEco Studio 4.x/5.x
 * File: entry/src/main/ets/pages/Index.ets
 */

const COLOR_PRIMARY: string = '#FFA500';
const COLOR_SECONDARY: string = '#FFC107';
const COLOR_TERTIARY: string = '#FFE066';
const COLOR_BACKGROUND: string = '#FFFBF2';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#FFEED6';
const COLOR_ON_SURFACE: string = '#1E1E1E';

const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;
const SPACE_XL: number = 24;

const WAVE_CARD_HEIGHT: number = 240;
const WAVE_SEGMENTS: number = 20;

@Entry
@Component
struct InstallmentPlan {
  @State @Watch('onProgressChanged') paymentProgress: number = 0.3;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasReady: boolean = false;

  onProgressChanged(): void {
    if (this.canvasReady) {
      this.drawWave();
    }
  }

  /** Same sine wave as the Compose Canvas: y = h/2 + sin(i*PI/5 + p*PI) * (h/3) */
  private drawWave(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    this.ctx.clearRect(0, 0, w, h);

    const step: number = w / WAVE_SEGMENTS;

    this.ctx.beginPath();
    this.ctx.lineWidth = 5;
    this.ctx.strokeStyle = COLOR_PRIMARY;
    this.ctx.lineJoin = 'round';
    this.ctx.lineCap = 'round';

    for (let i: number = 0; i <= WAVE_SEGMENTS; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }
    this.ctx.stroke();
  }

  build() {
    Column() {
      // ---------- CenterAlignedTopAppBar ----------
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      // ---------- Body (vertical gradient) ----------
      Column({ space: SPACE_LG }) {
        // Wave chart card (Surface, shape.large, tonalElevation level2)
        Column() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasReady = true;
              this.drawWave();
            })
        }
        .width('100%')
        .height(WAVE_CARD_HEIGHT)
        .padding(SPACE_LG)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(20)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_PRIMARY)

        // LinearProgressIndicator (progress = paymentProgress)
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(COLOR_SURFACE_VARIANT)
            .borderRadius(4)
          Row()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)

        // Slider
        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.InSet
        })
          .width('100%')
          .selectedColor(COLOR_PRIMARY)
          .trackColor(COLOR_SURFACE_VARIANT)
          .blockColor(COLOR_SECONDARY)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value;
          })

        // Reset Progress button
        Button('Reset Progress')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .borderRadius(12)
          .backgroundColor(COLOR_TERTIARY)
          .fontColor(COLOR_ON_SURFACE)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SPACE_LG)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [
          ['#40FFC107', 0.0], // secondary @ 25% alpha
          ['#FFFFFBF2', 0.5], // background
          ['#40FFA500', 1.0]  // primary @ 25% alpha
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}