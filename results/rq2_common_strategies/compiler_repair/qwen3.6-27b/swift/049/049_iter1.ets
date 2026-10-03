import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于集中管理应用的颜色、字体、形状、间距和阴影。
// 这种结构使得样式修改更加方便和统一。

export class AppTokens {
  static Colors = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    tertiary: '#FFD180',
    background: '#FFF8F2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    outline: '#D7CCC8',
    success: '#43A047',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onTertiary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  // 阴影规范，用于精确映射 Kotlin 的 ShadowSpec
  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };

  // LazyVGrid 的最小项宽度，对应 Kotlin 的 GridCells.Adaptive(160.dp)
  static gridItemMinSize: number = 160;
}

// MARK: - Data Model
// 翻译自 Kotlin 的 TripCard 数据类

export interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

// MARK: - TripCardView
// 辅助视图，用于渲染单个行程卡片，保持 RootScreen 的整洁。
// 对应 Kotlin 代码中的 Card Composable。

@Component
struct TripCardView {
  private trip: TripCard = {} as TripCard;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 图像占位符 Box，对应 Kotlin 中的 Box with background and shape
      Rectangle()
        .fill(Color(AppTokens.Colors.surfaceVariant))
        .width('100%')
        .height(100)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.trip.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text('Details')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .onClick(() => {
          console.info(`Details for ${this.trip.title}`);
        })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(36)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: Color.Black.withOpacity(AppTokens.ElevationMapping.level2.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

// MARK: - RootScreen
// 翻译自 Kotlin 的 RootScreen Composable，是应用的主要 UI 布局。

@Component
struct RootScreen {
  // 数据列表，对应 Kotlin 中的 remember { listOf(...) }
  private trips: TripCard[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Itinerary Planner")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Scroll() {
        GridContainer({ columnsTemplate: '1fr 1fr' }) {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          })
        }
        .hGap(AppTokens.Spacing.lg)
        .vGap(AppTokens.Spacing.lg)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.3],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.3]
      ]
    })
  }
}

// MARK: - App Entry Point
// 翻译自 Kotlin 的 MainActivity 和 AppTheme，作为 SwiftUI 应用的入口。

@Entry
@Component
struct ItineraryPlannerApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}