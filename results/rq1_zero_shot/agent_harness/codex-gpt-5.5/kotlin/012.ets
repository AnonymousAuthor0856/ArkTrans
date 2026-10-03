const NAME: string = '009FavoritesGriden';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#60A5FA';
  static readonly secondary: string = '#93C5FD';
  static readonly tertiary: string = '#A5B4FC';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EFF6FF';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E293B';
  static readonly onTertiary: string = '#1E1E2F';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#111827';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class OffsetPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State markerPosition: OffsetPoint = new OffsetPoint(200, 400);

  @Builder
  Header(): void {
    Text('Favorite Spots Map')
      .fontSize(28)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  MapPanel(): void {
    Stack() {
      Circle()
        .width(440)
        .height(440)
        .fill('#4D93C5FD');
      Circle()
        .width(680)
        .height(680)
        .fill('#3393C5FD');
      Circle()
        .width(60)
        .height(60)
        .fill(Color.Transparent)
        .border({ width: 3, color: '#4D60A5FA' });
      Circle()
        .width(28)
        .height(28)
        .fill(AppColors.primary);
    }
    .width('100%')
    .height(400)
    .backgroundColor('#CCFFFFFF')
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(24)
    .alignContent(Alignment.Center);
  }

  @Builder
  BottomControls(): void {
    Column({ space: AppSpacing.md }) {
      Text(`Spot Coordinates: (${Math.floor(this.markerPosition.x)}, ${Math.floor(this.markerPosition.y)})`)
        .fontSize(14)
        .fontColor(AppColors.onSurface);
      Button('Save Marker')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .width('100%')
        .height(48);
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Stack() {
        Column() {
          this.MapPanel();
          Blank().layoutWeight(1);
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center);
        this.BottomControls();
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
