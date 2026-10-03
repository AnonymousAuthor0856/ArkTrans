// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、形状、间距和阴影。

class FontToken {
  size: number
  weight: FontWeight
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class ShadowSpec {
  elevation: number // 阴影扩散程度，在 ArkUI 中通常与 radius 结合
  radius: number    // 阴影模糊半径
  dy: number        // 阴影 Y 轴偏移
  opacity: number   // 阴影不透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppColors {
  // 将 Kotlin 的 Color(0xFF...) 转换为 ArkUI 的十六进制颜色字符串
  readonly primary: string = '#111827' // 0xFF111827
  readonly secondary: string = '#374151' // 0xFF374151
  readonly tertiary: string = '#6B7280' // 0xFF6B7280
  readonly background: string = '#F9FAFB' // 0xFFF9FAFB
  readonly surface: string = '#FFFFFF' // 0xFFFFFFFF
  readonly surfaceVariant: string = '#E5E7EB' // 0xFFE5E7EB
  readonly outline: string = '#D1D5DB' // 0xFFD1D5DB
  readonly success: string = '#16A34A' // 0xFF16A34A
  readonly warning: string = '#F59E0B' // 0xFFF59E0B
  readonly error: string = '#EF4444' // 0xFFEF4444
  readonly onPrimary: string = '#FFFFFF' // 0xFFFFFFFF
  readonly onSecondary: string = '#FFFFFF' // 0xFFFFFFFF
  readonly onTertiary: string = '#111827' // 0xFF111827
  readonly onBackground: string = '#111827' // 0xFF111827
  readonly onSurface: string = '#1F2937' // 0xFF1F2937
}

class AppTypographyTokens {
  // Compose 的 sp 单位直接映射为 ArkUI 的 vp 字体大小
  readonly displayLarge: FontToken = new FontToken(28, FontWeight.Bold)
  readonly headlineMedium: FontToken = new FontToken(20, FontWeight.Medium) // .semibold 近似为 Medium
  readonly titleMedium: FontToken = new FontToken(16, FontWeight.Medium)
  readonly bodyMedium: FontToken = new FontToken(14, FontWeight.Regular)
  readonly labelMedium: FontToken = new FontToken(12, FontWeight.Medium)
}

class AppShapes {
  // Compose 的 dp 单位直接映射为 ArkUI 的 vp 圆角半径
  readonly small: number = 8.0
  readonly medium: number = 12.0
  readonly large: number = 16.0
}

class AppSpacing {
  // Compose 的 dp 单位直接映射为 ArkUI 的 vp 间距
  readonly xs: number = 4.0
  readonly sm: number = 8.0
  readonly md: number = 12.0
  readonly lg: number = 16.0
  readonly xl: number = 24.0
  readonly xxl: number = 36.0
}

class AppElevationMapping {
  // 阴影参数的映射
  readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14)
  readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16)
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors()
  static readonly TypographyTokens: AppTypographyTokens = new AppTypographyTokens()
  static readonly Shapes: AppShapes = new AppShapes()
  static readonly Spacing: AppSpacing = new AppSpacing()
  static readonly ElevationMapping: AppElevationMapping = new AppElevationMapping()
}

// MARK: - Data Model
// 翻译自 Kotlin 的 data class Medicine
class Medicine {
  id: number
  name: string
  time: string
  constructor(id: number, name: string, time: string) {
    this.id = id
    this.name = name
    this.time = time
  }
}

// 将黑色阴影的不透明度转换为带透明度的十六进制颜色（近似 Color.black.opacity）
function blackWithOpacity(opacity: number): string {
  let alpha: number = Math.round(opacity * 255)
  if (alpha < 0) {
    alpha = 0
  }
  if (alpha > 255) {
    alpha = 255
  }
  let hex: string = alpha.toString(16).toUpperCase()
  if (hex.length < 2) {
    hex = '0' + hex
  }
  return '#' + hex + '000000'
}

// MARK: - MedicineItem View
// 翻译自 Kotlin 的 @Composable fun MedicineItem
@Component
struct MedicineItem {
  medicine: Medicine = new Medicine(0, '', '')

  build() {
    Row() { // horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically
      Column({ space: AppTokens.Spacing.xs }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // 实现 Arrangement.SpaceBetween

      Circle({ width: 16, height: 16 }) // size(16.dp)
        .fill(AppTokens.Colors.primary)
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md) // padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface) // background(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium }) // border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
    .width('100%') // fillMaxWidth()
  }
}

// MARK: - MedicineList View
// 翻译自 Kotlin 的 @Composable fun MedicineList
@Component
struct MedicineList {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ]

  build() {
    // 使用 Scroll + Column 来精确控制间距和布局，类似于 LazyColumn with spacedBy
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ForEach(this.items, (m: Medicine) => {
          MedicineItem({ medicine: m })
        }, (m: Medicine) => m.id.toString())
      }
      .padding({ bottom: AppTokens.Spacing.xxl }) // contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen View
// 翻译自 Kotlin 的 @Composable fun RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    // Stack 用于将 FAB 和 BottomAppBar 叠加在主内容之上
    Stack({ alignContent: Alignment.BottomEnd }) { // 用于定位 FloatingActionButton
      Column() { // 主内容区域，模拟 Scaffold 的内容部分
        // 顶部区域，包含标题和列表，带有渐变背景
        Column({ space: AppTokens.Spacing.md }) { // 对应 Kotlin 的 Column
          Text('Medicine Reminder')
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)

          MedicineList()
            .layoutWeight(1)

          Button('Mark All Taken')
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48) // height(48.dp)
            .width('80%') // fillMaxWidth(0.8f) 的实现：宽度为父容器内容区域的 80%
            .backgroundColor(AppTokens.Colors.secondary) // containerColor
            .borderRadius(AppTokens.Shapes.large) // shape
            .margin({ bottom: AppTokens.Spacing.md }) // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            .onClick(() => {})
        }
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: 56 })
        .linearGradient({ // Brush.verticalGradient
          direction: GradientDirection.Bottom,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
        })
        .width('100%')
        .layoutWeight(1)
        .expandSafeArea([SafeAreaType.KEYBOARD], [SafeAreaEdge.BOTTOM]) // 防止键盘推出内容
      }
      .backgroundColor(AppTokens.Colors.background) // Scaffold 的 containerColor
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) // 内容延伸到状态栏区域

      // BottomAppBar
      Column() { // 使用 Column 配合 Blank 将 BottomAppBar 推到底部
        Blank()
        Row() { // horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically
          Text('Today')
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.primary) // primary color for selected item
          Blank()
          Text('History')
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg }) // padding(horizontal = AppTokens.Spacing.lg)
        .width('100%') // fillMaxWidth()
        .height(56) // BottomAppBar 默认高度
        .backgroundColor(AppTokens.Colors.surface) // containerColor
        .shadow({ // tonalElevation 转换为 shadow
          radius: AppTokens.ElevationMapping.level2.radius,
          color: blackWithOpacity(AppTokens.ElevationMapping.level2.opacity),
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM]) // BottomAppBar 延伸到屏幕底部边缘

      // FloatingActionButton
      Button('+')
        .fontSize(AppTokens.TypographyTokens.displayLarge.size)
        .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56) // 默认 FAB 大小
        .backgroundColor(AppTokens.Colors.primary) // containerColor
        .borderRadius(28) // shape = CircleShape
        .padding(AppTokens.Spacing.lg) // 定位 FAB，提供默认的间距
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    // statusBarHidden(true) 需通过窗口 API 设置，此处省略（隐藏状态栏，满足全屏显示要求）
  }
}

// MARK: - App Entry Point
// 应用程序的入口点，对应 SwiftUI 的 @main App；在 ArkUI 中 RootScreen 本身作为 @Entry 页面呈现。
