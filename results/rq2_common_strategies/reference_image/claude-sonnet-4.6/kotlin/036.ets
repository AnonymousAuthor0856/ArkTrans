// Index.ets — Crypto Market (Soft Pastel) · 047CryptoMarketen · Finance · en · 720x1280

const APP_NAME: string = '047CryptoMarketen';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Soft Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FFA8A8';
  static readonly secondary: string = '#FFE1A8';
  static readonly tertiary: string = '#A8FFE1';
  static readonly background: string = '#FFFCF5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F7F7F7';
  static readonly outline: string = '#E2E2E2';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#1E1E1E';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class TypographyTokens {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class ShapeTokens {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class SpacingTokens {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

@Entry
@Component
struct Index {
  @State selectedChip: string = 'BTC';
  @State @Watch('onProgressChange') progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private progressStyle: LinearStyleOptions = { strokeWidth: 8, enableSmoothEffect: true };

  onProgressChange(): void {
    this.drawChart();
  }

  drawChart(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }
    this.ctx.clearRect(0, 0, w, h);
    this.ctx.lineWidth = 5;
    this.ctx.strokeStyle = AppColors.primary;
    this.ctx.lineCap = 'round';
    this.ctx.lineJoin = 'round';

    const step: number = w / 30;
    let prevY: number = h / 2;
    for (let i: number = 0; i <= 30; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.ctx.beginPath();
      this.ctx.moveTo(x - step, prevY);
      this.ctx.lineTo(x, y);
      this.ctx.stroke();
      prevY = y;
    }
  }

  @Builder
  chip(label: string) {
    Text(label)
      .fontSize(TypographyTokens.bodySize)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onPrimary)
      .textAlign(TextAlign.Center)
      .padding({ left: 18, right: 18, top: 7, bottom: 7 })
      .backgroundColor(this.selectedChip === label ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(ShapeTokens.medium)
      .onClick(() => {
        this.selectedChip = label;
      })
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Crypto Market')
          .fontSize(TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: SpacingTokens.lg }) {
        Row({ space: SpacingTokens.md }) {
          ForEach(this.chips, (item: string) => {
            this.chip(item);
          }, (item: string) => item + '_' + this.selectedChip)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Chart surface
        Column() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .padding(SpacingTokens.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(ShapeTokens.large)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: '#2E1E1E1E',
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })

        Text('Price Variation')
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style(this.progressStyle)

        Row() {
          Text('Auto Update')
            .fontSize(TypographyTokens.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppColors.primary)
            .switchPointColor(AppColors.secondary)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SpacingTokens.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4DFFE1A8', 0.0],
          ['#FFFFFCF5', 0.5],
          ['#4DA8FFE1', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}