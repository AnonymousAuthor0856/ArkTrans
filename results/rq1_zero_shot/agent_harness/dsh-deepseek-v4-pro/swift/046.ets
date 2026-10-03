// MARK: - AppTokens (Translated from Kotlin)
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { elevation: number; radius: number; dy: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#7B61FF',
    secondary: '#26C6DA',
    tertiary: '#FF8A80',
    background: '#F5F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F2F8',
    outline: '#E0E3EB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0B1220',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 20
  }

  static readonly Spacing: NumberTokens = {
    xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 10, dy: 6, opacity: 0.16 },
    level3: { elevation: 10, radius: 14, dy: 8, opacity: 0.18 }
  }
}

// 从 #RRGGBB 生成带透明度的 rgba 颜色字符串。
function rgba(hex: string, alpha: number): string {
  const r = parseInt(hex.substring(1, 3), 16)
  const g = parseInt(hex.substring(3, 5), 16)
  const b = parseInt(hex.substring(5, 7), 16)
  return 'rgba(' + r + ', ' + g + ', ' + b + ', ' + alpha + ')'
}

// MARK: - AppColorScheme
class AppColorScheme {
  primary: string = AppTokens.Colors.primary
  onPrimary: string = AppTokens.Colors.onPrimary
  secondary: string = AppTokens.Colors.secondary
  onSecondary: string = AppTokens.Colors.onSecondary
  tertiary: string = AppTokens.Colors.tertiary
  onTertiary: string = AppTokens.Colors.onTertiary
  background: string = AppTokens.Colors.background
  onBackground: string = AppTokens.Colors.onBackground
  surface: string = AppTokens.Colors.surface
  onSurface: string = AppTokens.Colors.onSurface
  surfaceVariant: string = AppTokens.Colors.surfaceVariant
  outline: string = AppTokens.Colors.outline
  error: string = AppTokens.Colors.error
}

// MARK: - Data Models
class Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string

  constructor(id: number = 0, title: string = '', value: string = '', colorA: string = '#000000', colorB: string = '#000000') {
    this.id = id
    this.title = title
    this.value = value
    this.colorA = colorA
    this.colorB = colorB
  }
}

class MapPin {
  id: number
  x: number
  y: number
  label: string
  tint: string

  constructor(x: number = 0, y: number = 0, label: string = '', tint: string = '#000000') {
    this.id = MapPin.nextId++
    this.x = x
    this.y = y
    this.label = label
    this.tint = tint
  }

  private static nextId: number = 0
}

// MARK: - RootScreen
@Entry
@Component
struct Index {
  private appColorScheme: AppColorScheme = new AppColorScheme()

  coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppTokens.Colors.primary, AppTokens.Colors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppTokens.Colors.secondary, AppTokens.Colors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppTokens.Colors.tertiary, AppTokens.Colors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppTokens.Colors.secondary, AppTokens.Colors.primary)
  ]

  @State pins: MapPin[] = [
    new MapPin(140, 220, 'A', AppTokens.Colors.primary),
    new MapPin(320, 400, 'B', AppTokens.Colors.secondary),
    new MapPin(520, 300, 'C', AppTokens.Colors.tertiary)
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawMap(): void {
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant
    this.ctx.fillRect(0, 0, this.ctx.width, this.ctx.height)
    for (const pin of this.pins) {
      this.ctx.fillStyle = pin.tint
      this.ctx.beginPath()
      this.ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2)
      this.ctx.fill()
    }
  }

  build() {
    Stack() {
      // 背景渐变。
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['rgba(38, 198, 218, 0.25)', 0.0],
            ['#F5F7FF', 0.5],
            ['rgba(123, 97, 255, 0.25)', 1.0]
          ]
        })

      // 主内容。
      Column({ space: AppTokens.Spacing.lg }) {
        // 顶部导航栏。
        Row() {
          Button() {
            Circle({ width: 20, height: 20 })
              .fill(this.appColorScheme.onSurface)
          }
          .padding({ left: AppTokens.Spacing.lg })
          .onClick(() => {})

          Blank()

          Text('Coupon Pack')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(this.appColorScheme.onSurface)

          Blank()

          Button() {
            Circle({ width: 20, height: 20 })
              .fill(this.appColorScheme.primary)
          }
          .padding({ right: AppTokens.Spacing.lg })
          .onClick(() => {})
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg })

        Column({ space: AppTokens.Spacing.lg }) {
          Text('Nearby Packs')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(this.appColorScheme.onSurface)

          // 地图区域。
          Stack({ alignContent: Alignment.TopEnd }) {
            Column() {
              Canvas(this.ctx)
                .width('100%')
                .height('100%')
                .onReady(() => {
                  this.drawMap()
                })
            }
            .width('100%')
            .aspectRatio(16 / 9)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(this.appColorScheme.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: 'rgba(0, 0, 0, 0.16)',
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })

            // A B C 标签。
            Row({ space: AppTokens.Spacing.sm }) {
              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.primary)
              Text('A')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.appColorScheme.onSurface)
              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.secondary)
              Text('B')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.appColorScheme.onSurface)
              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.tertiary)
              Text('C')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.appColorScheme.onSurface)
            }
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor('rgba(255, 255, 255, 0.9)')
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .padding(AppTokens.Spacing.md)
          }
          .width('100%')

          Text('Your Coupon Packs')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(this.appColorScheme.onSurface)

          // 优惠券横向列表。
          Scroll() {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                Stack() {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Row({ space: AppTokens.Spacing.sm }) {
                      Circle({ width: 14, height: 14 })
                        .fill(this.appColorScheme.primary)
                      Text(coupon.title)
                        .fontSize(AppTokens.Typography.title.size)
                        .fontWeight(AppTokens.Typography.title.weight)
                        .fontColor(this.appColorScheme.onSurface)
                    }
                    Text(coupon.value)
                      .fontSize(AppTokens.Typography.display.size)
                      .fontWeight(AppTokens.Typography.display.weight)
                      .fontColor(this.appColorScheme.onSurface)
                    Button('Redeem')
                      .fontSize(AppTokens.Typography.label.size)
                      .fontWeight(AppTokens.Typography.label.weight)
                      .fontColor(this.appColorScheme.onPrimary)
                      .width('100%')
                      .height(40)
                      .backgroundColor(this.appColorScheme.primary)
                      .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                      .onClick(() => {})
                  }
                  .alignItems(HorizontalAlign.Start)
                  .width('100%')
                  .height('100%')
                  .padding(AppTokens.Spacing.lg)
                  .linearGradient({
                    angle: 90,
                    colors: [
                      [rgba(coupon.colorA, 0.18), 0.0],
                      [rgba(coupon.colorB, 0.18), 1.0]
                    ]
                  })
                  .borderRadius(AppTokens.Shapes.largeCornerRadius)
                }
                .width(200)
                .height(140)
                .backgroundColor(this.appColorScheme.surface)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .shadow({
                  radius: AppTokens.ElevationMapping.level2.radius,
                  color: 'rgba(0, 0, 0, 0.16)',
                  offsetX: 0,
                  offsetY: AppTokens.ElevationMapping.level2.dy
                })
              }, (coupon: Coupon) => coupon.id.toString())
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(AppTokens.Spacing.sm)

          // 底部两个按钮。
          Row({ space: AppTokens.Spacing.md }) {
            Button('My Coupons')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(this.appColorScheme.onSecondary)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(this.appColorScheme.secondary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .onClick(() => {})

            Button('Explore More')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(this.appColorScheme.onPrimary)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(this.appColorScheme.primary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .onClick(() => {})
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
    }
    .width('100%')
    .height('100%')
  }
}
