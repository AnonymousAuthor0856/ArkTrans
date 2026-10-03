import { window } from '@kit.ArkUI';

// ============================================================
// AppTokens —— 对应 SwiftUI AppTokens
// ============================================================
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
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 6;
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

class AppElevation {
  // level1: 无阴影
  static readonly level1: ShadowOptions = { radius: 0, color: '#00000000', offsetX: 0, offsetY: 0 };
  // level2: radius 4dp, dy 2dp, opacity 0.12f -> ARGB 0x1F
  static readonly level2: ShadowOptions = { radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 };
}

// ============================================================
// Data Model —— 对应 SwiftUI MapMarker
// ============================================================
class MapMarker {
  id: string;
  name: string;
  distance: string;

  constructor(id: string, name: string, distance: string) {
    this.id = id;
    this.name = name;
    this.distance = distance;
  }
}

// ============================================================
// RootScreen
// ============================================================
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFocused: boolean = false;

  private markers: MapMarker[] = [
    new MapMarker('0', 'Central Plaza', '1.2 km'),
    new MapMarker('1', 'Museum District', '3.4 km'),
    new MapMarker('2', 'Tech Park', '5.6 km'),
    new MapMarker('3', 'Old Town Gate', '7.8 km')
  ];

  aboutToAppear(): void {
    // 全屏（隐藏顶部状态栏），对应 SwiftUI 的 .statusBarHidden(true)
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
      })
      .catch(() => {
      });
  }

  build() {
    Column() {
      // ---------- Top App Bar ----------
      Text('Explore Map')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      // ---------- 主内容区 ----------
      Column({ space: AppSpacing.lg }) {
        // Search Field —— 对应 OutlinedTextField
        TextInput({
          text: this.query,
          placeholder: 'Search destination'
        })
          .placeholderColor(AppColors.tertiary)
          .placeholderFont({ size: AppTypography.bodySize })
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .border({
            width: 1,
            color: this.isSearchFocused ? AppColors.primary : AppColors.outline
          })
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .height(52)
          .width('100%')
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.isSearchFocused = true;
          })
          .onBlur(() => {
            this.isSearchFocused = false;
          })

        // Markers List
        Column({ space: AppSpacing.md }) {
          ForEach(this.markers, (marker: MapMarker) => {
            // Card —— 对应 Compose Card
            Row() {
              Column({ space: 4 }) {
                Text(marker.name)
                  .fontSize(AppTypography.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                  .textAlign(TextAlign.Start)

                Text(marker.distance)
                  .fontSize(AppTypography.bodySize)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.secondary)
                  .textAlign(TextAlign.Start)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              // View 按钮
              Button('View')
                .type(ButtonType.Normal)
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.small)
                .height(30)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .onClick(() => {
                  console.info(`View ${marker.name} Tapped`);
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .shadow(AppElevation.level2)
          }, (marker: MapMarker) => marker.id)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .layoutWeight(1)

        // Refresh Map 按钮 —— 固定在底部
        Button('Refresh Map')
          .type(ButtonType.Normal)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .height(48)
          .width('100%')
          .onClick(() => {
            console.info('Refresh Map Tapped');
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}