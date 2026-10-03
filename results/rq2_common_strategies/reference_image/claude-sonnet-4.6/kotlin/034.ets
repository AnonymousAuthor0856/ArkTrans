// entry/src/main/ets/pages/ExploreMapPage.ets
// Compose "010*ExploreMap*en" / Social / Monochrome Terminal / en / 720x1280

import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

const APP_NAME: string = '010*ExploreMap*en';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Monochrome Terminal';
const APP_LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------------------------------------------ */
/*  Design tokens                                                      */
/* ------------------------------------------------------------------ */

class AppColors {
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
  static readonly shadowLevel2: string = '#1F000000';
}

class AppTypography {
  static readonly displaySize: number = 28;   // sp -> fp
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 6;          // dp -> vp
  static readonly medium: number = 10;
  static readonly large: number = 14;
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(0, 0, 0, 0);
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
}

/* ------------------------------------------------------------------ */
/*  Model                                                              */
/* ------------------------------------------------------------------ */

class MapMarker {
  name: string;
  distance: string;

  constructor(name: string, distance: string) {
    this.name = name;
    this.distance = distance;
  }
}

/* ------------------------------------------------------------------ */
/*  Page                                                               */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct ExploreMapPage {
  @State query: string = '';
  @State isSearchFocused: boolean = false;
  @State markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ];

  aboutToAppear(): void {
    this.applyImmersiveMode();
  }

  /** Equivalent of hiding system bars + BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE */
  private applyImmersiveMode(): void {
    try {
      window.getLastWindow(getContext(this))
        .then((win: window.Window) => {
          win.setWindowLayoutFullScreen(true);
          win.setWindowSystemBarEnable([]);
          win.setWindowSystemBarProperties({
            navigationBarColor: AppColors.background,
            statusBarColor: AppColors.background,
            statusBarContentColor: AppColors.onBackground,
            navigationBarContentColor: AppColors.onBackground
          });
        })
        .catch((err: BusinessError) => {
          console.error(`immersive mode failed: ${err.code} ${err.message}`);
        });
    } catch (err) {
      const e = err as BusinessError;
      console.error(`immersive mode exception: ${e.code} ${e.message}`);
    }
  }

  @Builder
  MarkerCard(marker: MapMarker) {
    Row() {
      Column() {
        Text(marker.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(marker.distance)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('View')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
        .height(40)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .onClick(() => {
          console.info(`view marker: ${marker.name}`);
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppElevation.level2.radius,
      color: AppColors.shadowLevel2,
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Explore Map')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      Column() {
        // Search field
        TextInput({ placeholder: 'Search destination', text: this.query })
          .type(InputType.Normal)
          .placeholderColor(AppColors.onSurface)
          .placeholderFont({ size: AppTypography.bodySize, weight: FontWeight.Normal })
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: this.isSearchFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium,
            style: BorderStyle.Solid
          })
          .borderRadius(AppShapes.medium)
          .height(56)
          .width('100%')
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.isSearchFocused = true;
          })
          .onBlur(() => {
            this.isSearchFocused = false;
          })

        // Marker list
        Column() {
          ForEach(this.markers, (marker: MapMarker) => {
            this.MarkerCard(marker)
          }, (marker: MapMarker) => marker.name)
        }
        .width('100%')
        .margin({ top: AppSpacing.lg })
        .justifyContent(FlexAlign.Start)

        // Spacer(32.dp) then primary action pinned near the bottom
        Blank()

        Button('Refresh Map')
          .type(ButtonType.Normal)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .width('100%')
          .height(48)
          .margin({ bottom: AppSpacing.xxl })
          .onClick(() => {
            console.info('refresh map');
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg
      })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}