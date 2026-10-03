// Index.ets  —  HarmonyOS / ArkTS  (API 10+)

import window from '@ohos.window';

/* ============================================================
 * AppTokens —— 设计系统常量（对应 SwiftUI 里的 AppTokens）
 * ============================================================ */
export class AppTokens {
  // ---- Colors ----
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';

  // ---- Typography ----
  static readonly displaySize: number = 28;   // Font.bold(28)
  static readonly titleSize: number = 18;     // Font.medium(18)
  static readonly bodySize: number = 14;      // Font.regular(14)
  static readonly labelSize: number = 12;     // Font.medium(12)

  // ---- Shapes ----
  static readonly radiusSmall: number = 6;
  static readonly radiusMedium: number = 10;
  static readonly radiusLarge: number = 16;

  // ---- Spacing ----
  static readonly spaceSm: number = 6;
  static readonly spaceMd: number = 10;
  static readonly spaceLg: number = 16;
  static readonly spaceXl: number = 24;
  static readonly spaceXxl: number = 36;

  // ---- Elevation level1 (#000000 @ 0.12 / radius 4 / dy 2) ----
  static readonly elevation1Color: string = '#1F000000';
  static readonly elevation1Radius: number = 4;
  static readonly elevation1Dy: number = 2;

  // ---- Elevation level2 (#000000 @ 0.15 / radius 8 / dy 4) ----
  static readonly elevation2Color: string = '#26000000';
  static readonly elevation2Radius: number = 8;
  static readonly elevation2Dy: number = 4;

  // ---- Material 3 defaults ----
  static readonly bottomAppBarHeight: number = 80;
  static readonly bottomAppBarShadow: string = '#1A000000';
  static readonly fabSize: number = 56;
  static readonly fabRadius: number = 28;
  static readonly buttonHorizontalPadding: number = 16;
  static readonly buttonVerticalPadding: number = 8;
  static readonly fabBottomMargin: number = 16;
  static readonly fabTrailingMargin: number = 16;
  static readonly lazyColumnContentBottomPadding: number = 96;
}

/* ============================================================
 * Data Model
 * ============================================================ */
export class LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id;
    this.title = title;
    this.viewers = viewers;
    this.price = price;
  }
}

function formatViewers(value: number): string {
  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

/* ============================================================
 * RootScreen —— 对应 SwiftUI 的 RootScreen（Scaffold + FAB + BottomBar）
 * ============================================================ */
@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];

  aboutToAppear(): void {
    // 等价于 .statusBarHidden(true)
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: Error) => {
        console.error(`setWindowLayoutFullScreen failed: ${err.message}`);
      });
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // ---------- 主体内容（Scaffold content） ----------
      Column() {
        Text('Live Shop Events')
          .fontSize(AppTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        List({ space: AppTokens.spaceMd }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              LiveItemCard({ item: item })
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        // LazyColumn contentPadding bottom = 96vp，为 FAB 留出空间
        .padding({ bottom: AppTokens.lazyColumnContentBottomPadding })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .padding(AppTokens.spaceLg)              // Modifier.padding(AppTokens.Spacing.lg)
      .linearGradient({                        // 垂直渐变背景
        angle: 180,
        colors: [
          [AppTokens.background, 0.0],
          [AppTokens.surfaceVariant, 0.5],
          [AppTokens.background, 1.0]
        ]
      })

      // ---------- Floating Action Button ----------
      Button() {
        Text('+')
          .fontSize(AppTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSecondary)
      }
      .type(ButtonType.Normal)
      .width(AppTokens.fabSize)
      .height(AppTokens.fabSize)
      .borderRadius(AppTokens.fabRadius)
      .backgroundColor(AppTokens.secondary)
      .margin({
        right: AppTokens.fabTrailingMargin,
        bottom: AppTokens.fabBottomMargin + AppTokens.bottomAppBarHeight
      })
      .shadow({
        radius: AppTokens.elevation2Radius,
        color: AppTokens.elevation2Color,
        offsetX: 0,
        offsetY: AppTokens.elevation2Dy
      })
      .onClick(() => {
        // TODO: FAB action
      })

      // ---------- Bottom Navigation Bar ----------
      BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)     // Scaffold containerColor
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

/* ============================================================
 * LiveItemCard
 * ============================================================ */
@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem(0, '', 0, '');

  build() {
    Column({ space: AppTokens.spaceSm }) {
      // 占位图片区域
      Column() {}
      .width('100%')
      .height(160)
      .backgroundColor(AppTokens.secondary)
      .borderRadius(AppTokens.radiusMedium)

      Text(this.item.title)
        .fontSize(AppTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text(`${formatViewers(this.item.viewers)} viewers`)
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.tertiary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)

        Blank()

        Button() {
          Text('Join Live')
            .fontSize(AppTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onPrimary)
        }
        .type(ButtonType.Normal)
        .borderRadius(AppTokens.radiusMedium)
        .backgroundColor(AppTokens.primary)
        .padding({
          top: AppTokens.buttonVerticalPadding,
          bottom: AppTokens.buttonVerticalPadding,
          left: AppTokens.buttonHorizontalPadding,
          right: AppTokens.buttonHorizontalPadding
        })
        .onClick(() => {
          // TODO: join live action
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.spaceLg)                 // Card 内部填充
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)        // Card 圆角
    .shadow({
      radius: AppTokens.elevation1Radius,
      color: AppTokens.elevation1Color,
      offsetX: 0,
      offsetY: AppTokens.elevation1Dy
    })
  }
}

/* ============================================================
 * BottomNavBar
 * ============================================================ */
@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.primary)
        .textAlign(TextAlign.Center)

      Text('Live')
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)

      Text('Cart')
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(AppTokens.bottomAppBarHeight)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.surface)
    .shadow({
      radius: 0.5,
      color: AppTokens.bottomAppBarShadow,
      offsetX: 0,
      offsetY: -1
    })
  }
}