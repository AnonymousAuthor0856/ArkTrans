// ===== Design tokens =====
const COLORS_PRIMARY: string = '#FFA8A8';
const COLORS_SECONDARY: string = '#FFE1A8';
const COLORS_TERTIARY: string = '#A8FFE1';
const COLORS_BACKGROUND: string = '#FFFCF5';
const COLORS_SURFACE: string = '#FFFFFF';
const COLORS_SURFACE_VARIANT: string = '#F7F7F7';
const COLORS_OUTLINE: string = '#E2E2E2';
const COLORS_ON_SURFACE: string = '#1E1E1E';

const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;

const SHAPES_SMALL: number = 6;
const SHAPES_MEDIUM: number = 12;
const SHAPES_LARGE: number = 20;

const ELEVATION_LEVEL2_COLOR: string = '#2E000000'; // black @ 18% opacity
const ELEVATION_LEVEL2_RADIUS: number = 8;
const ELEVATION_LEVEL2_DY: number = 4;

@Entry
@Component
struct CryptoMarketPage {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chipLabels: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  /**
   * Draws the sine waveform: y = h/2 + sin(i * PI/6 + progress * PI) * (h/3)
   */
  private drawWave(): void {
    const w: number = this.canvasCtx.width;
    const h: number = this.canvasCtx.height;
    const step: number = w / 30;
    const prevY: number = h / 2;

    this.canvasCtx.beginPath();
    this.canvasCtx.moveTo(-step, prevY);
    for (let i = 0; i <= 30; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.canvasCtx.lineTo(x, y);
    }
    this.canvasCtx.strokeStyle = COLORS_PRIMARY;
    this.canvasCtx.lineWidth = 5;
    this.canvasCtx.lineCap = 'round';
    this.canvasCtx.lineJoin = 'round';
    this.canvasCtx.stroke();
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(COLORS_ON_SURFACE)
      .textAlign(TextAlign.Center)
      .padding({ left: SPACING_MD, right: SPACING_MD, top: SPACING_SM, bottom: SPACING_SM })
      .backgroundColor(this.selectedChip === label ? COLORS_PRIMARY : COLORS_SURFACE_VARIANT)
      .borderRadius(SHAPES_SMALL)
      .onClick(() => {
        this.selectedChip = label;
      })
  }

  @Builder
  LinearProgressIndicator(value: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(COLORS_SURFACE_VARIANT)

      Row()
        .width(`${value * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(COLORS_PRIMARY)
    }
    .width('100%')
    .height(8)
  }

  @Builder
  CustomSwitch(checked: boolean) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width(51)
        .height(31)
        .borderRadius(15.5)
        .backgroundColor(checked ? COLORS_PRIMARY : COLORS_SURFACE_VARIANT)

      Row()
        .width(25)
        .height(25)
        .borderRadius(12.5)
        .backgroundColor(checked ? COLORS_SECONDARY : COLORS_OUTLINE)
        .margin({ left: 3 })
        .offset({ x: checked ? 20 : 0 })
        .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
    }
    .width(51)
    .height(31)
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isAutoUpdate = !this.isAutoUpdate;
      });
    })
  }

  build() {
    Column() {
      // ===== Top app bar =====
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS_ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: SPACING_LG, bottom: SPACING_LG })
        .backgroundColor(COLORS_BACKGROUND)

      // ===== Content area =====
      Column({ space: SPACING_LG }) {
        // Filter chips row
        Row({ space: SPACING_MD }) {
          ForEach(this.chipLabels, (label: string) => {
            this.FilterChip(label)
          }, (label: string) => label)
        }

        // Chart surface
        Column() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(260)
        .padding(SPACING_LG)
        .backgroundColor(COLORS_SURFACE)
        .borderRadius(SHAPES_LARGE)
        .clip(true)
        .shadow({
          radius: ELEVATION_LEVEL2_RADIUS,
          color: ELEVATION_LEVEL2_COLOR,
          offsetX: 0,
          offsetY: ELEVATION_LEVEL2_DY
        })

        // Price variation title
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS_PRIMARY)

        // Linear progress indicator
        this.LinearProgressIndicator(this.progress)

        // Auto update row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(COLORS_ON_SURFACE)

          Blank()

          this.CustomSwitch(this.isAutoUpdate)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(SPACING_LG)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4DFFE1A8', 0.0], // secondary @ 30%
          ['#FFFFFCF5', 0.5], // background
          ['#4DA8FFE1', 1.0]  // tertiary @ 30%
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS_BACKGROUND)
  }
}