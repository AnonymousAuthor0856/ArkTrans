// 本文件由 SwiftUI 源文件 048.swift 翻译为 ArkTS (HarmonyOS ArkUI)
// import SwiftUI  ->  使用 ArkUI 内置组件，无需显式导入

// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 包含应用的所有设计系统常量，便于统一管理和修改

// 颜色令牌（Swift 的 Color(red:green:blue:) -> ArkTS 十六进制颜色字符串）
class AppColors {
  static readonly primary: string = '#1E3A8A'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#F5F8FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E8EEFA'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0B1220'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

// 字体规范（Swift 的 Font.system(size:weight:) -> ArkTS 的 fontSize + fontWeight）
class FontSpec {
  size: number
  weight: FontWeight
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class TypographyTokens {
  static readonly display: FontSpec = new FontSpec(28, FontWeight.Bold)
  static readonly title: FontSpec = new FontSpec(18, FontWeight.Medium)
  // Kotlin's FontWeight.Normal 对应 Swift 的 .regular，这里对应 ArkTS 的 FontWeight.Normal
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Normal)
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium)
}

// 辅助结构体，用于封装圆角值
class RoundedCornerShape {
  cornerRadius: number
  constructor(cornerRadius: number) {
    this.cornerRadius = cornerRadius
  }
}

class ShapeTokens {
  static readonly small: RoundedCornerShape = new RoundedCornerShape(6)
  static readonly medium: RoundedCornerShape = new RoundedCornerShape(10)
  static readonly large: RoundedCornerShape = new RoundedCornerShape(16)
}

class SpacingTokens {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number // Kotlin's Float 对应 Swift 的 Double
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationTokens {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15)
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18)
}

// Material 3 默认尺寸/填充，用于精确匹配安卓行为
class MaterialTokens {
  static readonly bottomAppBarHeight: number = 80
  static readonly fabSize: number = 56
  static readonly buttonHorizontalPadding: number = 16 // Material3 FilledButton 默认水平填充
  static readonly buttonVerticalPadding: number = 8 // Material3 FilledButton 默认垂直填充
  static readonly fabBottomMargin: number = 16 // FAB 距离底部边缘的默认间距
  static readonly fabTrailingMargin: number = 16 // FAB 距离右侧边缘的默认间距
  static readonly lazyColumnContentBottomPadding: number = 96 // Kotlin LazyColumn 的 contentPadding
}

// MARK: - Data Model
// 列表数据模型，遵循 Identifiable 协议以便在 ForEach 中使用
interface LiveItem {
  id: number
  title: string
  viewers: number
  price: string
}

// MARK: - LiveItemCard View
@Component
struct LiveItemCard {
  item: LiveItem = { id: 0, title: '', viewers: 0, price: '' }

  build() {
    Column({ space: SpacingTokens.sm }) {
      // 占位图片区域
      Column() {}
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(ShapeTokens.medium.cornerRadius)

      Text(this.item.title)
        .fontSize(TypographyTokens.title.size)
        .fontWeight(TypographyTokens.title.weight)
        .fontColor(AppColors.onSurface)

      Text(`${this.item.viewers} viewers`)
        .fontSize(TypographyTokens.body.size)
        .fontWeight(TypographyTokens.body.weight)
        .fontColor(AppColors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(TypographyTokens.title.size)
          .fontWeight(TypographyTokens.title.weight)
          .fontColor(AppColors.primary)

        Blank() // 将价格和按钮推开

        Button() {
          Text('Join Live')
            .fontSize(TypographyTokens.label.size)
            .fontWeight(TypographyTokens.label.weight)
            .fontColor(AppColors.onPrimary)
            // 按钮内容填充，精确匹配 Material3 默认值
            .padding({
              top: MaterialTokens.buttonVerticalPadding,
              bottom: MaterialTokens.buttonVerticalPadding,
              left: MaterialTokens.buttonHorizontalPadding,
              right: MaterialTokens.buttonHorizontalPadding
            })
        }
        .type(ButtonType.Normal) // 移除默认胶囊按钮样式
        .backgroundColor(AppColors.primary)
        .borderRadius(ShapeTokens.medium.cornerRadius)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(SpacingTokens.lg) // Card 内部填充
    .backgroundColor(AppColors.surface)
    .borderRadius(ShapeTokens.large.cornerRadius) // Card 圆角
    .shadow({ // Card 阴影
      radius: ElevationTokens.level1.radius,
      color: `rgba(0, 0, 0, ${ElevationTokens.level1.opacity})`,
      offsetX: 0,
      offsetY: ElevationTokens.level1.dy
    })
  }
}

// MARK: - BottomNavBar View
@Component
struct BottomNavBar {
  build() {
    Row() { // 使用 spacing 0 配合 Blank 实现 SpaceBetween 效果
      Blank()
      Text('Home')
        .fontSize(TypographyTokens.body.size)
        .fontWeight(TypographyTokens.body.weight)
        .fontColor(AppColors.primary) // 主色
      Blank()
      Text('Live')
        .fontSize(TypographyTokens.body.size)
        .fontWeight(TypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Cart')
        .fontSize(TypographyTokens.body.size)
        .fontWeight(TypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(TypographyTokens.body.size)
        .fontWeight(TypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)
      Blank()
    }
    .width('100%')
    .height(MaterialTokens.bottomAppBarHeight) // 底部导航栏高度
    .backgroundColor(AppColors.surface) // 背景色
    .shadow({ // 底部导航栏的顶部阴影
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: -1
    })
  }
}

// MARK: - RootScreen View
@Component
struct RootScreen {
  liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ]

  build() {
    // Stack 用于模拟 Scaffold 的层叠布局：内容、FAB 和底部导航栏
    Stack() {
      // 主要内容区域，对应 Scaffold 的 content
      Column({ space: SpacingTokens.md }) {
        Text('Live Shop Events')
          .fontSize(TypographyTokens.display.size)
          .fontWeight(TypographyTokens.display.weight)
          .fontColor(AppColors.primary)

        Scroll() {
          Column({ space: SpacingTokens.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          // Kotlin LazyColumn 的 contentPadding 底部 96.dp，用于为 FAB 留出空间
          .padding({ bottom: MaterialTokens.lazyColumnContentBottomPadding })
        }
        .width('100%')
        .layoutWeight(1)
      }
      // 整个内容 Column 的外部填充，对应 Kotlin Modifier.padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .padding(SpacingTokens.lg)
      .width('100%')
      .height('100%')
      .linearGradient({ // 垂直渐变背景
        direction: GradientDirection.Bottom,
        colors: [[0xFFF5F8FF, 0.0], [0xFFE8EEFA, 0.5], [0xFFF5F8FF, 1.0]]
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 使内容延伸至屏幕边缘，实现全屏效果

      // 浮动操作按钮 (Floating Action Button)
      Column() { // 使用 Column + Blank 将 FAB 推到 Stack 的底部
        Blank()
        Row() { // 使用 Row + Blank 将 FAB 推到 Stack 的右侧
          Blank()
          Button() {
            Text('+')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(AppColors.onSecondary)
          }
          .type(ButtonType.Normal)
          .width(MaterialTokens.fabSize)
          .height(MaterialTokens.fabSize)
          .backgroundColor(AppColors.secondary)
          .borderRadius(MaterialTokens.fabSize / 2) // 圆形剪裁
          // FAB 距离右侧和底部边缘的间距，底部间距需要考虑底部导航栏的高度
          .margin({
            right: MaterialTokens.fabTrailingMargin,
            bottom: MaterialTokens.fabBottomMargin + MaterialTokens.bottomAppBarHeight
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // 底部导航栏 (Bottom Bar)
      Column() { // 使用 Column + Blank 将底部导航栏推到 Stack 的底部
        Blank()
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background) // Scaffold 的 containerColor
    // .statusBarHidden(true) -> 隐藏状态栏：在 ArkTS 中需通过 windowStage 设置，组件层无法直接隐藏状态栏
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct LiveShopApp {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
