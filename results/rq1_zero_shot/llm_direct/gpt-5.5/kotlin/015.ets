import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

const NAME: string = '013VideoPlayeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#0369A1';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BFE0F4';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#001F2F';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#082F49';
  static readonly onSurface: string = '#082F49';
  static readonly onSurface60: string = 'rgba(8, 47, 73, 0.6)';
  static readonly onSurface70: string = 'rgba(8, 47, 73, 0.7)';
}

class AppTypographyTokens {
  static readonly displaySize: number = 26;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

class VideoItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

@Component
struct VideoCard {
  item: VideoItem = new VideoItem('', '');

  build() {
    Column({ space: AppSpacing.sm }) {
      Stack() {
        Text('Thumbnail')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface60)
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .alignContent(Alignment.Center)

      Text(this.item.title)
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Text(this.item.duration)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface70)
        .width('100%')

      Button() {
        Text('Play')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(40)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.small)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err: BusinessError, win: window.Window) => {
      if (err.code) {
        return;
      }
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Column() {
      Row() {
        Text('Video Library')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        Text('Explore the latest videos')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              VideoCard({ item: item })
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceVariant, 0.0],
          [AppColors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}