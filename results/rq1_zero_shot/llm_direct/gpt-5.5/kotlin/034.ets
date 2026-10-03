import window from '@ohos.window';
import common from '@ohos.app.ability.common';

const NAME: string = '010*ExploreMap*en';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Monochrome Terminal';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppTokensColors {
  static readonly primary: string = '#00FF66';
  static readonly secondary: string = '#CCCCCC';
  static readonly tertiary: string = '#999999';
  static readonly background: string = '#000000';
  static readonly surface: string = '#0A0A0A';
  static readonly surfaceVariant: string = '#111111';
  static readonly outline: string = '#1F1F1F';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#FF4444';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#E0E0E0';
  static readonly onSurface: string = '#E0E0E0';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 13;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 11;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppTokensSpacing {
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

class AppTokensElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(0, 0, 0, 0);
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
}

class MapMarker {
  name: string;
  distance: string;

  constructor(name: string, distance: string) {
    this.name = name;
    this.distance = distance;
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State searchFocused: boolean = false;

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ];

  aboutToAppear(): void {
    this.enableImmersiveMode();
  }

  onPageShow(): void {
    this.enableImmersiveMode();
  }

  private enableImmersiveMode(): void {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      window.getLastWindow(context).then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      });
    } catch (error) {
    }
  }

  @Builder
  MarkerCard(marker: MapMarker) {
    Column() {
      Row() {
        Column() {
          Text(marker.name)
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppTokensColors.onSurface)

          Text(marker.distance)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppTokensColors.secondary)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('View')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(AppTypographyTokens.labelWeight)
            .fontColor(AppTokensColors.onPrimary)
        }
        .height(36)
        .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md })
        .backgroundColor(AppTokensColors.primary)
        .borderRadius(AppTokensShapes.small)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding(AppTokensSpacing.md)
    }
    .width('100%')
    .backgroundColor(AppTokensColors.surface)
    .borderRadius(AppTokensShapes.medium)
    .shadow({
      radius: AppTokensElevationMapping.level2.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppTokensElevationMapping.level2.dy
    })
  }

  build() {
    Column() {
      Row() {
        Text('Explore Map')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppTokensColors.primary)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokensColors.background)

      Column({ space: AppTokensSpacing.lg }) {
        TextInput({
          placeholder: 'Search destination',
          text: this.query
        })
          .width('100%')
          .height(56)
          .singleLine(true)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(AppTypographyTokens.bodyWeight)
          .fontColor(AppTokensColors.onSurface)
          .placeholderColor(AppTokensColors.onSurface)
          .caretColor(AppTokensColors.primary)
          .backgroundColor('#00000000')
          .border({
            width: 1,
            color: this.searchFocused ? AppTokensColors.primary : AppTokensColors.outline,
            radius: AppTokensShapes.medium
          })
          .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md })
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.searchFocused = true;
          })
          .onBlur(() => {
            this.searchFocused = false;
          })

        Column({ space: AppTokensSpacing.md }) {
          ForEach(this.markers, (marker: MapMarker) => {
            this.MarkerCard(marker);
          }, (marker: MapMarker) => marker.name)
        }
        .width('100%')

        Blank()
          .height(AppTokensSpacing.xxl)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Refresh Map')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppTokensColors.onPrimary)
        }
        .width('100%')
        .height(48)
        .backgroundColor(AppTokensColors.primary)
        .borderRadius(AppTokensShapes.large)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokensSpacing.lg,
        right: AppTokensSpacing.lg,
        bottom: AppTokensSpacing.lg
      })
      .backgroundColor(AppTokensColors.background)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
  }
}