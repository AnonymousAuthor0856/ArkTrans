const NAME: string = '034BillCalendaren';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Gradient Flow';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
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
  @State spending: number = 500;
  private goal: number = 1000;

  @Builder
  Header(): void {
    Text('Bill Calendar')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  SpendingCard(): void {
    Column() {
      Text('Current Spending')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
      Progress({ value: Math.max(0, Math.min(100, (this.spending / this.goal) * 100)), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height(160)
    .padding(AppSpacing.lg)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.SpendingCard();
        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Slider({ value: this.spending, min: 0, max: 2000 })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.secondary)
          .onChange((value: number) => {
            this.spending = value;
          });
        Button('Reset')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(12)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.spending = 0;
          });
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
