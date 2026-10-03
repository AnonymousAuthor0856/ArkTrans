// MARK: - AppTokens (Design System)

// 定义应用的设计系统，便于集中管理和修改
// 注意：ArkTS 不支持 SwiftUI 的嵌套 struct，这里使用顶层 class 模拟 AppTokens 的设计系统。

// 颜色定义
class AppTokensColors {
  static readonly primary: string = '#FF214E34'
  static readonly secondary: string = '#FF2D6A4F'
  static readonly tertiary: string = '#FF6C757D'
  static readonly background: string = '#FFF8F1E5'
  static readonly surface: string = '#FFFFFBF0'
  static readonly surfaceVariant: string = '#FFE9DFC7'
  static readonly outline: string = '#FFD2C6AA'
  static readonly success: string = '#FF2B9348'
  static readonly warning: string = '#FFF4A261'
  static readonly error: string = '#FFD62828'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FF1B1F22'
  static readonly onBackground: string = '#FF1B1F22'
  static readonly onSurface: string = '#FF1B1F22'
}

// 字体定义
// SwiftUI 的 Font 不直接支持 lineHeight 和 letterSpacing，
// 但可以通过系统默认行为或进一步的 Text 修饰符来近似。
// 对于 letterSpacing = 0.sp，无需特殊处理。
class TypographyTokens {
  static readonly displaySize: number = 26
  static readonly displayWeight: number = 600 // .semibold
  static readonly headlineSize: number = 20
  static readonly headlineWeight: number = 500 // .medium
  static readonly titleSize: number = 16
  static readonly titleWeight: number = 500 // .medium
  static readonly bodySize: number = 13
  static readonly bodyWeight: number = 400 // .regular
  static readonly labelSize: number = 11
  static readonly labelWeight: number = 500 // .medium
}

// 形状定义
class Shapes {
  static readonly smallRadius: number = 6
  static readonly mediumRadius: number = 10
  static readonly largeRadius: number = 14
}

// 间距定义
class Spacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 20
  static readonly xxl: number = 28
  static readonly xxxl: number = 40
}

// 阴影规格定义
class ShadowSpec {
  elevation: number // 在 SwiftUI 中，这通常映射到 shadow 的 radius
  radius: number    // 在 SwiftUI 中，这通常映射到 shadow 的 radius
  dy: number        // 垂直偏移
  opacity: number   // 阴影颜色透明度
  color: string     // 由透明度推导出的阴影颜色（ArkTS 用颜色字符串的 alpha 通道表达透明度）
  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
    this.color = color
  }
}

// 阴影映射
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10, '#1A000000')
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 3, 0.14, '#24000000')
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 5, 0.16, '#29000000')
  static readonly level4: ShadowSpec = new ShadowSpec(10, 14, 7, 0.18, '#2E000000')
  static readonly level5: ShadowSpec = new ShadowSpec(14, 18, 9, 0.20, '#33000000')
}

// MARK: - AppTheme (Environment Values)

// SwiftUI 中没有直接的 MaterialTheme，我们通过 EnvironmentValues 来模拟
// 定义 AppColorScheme 结构体，持有所有颜色
class AppColorScheme {
  readonly primary: string = AppTokensColors.primary
  readonly onPrimary: string = AppTokensColors.onPrimary
  readonly secondary: string = AppTokensColors.secondary
  readonly onSecondary: string = AppTokensColors.onSecondary
  readonly tertiary: string = AppTokensColors.tertiary
  readonly onTertiary: string = AppTokensColors.onTertiary
  readonly background: string = AppTokensColors.background
  readonly onBackground: string = AppTokensColors.onBackground
  readonly surface: string = AppTokensColors.surface
  readonly onSurface: string = AppTokensColors.onSurface
  readonly surfaceVariant: string = AppTokensColors.surfaceVariant
  readonly outline: string = AppTokensColors.outline
  readonly error: string = AppTokensColors.error
  readonly success: string = AppTokensColors.success // 添加 success 和 warning
  readonly warning: string = AppTokensColors.warning
}

// 定义 AppTypography 结构体，持有所有字体
class AppTypography {
  readonly displayLargeSize: number = TypographyTokens.displaySize
  readonly displayLargeWeight: number = TypographyTokens.displayWeight
  readonly headlineMediumSize: number = TypographyTokens.headlineSize
  readonly headlineMediumWeight: number = TypographyTokens.headlineWeight
  readonly titleMediumSize: number = TypographyTokens.titleSize
  readonly titleMediumWeight: number = TypographyTokens.titleWeight
  readonly bodyMediumSize: number = TypographyTokens.bodySize
  readonly bodyMediumWeight: number = TypographyTokens.bodyWeight
  readonly labelMediumSize: number = TypographyTokens.labelSize
  readonly labelMediumWeight: number = TypographyTokens.labelWeight
}

// 定义 AppShapes 结构体，持有所有形状
class AppShapes {
  readonly smallRadius: number = Shapes.smallRadius
  readonly mediumRadius: number = Shapes.mediumRadius
  readonly largeRadius: number = Shapes.largeRadius
}

// ArkTS 中没有 SwiftUI 的 EnvironmentKey / EnvironmentValues 机制，
// 这里使用模块级单例来近似 .environment(\.appColorScheme, ...) 等注入的主题值。
const appColorScheme: AppColorScheme = new AppColorScheme()
const appTypography: AppTypography = new AppTypography()
const appShapes: AppShapes = new AppShapes()

// MARK: - Data Models

// 股票日历中的日期标签数据模型
class DayTab {
  id: number
  label: string
  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

// 股票行数据模型，需要 Identifiable 以便在 ForEach 中使用
class StockRow {
  id: string // SwiftUI 需要 Identifiable 协议的 id 属性（原为 UUID()，这里用 code 作为唯一标识）
  code: string
  name: string
  price: string
  change: string
  positive: boolean
  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.id = code
    this.code = code
    this.name = name
    this.price = price
    this.change = change
    this.positive = positive
  }
}

// MARK: - Custom Components (模拟 Material Design 3 组件)

// 模拟 Compose 的 Card 组件
@Component
struct CustomCard {
  shapeRadius: number = 0
  containerColor: string = '#00000000'
  elevation: ShadowSpec = new ShadowSpec(0, 0, 0, 0, '#00000000')
  borderStrokeWidth: number = 0
  borderStrokeColor: string = '#00000000'
  @BuilderParam content: () => void = this.defaultContent

  @Builder
  defaultContent() {
  }

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(this.containerColor)
    .borderRadius(this.shapeRadius)
    .shadow({ radius: this.elevation.radius, color: this.elevation.color, offsetX: 0, offsetY: this.elevation.dy })
    .border({ width: this.borderStrokeWidth, color: this.borderStrokeColor })
    .clip(true)
  }
}

// 模拟 Compose 的 FilterChip 组件
@Component
struct CustomFilterChip {
  selected: boolean = false
  label: string = ''
  action: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.label)
        .fontSize(appTypography.labelMediumSize)
        .fontWeight(appTypography.labelMediumWeight)
        .fontColor(this.selected ? appColorScheme.onPrimary : appColorScheme.onSurface)
    }
    .onClick(() => {
      this.action()
    })
    .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
    .backgroundColor(this.selected ? appColorScheme.secondary : appColorScheme.surface)
    .borderRadius(appShapes.smallRadius)
    .border({ width: 1, color: appColorScheme.outline })
  }
}

// MARK: - RootScreen View (主 UI 界面)

@Entry
@Component
struct RootScreen {
  // 从环境中获取自定义主题值（ArkTS 中通过模块级单例近似）
  // @Environment(\.appColorScheme) var colorScheme → appColorScheme
  // @Environment(\.appTypography) var typography → appTypography
  // @Environment(\.appShapes) var shapes → appShapes

  // 状态管理，使用 @State 模拟 Compose 的 remember { mutableStateOf(...) }
  days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ]
  @State selectedDayId: number = 1

  sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  @State currentSector: string = 'All'

  items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ]

  build() {
    // ZStack 模拟 Scaffold 的背景色和内容层叠
    Stack() {
      Column() {
        // 顶部应用栏 (CenterAlignedTopAppBar)
        Row() {
          Text('Stock Calendar')
            .fontSize(appTypography.displayLargeSize)
            .fontWeight(appTypography.displayLargeWeight)
            .fontColor(appColorScheme.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 40, bottom: 40 }) // 垂直方向的 padding
        .backgroundColor(appColorScheme.background) // TopBar 的背景色

        // 主要内容区域，使用 Scroll 模拟 LazyColumn
        Scroll() {
          Column() {
            // 日期选择和行业筛选卡片
            CustomCard({
              shapeRadius: appShapes.largeRadius,
              containerColor: appColorScheme.surface,
              elevation: ElevationMapping.level2,
              borderStrokeWidth: 1,
              borderStrokeColor: appColorScheme.outline
            }) {
              Column({ space: Spacing.md }) {
                Row({ space: Spacing.md }) {
                  ForEach(this.days, (d: DayTab) => {
                    Button({ type: ButtonType.Normal }) {
                      Text(d.label)
                        .fontSize(d.id === this.selectedDayId ? appTypography.titleMediumSize : appTypography.bodyMediumSize)
                        .fontWeight(d.id === this.selectedDayId ? appTypography.titleMediumWeight : appTypography.bodyMediumWeight)
                        .fontColor(d.id === this.selectedDayId ? appColorScheme.onPrimary : appColorScheme.onSurface)
                    }
                    .onClick(() => {
                      this.selectedDayId = d.id
                    })
                    .layoutWeight(1) // Modifier.weight(1f)
                    .height(36) // .height(36.dp)
                    .backgroundColor(d.id === this.selectedDayId ? appColorScheme.primary : appColorScheme.surfaceVariant)
                    .borderRadius(appShapes.smallRadius)
                  }, (d: DayTab) => d.id.toString())
                }
                .width('100%')

                Row({ space: Spacing.sm }) {
                  ForEach(this.sectors, (s: string) => {
                    CustomFilterChip({ selected: this.currentSector === s, label: s, action: () => { this.currentSector = s } })
                  }, (s: string) => s)
                  Blank() // 使 FilterChip 靠左排列
                }
                .width('100%')
              }
              .width('100%')
              .padding(Spacing.md) // Column(modifier = Modifier.padding(AppTokens.Spacing.md))
            }

            // 股票列表
            Column({ space: Spacing.sm }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
              ForEach(this.items, (item: StockRow) => {
                CustomCard({
                  shapeRadius: appShapes.mediumRadius,
                  containerColor: appColorScheme.surface,
                  elevation: ElevationMapping.level1,
                  borderStrokeWidth: 1,
                  borderStrokeColor: appColorScheme.outline
                }) {
                  Row() { // verticalAlignment = Alignment.CenterVertically
                    Row({ space: Spacing.md }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                      Row()
                        .width(28)
                        .height(28) // size(28.dp)
                        .backgroundColor(appColorScheme.surfaceVariant)
                        .borderRadius(appShapes.smallRadius)

                      Column({ space: Spacing.xs }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                        Text(item.name)
                          .fontSize(appTypography.titleMediumSize)
                          .fontWeight(appTypography.titleMediumWeight)
                          .fontColor(appColorScheme.onSurface)
                        Text(item.code)
                          .fontSize(appTypography.labelMediumSize)
                          .fontWeight(appTypography.labelMediumWeight)
                          .fontColor(appColorScheme.onSurface)
                      }
                      .alignItems(HorizontalAlign.Start)
                    }
                    .alignItems(VerticalAlign.Center)

                    Blank() // horizontalArrangement = Arrangement.SpaceBetween

                    Row({ space: Spacing.lg }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                      Column() { // horizontalAlignment = Alignment.End
                        Text(item.price)
                          .fontSize(appTypography.titleMediumSize)
                          .fontWeight(appTypography.titleMediumWeight)
                          .fontColor(appColorScheme.onSurface)
                        Row({ space: Spacing.xs }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                          Row()
                            .width(8)
                            .height(8) // size(8.dp, 8.dp)
                            .backgroundColor(item.positive ? appColorScheme.success : appColorScheme.error)
                            .borderRadius(appShapes.smallRadius)
                          Text(item.change)
                            .fontSize(appTypography.labelMediumSize)
                            .fontWeight(appTypography.labelMediumWeight)
                            .fontColor(item.positive ? appColorScheme.success : appColorScheme.error)
                        }
                      }
                      .alignItems(HorizontalAlign.End)

                      Button({ type: ButtonType.Normal }) {
                        Text('Detail')
                          .fontSize(appTypography.labelMediumSize)
                          .fontWeight(appTypography.labelMediumWeight)
                          .fontColor(appColorScheme.onPrimary)
                      }
                      .onClick(() => {})
                      .width(76)
                      .height(36) // height(36.dp).width(76.dp)
                      .backgroundColor(appColorScheme.primary)
                      .borderRadius(appShapes.smallRadius)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('100%')
                  .alignItems(VerticalAlign.Center)
                  .padding(Spacing.md) // Modifier.padding(AppTokens.Spacing.md)
                  .height(72) // heightIn(min = 72.dp)
                }
              }, (item: StockRow) => item.id)
            }
            .width('100%')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          // Column(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md))
          // contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.xxxl })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off) // showsIndicators: false
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(appColorScheme.background)
    // 要求2: 隐藏顶部状态栏
    // ArkTS 中状态栏的隐藏需在窗口层面配置（window.setWindowLayoutFullScreen(true)），
    // 此处通过 expandSafeArea 让背景色延伸到系统状态栏区域，近似 ignoresSafeArea(.all) 的效果。
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END])
  }
}

// MARK: - Preview (预览功能)

// ArkTS 使用 @Preview 装饰器提供预览，对应 SwiftUI 的 PreviewProvider。
@Preview
@Component
struct RootScreenPreview {
  build() {
    RootScreen() // 预览时也应用主题
  }
}
