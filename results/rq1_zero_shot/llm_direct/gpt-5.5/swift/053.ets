import window from '@ohos.window';

class AppColors {
  static readonly primary: ResourceColor = '#1E293B';
  static readonly secondary: ResourceColor = '#0EA5E9';
  static readonly tertiary: ResourceColor = '#FACC15';
  static readonly background: ResourceColor = '#1E293B';
  static readonly surface: ResourceColor = '#1E293B';
  static readonly surfaceVariant: ResourceColor = '#334155';
  static readonly outline: ResourceColor = '#475569';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#0B1220';
  static readonly onBackground: ResourceColor = '#E2E8F0';
  static readonly onSurface: ResourceColor = '#E2E8F0';
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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
  radius: number;
  y: number;
  opacity: number;
  color: ResourceColor;

  constructor(radius: number, y: number, opacity: number, color: ResourceColor) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
    this.color = color;
  }

  static readonly level1: ShadowSpec = new ShadowSpec(2, 1, 0.1, '#1A000000');
  static readonly level2: ShadowSpec = new ShadowSpec(4, 2, 0.14, '#24000000');
  static readonly level3: ShadowSpec = new ShadowSpec(6, 3, 0.16, '#29000000');
}

class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

@Component
struct CustomTopAppBar {
  title: string = '';

  build() {
    Row() {
      Blank()

      Text(this.title)
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)

      Blank()
    }
    .width('100%')
    .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}

@Component
struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: AppSpacing.md }) {
      Text(this.marker.id.toString())
        .width(32)
        .height(32)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSecondary)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)

      Column() {
        Text(this.marker.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)

        Text(this.marker.desc)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: ShadowSpec.level1.radius,
      color: ShadowSpec.level1.color,
      offsetX: 0,
      offsetY: ShadowSpec.level1.y
    })
  }
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable(['navigation']);
      })
      .catch(() => {
      });
  }

  build() {
    Column() {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Project Files')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)

          Column({ space: AppSpacing.sm }) {
            ForEach(
              this.markers,
              (marker: CodeMarker) => {
                CodeMarkerCard({ marker: marker })
              },
              (marker: CodeMarker) => marker.id.toString()
            )
          }
          .width('100%')
          .margin({ bottom: AppSpacing.xl })

          Text('Live Terminal')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Column() {
            }
            .width('100%')
            .height(240)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: AppColors.outline,
              radius: AppShapes.medium
            })

            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
          }
          .width('100%')
          .height(240)

          Button('Run Code', { type: ButtonType.Normal, stateEffect: true })
            .width('60%')
            .height(48)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .shadow({
              radius: ShadowSpec.level1.radius,
              color: ShadowSpec.level1.color,
              offsetX: 0,
              offsetY: ShadowSpec.level1.y
            })
            .alignSelf(ItemAlign.Center)
            .onClick(() => {
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
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