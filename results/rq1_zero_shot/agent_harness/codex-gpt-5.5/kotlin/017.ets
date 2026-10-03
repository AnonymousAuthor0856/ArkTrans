const NAME: string = '016AudioMixeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Monochrome Terminal';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00FF66';
  static readonly secondary: string = '#CCCCCC';
  static readonly tertiary: string = '#999999';
  static readonly background: string = '#000000';
  static readonly surface: string = '#0A0A0A';
  static readonly surfaceVariant: string = '#141414';
  static readonly outline: string = '#2A2A2A';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#E0E0E0';
  static readonly onSurface: string = '#E0E0E0';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct MainActivity {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  @Builder
  Header(): void {
    Text('Audio Mixer Terminal')
      .fontSize(26)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.primary)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  MixerSlider(label: string, value: number, onChange: (value: number) => void): void {
    Column({ space: AppSpacing.xs }) {
      Text(`${label} ${Math.floor(value * 100)}%`)
        .fontSize(13)
        .fontColor(AppColors.onSurface);
      Slider({ value: value, min: 0, max: 1 })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .onChange(onChange);
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.MixerSlider('Bass', this.bass, (value: number) => {
          this.bass = value;
        });
        this.MixerSlider('Mid', this.mid, (value: number) => {
          this.mid = value;
        });
        this.MixerSlider('Treble', this.treble, (value: number) => {
          this.treble = value;
        });
        Blank().height(AppSpacing.lg);
        Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Slider({ value: this.master, min: 0, max: 1 })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .onChange((value: number) => {
            this.master = value;
          });
        Button('Apply Settings')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
          .width('100%')
          .height(48);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
