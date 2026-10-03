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
struct MainActivity {
  @State progress: number = 0.5;
  private bars: number[] = [0.42, 0.58, 0.36, 0.72, 0.64, 0.82, 0.55, 0.68, 0.46, 0.74, 0.62, 0.88];

  @Builder
  Header(): void {
    Text('Stock K-Line')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  ChartPanel(): void {
    Row() {
      ForEach(this.bars, (value: number, index: number) => {
        Rect()
          .width(12)
          .height(`${Math.max(12, (value + this.progress * 0.2) * 100)}%`)
          .fill(index % 2 === 0 ? AppColors.primary : AppColors.secondary)
          .radius(4);
      }, (_value: number, index: number) => index.toString())
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Bottom);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.ChartPanel();
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Slider({ value: this.progress, min: 0, max: 1 })
          .width('100%')
          .selectedColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.primary)
          .onChange((value: number) => {
            this.progress = value;
          });
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
