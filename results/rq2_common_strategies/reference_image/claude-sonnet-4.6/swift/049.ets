// ============================================================
// AppTokens.ets  —— 集中管理颜色 / 字体 / 圆角 / 间距 / 阴影
// ============================================================

export class AppColors {
  // 品牌色（Kotlin Color(0xFFFF7043) 等值映射）
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly tertiary: string = '#FFD180';

  // 容器色
  static readonly background: string = '#FFF8F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE0B2';
  static readonly outline: string = '#D7CCC8';

  // 语义色
  static readonly success: string = '#43A047';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';

  // 前景色
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onTertiary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
  // onSurface.copy(alpha = 0.7f) 预算结果（AARRGGBB）
  static readonly onSurface70: string = '#B33E2723';

  // primary.copy(alpha = 0.3f) / secondary.copy(alpha = 0.3f) 预算结果
  static readonly primary30: string = '#4DFF7043';
  static readonly secondary30: string = '#4DFFB74D';
}

export class AppFont {
  // Kotlin sp -> ArkTS 的 fontSize(vp)
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

export class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 20;
}

export class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

/** 阴影规格，对应 Kotlin 的 ShadowSpec */
export class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: string;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    // opacity -> 8 位 AARRGGBB 的 alpha 通道
    const alpha: number = Math.round(opacity * 255);
    const hex: string = alpha.toString(16).toUpperCase().padStart(2, '0');
    this.color = '#' + hex + '000000';
  }
}

export class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

/** 对应 GridCells.Adaptive(160.dp) */
export const GRID_ITEM_MIN_SIZE: number = 160;


// ============================================================
// TripCardModel.ets —— 数据模型，对应 Kotlin 的 TripCard data class
// ============================================================

export interface TripCardData {
  id: number;
  title: string;
  days: number;
  price: string;
}


// ============================================================
// TripCardView.ets —— 单个行程卡片，对应 Kotlin 的 Card Composable
// ============================================================

import { AppColors, AppFont, AppShapes, AppSpacing, ElevationMapping } from './AppTokens';
import { TripCardData } from './TripCardModel';

@Builder
export function TripCardView(trip: TripCardData) {
  Column({ space: AppSpacing.sm }) {
    // 图像占位 Box（Kotlin: Box + background + shape）
    Row()
      .width('100%')
      .height(100)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

    Text(trip.title)
      .fontSize(AppFont.title)
      .fontWeight(AppFont.titleWeight)
      .fontColor(AppColors.onSurface)
      .lineHeight(AppFont.title + 6)
      .maxLines(2)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .width('100%')
      .textAlign(TextAlign.Start)

    Text(`${trip.days} days`)
      .fontSize(AppFont.body)
      .fontWeight(AppFont.bodyWeight)
      .fontColor(AppColors.onSurface70)
      .width('100%')
      .textAlign(TextAlign.Start)

    // Kotlin 的 Row + Arrangement.SpaceBetween
    Row() {
      Text(trip.price)
        .fontSize(AppFont.title)
        .fontWeight(AppFont.titleWeight)
        .fontColor(AppColors.primary)

      Blank()

      Button() {
        Text('Details')
          .fontSize(AppFont.label)
          .fontWeight(AppFont.labelWeight)
          .fontColor(AppColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .height(36)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: 0, bottom: 0 })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)      // 对应 ButtonDefaults.shape
      .onClick(() => {
        console.info(`Details for ${trip.title}`);
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
  .alignItems(HorizontalAlign.Start)
  .width('100%')
  .padding(AppSpacing.md)                                   // Card 内容内边距
  .backgroundColor(AppColors.surface)                       // CardDefaults.cardColors
  .borderRadius(AppShapes.large)                            // shape = AppTokens.Shapes.large
  .shadow({
    radius: ElevationMapping.level2.radius,
    color: ElevationMapping.level2.color,
    offsetX: 0,
    offsetY: ElevationMapping.level2.dy
  })
}


// ============================================================
// RootScreen.ets —— 主界面，对应 Kotlin 的 RootScreen Composable
// ============================================================

import { AppColors, AppFont, AppSpacing, GRID_ITEM_MIN_SIZE } from './AppTokens';
import { TripCardData } from './TripCardModel';
import { TripCardView } from './TripCardView';

@Entry
@Component
struct RootScreen {
  // 对应 remember { listOf(...) }
  @State private trips: TripCardData[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ];

  build() {
    // 对应 Scaffold + Column
    Column() {
      Text('Itinerary Planner')
        .fontSize(AppFont.display)
        .fontWeight(AppFont.displayWeight)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: AppSpacing.md
        })

      // 对应 LazyVerticalGrid(columns = GridCells.Adaptive(160.dp))
      Grid() {
        ForEach(this.trips, (trip: TripCardData) => {
          GridItem() {
            TripCardView(trip)
          }
        }, (trip: TripCardData) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')          // 自适应最小宽度 160vp 在手机上等价于两列
      .columnsGap(AppSpacing.lg)           // horizontalArrangement
      .rowsGap(AppSpacing.lg)              // verticalArrangement
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.xxl          // contentPadding = PaddingValues(bottom = 36.dp)
      })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    // 对应 Brush.verticalGradient
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondary30, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primary30, 1.0]
      ]
    })
    // 对应 fillMaxSize + setDecorFitsSystemWindows(false) / hide(systemBars)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}


// ============================================================
// EntryAbility.ets（在 module.json5 之外需要隐藏状态栏时使用）
// 在 onWindowStageCreate 中调用：
//
//   windowStage.getMainWindow((err, win) => {
//     win.setWindowLayoutFullScreen(true);
//     win.setWindowSystemBarEnable([]);
//   });
//
// 对应 SwiftUI 的 .ignoresSafeArea() + .statusBarHidden(true)
// ============================================================