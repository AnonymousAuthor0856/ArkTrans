class AppColors {
  static readonly primary: string = '#FF2563EB';
  static readonly secondary: string = '#FF60A5FA';
  static readonly tertiary: string = '#FF93C5FD';
  static readonly background: string = '#FFF8FAFC';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF1E3A8A';
  static readonly onTertiary: string = '#FF1E40AF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF0F172A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level1Color: string = '#1F0F172A';

  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
  static readonly level2Color: string = '#2E0F172A';
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.5;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private clampProgress(value: number): number {
    return Math.max(0, Math.min(1, value));
  }

  private drawKLine(value: number = this.progress): void {
    const ctx = this.context;
    const width = ctx.width;
    const height = ctx.height;

    if (width <= 0 || height <= 0) {
      return;
    }

    ctx.clearRect(0, 0, width, height);

    const padding = AppSpacing.lg;
    const chartWidth = Math.max(0, width - padding * 2);
    const chartHeight = Math.max(0, height - padding * 2);
    const startX = padding;
    const centerY = padding + chartHeight / 2;
    const step = chartWidth / 50.0;

    ctx.beginPath();
    ctx.lineWidth = 4;
    ctx.strokeStyle = AppColors.primary;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    ctx.moveTo(startX, centerY);

    for (let i = 0; i <= 50; i++) {
      const x = startX + i * step;
      const y = centerY + Math.sin(i * Math.PI / 8.0 + value * Math.PI) * (chartHeight / 3.0);
      ctx.lineTo(x, y);
    }

    ctx.stroke();
  }

  @Builder
  private LinearProgressBar(value: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)

      Row()
        .width(`${this.clampProgress(value) * 100}%`)
        .height(8)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Stock K-Line')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      Column({ space: AppSpacing.lg }) {
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawKLine();
            })
            .onAreaChange(() => {
              this.drawKLine();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2Radius,
          color: AppElevation.level2Color,
          offsetX: 0,
          offsetY: AppElevation.level2Dy
        })

        Text('Market Trend')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.001,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.primary)
          .onChange((value: number) => {
            this.progress = value;
            this.drawKLine(value);
          })

        this.LinearProgressBar(this.progress)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primary, 1.0]
        ]
      })
      .opacity(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}