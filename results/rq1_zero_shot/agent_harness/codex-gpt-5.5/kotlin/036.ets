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
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private bars: number[] = [0.55, 0.38, 0.74, 0.62, 0.83, 0.45, 0.66, 0.52, 0.78, 0.58, 0.7, 0.49];

  @Builder
  Header(): void {
    Text('Crypto Market')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  ChipRow(): void {
    Row({ space: AppSpacing.md }) {
      ForEach(this.chips, (chip: string) => {
        Button(chip)
          .fontSize(14)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(this.selectedChip === chip ? AppColors.primary : AppColors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {
            this.selectedChip = chip;
          });
      }, (chip: string) => chip)
    }
    .justifyContent(FlexAlign.Center);
  }

  @Builder
  ChartPanel(): void {
    Row() {
      ForEach(this.bars, (bar: number, index: number) => {
        Rect()
          .width(14)
          .height(`${Math.max(10, (bar + this.progress * 0.15) * 100)}%`)
          .fill(index % 2 === 0 ? AppColors.primary : AppColors.secondary)
          .radius(6);
      }, (_bar: number, index: number) => index.toString())
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Bottom);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.ChipRow();
        this.ChartPanel();
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(AppColors.onSurface);
          Blank();
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppColors.secondary)
            .onChange((value: boolean) => {
              this.isAutoUpdate = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
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
