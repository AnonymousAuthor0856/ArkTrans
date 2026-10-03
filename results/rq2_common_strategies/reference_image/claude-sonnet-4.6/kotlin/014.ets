// 012PodcastListen / Index.ets
// ArkTS (HarmonyOS ArkUI, declarative) port of the Kotlin Compose single-file UI.
// Drop into: entry/src/main/ets/pages/Index.ets  (list it in main_pages.json)

const NAME: string = '012PodcastListen';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/** Design tokens — mirrors AppTokens */
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
  // onSurface.copy(alpha = 0.7f) -> #B3 + 082F49
  static readonly onSurface70: string = '#B3082F49';
  // onSurface.copy(alpha = 0.8f) -> #CC + 082F49
  static readonly onSurface80: string = '#CC082F49';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.SemiBold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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

/** ElevationMapping -> ShadowSpec */
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  private openPlayerDialog(): void {
    this.showDialog = true;
    AlertDialog.show({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      autoCancel: true,
      alignment: DialogAlignment.Center,
      backgroundColor: AppColors.surface,
      titleFontSize: AppTypography.titleSize,
      titleFontColor: AppColors.onSurface,
      messageFontSize: AppTypography.bodySize,
      messageFontColor: AppColors.onSurface80,
      confirm: {
        value: 'OK',
        fontColor: AppColors.primary,
        action: () => {
          this.showDialog = false;
        }
      }
    });
  }

  /** SegmentedButtonRow + SegmentedButton */
  @Builder
  SegmentedControl() {
    Row() {
      ForEach(this.tabs, (label: string, index: number) => {
        Row({ space: AppSpacing.sm - 2 }) {
          if (this.selectedTab === index) {
            Text('✓')
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
          }
          Text(label)
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(this.selectedTab === index ? AppColors.onPrimary : AppColors.onSurface)
        }
        .justifyContent(FlexAlign.Center)
        .height(40)
        .layoutWeight(1)
        .backgroundColor(this.selectedTab === index ? AppColors.primary : AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: this.selectedTab === index ? AppColors.primary : AppColors.outline
        })
        .onClick(() => {
          this.selectedTab = index;
        })
      }, (label: string, index: number) => label + index.toString())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  /** Card + Row + Button("Play") */
  @Builder
  PodcastCard(title: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Text('30 min episode')
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.onSurface70)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .height(40)
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
        .onClick(() => {
          this.openPlayerDialog();
        })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppElevation.level2.radius,
      color: 'rgba(2, 132, 199, ' + AppElevation.level2.opacity.toString() + ')',
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Podcasts')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)

      // Body: Brush.verticalGradient(surfaceVariant -> background)
      Column({ space: AppSpacing.lg }) {
        this.SegmentedControl()

        Column({ space: AppSpacing.md }) {
          ForEach(this.podcasts, (item: string) => {
            this.PodcastCard(item)
          }, (item: string) => item)
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.surfaceVariant, 0.0], [AppColors.background, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}