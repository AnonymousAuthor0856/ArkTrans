import prompt from '@ohos.promptAction';

// AppTokens - color palette
class AppColors {
  static readonly primary: string = '#FFA8A8';
  static readonly secondary: string = '#FFE1A8';
  static readonly tertiary: string = '#A8FFE1';
  static readonly background: string = '#FFFCF5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F7F7F7';
  static readonly outline: string = '#E2E2E2';
  static readonly onPrimary: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly sm: Length = 8;
  static readonly md: Length = 12;
  static readonly lg: Length = 16;
  static readonly xl: Length = 24;
  static readonly xxl: Length = 32;
}

class AppRadius {
  static readonly small: Length = 6;
  static readonly medium: Length = 12;
  static readonly large: Length = 20;
}

@Entry
@Component
struct CryptoMarketScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Column() {
      // Title
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xl, bottom: AppSpacing.xl });

      // Filter chips row
      Row({ space: AppSpacing.md }) {
        ForEach(this.chips, (chip: string) => {
          Text(chip)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.md, bottom: AppSpacing.md })
            .borderRadius(AppRadius.medium)
            .backgroundColor(this.selectedChip === chip ? AppColors.primary : AppColors.surfaceVariant)
            .border({ width: 1, color: this.selectedChip === chip ? AppColors.primary : AppColors.outline })
            .onClick(() => {
              this.selectedChip = chip;
            });
        }, (chip: string) => chip);
      }
      .margin({ bottom: AppSpacing.lg });

      // Chart surface with sine wave
      Stack() {
        Canvas(this.chartSettings)
          .width('100%')
          .height(260)
          .backgroundColor('rgba(255, 168, 168, 0.08)')
          .borderRadius(AppRadius.large);
      }
      .width('100%')
      .margin({ bottom: AppSpacing.lg });

      // Price Variation label
      Text('Price Variation')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .margin({ bottom: AppSpacing.md });

      // Linear progress indicator (slider styled as progress bar)
      Slider({
        value: this.progress * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .width('100%')
        .height(8)
        .onChange((value: number) => {
          this.progress = value / 100;
        })
        .margin({ bottom: AppSpacing.lg });

      // Auto Update row
      Row() {
        Text('Auto Update')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1);

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
          .onChange((isOn: boolean) => {
            this.isAutoUpdate = isOn;
          })
          .selectedColor(AppColors.primary)
          .switchPointColor(AppColors.secondary);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.tertiary + '4D', 0.0],
        [AppColors.background, 0.5],
        [AppColors.secondary + '4D', 1.0]
      ]
    });
  }

  private chartSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  aboutToAppear() {
    this.drawChart();
  }

  onAreaChange() {
    this.drawChart();
  }

  private drawChart(): void {
    const ctx = this.chartSettings;
    const w = 360;
    const h = 260;
    const padding = 16;
    const chartW = w - padding * 2;
    const chartH = h - padding * 2;
    const steps = 30;
    const step = chartW / steps;

    ctx.clearRect(0, 0, w, h);

    ctx.strokeStyle = AppColors.primary;
    ctx.lineWidth = 5;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    ctx.beginPath();
    for (let i = 0; i <= steps; i++) {
      const x = padding + i * step;
      const y = padding + chartH / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (chartH / 3);
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();
  }
}
