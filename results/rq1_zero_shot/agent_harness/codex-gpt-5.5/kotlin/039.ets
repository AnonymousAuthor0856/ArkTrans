const NAME: string = '051*InstallmentPlan*en';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
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
struct MainActivity {
  @State paymentProgress: number = 0.3;
  private bars: number[] = [0.4, 0.62, 0.48, 0.74, 0.55, 0.8, 0.5, 0.68, 0.58, 0.76];

  @Builder
  Header(): void {
    Text('Installment Plan')
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
      ForEach(this.bars, (bar: number, index: number) => {
        Rect()
          .width(16)
          .height(`${Math.max(10, (bar + this.paymentProgress * 0.2) * 100)}%`)
          .fill(index % 2 === 0 ? AppColors.primary : AppColors.secondary)
          .radius(6);
      }, (_bar: number, index: number) => index.toString())
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Bottom);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.ChartPanel();
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Progress({ value: this.paymentProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
        Slider({ value: this.paymentProgress, min: 0, max: 1 })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.secondary)
          .onChange((value: number) => {
            this.paymentProgress = value;
          });
        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(12)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.paymentProgress = 0;
          });
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
