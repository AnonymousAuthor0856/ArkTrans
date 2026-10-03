// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状和间距。
// 这些常量在整个应用中提供一致的UI样式。
// 说明：ArkUI 直接使用十六进制颜色字符串，因此无需 SwiftUI 的 Color(hex:) 扩展。

class AppTokensColors {
  static readonly primary: string = '#111827'
  static readonly secondary: string = '#374151'
  static readonly tertiary: string = '#6B7280'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#111827'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
}

// 字体令牌（对应 SwiftUI 的 Font.system(size:weight:)）。
// 用 { size, weight } 描述，weight 采用数值（400=regular, 500=medium, 600=semibold, 700=bold）。
interface FontToken {
  size: number
  weight: number
}

class AppTokensTypography {
  static readonly display: FontToken = { size: 28, weight: 700 }
  static readonly headline: FontToken = { size: 20, weight: 600 }
  static readonly title: FontToken = { size: 16, weight: 500 }
  static readonly body: FontToken = { size: 14, weight: 400 }
  static readonly label: FontToken = { size: 12, weight: 500 }
}

class AppTokensShapes {
  // Compose的RoundedCornerShape(X.dp)被翻译为SwiftUI的CGFloat圆角值
  static readonly small: number = 8.0
  static readonly medium: number = 12.0
  static readonly large: number = 16.0
}

class AppTokensSpacing {
  // Compose的X.dp被翻译为SwiftUI的CGFloat间距值
  static readonly xs: number = 4.0
  static readonly sm: number = 8.0
  static readonly md: number = 12.0
  static readonly lg: number = 16.0
  static readonly xl: number = 24.0
  static readonly xxl: number = 36.0
}

// Kotlin中的ShadowSpec未在UI中直接使用，因此在ArkUI中无需直接翻译为结构体。

// MARK: - 数值范围限制辅助函数
// 对应 Swift 的 clamped(to:) 扩展与 Kotlin 的 .coerceAtMost(1f)
function clamp(value: number, lower: number, upper: number): number {
  return Math.min(Math.max(value, lower), upper)
}

// MARK: - RootScreen
// 对应Kotlin的RootScreen Composable，是应用的主界面。
@Component
struct RootScreen {
  // @State 对应 Compose 的 rememberPagerState，用于管理当前选中的Tab和Pager页面。
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private tabsController: TabsController = new TabsController()

  build() {
    Column({ space: 0 }) { // spacing: 0 对应 Compose 的 Column 默认无间距
      // 顶部标题区域，对应 Kotlin 中的 Box
      Text('Step Challenge')
        .fontSize(AppTokensTypography.display.size)
        .fontWeight(AppTokensTypography.display.weight)
        .fontColor(AppTokensColors.onBackground)
        .padding(AppTokensSpacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // 自定义 TabRow，模仿 Compose 的 TabRow 行为和样式。
      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: this.selectedTabIndex,
        onSelect: (index: number) => {
          this.selectedTabIndex = index
          this.tabsController.changeIndex(index)
        }
      })
        .width('100%')

      // HorizontalPager 对应 ArkUI 的 Tabs，并设置为分页样式。
      Tabs({ index: this.selectedTabIndex, controller: this.tabsController }) {
        TabContent() {
          OverviewPage()
        }
        TabContent() {
          RankingPage()
        }
        TabContent() {
          StatsPage()
        }
      }
      .layoutWeight(1) // 确保页面内容填充可用空间
      .barHeight(0) // 隐藏页面指示器（小圆点）
      .scrollable(true)
      .animationDuration(200)
      .onChange((index: number) => {
        this.selectedTabIndex = index
      })
      .backgroundColor(AppTokensColors.surface) // Pager内容区域的默认背景色
    }
    .width('100%')
    .height('100%')
    // 整个RootScreen的背景渐变，对应 Kotlin 中的 Brush.verticalGradient
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppTokensColors.surfaceVariant, 0.0], [AppTokensColors.surface, 1.0]]
    })
    // 忽略安全区域，实现全屏显示，对应 Android 的 WindowCompat.setDecorFitsSystemWindows(window, false)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - CustomTabRow
// 自定义 TabRow 组件，以精确匹配 Compose TabRow 的视觉和交互。
@Component
struct CustomTabRow {
  @Prop tabs: string[] = []
  @Prop selectedTabIndex: number = 0
  onSelect: (index: number) => void = () => {}

  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) { // 水平堆叠 Tab 按钮，无额外间距
        ForEach(this.tabs, (tab: string, index: number) => {
          Button(tab, { type: ButtonType.Normal })
            .fontSize(AppTokensTypography.title.size)
            .fontWeight(AppTokensTypography.title.weight)
            .fontColor(this.selectedTabIndex === index ? AppTokensColors.primary : AppTokensColors.onSurface)
            .padding({ top: AppTokensSpacing.md, bottom: AppTokensSpacing.md })
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.onSelect(index) // 点击 Tab 按钮时更新选中索引
            })
        }, (tab: string, index: number) => index.toString())
      }
      .width('100%')

      // 下划线指示器，用于显示当前选中的 Tab
      Row()
        .width((100 / this.tabs.length) + '%')
        .height(2)
        .backgroundColor(AppTokensColors.primary)
        // 根据 selectedTabIndex 计算下划线的偏移量
        .translate({ x: (this.selectedTabIndex * 100) + '%' })
        .animation({ duration: 200, curve: Curve.EaseInOut }) // 动画效果
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokensColors.surface) // TabRow 的背景色
  }
}

// MARK: - OverviewPage
// 对应 Kotlin 的 OverviewPage Composable。
@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokensSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokensTypography.headline.size)
        .fontWeight(AppTokensTypography.headline.weight)
        .fontColor(AppTokensColors.onSurface)

      Blank()
        .height(AppTokensSpacing.lg) // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))

      Button('Sync Device', { type: ButtonType.Normal })
        .fontSize(AppTokensTypography.title.size)
        .fontWeight(AppTokensTypography.title.weight)
        .fontColor(AppTokensColors.onPrimary)
        .width('60%') // 对应 Modifier.fillMaxWidth(0.6f).height(48.dp)
        .height(48)
        .backgroundColor(AppTokensColors.primary)
        .borderRadius(AppTokensShapes.large)
        .onClick(() => {
          // 处理 Sync Device 按钮点击事件
        })

      Blank() // 垂直居中内容
    }
    .padding(AppTokensSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - RankingPage
// 对应 Kotlin 的 RankingPage Composable。
@Component
struct RankingPage {
  build() {
    Column({ space: AppTokensSpacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (it: number) => { // 对应 repeat(5)
        Row() {
          Text('User ' + (it + 1))
            .fontColor(AppTokensColors.onSurface)
            .fontSize(AppTokensTypography.body.size)
            .fontWeight(AppTokensTypography.body.weight)

          Blank() // 将文本推向两端

          Text((9000 - it * 500) + ' steps')
            .fontColor(AppTokensColors.onSurface)
            .fontSize(AppTokensTypography.body.size)
            .fontWeight(AppTokensTypography.body.weight)
        }
        .width('100%')
        .padding(AppTokensSpacing.md)
        .backgroundColor(AppTokensColors.surfaceVariant)
        .borderRadius(AppTokensShapes.medium)
      }, (it: number) => it.toString())
    }
    .padding(AppTokensSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - StatsPage
// 对应 Kotlin 的 StatsPage Composable。
@Component
struct StatsPage {
  build() {
    Column({ space: AppTokensSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokensTypography.headline.size)
        .fontWeight(AppTokensTypography.headline.weight)
        .fontColor(AppTokensColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => { // 对应 repeat(7)
        Row() {
          Row()
            .width((clamp(0.3 + it * 0.1, 0, 1) * 100).toFixed(0) + '%')
            .height(20)
            .backgroundColor(AppTokensColors.primary)
            .borderRadius(AppTokensShapes.small)

          Blank()
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokensColors.surfaceVariant)
        .borderRadius(AppTokensShapes.small)
      }, (it: number) => it.toString())

      Blank() // 将内容推向顶部
    }
    .padding(AppTokensSpacing.lg)
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point
// ArkUI 应用的入口点，对应 Kotlin 的 MainActivity。
// 注：statusBarHidden(true) 在 ArkUI 中通过 window 系统栏属性配置，此处省略。
@Entry
@Component
struct StepChallengeApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
