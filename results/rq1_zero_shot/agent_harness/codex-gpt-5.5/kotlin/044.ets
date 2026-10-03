const NAME: string = '058*OrderTracking*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly tertiary: string = '#FFD180';
  static readonly background: string = '#FFF3E0';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE0B2';
  static readonly outline: string = '#D7CCC8';
  static readonly success: string = '#66BB6A';
  static readonly warning: string = '#FFCA28';
  static readonly error: string = '#D32F2F';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @State progress: number = 0.45;

  @Builder
  TrackingCard(): void {
    Column({ space: AppSpacing.md }) {
      Text('Order #25491')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text('Estimated Delivery: 2 days')
        .fontSize(14)
        .fontColor(AppColors.secondary);
      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(10)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant);
      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary);
        Blank();
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
      }
      .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  AdjustPanel(): void {
    Column({ space: AppSpacing.md }) {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Slider({ value: this.progress, min: 0, max: 1 })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .onChange((value: number) => {
          this.progress = value;
        });
      Button('Mark as Delivered')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .width('100%')
        .onClick(() => {
          this.progress = 1;
        });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Center);
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      this.TrackingCard();
      this.AdjustPanel();
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
