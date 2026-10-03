// 翻译自 SwiftUI (052.swift) 到 ArkTS (HarmonyOS)
// 源文件使用 SwiftUI/UIKit；此处映射为 ArkUI 声明式组件。

// MARK: - AppTokens
// 翻译 AppTokens 对象到 ArkTS 类，包含静态属性
interface ColorTokens {
  primary: string
  secondary: string
  background: string
  surface: string
  outline: string
  onPrimary: string
  onSurface: string
}

interface TypographyTokens {
  display: number
  headline: number
  body: number
}

// 对应 SwiftUI 的 Shapes：radius + 圆角样式
class ShapeSpec {
  radius: number
  style: string = 'continuous' // 默认使用连续圆角，视觉上更平滑
  constructor(radius: number) {
    this.radius = radius
  }
}

interface ShapeTokens {
  small: ShapeSpec
  medium: ShapeSpec
  large: ShapeSpec
}

interface SpacingTokens {
  sm: number
  md: number
  lg: number
}

// Kotlin 的 ShadowSpec(elevation, radius, dy, opacity)
// elevation 在 Compose 中常与 blur radius 相关，这里 Kotlin 明确给出了 radius。
// 我们将 Kotlin 的 radius 映射到阴影的 blurRadius，dy 映射到 yOffset。
class ShadowSpec {
  blurRadius: number
  yOffset: number
  opacity: number
  constructor(blurRadius: number, yOffset: number, opacity: number) {
    this.blurRadius = blurRadius
    this.yOffset = yOffset
    this.opacity = opacity
  }
}

interface ElevationTokens {
  level1: ShadowSpec
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF111111',
    secondary: '#FF444444',
    background: '#FFF5F5F5',
    surface: '#FFFFFFFF',
    outline: '#FFCCCCCC',
    onPrimary: '#FFFFFFFF',
    onSurface: '#FF111111'
  }

  static readonly TypographyTokens: TypographyTokens = {
    display: 28,
    headline: 18,
    body: 14
  }

  static readonly Shapes: ShapeTokens = {
    small: new ShapeSpec(6),
    medium: new ShapeSpec(10),
    large: new ShapeSpec(14)
  }

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly ElevationMapping: ElevationTokens = {
    // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.1f)
    // 对应阴影: blurRadius: 4, yOffset: 2, opacity: 0.1
    level1: new ShadowSpec(4, 2, 0.1)
  }
}

// MARK: - CourseCard
@Component
struct CourseCard {
  courseNumber: number = 0

  build() {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Course ' + this.courseNumber)
            .fontSize(AppTokens.TypographyTokens.headline)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)

          // Kotlin 的 (5 + it) 对应 (5 + courseNumber - 1)，因为 courseNumber 是 1-indexed
          Text('Duration: ' + (5 + this.courseNumber - 1) + ' hrs')
            .fontSize(AppTokens.TypographyTokens.body)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)

        Blank() // Spacer 等效实现：占据剩余空间，实现左右两端对齐

        // Box (按钮样式) 等效实现：Text 结合背景和胶囊形状裁剪
        Text('View')
          .fontSize(AppTokens.TypographyTokens.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 12, right: 12 })
          .height(24)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12) // 胶囊形裁剪，模拟 CircleShape
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding(AppTokens.Spacing.md)
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium.radius)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: '#1A000000', // 黑色带 0.1 透明度 (level1.opacity)
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.yOffset
    })
    .width('100%')
  }
}

// MARK: - CourseList
@Component
struct CourseList {
  title: string = ''
  count: number = 0

  private indices(): number[] {
    const result: number[] = []
    for (let i = 0; i < this.count; i++) {
      result.push(i)
    }
    return result
  }

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .fontSize(AppTokens.TypographyTokens.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)

        ForEach(this.indices(), (index: number) => {
          CourseCard({ courseNumber: index + 1 })
        }, (index: number) => index.toString())
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - CustomTabRow
@Component
struct CustomTabRow {
  tabs: string[] = []
  @Link selectedTabIndex: number

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column({ space: 0 }) {
          Text(tab)
            .fontSize(this.selectedTabIndex === index ? AppTokens.TypographyTokens.headline : AppTokens.TypographyTokens.body)
            .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .textAlign(TextAlign.Center)

          if (this.selectedTabIndex === index) {
            Rect()
              .fill(AppTokens.Colors.primary)
              .width('100%')
              .height(2)
          } else {
            // 占位符，保持未选中标签的布局一致性
            Rect()
              .fill(Color.Transparent)
              .width('100%')
              .height(2)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTabIndex = index
        })
      }, (tab: string, index: number) => index.toString())
    }
    .width('100%')
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  @State selectedTabIndex: number = 0

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small.radius)

        // HorizontalPager 的等效实现：使用 Swiper 实现水平分页
        Swiper() {
          CourseList({ title: 'All Courses', count: 6 })
          CourseList({ title: 'Enrolled', count: 3 })
          CourseList({ title: 'Completed', count: 4 })
        }
        .index(this.selectedTabIndex)
        .indicator(false)
        .loop(false)
        .curve(Curve.EaseInOut)
        .duration(300)
        .onChange((index: number) => {
          this.selectedTabIndex = index
        })
        .layoutWeight(1)
        .width('100%')
      }
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .width('100%')
      .height('100%')
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App 入口点
// 这是 ArkTS 应用程序的入口组件。
// SwiftUI 中通过 UIViewControllerRepresentable 隐藏状态栏的逻辑，
// 在 ArkTS 中由系统栏属性 / expandSafeArea 控制，此处省略 UIKit 相关代码。
@Entry
@Component
struct CourseCatalogApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 预览
// SwiftUI 的 PreviewProvider 在 ArkTS 中无对应概念，此处省略。
