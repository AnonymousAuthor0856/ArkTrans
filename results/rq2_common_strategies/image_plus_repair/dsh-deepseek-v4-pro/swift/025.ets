// MARK: - Hex Color Helper
// 扩展 Color 以支持十六进制颜色初始化，方便与 Kotlin 代码对应
// ArkTS 中颜色直接使用十六进制字符串（#AARRGGBB），无需扩展类型

// MARK: - AppTokens
// 对应 Kotlin 的 AppTokens 对象，定义了颜色、字体、间距和阴影规范

interface ColorsSpec {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

interface TypographySpec {
  displaySize: number
  displayWeight: number
  titleSize: number
  titleWeight: number
  bodySize: number
  bodyWeight: number
  labelSize: number
  labelWeight: number
}

interface SpacingSpec {
  sm: number
  md: number
  lg: number
  xl: number
}

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

interface ElevationSpec {
  level1: ShadowSpec
  level2: ShadowSpec
}

interface Point {
  x: number
  y: number
}

class AppTokens {
  static readonly Colors: ColorsSpec = {
    primary: '#FF00FFFF',
    secondary: '#FF00FF88',
    tertiary: '#FFBB86FC',
    background: '#FF0D0D0D',
    surface: '#FF1C1C1C',
    surfaceVariant: '#FF2E2E2E',
    outline: '#FF3F3F3F',
    success: '#FF00FFAA',
    warning: '#FFFFC107',
    error: '#FFFF1744',
    onPrimary: '#FF000000',
    onSecondary: '#FF000000',
    onTertiary: '#FF000000',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF'
  }

  static readonly TypographyTokens: TypographySpec = {
    // Kotlin 的 FontWeight.Normal 对应 Swift 的 .regular（ArkTS 使用 400）
    displaySize: 28,
    displayWeight: 700,
    titleSize: 18,
    titleWeight: 500,
    bodySize: 14,
    bodyWeight: 400,
    labelSize: 12,
    labelWeight: 500
  }

  static readonly Spacing: SpacingSpec = {
    // Dp 单位直接映射为数值（vp）
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly ElevationMapping: ElevationSpec = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable 函数
@Entry
@Component
struct RootScreen {
  // 对应 Kotlin 的 mutableStateListOf 和 mutableStateOf
  @State private nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State private currentColor: string = AppTokens.Colors.primary

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private draw(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.lineWidth = 6
    this.context.strokeStyle = this.currentColor
    this.context.fillStyle = this.currentColor

    // 绘制连线
    for (let i = 1; i < this.nodes.length; i++) {
      const start: Point = this.nodes[i - 1]
      const end: Point = this.nodes[i]
      this.context.beginPath()
      this.context.moveTo(start.x, start.y)
      this.context.lineTo(end.x, end.y)
      this.context.stroke()
    }

    // 绘制节点
    for (const node of this.nodes) {
      this.context.beginPath()
      // radius = 20f, 所以直径为 40f
      this.context.ellipse(node.x, node.y, 20, 20, 0, 0, 2 * Math.PI)
      this.context.fill()
    }
  }

  build() {
    Stack() {
      // 背景色，忽略安全区域以实现全屏
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas 用于绘制节点和连线
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.draw()
        })
        // 对应 Kotlin 的 pointerInput + detectDragGestures
        .gesture(
          PanGesture({ fingers: 1, direction: PanDirection.All, distance: 0 })
            .onActionStart((event: GestureEvent) => {
              const finger = event.fingerList[0]
              this.nodes.push({ x: finger.localX, y: finger.localY })
              this.draw()
            })
            .onActionUpdate((event: GestureEvent) => {
              const finger = event.fingerList[0]
              this.nodes.push({ x: finger.localX, y: finger.localY })
              this.draw()
            })
        )

      // 顶部栏 (Top Bar)
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          // 垂直内边距，使其高度与 Compose 的 TopAppBar 视觉上接近
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%') // 填充宽度
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)
        Blank() // 将顶部栏推到顶部
      }
      .width('100%')
      .height('100%')

      // 底部栏 (Bottom Bar)
      Column() {
        Blank() // 将底部栏推到底部
        Row({ space: AppTokens.Spacing.md }) { // 按钮之间的间距
          // Cyan 按钮
          Button({ type: ButtonType.Normal }) {
            Text('Cyan')
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding({
                left: AppTokens.Spacing.lg, // 按钮内容水平内边距
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm, // 按钮内容垂直内边距
                bottom: AppTokens.Spacing.sm
              })
          }
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(15) // 胶囊形圆角
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
            this.draw()
          })

          // Green 按钮
          Button({ type: ButtonType.Normal }) {
            Text('Green')
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onSecondary)
              .padding({
                left: AppTokens.Spacing.lg,
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm
              })
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
            this.draw()
          })

          // Purple 按钮
          Button({ type: ButtonType.Normal }) {
            Text('Purple')
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onTertiary)
              .padding({
                left: AppTokens.Spacing.lg,
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm
              })
          }
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
            this.draw()
          })
        }
        .padding(AppTokens.Spacing.md) // 整个按钮行的内边距
        .width('100%') // 填充宽度
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        // 对应 Kotlin 的 tonalElevation 和 ShadowSpec
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (Floating Action Button)
      Column() {
        Blank() // 将 FAB 推到底部
        Row() {
          Blank() // 将 FAB 推到右侧
          Button({ type: ButtonType.Normal }) {
            Text('+')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(56) // 标准 FAB 尺寸，假设 56vp
              .height(56)
              .textAlign(TextAlign.Center)
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(28) // 圆形
          // 对应 Kotlin 的 ShadowSpec
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: 'rgba(0, 0, 0, 0.18)',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })
          .onClick(() => {
            // 对应 Kotlin 的随机位置生成
            const randomX = Math.random() * 500 + 100 // 100...600
            const randomY = Math.random() * 600 + 200 // 200...800
            this.nodes.push({ x: randomX, y: randomY })
            this.draw()
          })
          .padding(AppTokens.Spacing.lg) // FAB 距离屏幕边缘的内边距
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    // statusBarHidden(true) 对应 Kotlin 的 WindowInsetsControllerCompat.hide(...)，由系统设置控制
  }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 setContent
// ArkTS 页面通过 @Entry 装饰器作为应用入口，无需单独的 App 结构体
