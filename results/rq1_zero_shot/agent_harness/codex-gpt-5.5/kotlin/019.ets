const NAME: string = '019SubtitleEditoren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Clay Morph';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#8B5CF6';
  static readonly secondary: string = '#D946EF';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F9F5FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1E9FE';
  static readonly outline: string = '#E3D7FE';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
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
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  @Builder
  Header(): void {
    Text('Subtitle Editor')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  PreviewPanel(): void {
    Stack() {
      Text('Sample Subtitle Line')
        .fontSize(this.fontSize)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(200)
    .backgroundColor(AppColors.surface)
    .borderRadius(22)
    .shadow({ radius: 12, color: '#2E000000', offsetY: 6 })
    .alignContent(Alignment.Center);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.PreviewPanel();
        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(AppColors.onSurface);
        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.secondary)
          .onChange((value: number) => {
            this.fontSize = value;
          });
        Text('Sync Progress')
          .fontSize(14)
          .fontColor(AppColors.onSurface);
        Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
        Row({ space: AppSpacing.md }) {
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(14)
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.min(1, this.syncProgress + 0.1);
            });
          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.max(0, this.syncProgress - 0.1);
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
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
