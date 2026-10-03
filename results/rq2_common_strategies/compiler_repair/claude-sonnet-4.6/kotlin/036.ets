import { curves } from '@kit.ArkUI';

const PRIMARY_COLOR = '#FFFFA8A8';
const SECONDARY_COLOR = '#FFFFE1A8';
const TERTIARY_COLOR = '#FFA8FFE1';
const BACKGROUND_COLOR = '#FFFFFCF5';
const SURFACE_COLOR = '#FFFFFFFF';
const SURFACE_VARIANT_COLOR = '#FFF7F7F7';
const OUTLINE_COLOR = '#FFE2E2E2';
const ON_SURFACE_COLOR = '#FF1E1E1E';
const ON_PRIMARY_COLOR = '#FF1E1E1E';

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(BACKGROUND_COLOR)

      // Main Content
      Column({ space: 16 }) {
        // Filter Chips
        Row({ space: 12 }) {
          ForEach(this.chips, (chip: string) => {
            Text(chip)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_PRIMARY_COLOR)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor(this.selectedChip === chip ? PRIMARY_COLOR : SURFACE_VARIANT_COLOR)
              .borderRadius(16)
              .onClick(() => {
                this.selectedChip = chip;
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Chart Card
        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(SURFACE_COLOR)
        .borderRadius(20)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
        .padding(16)

        // Price Variation Label
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_COLOR)

        // Progress Bar
        Column() {
          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(PRIMARY_COLOR)
            .backgroundColor(SURFACE_VARIANT_COLOR)
        }
        .width('100%')

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(ON_SURFACE_COLOR)

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(PRIMARY_COLOR)
            .switchPointColor(SECONDARY_COLOR)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFE1A8', 0.0],
        [BACKGROUND_COLOR, 0.5],
        ['#4DA8FFE1', 1.0]
      ]
    })
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawChart(): void {
    const ctx = this.canvasContext;
    const w = ctx.width;
    const h = ctx.height;
    const step = w / 30;

    ctx.clearRect(0, 0, w, h);
    ctx.strokeStyle = PRIMARY_COLOR;
    ctx.lineWidth = 5;
    ctx.lineJoin = 'round';
    ctx.lineCap = 'round';

    ctx.beginPath();
    let prevY = h / 2;
    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
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