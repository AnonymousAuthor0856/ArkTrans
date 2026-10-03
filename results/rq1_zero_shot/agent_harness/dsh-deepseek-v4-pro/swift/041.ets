// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 集中管理应用的设计系统代币，方便统一修改和维护。
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { radius: number; dy: number; opacity: number; elevation?: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#777777',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#E5E5E5',
    outline: '#CCCCCC',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111111',
    onBackground: '#111111',
    onSurface: '#111111'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  }

  static readonly Spacing: NumberTokens = {
    sm: 8, md: 12, lg: 16, xl: 24, xxl: 32
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.12 },
    level3: { radius: 12, dy: 6, opacity: 0.15 }
  }
}

// MARK: - Marker Data Model
// 对应 Kotlin 的 Marker 数据类。
class Marker {
  id: number
  x: number
  y: number
  label: string

  constructor(x: number = 0, y: number = 0, label: string = '') {
    this.id = Marker.nextId++
    this.x = x
    this.y = y
    this.label = label
  }

  private static nextId: number = 0
}

// MARK: - RootScreen View (Equivalent to Kotlin's RootScreen Composable)
@Entry
@Component
struct Index {
  // 使用 @State 包装器管理可变状态。
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawMap(): void {
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant
    this.ctx.fillRect(0, 0, this.ctx.width, this.ctx.height)
    this.ctx.fillStyle = AppTokens.Colors.primary
    for (const marker of this.markers) {
      this.ctx.beginPath()
      this.ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2)
      this.ctx.fill()
    }
  }

  build() {
    Stack() {
      // 对应 Scaffold 的全屏背景色。
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // 主内容区域。
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)

        // 产品信息卡片。
        Column({ space: AppTokens.Spacing.md }) {
          Column()
            .width('100%')
            .height(160)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Text('Monochrome Bag')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.tertiary)

          Text('$79.00')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)

          Button('Add to Cart')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              console.log('Add to Cart tapped!')
            })
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        // 地图区域，包含 Canvas 绘制。
        Column() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMap()
            })
        }
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)

        // 底部操作按钮行。
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Marker')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              this.markers.push(new Marker(
                Math.floor(Math.random() * 401) + 100,
                Math.floor(Math.random() * 301) + 150,
                'New'
              ))
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = []
            })
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}
