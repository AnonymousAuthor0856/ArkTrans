// 该文件由 SwiftUI 源码翻译为 ArkTS（HarmonyOS ArkUI 声明式语法）。

// MARK: - AppTokens
// 集中管理所有设计令牌，方便原子级修改和保持双平台一致性。

// 使用 hex 字符串初始化颜色，确保颜色精确对应（ArkUI 使用 #AARRGGBB，等价于 SwiftUI 的 Color(hex:)）
class AppTokensColors {
  static primary: string = '#FF007BFF'
  static secondary: string = '#FF6C757D'
  static tertiary: string = '#FF17A2B8'
  static background: string = '#FFF8F9FA'
  static surface: string = '#FFFFFFFF'
  static surfaceVariant: string = '#FFE9ECEF'
  static outline: string = '#FFDEE2E6'
  static success: string = '#FF28A745'
  static warning: string = '#FFFFC107'
  static error: string = '#FFDC3545'
  static onPrimary: string = '#FFFFFFFF'
  static onSecondary: string = '#FFFFFFFF'
  static onTertiary: string = '#FFFFFFFF'
  static onBackground: string = '#FF212529'
  static onSurface: string = '#FF212529'
}

// 字体规格：字号 + 字重（数字 100-900，对应 SwiftUI 的 Font.Weight）
class AppTypographySpec {
  size: number
  weight: number
  constructor(size: number, weight: number) {
    this.size = size
    this.weight = weight
  }
}

class AppTokensTypography {
  // 字体大小和字重与 Compose 对应
  static display: AppTypographySpec = new AppTypographySpec(36, 700)   // .bold
  static headline: AppTypographySpec = new AppTypographySpec(28, 600)  // .semibold
  static title: AppTypographySpec = new AppTypographySpec(22, 500)     // .medium
  static body: AppTypographySpec = new AppTypographySpec(16, 400)      // .regular（对应 Compose 的 FontWeight.Normal）
  static label: AppTypographySpec = new AppTypographySpec(14, 500)     // .medium
}

class AppTokensShapes {
  // 圆角半径
  static small: number = 4
  static medium: number = 8
  static large: number = 12
}

class AppTokensSpacing {
  // 间距值（vp，直接从 Dp 转换）
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
}

// 阴影规范，用于精确匹配 Compose 的 elevation
class ShadowSpec {
  elevation: number // 对应 Compose 的 elevation，用于计算阴影强度
  radius: number    // 阴影模糊半径
  dy: number        // Y 轴偏移
  opacity: number   // 阴影不透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppTokensElevationMapping {
  static level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.1)
  static level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.1)
  static level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.1)
}

// MARK: - Data Models
// 对应 Kotlin 的 ClipboardItem 数据类
class ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number
  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id
    this.content = content
    this.type = type
    this.timestamp = timestamp
    this.progress = progress
  }
}

// MARK: - CustomLinearProgressView
// 自定义 ProgressViewStyle，以匹配 Compose 的 LinearProgressIndicator 的 trackColor
@Component
struct CustomLinearProgressView {
  @Prop fraction: number = 0
  tint: string = '#FF17A2B8' // 进度条颜色
  track: string = '#FFE9ECEF' // 轨道颜色

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 轨道背景
      Row()
        .width('100%')
        .height(4)
        .borderRadius(AppTokensShapes.small)
        .backgroundColor(this.track)

      // 进度条
      Row()
        .width((this.fraction * 100).toString() + '%')
        .height(4)
        .borderRadius(AppTokensShapes.small)
        .backgroundColor(this.tint)
    }
    .width('100%')
    .height(4) // 确保整个 ProgressView 的高度
  }
}

// MARK: - ClipboardCard
// 对应 Kotlin 的 ClipboardCard Composable
@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0)

  build() {
    Column({ space: 0 }) {
      Row({ space: AppTokensSpacing.sm }) {
        // 模拟 Box + clip + background
        Column()
          .width(24)
          .height(24)
          .borderRadius(AppTokensShapes.small)
          .backgroundColor(AppTokensColors.primary)

        Text(this.item.type)
          .fontSize(AppTokensTypography.label.size)
          .fontColor(AppTokensColors.primary)
          .fontWeight(700) // .bold

        Blank() // 模拟 Modifier.weight(1f)

        Text(this.item.timestamp)
          .fontSize(AppTokensTypography.label.size)
          .fontWeight(AppTokensTypography.label.weight)
          .fontColor(AppTokensColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: AppTokensSpacing.sm }) // 模拟 Spacer height

      Text(this.item.content)
        .fontSize(AppTokensTypography.body.size)
        .fontWeight(AppTokensTypography.body.weight)
        .fontColor(AppTokensColors.onSurface)
        .maxLines(2) // 模拟 maxLines
        .textOverflow({ overflow: TextOverflow.Ellipsis }) // 模拟 TextOverflow.Ellipsis
        .padding({ bottom: AppTokensSpacing.md }) // 模拟 Spacer height

      // 线性进度指示器，使用自定义样式以匹配 Compose 的 trackColor
      CustomLinearProgressView({
        fraction: this.item.progress,
        tint: AppTokensColors.tertiary,
        track: AppTokensColors.surfaceVariant
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokensSpacing.md) // 内边距
    .backgroundColor(AppTokensColors.surface) // 背景色
    .borderRadius(AppTokensShapes.large) // 圆角
    .border({ width: 1, color: AppTokensColors.surfaceVariant }) // 边框，模拟 BorderStroke
    // 阴影，模拟 elevation
    .shadow({ radius: AppTokensElevationMapping.level1.radius, color: '#1A000000', offsetX: 0, offsetY: AppTokensElevationMapping.level1.dy })
  }
}

// MARK: - SettingsPane
// 对应 Kotlin 的 SettingsPane Composable
@Component
struct SettingsPane {
  @Link sliderValue: number // 绑定滑块值

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokensTypography.label.size)
          .fontWeight(AppTokensTypography.label.weight)
          .fontColor(AppTokensColors.onSurface)
        Blank()
        Text(Math.round(this.sliderValue).toString()) // 显示整数值
          .fontSize(AppTokensTypography.body.size)
          .fontWeight(600) // .semibold
          .fontColor(AppTokensColors.onSurface)
      }
      .width('100%')
      .padding({ bottom: AppTokensSpacing.sm }) // 垂直间距

      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
        .selectedColor(AppTokensColors.primary) // 对应 .tint / .accentColor
        .width('100%')
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokensSpacing.lg) // 内边距
  }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable；@Entry 同时作为应用入口（对应 SwiftUI 的 @main + WindowGroup）
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24.0

  // 模拟 Compose 中的 remember { listOf(...) }
  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ]

  build() {
    Column() {
      // 自定义顶部栏，模拟 CenterAlignedTopAppBar
      Row() {
        Blank().layoutWeight(1) // 用于居中标题
        Text('Clipboard History')
          .fontSize(AppTokensTypography.title.size)
          .fontWeight(AppTokensTypography.title.weight)
          .fontColor(AppTokensColors.onBackground)
        Blank().layoutWeight(1) // 用于居中标题
        Text('Clear')
          .fontSize(AppTokensTypography.label.size)
          .fontWeight(AppTokensTypography.label.weight)
          .fontColor(AppTokensColors.onSurface)
          .padding({ top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm, left: AppTokensSpacing.md, right: AppTokensSpacing.md })
          .backgroundColor(AppTokensColors.surfaceVariant)
          .borderRadius(AppTokensShapes.medium)
          .onClick(() => {
            // 处理 Clear 按钮点击事件
            console.info('Clear button tapped')
          })
          .margin({ right: AppTokensSpacing.md }) // 按钮右侧间距
      }
      .width('100%')
      .height(56)
      .padding({ top: 24 }) // 顶部内边距，避开状态栏（对应 geometry.safeAreaInsets.top）
      .backgroundColor(AppTokensColors.surface)
      // 顶部栏阴影，模拟 elevation
      .shadow({ radius: 0.5, color: '#0D000000', offsetX: 0, offsetY: 0.5 })

      // 内容区域，模拟 LazyColumn
      Scroll() {
        Column({ space: AppTokensSpacing.md }) { // 垂直间距
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.md, bottom: AppTokensSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokensColors.background) // 滚动区域背景色

      // 设置面板
      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppTokensColors.surface)
        // 设置面板阴影，模拟 elevation（阴影向上）
        .shadow({ radius: AppTokensElevationMapping.level2.radius, color: '#1A000000', offsetX: 0, offsetY: -AppTokensElevationMapping.level2.dy })
    }
    .width('100%')
    .height('100%')
    // 忽略安全区域，使内容延伸到屏幕边缘，包括状态栏下方
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .backgroundColor(AppTokensColors.background) // 整个屏幕的背景色
  }
}
