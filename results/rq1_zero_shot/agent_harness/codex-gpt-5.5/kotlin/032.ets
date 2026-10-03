const NAME: string = '033TransferWizarden';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC300';
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

class OffsetPoint {
  x: number;
  y: number;
  constructor(x: number, y: number) { this.x = x; this.y = y; }
}

@Entry
@Component
struct MainActivity {
  @State markerPosition: OffsetPoint = new OffsetPoint(200, 400);
  @State progress: number = 0.4;

  @Builder
  Header(): void {
    Text('Transfer Wizard')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  TransferCanvas(): void {
    Stack() {
      Circle()
        .width(520)
        .height(520)
        .fill(AppColors.surfaceVariant);
      Circle()
        .width(40)
        .height(40)
        .fill(AppColors.primary)
        .position({ x: this.markerPosition.x, y: this.markerPosition.y });
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Center);
  }

  @Builder
  BottomControls(): void {
    Column({ space: AppSpacing.lg }) {
      Text('Transfer Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('80%')
        .height(8)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant);
      Row({ space: AppSpacing.md }) {
        Button('+')
          .fontSize(18)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(24)
          .onClick(() => {
            this.progress = Math.min(1, this.progress + 0.1);
          });
        Button('-')
          .fontSize(18)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(24)
          .onClick(() => {
            this.progress = Math.max(0, this.progress - 0.1);
          });
      }
    }
    .width('100%')
    .padding({ bottom: AppSpacing.xxl })
    .alignItems(HorizontalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Stack() {
        this.TransferCanvas();
        this.BottomControls();
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .alignContent(Alignment.Bottom);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
