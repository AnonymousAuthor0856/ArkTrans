// pages/VideoLibraryPage.ets
// ArkTS (HarmonyOS) port of the single-file Compose UI "013VideoPlayeren"
// UI_TYPE: Media | STYLE_THEME: Cold Gradient | LANG: en | BASELINE_SIZE: 720x1280

const NAME: string = '013VideoPlayeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------------------------------------------ */
/* Design tokens                                                       */
/* ------------------------------------------------------------------ */

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
  static readonly onSurface60: string = 'rgba(8,47,73,0.60)';
  static readonly onSurface70: string = 'rgba(8,47,73,0.70)';
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Radius {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class FontSizes {
  static readonly display: number = 26;
  static readonly title: number = 16;
  static readonly body: number = 13;
  static readonly label: number = 11;
}

class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

/* ------------------------------------------------------------------ */
/* Model                                                               */
/* ------------------------------------------------------------------ */

interface VideoItem {
  title: string;
  duration: string;
}

/* ------------------------------------------------------------------ */
/* Reusable styles                                                     */
/* ------------------------------------------------------------------ */

@Extend(Text)
function displayTitle() {
  .fontSize(FontSizes.display)
  .fontWeight(FontWeight.Bold)
  .fontColor(AppColors.onSurface)
}

@Extend(Text)
function cardTitle() {
  .fontSize(FontSizes.title)
  .fontWeight(FontWeight.Medium)
  .fontColor(AppColors.onSurface)
}

@Extend(Text)
function cardBody() {
  .fontSize(FontSizes.body)
  .fontWeight(FontWeight.Normal)
  .fontColor(AppColors.onSurface70)
}

@Extend(Text)
function cardLabel() {
  .fontSize(FontSizes.label)
  .fontWeight(FontWeight.Medium)
  .fontColor(AppColors.onSurface60)
}

@Extend(Column)
function cardSurface() {
  .padding(Spacing.md)
  .backgroundColor(AppColors.surface)
  .borderRadius(Radius.medium)
  .shadow({
    radius: ElevationMapping.level1.radius,
    color: AppColors.onSurface,
    offsetX: 0,
    offsetY: ElevationMapping.level1.dy
  })
}

/* ------------------------------------------------------------------ */
/* Page                                                                */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct VideoLibraryPage {
  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  /* Top app bar: centered title, background-colored container */
  @Builder
  TopBar() {
    Column() {
      Text('Video Library')
        .displayTitle()
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({
      top: Spacing.lg,
      bottom: Spacing.lg,
      left: Spacing.lg,
      right: Spacing.lg
    })
    .backgroundColor(AppColors.background)
  }

  /* Thumbnail placeholder box */
  @Builder
  Thumbnail() {
    Stack() {
      Text('Thumbnail')
        .cardLabel()
    }
    .width('100%')
    .height(120)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(Radius.small)
    .alignContent(Alignment.Center)
  }

  /* One grid card */
  @Builder
  VideoCard(item: VideoItem) {
    Column({ space: Spacing.sm }) {
      this.Thumbnail()

      Text(item.title)
        .cardTitle()
        .width('100%')
        .textAlign(TextAlign.Start)

      Text(item.duration)
        .cardBody()
        .width('100%')
        .textAlign(TextAlign.Start)

      Button('Play')
        .type(ButtonType.Normal)
        .fontSize(FontSizes.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(Radius.small)
        .height(40)
        .width('100%')
        .onClick(() => {
          console.info(`Play pressed: ${item.title}`);
        })
    }
    .cardSurface()
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: Spacing.md }) {
        Text('Explore the latest videos')
          .fontSize(FontSizes.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Grid() {
          ForEach(
            this.videos,
            (item: VideoItem) => {
              GridItem() {
                this.VideoCard(item)
              }
            },
            (item: VideoItem) => item.title
          )
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Start)
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