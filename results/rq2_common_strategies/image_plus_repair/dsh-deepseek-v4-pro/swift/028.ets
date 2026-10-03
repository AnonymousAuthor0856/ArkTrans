// 本文件由 SwiftUI 源码翻译为 ArkTS（HarmonyOS ArkUI）。
// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, Elevation)

// 应用程序的统一设计令牌，包括颜色、字体、形状、间距和阴影。

// 颜色令牌
class AppColors {
  static readonly primary: string = '#FF0F172A'
  static readonly secondary: string = '#FF475569'
  static readonly tertiary: string = '#FF94A3B8'
  static readonly background: string = '#FFF8FAFC'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF1F5F9'
  static readonly outline: string = '#FFE2E8F0'
  static readonly success: string = '#FF22C55E'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FF0F172A'
  static readonly onBackground: string = '#FF0F172A'
  static readonly onSurface: string = '#FF0F172A'
}

// 字体排版令牌
// 定义一个字体样式，包括字体、字号、行高和字间距。
class TypographyStyle {
  fontSize: number
  lineHeight: number
  letterSpacing: number
  fontWeight: number

  constructor(fontSize: number, lineHeight: number, letterSpacing: number, fontWeight: number) {
    this.fontSize = fontSize
    this.lineHeight = lineHeight
    this.letterSpacing = letterSpacing
    this.fontWeight = fontWeight
  }

  // 根据字号和行高计算额外行间距值。
  // Compose 的 lineHeight 是行框的总高度，SwiftUI 的 lineSpacing 是行之间的额外空间。
  get lineSpacingValue(): number {
    return Math.max(0, this.lineHeight - this.fontSize)
  }
}

class TypographyTokens {
  static readonly display: TypographyStyle = new TypographyStyle(32, 40, 0, 700)
  static readonly headline: TypographyStyle = new TypographyStyle(24, 32, 0, 600)
  static readonly title: TypographyStyle = new TypographyStyle(18, 24, 0.15, 500)
  static readonly body: TypographyStyle = new TypographyStyle(16, 22, 0.5, 400)
  static readonly label: TypographyStyle = new TypographyStyle(14, 18, 0.5, 500)
}

// 形状令牌，主要用于圆角半径。
class Shapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 12
  static readonly largeCornerRadius: number = 16
}

// 间距令牌
class Spacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

// 阴影规格，用于定义阴影的属性。
class ShadowSpec {
  elevation: number // 映射到阴影的 radius 和 y 偏移
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

// 阴影层级映射
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.10)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.10)
}

// MARK: - Data Models

// 生产力项目数据模型
class ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string

  constructor(id: number, title: string, status: string, progress: number, statusColor: string) {
    this.id = id
    this.title = title
    this.status = status
    this.progress = progress
    this.statusColor = statusColor
  }
}

// 图表数据模型
class ChartData {
  id: string
  label: string
  value: number

  constructor(label: string, value: number) {
    // SwiftUI 的 ForEach 需要 Identifiable；此处以唯一的 label 作为 id（Swift 中为 UUID()）
    this.id = label
    this.label = label
    this.value = value
  }
}

// MARK: - Custom Views / Components

// 自定义筛选芯片，模仿 Compose 的 FilterChip。
@Component
struct FilterChip {
  title: string = ''
  isSelected: boolean = false
  action: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.title)
        .fontSize(TypographyTokens.label.fontSize)
        .fontWeight(TypographyTokens.label.fontWeight)
        .letterSpacing(TypographyTokens.label.letterSpacing)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .onClick(() => {
      this.action()
    })
    .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(Shapes.smallCornerRadius)
    .border({ width: 1, color: AppColors.outline })
  }
}

// 自定义线性进度指示器，模仿 Compose 的 LinearProgressIndicator。
@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  color: string = ''
  trackColor: string = ''
  barHeight: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      Row()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .backgroundColor(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// MARK: - RootScreen (Main UI)

// 应用程序的主屏幕视图。
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'

  filters: string[] = ['Daily', 'Weekly', 'Monthly']
  productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ]

  chartData: ChartData[] = [
    new ChartData('Mon', 0.6), new ChartData('Tue', 0.8), new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0), new ChartData('Fri', 0.7), new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ]

  topBarHeight: number = 56 // 对应 Compose TopAppBar 的默认高度
  bottomBarButtonHeight: number = 56 // 底部按钮的高度
  bottomBarPadding: number = Spacing.md // 底部按钮的垂直内边距

  get bottomBarTotalHeight(): number {
    return this.bottomBarButtonHeight + this.bottomBarPadding * 2 // 按钮高度 + 上下内边距
  }

  build() {
    Column({ space: 0 }) { // 整体布局，模仿 Compose Scaffold
      // MARK: - Top Bar
      Row() {
        Button({ type: ButtonType.Normal }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .onClick(() => {})
        .padding({ left: Spacing.md }) // 对应 IconButton 的默认内边距

        Blank()

        Text('Productivity Check')
          .fontSize(TypographyTokens.headline.fontSize)
          .fontWeight(TypographyTokens.headline.fontWeight)
          .fontColor(AppColors.onSurface)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .onClick(() => {})
        .padding({ right: Spacing.md }) // 对应 IconButton 的默认内边距
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: ElevationMapping.level3.radius,
        color: `rgba(0, 0, 0, ${ElevationMapping.level3.opacity})`,
        offsetX: 0,
        offsetY: ElevationMapping.level3.dy
      })
      .zIndex(1) // 确保顶部栏在滚动内容之上

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: Spacing.lg }) { // 对应 LazyColumn 的 verticalArrangement
          // Filter Chips Row
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                action: () => {
                  this.selectedFilter = filter
                }
              })
              if (filter !== this.filters[this.filters.length - 1]) {
                Blank().width(Spacing.sm) // 对应 Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
              }
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({ left: Spacing.md, right: Spacing.md }) // 对应 LazyColumn 的 contentPadding

          // Weekly Throughput Card
          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(TypographyTokens.title.fontSize)
              .fontWeight(TypographyTokens.title.fontWeight)
              .fontColor(AppColors.onSurface)
              .padding({ bottom: Spacing.md }) // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.md))

            // Chart
            Column({ space: Spacing.sm }) {
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Row()
                      .width('60%') // 对应 fillMaxWidth(0.6f)
                      .height(150 * data.value) // 对应 fillMaxHeight(data.value)
                      .backgroundColor(AppColors.primary)
                      .borderRadius(Shapes.smallCornerRadius)
                  }
                  .height('100%')
                  .layoutWeight(1) // 对应 Modifier.weight(1f)
                  .justifyContent(FlexAlign.End)
                  .alignItems(HorizontalAlign.Center)
                }, (data: ChartData) => data.id)
              }
              .width('100%')
              .height(150) // 对应 .height(150.dp)
              .alignItems(VerticalAlign.Bottom)

              // Chart Labels
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(TypographyTokens.label.fontSize)
                    .fontWeight(TypographyTokens.label.fontWeight)
                    .fontColor(AppColors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1) // 对应 Modifier.weight(1f)
                }, (data: ChartData) => data.id)
              }
              .width('100%')
            }
            .width('100%')
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(Shapes.largeCornerRadius)
          .shadow({
            radius: ElevationMapping.level1.radius,
            color: `rgba(0, 0, 0, ${ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: ElevationMapping.level1.dy
          })
          .padding({ left: Spacing.md, right: Spacing.md }) // 对应 LazyColumn 的 contentPadding

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column({ space: 0 }) {
              Row() { // 对应 verticalAlignment = Alignment.CenterVertically
                Text(item.title)
                  .fontSize(TypographyTokens.title.fontSize)
                  .fontWeight(TypographyTokens.title.fontWeight)
                  .fontColor(AppColors.onSurface)

                Blank() // 对应 horizontalArrangement = Arrangement.SpaceBetween

                Row({ space: Spacing.sm }) {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.statusColor)

                  Text(item.status)
                    .fontSize(TypographyTokens.label.fontSize)
                    .fontWeight(TypographyTokens.label.fontWeight)
                    .fontColor(item.statusColor)
                }
              }
              .width('100%')
              .padding({ bottom: Spacing.md }) // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.md))

              Row({ space: Spacing.sm }) {
                CustomLinearProgressIndicator({
                  progress: item.progress,
                  color: item.statusColor,
                  trackColor: AppColors.surfaceVariant,
                  barHeight: 8
                })
                .layoutWeight(1) // 对应 Modifier.weight(1f)

                Text(`${Math.floor(item.progress * 100)}%`)
                  .fontSize(TypographyTokens.label.fontSize)
                  .fontWeight(TypographyTokens.label.fontWeight)
                  .fontColor(AppColors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40) // 对应 Modifier.width(40.dp)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(Shapes.mediumCornerRadius)
            .border({ width: 1, color: AppColors.outline })
            .padding({ left: Spacing.md, right: Spacing.md }) // 对应 LazyColumn 的 contentPadding
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({ top: Spacing.md, bottom: Spacing.md + this.bottomBarTotalHeight }) // 对应 LazyColumn 的 contentPadding；确保滚动内容不会被底部栏遮挡
      }
      .width('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background) // 滚动区域的背景色

      // MARK: - Bottom Bar
      Column() {
        Button({ type: ButtonType.Normal }) {
          Text('Submit New Form')
            .fontSize(TypographyTokens.title.fontSize)
            .fontWeight(TypographyTokens.title.fontWeight)
            .fontColor(AppColors.onPrimary)
        }
        .onClick(() => {})
        .width('100%')
        .height(this.bottomBarButtonHeight) // 对应 .height(56.dp)
        .backgroundColor(AppColors.primary)
        .borderRadius(Shapes.mediumCornerRadius)
        .padding(Spacing.md) // 对应 .padding(AppTokens.Spacing.md)
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: ElevationMapping.level3.radius,
        color: `rgba(0, 0, 0, ${ElevationMapping.level3.opacity})`,
        offsetX: 0,
        offsetY: ElevationMapping.level3.dy
      })
      .zIndex(1) // 确保底部栏在滚动内容之上
    }
    .width('100%')
    .height('100%')
    // MARK: - Fullscreen & Status Bar Hidden
    // 对应 SwiftUI 的 .ignoresSafeArea(.all, edges: .all) 与 .statusBarHidden(true)
  }
}
