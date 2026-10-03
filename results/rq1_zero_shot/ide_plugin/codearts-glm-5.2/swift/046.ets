class AppTokens {
  static readonly Colors = {
    primary: '#FF7B61FF',
    secondary: '#FF26C6DA',
    tertiary: '#FFFF8A80',
    background: '#FFF5F7FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF0F2F8',
    outline: '#FFE0E3EB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0B1220',
    onTertiary: '#FF0B1220',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }
}

class Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id
    this.title = title
    this.value = value
    this.colorA = colorA
    this.colorB = colorB
  }
}

class MapPin {
  x: number
  y: number
  label: string
  tint: string

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x
    this.y = y
    this.label = label
    this.tint = tint
  }
}

@Component
struct CouponCard {
  @Prop title: string
  @Prop value: string
  @Prop colorA: string
  @Prop colorB: string

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.sm }) {
        Row({ space: AppTokens.Spacing.sm }) {
          Circle({ width: 14, height: 14 })
            .fill(AppTokens.Colors.primary)

          Text(this.title)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Text(this.value)
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Button('Redeem')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(40)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        direction: GradientDirection.Right,
        colors: [[this.colorA, 0.0], [this.colorB, 1.0]]
      })
      .borderRadius(AppTokens.Shapes.large)
    }
    .width(200)
    .height(140)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 10, color: '#29000000', offsetY: 6 })
  }
}

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', '#2E7B61FF', '#2E26C6DA'),
    new Coupon(2, 'Cafe Bundle', '-15%', '#2E26C6DA', '#2EFF8A80'),
    new Coupon(3, 'Electro Deal', '-$20', '#2EFF8A80', '#2E7B61FF'),
    new Coupon(4, 'Fashion Duo', '-10%', '#2E26C6DA', '#2E7B61FF'),
  ]
  private pins: MapPin[] = [
    new MapPin(80, 60, 'A', AppTokens.Colors.primary),
    new MapPin(160, 120, 'B', AppTokens.Colors.secondary),
    new MapPin(240, 80, 'C', AppTokens.Colors.tertiary),
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w = 304
    const h = 171
    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)
    for (let i = 0; i < this.pins.length; i++) {
      const p = this.pins[i]
      ctx.fillStyle = p.tint
      ctx.beginPath()
      ctx.arc(p.x, p.y, 14, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#4026C6DA', 0.0], [AppTokens.Colors.background, 0.5], ['#407B61FF', 1.0]]
        })

      Column({ space: AppTokens.Spacing.lg }) {
        Row() {
          Button() {
            Circle({ width: 20, height: 20 })
              .fill(AppTokens.Colors.onSurface)
          }
          .backgroundColor(Color.Transparent)

          Blank()

          Text('Coupon Pack')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button() {
            Circle({ width: 20, height: 20 })
              .fill(AppTokens.Colors.primary)
          }
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Column({ space: AppTokens.Spacing.lg }) {
          Text('Nearby Packs')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Stack({ alignContent: Alignment.TopEnd }) {
            Stack() {
              Canvas(this.canvasContext)
                .width('100%')
                .height('100%')
                .onReady(() => {
                  this.drawCanvas()
                })
            }
            .width('100%')
            .height(171)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 10, color: '#29000000', offsetY: 6 })

            Row({ space: AppTokens.Spacing.sm }) {
              Circle({ width: 10, height: 10 })
                .fill(AppTokens.Colors.primary)
              Text('A')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Circle({ width: 10, height: 10 })
                .fill(AppTokens.Colors.secondary)
              Text('B')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Circle({ width: 10, height: 10 })
                .fill(AppTokens.Colors.tertiary)
              Text('C')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor('#E6FFFFFF')
            .borderRadius(AppTokens.Shapes.small)
            .margin({ top: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          }
          .width('100%')

          Text('Your Coupon Packs')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Scroll() {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (c: Coupon) => {
                CouponCard({ title: c.title, value: c.value, colorA: c.colorA, colorB: c.colorB })
              })
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Row({ space: AppTokens.Spacing.md }) {
            Button('My Coupons')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)

            Button('Explore More')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.large)
          }
          .width('100%')
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}