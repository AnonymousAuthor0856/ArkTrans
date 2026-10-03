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
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class VideoItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct MainActivity {
  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ];

  @Builder
  Header(): void {
    Text('Video Library')
      .fontSize(26)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  VideoCard(item: VideoItem): void {
    Column({ space: AppSpacing.sm }) {
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49');
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center);
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text(item.duration)
        .fontSize(13)
        .fontColor('#B3082F49');
      Button('Play')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.md }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              this.VideoCard(item);
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .layoutWeight(1);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
