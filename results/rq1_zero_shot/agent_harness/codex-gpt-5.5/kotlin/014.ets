const NAME: string = '012PodcastListen';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#0284C7';
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

@Entry
@Component
struct MainActivity {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  @Builder
  Header(): void {
    Text('Podcasts')
      .fontSize(28)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  SegmentedTabs(): void {
    Row() {
      ForEach(this.tabs, (label: string, index: number) => {
        Button(label)
          .fontSize(14)
          .fontColor(this.selectedTab === index ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(this.selectedTab === index ? AppColors.primary : AppColors.surface)
          .borderRadius(8)
          .layoutWeight(1)
          .height(40)
          .onClick(() => {
            this.selectedTab = index;
          });
      }, (label: string) => label)
    }
    .width('100%')
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(8);
  }

  @Builder
  PodcastRow(title: string): void {
    Row() {
      Column() {
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text('30 min episode')
          .fontSize(14)
          .fontColor('#B3082F49');
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('Play')
        .fontSize(14)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(8)
        .onClick(() => {
          this.showDialog = true;
        });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  PlayerDialog(): void {
    if (this.showDialog) {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#66000000')
          .onClick(() => {
            this.showDialog = false;
          });
        Column({ space: AppSpacing.md }) {
          Text('Playing Podcast')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Text('Streaming audio...')
            .fontSize(14)
            .fontColor('#CC082F49');
          Button('OK')
            .fontSize(14)
            .fontColor(AppColors.primary)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.showDialog = false;
            });
        }
        .width(280)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(20)
        .alignItems(HorizontalAlign.Start);
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center);
    }
  }

  build() {
    Stack() {
      Column() {
        this.Header();
        Column({ space: AppSpacing.lg }) {
          this.SegmentedTabs();
          Column({ space: AppSpacing.md }) {
            ForEach(this.podcasts, (podcast: string) => {
              this.PodcastRow(podcast);
            }, (podcast: string) => podcast)
          }
        }
        .width('100%')
        .height('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surfaceVariant);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background);
      this.PlayerDialog();
    }
    .width('100%')
    .height('100%');
  }
}
