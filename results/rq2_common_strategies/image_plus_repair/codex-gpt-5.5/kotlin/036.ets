const PRIMARY: string = '#FFA8A8';
const SECONDARY: string = '#FFE1A8';
const BACKGROUND: string = '#FFFCF5';
const SURFACE_VARIANT: string = '#F7F7F7';
const OUTLINE: string = '#E2E2E2';
const TEXT_MAIN: string = '#1E1E1E';
const CHART_SURFACE: string = '#FFF8FB';

@Entry
@Component
struct CryptoMarketPage {
  @State selectedChip: string = 'BTC';
  @State progress: number = 60;
  @State isAutoUpdate: boolean = true;

  private readonly coins: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  private drawMarketLine(): void {
    const cardWidth: number = 656;
    const cardHeight: number = 520;
    const pad: number = 16;
    const width: number = cardWidth - pad * 2;
    const height: number = cardHeight - pad * 2;
    const step: number = width / 30;
    const centerY: number = pad + height / 2;
    let previousY: number = centerY;

    this.canvasContext.clearRect(0, 0, cardWidth, cardHeight);
    this.canvasContext.beginPath();
    this.canvasContext.lineWidth = 5;
    this.canvasContext.lineCap = 'butt';
    this.canvasContext.lineJoin = 'miter';
    this.canvasContext.strokeStyle = PRIMARY;
    this.canvasContext.moveTo(pad - step, previousY);

    for (let i = 0; i <= 30; i++) {
      const x: number = pad + i * step;
      const y: number = centerY + Math.sin(i * Math.PI / 6 + this.progress / 100 * Math.PI) * height / 3;
      this.canvasContext.lineTo(x, y);
      previousY = y;
    }

    this.canvasContext.stroke();
  }

  @Builder
  private CoinChip(label: string) {
    Button(label)
      .width(118)
      .height(64)
      .borderRadius(12)
      .backgroundColor(this.selectedChip === label ? PRIMARY : SURFACE_VARIANT)
      .border({
        width: this.selectedChip === label ? 0 : 2,
        color: OUTLINE
      })
      .fontColor(TEXT_MAIN)
      .fontSize(28)
      .fontWeight(FontWeight.Medium)
      .type(ButtonType.Normal)
      .stateEffect(false)
      .onClick(() => {
        this.selectedChip = label;
      })
  }

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_MAIN)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(70)
        .margin({ top: 31 })

      Row({ space: 24 }) {
        ForEach(this.coins, (coin: string) => {
          this.CoinChip(coin)
        }, (coin: string) => coin)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(64)
      .margin({ top: 75 })

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMarketLine();
          })
          .onAreaChange(() => {
            this.drawMarketLine();
          })
      }
      .width('100%')
      .height(520)
      .backgroundColor(CHART_SURFACE)
      .borderRadius(36)
      .clip(true)
      .margin({ top: 48 })

      Text('Price Variation')
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(48)
        .margin({ top: 31 })

      Progress({
        value: this.progress,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(16)
        .color(PRIMARY)
        .backgroundColor(SURFACE_VARIANT)
        .style({ strokeWidth: 16 })
        .margin({ top: 15 })

      Row() {
        Text('Auto Update')
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_MAIN)

        Toggle({
          type: ToggleType.Switch,
          isOn: this.isAutoUpdate
        })
          .selectedColor(PRIMARY)
          .switchPointColor(SECONDARY)
          .width(104)
          .height(64)
          .onChange((checked: boolean) => {
            this.isAutoUpdate = checked;
          })
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 48 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor(BACKGROUND)
    .linearGradient({
      angle: 180,
      colors: [
        [0x4DFFE1A8, 0.0],
        [0xFFFFFCF5, 0.5],
        [0x4DA8FFE1, 1.0]
      ]
    })
  }
}
