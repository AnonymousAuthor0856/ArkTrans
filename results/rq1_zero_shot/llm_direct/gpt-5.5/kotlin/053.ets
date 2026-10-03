interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

const NAME: string = '078_CodeIDE_en';
const UI_TYPE: string = 'Education Terminal';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#1E293B';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#FACC15';
  static readonly background: string = '#111827';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#E2E8F0';
  static readonly onSurface: string = '#E2E8F0';
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 1, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 4, 2, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 6, 3, 0.16);
}

@Component
struct TopAppBar {
  build() {
    Row() {
      Text('CodeIDE Terminal')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(72)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }
}

@Component
struct FileCard {
  marker: CodeMarker = { id: 0, name: '', desc: '' };

  build() {
    Row({ space: AppSpacing.md }) {
      Text(this.marker.id.toString())
        .width(32)
        .height(32)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)

      Column() {
        Text(this.marker.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text(this.marker.desc)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
  }
}

@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ];

  build() {
    Column() {
      TopAppBar()

      Column({ space: AppSpacing.lg }) {
        Text('Project Files')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        Column({ space: AppSpacing.sm }) {
          ForEach(this.markers, (marker: CodeMarker) => {
            FileCard({ marker: marker })
          }, (marker: CodeMarker) => marker.id.toString())
        }
        .width('100%')
        .padding({ bottom: AppSpacing.xl })

        Text('Live Terminal')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        Stack({ alignContent: Alignment.TopStart }) {
          Text('> println("Hello, Kotlin!")')
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(240)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.medium
        })

        Button() {
          Text('Run Code')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .width('60%')
        .height(48)
        .alignSelf(ItemAlign.Center)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
        .onClick(() => {
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [
          ['#CC1E293B', 0.0],
          ['#E61E293B', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct MainActivity {
  build() {
    RootScreen()
  }
}