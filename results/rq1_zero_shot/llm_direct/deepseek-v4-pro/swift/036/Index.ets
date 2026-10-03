import { display } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  // AppTokens Colors
  private primary: string = '#FFA8A8';
  private secondary: string = '#FFE1A8';
  private tertiary: string = '#A8FFE1';
  private background: string = '#FFFCF5';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#F7F7F7';
  private outline: string = '#E2E2E2';
  private onPrimary: string = '#1E1E1E';
  private onSurface: string = '#1E1E1E';

  // Spacing
  private spacingSm: number = 8;
  private spacingMd: number = 12;
  private spacingLg: number = 16;
  private spacingXl: number = 24;
  private spacingXxl: number = 32;

  // Shapes
  private shapeSmall: number = 6;
  private shapeMedium: number = 12;
  private shapeLarge: number = 20;

  @Builder
  FilterChip(text: string, isSelected: boolean, onTap: () => void) {
    Text(text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.onPrimary)
      .padding({ left: this.spacingMd, right: this.spacingMd, top: this.spacingSm, bottom: this.spacingSm })
      .backgroundColor(isSelected ? this.primary : this.surfaceVariant)
      .borderRadius(this.shapeSmall)
      .onClick(() => {
        onTap();
      })
  }

  @Builder
  CustomSwitch(isOn: boolean, onToggle: () => void) {
    Row() {
      Blank()
        .width(isOn ? 20 : 0)
        .animation({ duration: 200, curve: Curve.EaseInOut })
      Circle()
        .width(27)
        .height(27)
        .fill(isOn ? this.secondary : this.outline)
        .shadow({ radius: 2, offsetY: 1, color: 'rgba(0, 0, 0, 0.1)' })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(51)
    .height(31)
    .backgroundColor(isOn ? this.primary : this.surfaceVariant)
    .borderRadius(15.5)
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .padding(2)
    .onClick(() => {
      onToggle();
    })
  }

  @Builder
  ChartCanvas() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawChart();
      })
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  private drawChart(): void {
    const canvasWidth = this.context.width;
    const canvasHeight = this.context.height;
    const step = canvasWidth / 30;
    const initialPrevY = canvasHeight / 2;

    this.context.beginPath();
    this.context.moveTo(-step, initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = canvasHeight / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (canvasHeight / 3);
      this.context.lineTo(x, y);
    }

    this.context.strokeStyle = this.primary;
    this.context.lineWidth = 5;
    this.context.stroke();
  }

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: this.spacingLg, bottom: this.spacingLg })
        .backgroundColor(this.background)

      // Content Area
      Column({ space: this.spacingLg }) {
        // Filter Chips Row
        Row({ space: this.spacingMd }) {
          this.FilterChip('BTC', this.selectedChip === 'BTC', () => { this.selectedChip = 'BTC'; });
          this.FilterChip('ETH', this.selectedChip === 'ETH', () => { this.selectedChip = 'ETH'; });
          this.FilterChip('SOL', this.selectedChip === 'SOL', () => { this.selectedChip = 'SOL'; });
          this.FilterChip('ADA', this.selectedChip === 'ADA', () => { this.selectedChip = 'ADA'; });
        }
        .width('100%')

        // Chart Surface
        Column() {
          this.ChartCanvas()
        }
        .width('100%')
        .height(260)
        .backgroundColor(this.surface)
        .borderRadius(this.shapeLarge)
        .shadow({ radius: 8, offsetY: 4, color: 'rgba(0, 0, 0, 0.18)' })
        .padding(this.spacingLg)

        // Price Variation Text
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)

        // Linear Progress Indicator
        Progress({ value: this.progress, total: 1.0 })
          .width('100%')
          .height(8)
          .color(this.primary)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(4)

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.onSurface)

          Blank()

          this.CustomSwitch(this.isAutoUpdate, () => {
            this.isAutoUpdate = !this.isAutoUpdate;
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(this.spacingLg)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(255, 225, 168, 0.3)', 0],
          [this.background, 0.5],
          ['rgba(168, 255, 225, 0.3)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}