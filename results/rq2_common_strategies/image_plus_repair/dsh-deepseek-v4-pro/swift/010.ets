// 对应 SwiftUI 的 import SwiftUI：ArkUI 组件由框架隐式提供，无需显式导入

// MARK: - AppTokens
// ArkTS 不支持嵌套结构体/命名空间，将 Swift 的嵌套结构体拍平为顶层类
class AppTokensColors {
  static readonly primary: string = '#FF1976D2'
  static readonly secondary: string = '#FF607D8B'
  static readonly tertiary: string = '#FF757575'
  static readonly background: string = '#FFECEFF1'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFCFD8DC'
  static readonly outline: string = '#FFB0BEC5'
  static readonly success: string = '#FF4CAF50'
  static readonly warning: string = '#FFFFC107'
  static readonly error: string = '#FFF44336'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FFFFFFFF'
  static readonly onBackground: string = '#FF263238'
  static readonly onSurface: string = '#FF263238'
}

// 字体令牌：将 Font.system(size:weight:) 拆分为字号与字重
interface FontToken {
  size: number
  weight: FontWeight
}

class TypographyTokens {
  static readonly display: FontToken = { size: 36, weight: FontWeight.Bold }
  static readonly headline: FontToken = { size: 24, weight: FontWeight.Medium } // semibold 无对应字重，取 Medium
  static readonly title: FontToken = { size: 18, weight: FontWeight.Medium }
  static readonly body: FontToken = { size: 14, weight: FontWeight.Normal }
  static readonly label: FontToken = { size: 12, weight: FontWeight.Medium }
}

// 形状令牌：将 RoundedRectangle(cornerRadius:) 映射为圆角半径数值
class AppTokensShapes {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

class AppTokensSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24 // 增加到24
  static readonly xxl: number = 32 // 新增更大的间距
}

class AppTokens {
  static readonly topBarHeight: number = 64
}

// 扩展 Color 以支持从十六进制值初始化
// ArkTS 中颜色直接使用十六进制字符串，无需扩展初始化器：
// 例如 Color(hex: 0xFF1976D2) 对应 '#FF1976D2'

// MARK: - Data Models
// 对应 Swift 的 Identifiable 结构体
class StoryLayer {
  id: number
  type: string
  content: string
  constructor(id: number, type: string, content: string) {
    this.id = id
    this.type = type
    this.content = content
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]
  @State selectedLayer: number = 3

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 主内容区域
      Column({ space: 0 }) {
        // 顶部栏 - 对应 CenterAlignedTopAppBar
        Row() {
          // 左侧按钮 - Exit (透明背景)
          Button({ type: ButtonType.Normal }) {
            Text('Exit')
              .fontSize(TypographyTokens.body.size)
              .fontWeight(TypographyTokens.body.weight)
              .fontColor(AppTokensColors.onBackground)
          }
          .backgroundColor(Color.Transparent)
          .padding({ left: AppTokensSpacing.sm, right: AppTokensSpacing.sm })
          .onClick(() => {})

          Blank()

          // 中间标题
          Text('Story Editor')
            .fontSize(TypographyTokens.title.size)
            .fontWeight(TypographyTokens.title.weight)
            .fontColor(AppTokensColors.onSurface)

          Blank()

          // 右侧按钮 - Post (蓝色背景)
          Button({ type: ButtonType.Normal }) {
            Text('Post')
              .fontSize(TypographyTokens.body.size)
              .fontWeight(TypographyTokens.body.weight)
              .fontColor(AppTokensColors.onPrimary)
              .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.sm, bottom: AppTokensSpacing.sm })
          }
          .backgroundColor(AppTokensColors.primary)
          .borderRadius(AppTokensShapes.medium)
          .padding({ left: AppTokensSpacing.sm, right: AppTokensSpacing.sm })
          .onClick(() => {})
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokensColors.surface)

        // 主要内容区域 - 对应 Scaffold 的 content
        Scroll() {
          Column({ space: AppTokensSpacing.lg }) {
            // 预览卡片 - 对应 Card with weight(1f)
            Stack() {
              Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppTokensColors.tertiary)
                .borderRadius(AppTokensShapes.large)
                .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

              Text('Your Story Preview')
                .fontSize(TypographyTokens.headline.size)
                .fontWeight(TypographyTokens.headline.weight)
                .fontColor(AppTokensColors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .width('100%')
            .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })

            // 上传状态 - 对应 Column
            Column({ space: AppTokensSpacing.sm }) {
              Text('Upload Status')
                .fontSize(TypographyTokens.label.size)
                .fontWeight(TypographyTokens.label.weight)
                .fontColor(AppTokensColors.secondary)

              // 自定义进度条 - 对应 LinearProgressIndicator
              Stack({ alignContent: Alignment.Start }) {
                // 轨道背景
                Column()
                  .width('100%')
                  .height(AppTokensSpacing.sm)
                  .backgroundColor(AppTokensColors.surfaceVariant)
                  .borderRadius(AppTokensShapes.small)

                // 进度条
                Column()
                  .width((this.uploadProgress * 100) + '%')
                  .height(AppTokensSpacing.sm)
                  .backgroundColor(AppTokensColors.success)
                  .borderRadius(AppTokensShapes.small)
              }
              .height(AppTokensSpacing.sm)
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })

            // 图层列表 - 对应 LazyRow
            Column({ space: AppTokensSpacing.sm }) {
              Text('Story Layers')
                .fontSize(TypographyTokens.label.size)
                .fontWeight(TypographyTokens.label.weight)
                .fontColor(AppTokensColors.secondary)
                .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })

              Scroll() {
                Row({ space: AppTokensSpacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    this.LayerItem(layer, layer.id === this.selectedLayer)
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.md, bottom: AppTokensSpacing.md })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: AppTokensSpacing.lg, bottom: AppTokensSpacing.lg })
        }
        .layoutWeight(1)
        .backgroundColor(AppTokensColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokensColors.background)

      // 底部栏 - 对应 BottomBar 的 Surface
      Column({ space: AppTokensSpacing.md }) {
        Text('Layer Properties')
          .fontSize(TypographyTokens.label.size)
          .fontWeight(TypographyTokens.label.weight)
          .fontColor(AppTokensColors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(TypographyTokens.body.size)
            .fontWeight(TypographyTokens.body.weight)
            .fontColor(AppTokensColors.onSurface)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({ value: this.textOpacity, min: 0, max: 1 })
            .blockColor(AppTokensColors.primary)
            .selectedColor(AppTokensColors.primary)
            .trackColor(AppTokensColors.surfaceVariant)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokensSpacing.lg)
      .width('100%')
      .backgroundColor(AppTokensColors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
    // 对应 Swift 的 .ignoresSafeArea(.all, edges: .all)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    // .statusBar(hidden: true) 对应隐藏状态栏，需通过窗口系统属性设置，此处省略
  }

  // MARK: - Layer Item View
  // 对应 Swift 的 LayerItemView 结构体（以 @Builder 形式内联，避免对象类型 @Prop 限制）
  @Builder
  LayerItem(layer: StoryLayer, isSelected: boolean) {
    Button({ type: ButtonType.Normal }) {
      Column({ space: AppTokensSpacing.sm }) {
        // 图标区域 - 对应 Box with CircleShape
        Circle()
          .width(32)
          .height(32)
          .fill(isSelected ? '#33FFFFFF' : AppTokensColors.surfaceVariant)

        // 类型标签
        Text(layer.type)
          .fontSize(TypographyTokens.label.size)
          .fontWeight(TypographyTokens.label.weight)
          .fontColor(isSelected ? AppTokensColors.onPrimary : '#B3263238')

        // 内容文本
        Text(layer.content)
          .fontSize(TypographyTokens.body.size)
          .fontWeight(TypographyTokens.body.weight)
          .fontColor(isSelected ? AppTokensColors.onPrimary : AppTokensColors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .padding({ left: AppTokensSpacing.xxl, right: AppTokensSpacing.xxl, top: AppTokensSpacing.md, bottom: AppTokensSpacing.md }) // 使用更大的水平内边距
      .width(130) // 进一步增加宽度以容纳更大的内边距
      .backgroundColor(isSelected ? AppTokensColors.primary : AppTokensColors.surface)
      .borderRadius(AppTokensShapes.medium)
      .border({ width: 1, color: isSelected ? AppTokensColors.primary : AppTokensColors.outline })
    }
    .backgroundColor(Color.Transparent)
    .padding(0)
    .onClick(() => {
      this.selectedLayer = layer.id
    })
  }
}

// MARK: - App Entry Point
// 对应 Swift 的 @main App 入口：在 ArkTS 中由 @Entry 修饰的 RootScreen 作为页面入口

// MARK: - Preview Provider
// SwiftUI 预览提供者 PreviewProvider 无需翻译为 ArkTS 运行时代码
