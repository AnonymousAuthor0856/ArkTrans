class AppColors {
  static readonly primary: ResourceColor = '#2563EB';
  static readonly secondary: ResourceColor = '#60A5FA';
  static readonly tertiary: ResourceColor = '#93C5FD';
  static readonly background: ResourceColor = '#F8FAFC';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E2E8F0';
  static readonly outline: ResourceColor = '#CBD5E1';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#1E3A8A';
  static readonly onTertiary: ResourceColor = '#1E40AF';
  static readonly onBackground: ResourceColor = '#0F172A';
  static readonly onSurface: ResourceColor = '#0F172A';
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

@Entry
@Component
struct Index {
  @State @Watch('onProgressChanged') progress: number = 0.5;

  private chartSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private chartContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.chartSettings);

  private onProgressChanged(): void {
    this.drawChart();
  }

  private drawChart(): void {
    const width: number = this.chartContext.width;
    const height: number = this.chartContext.height;

    if (width <= 0 || height <= 0) {
      return;
    }

    this.chartContext.clearRect(0, 0, width, height);
    this.chartContext.beginPath();
    this.chartContext.strokeStyle = AppColors.primary as string;
    this.chartContext.lineWidth = 4;
    this.chartContext.lineCap = 'round';
    this.chartContext.lineJoin = 'round';

    const step: number = width / 50;
    let prevY: number = height / 2;

    for (let i: number = 0; i <= 50; i++) {
      const x: number = i * step;
      const y: number = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);

      if (i === 0) {
        this.chartContext.moveTo(x - step, prevY);
      }

      this.chartContext.lineTo(x, y);
      prevY = y;
    }

    this.chartContext.stroke();
  }

  build() {
    Column() {
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
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Stack() {
          Canvas(this.chartContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
            .onAreaChange(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
        .clip(true)
        .shadow({
          radius: 8,
          color: '#2E0F172A',
          offsetX: 0,
          offsetY: 4
        })

        Text('Market Trend')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(48)
          .blockColor(AppColors.primary)
          .selectedColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .showTips(false)
          .onChange((value: number) => {
            this.progress = value;
            this.drawChart();
          })

        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width('100%')
            .height(8)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(4)

          Blank()
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor(AppColors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(96, 165, 250, 0.15)', 0.0],
          [AppColors.background, 0.5],
          ['rgba(37, 99, 235, 0.15)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}