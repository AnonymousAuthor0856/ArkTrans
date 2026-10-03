const NAME: string = '047CryptoMarketen';
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

  static readonly secondarySoft: string = '#FFF5DD';
  static readonly tertiarySoft: string = '#E9FFF7';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct Index {
  @State private selectedChip: string = 'BTC';
  @State private progress: number = 0.6;
  @State private isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawChart(): void {
    const w: number = this.context.width;
    const h: number = this.context.height;

    if (w <= 0 || h <= 0) {
      return;
    }

    this.context.clearRect(0, 0, w, h);
    this.context.beginPath();
    this.context.lineWidth = 5;
    this.context.lineCap = 'round';
    this.context.lineJoin = 'round';
    this.context.strokeStyle = AppColors.primary;

    const step: number = w / 30;

    for (let i: number = 0; i <= 30; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);

      if (i === 0) {
        this.context.moveTo(x, y);
      } else {
        this.context.lineTo(x, y);
      }
    }

    this.context.stroke();
  }

  @Builder
  private FilterChip(chip: string) {
    Button(chip, { type: ButtonType.Normal, stateEffect: true })
      .width(118)
      .height(64)
      .borderRadius(6)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onPrimary)
      .backgroundColor(this.selectedChip === chip ? AppColors.primary : AppColors.surfaceVariant)
      .border({
        width: this.selectedChip === chip ? 0 : 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.selectedChip = chip;
      })
  }

  @Builder
  private ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.surfaceVariant)

      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height(8)
  }

  build() {
    Column() {
      Text('Crypto Market')
        .width('100%')
        .height(72)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .align(Alignment.Center)

      Column({ space: AppSpacing.lg }) {
        Row({ space: AppSpacing.xl }) {
          ForEach(this.chips, (chip: string) => {
            this.FilterChip(chip)
          }, (chip: string) => chip)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .padding(AppSpacing.lg)
        .borderRadius(20)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 8,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 4
        })

        Text('Price Variation')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)

        this.ProgressBar()

        Row() {
          Text('Auto Update')
            .fontSize(14)
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
        .margin({ top: AppSpacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondarySoft, 0.0],
        [AppColors.background, 0.5],
        [AppColors.tertiarySoft, 1.0]
      ]
    })
  }
}