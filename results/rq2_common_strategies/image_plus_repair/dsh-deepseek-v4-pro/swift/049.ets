// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于集中管理应用的颜色、字体、形状、间距和阴影。
// 这种结构使得样式修改更加方便和统一。

// AppTokens.Colors -> AppColors
class AppColors {
  // Kotlin Color(0xFFFF7043) -> ArkTS '#FFFF7043'
  static readonly primary: string = '#FFFF7043'
  static readonly secondary: string = '#FFFFB74D'
  static readonly tertiary: string = '#FFFFD180'
  static readonly background: string = '#FFFFF8F2'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFFFE0B2'
  static readonly outline: string = '#FFD7CCC8'
  static readonly success: string = '#FF43A047'
  static readonly warning: string = '#FFFFB300'
  static readonly error: string = '#FFE53935'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF3E2723'
  static readonly onTertiary: string = '#FF3E2723'
  static readonly onBackground: string = '#FF3E2723'
  static readonly onSurface: string = '#FF3E2723'
}

// AppTokens.TypographyTokens -> AppTypography
class AppTypography {
  // Kotlin sp 单位直接映射为 ArkTS 的 fp (number)
  static readonly display: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly title: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly body: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Normal // Kotlin's FontWeight.Normal 对应 ArkUI 的 FontWeight.Normal
  static readonly label: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

// AppTokens.Shapes -> AppShapes
class AppShapes {
  // Kotlin Dp 单位直接映射为 ArkTS 的 number (vp)
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
}

// AppTokens.Spacing -> AppSpacing
class AppSpacing {
  // Kotlin Dp 单位直接映射为 ArkTS 的 number (vp)
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

// 阴影规范，用于精确映射 Kotlin 的 ShadowSpec
class AppShadowSpec {
  elevation: number // Kotlin 中的 elevation，在 ArkUI 中通常通过 radius 和 y 偏移来模拟
  radius: number    // 阴影的模糊半径
  dy: number        // 阴影的 Y 轴偏移
  opacity: number   // 阴影颜色的不透明度

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }

  get shadowColor(): string {
    const alpha: number = Math.round(this.opacity * 255)
    let hex: string = alpha.toString(16).toUpperCase()
    if (hex.length < 2) {
      hex = '0' + hex
    }
    return '#' + hex + '000000'
  }
}

// AppTokens.ElevationMapping -> AppElevation
class AppElevation {
  static readonly level1: AppShadowSpec = new AppShadowSpec(2, 4, 2, 0.1)
  static readonly level2: AppShadowSpec = new AppShadowSpec(6, 8, 4, 0.15)
  static readonly level3: AppShadowSpec = new AppShadowSpec(10, 12, 6, 0.18)
}

// AppTokens.gridItemMinSize -> 最小项宽度，对应 Kotlin 的 GridCells.Adaptive(160.dp)
class AppTokens {
  static readonly gridItemMinSize: number = 160
}

// MARK: - Data Model
// 翻译自 Kotlin 的 TripCard 数据类
class TripCard {
  id: number
  title: string
  days: number
  price: string

  constructor(id: number, title: string, days: number, price: string) {
    this.id = id
    this.title = title
    this.days = days
    this.price = price
  }
}

// MARK: - TripCardView
// 辅助视图，用于渲染单个行程卡片，保持 RootScreen 的整洁。
// 对应 Kotlin 代码中的 Card Composable。
@Component
struct TripCardView {
  trip: TripCard = new TripCard(0, '', 0, '')

  build() {
    Column({ space: AppSpacing.sm }) {
      // 图像占位符 Box，对应 Kotlin 中的 Box with background and shape
      Row()
        .width('100%') // 对应 Modifier.fillMaxWidth()
        .height(100)   // 对应 Modifier.height(100.dp)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.trip.title)
        .fontSize(AppTypography.title)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)

      Text(`${this.trip.days} days`)
        .fontSize(AppTypography.body)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor('#B33E2723') // 对应 .copy(alpha = 0.7f)，即 onSurface.opacity(0.7)

      Row() { // 对应 Kotlin 的 Row
        Text(this.trip.price)
          .fontSize(AppTypography.title)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)

        Blank() // 对应 Kotlin 的 Arrangement.SpaceBetween

        Button('Details')
          .fontSize(AppTypography.label)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onPrimary)
          // 按钮内部填充，为了原子级对应 Kotlin 按钮的视觉效果
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .backgroundColor(AppColors.primary) // 对应 ButtonDefaults.buttonColors(containerColor = ...)
          .borderRadius(AppShapes.medium) // 对应 shape = AppTokens.Shapes.medium
          .height(36) // 对应 Modifier.height(36.dp)
          .onClick(() => {
            // 按钮点击事件，此处仅打印日志
            console.log('Details for ' + this.trip.title)
          })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.md) // 卡片内容的内部填充，对应 Column 的 padding
    .backgroundColor(AppColors.surface) // 卡片背景色，对应 CardDefaults.cardColors
    .borderRadius(AppShapes.large) // 卡片圆角，对应 shape = AppTokens.Shapes.large
    .shadow({ // 对应 CardDefaults.cardElevation
      radius: AppElevation.level2.radius,
      color: AppElevation.level2.shadowColor,
      offsetX: 0, // Kotlin 的 elevation 通常只影响 Y 轴偏移，X 轴默认为 0
      offsetY: AppElevation.level2.dy
    })
  }
}

// MARK: - RootScreen
// 翻译自 Kotlin 的 RootScreen Composable，是应用的主要 UI 布局。
@Component
struct RootScreen {
  // 数据列表，对应 Kotlin 中的 remember { listOf(...) }
  trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ]

  build() {
    // 对应 Kotlin 的 Scaffold，背景渐变覆盖整个屏幕，内容在 Column 中布局。
    Column({ space: AppSpacing.md }) { // 对应 Kotlin Column 的 verticalArrangement
      Text('Itinerary Planner')
        .fontSize(AppTypography.display)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.primary)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg }) // 标题的水平填充，与整体内容对齐

      Scroll() { // 对应 Kotlin 的 LazyVerticalGrid 外层的可滚动区域
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr') // 对应 GridCells.Adaptive(minimum = 160.dp) 的双列近似
        .columnsGap(AppSpacing.lg) // 对应 horizontalArrangement
        .rowsGap(AppSpacing.lg) // 对应 verticalArrangement
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.xxl }) // Grid 的水平填充与底部填充
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.TopStart)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .linearGradient({ // 对应 Brush.verticalGradient
      angle: 180,
      colors: [
        ['#4DFFB74D', 0.0], // AppTokens.Colors.secondary.opacity(0.3) 对应 .copy(alpha = 0.3f)
        ['#FFFFF8F2', 0.5], // AppTokens.Colors.background
        ['#4DFF7043', 1.0]  // AppTokens.Colors.primary.opacity(0.3) 对应 .copy(alpha = 0.3f)
      ]
    })
    // Kotlin Column 的 Modifier.padding(AppTokens.Spacing.lg) 被分解为
    // 标题和 Scroll 的水平填充，以及 Column 的垂直 spacing，
    // 确保视觉效果一致。
  }
}

// MARK: - App Entry Point
// 翻译自 Kotlin 的 MainActivity 和 AppTheme，作为 HarmonyOS 应用的入口。
// SwiftUI 的 @main struct ItineraryPlannerApp: App 对应 ArkUI 的 @Entry 组件。
@Entry
@Component
struct ContentView {
  build() {
    // SwiftUI 的 .ignoresSafeArea() 和 .statusBarHidden(true)
    // 对应 ArkUI 中 Window 的全屏/沉浸式配置（在窗口层处理）。
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Preview
// 翻译自 Kotlin 的 PreviewRoot Composable，用于 Xcode 预览。
// ArkUI 无 PreviewProvider，此部分仅作为说明注释保留。
