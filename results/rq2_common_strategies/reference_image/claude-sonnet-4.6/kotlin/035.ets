// entry/src/main/ets/pages/Index.ets
const NAME: string = '046StockKLineen';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#60A5FA';
  static readonly tertiary: string = '#93C5FD';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E3A8A';
  static readonly onTertiary: string = '#1E40AF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';

  static readonly secondaryFade15: string = 'rgba(96, 165, 250, 0.15)';
  static readonly primaryFade15: string = 'rgba(37, 99, 235, 0.15)';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class AppRadius {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

@Entry
@Component
struct Index {
  @State progress: number = 0.5;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasReady: boolean = false;

  private drawChart(): void {
    if (!this.canvasReady) {
      return;
    }
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, w, h);
    this.ctx.lineWidth = 4;
    this.ctx.strokeStyle = AppColors.primary;
    this.ctx.lineCap = 'round';
    this.ctx.lineJoin = 'round';

    const step: number = w / 50;
    const midY: number = h / 2;
    const amplitude: number = h / 3;

    this.ctx.beginPath();
    for (let i: number = 0; i <= 50; i++) {
      const x: number = i * step;
      const y: number = midY + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * amplitude;
      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }
    this.ctx.stroke();
  }

  @Builder
  chartCard() {
    Column() {
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasReady = true;
          this.drawChart();
        })
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: 'rgba(15, 23, 42, 0.18)',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Body
      Column() {
        this.chartCard()

        Text('Market Trend')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .margin({ top: AppSpacing.lg })

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppColors.primary)
          .selectedColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .trackThickness(8)
          .margin({ top: AppSpacing.xl })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value;
            this.drawChart();
          })

        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 8 })
          .margin({ top: AppSpacing.xl })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondaryFade15, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primaryFade15, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}