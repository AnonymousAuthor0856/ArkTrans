const NAME = '060CouponPacken'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Gradient Flow'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#0B1220',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 10, dy: 6, opacity: 0.16 },
    level3: { elevation: 10, radius: 14, dy: 8, opacity: 0.18 },
  }
}

interface Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string
}

interface MapPin {
  x: number
  y: number
  label: string
  tint: string
}

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary },
  ]

  private pins: MapPin[] = [
    { x: 140, y: 120, label: 'A', tint: AppTokens.Colors.primary },
    { x: 320, y: 200, label: 'B', tint: AppTokens.Colors.secondary },
    { x: 520, y: 150, label: 'C', tint: AppTokens.Colors.tertiary },
  ]

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 180
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    for (const pin of this.pins) {
      ctx.fillStyle = pin.tint
      ctx.beginPath()
      ctx.arc(pin.x, pin.y, 14, 0, 2 * Math.PI)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Row() {
        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppTokens.Colors.onSurface)
          .borderRadius(10)

        Text('Coupon Pack')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(10)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('Nearby Packs')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })

          Row() {
            Column()
              .width(10)
              .height(10)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(5)
            Text('A')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: AppTokens.Spacing.sm })
            Column()
              .width(10)
              .height(10)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(5)
              .margin({ left: AppTokens.Spacing.md })
            Text('B')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: AppTokens.Spacing.sm })
            Column()
              .width(10)
              .height(10)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(5)
              .margin({ left: AppTokens.Spacing.md })
            Text('C')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: AppTokens.Spacing.sm })
          }
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor('#E6FFFFFF')
          .borderRadius(AppTokens.Shapes.small)
          .position({ x: '100%', y: 0 })
          .markAnchor({ x: '100%', y: 0 })
        }
        .width('100%')
        .height(180)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.lg })

        Text('Your Coupon Packs')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        Scroll() {
          Row() {
            ForEach(this.coupons, (c: Coupon) => {
              CouponCard({ coupon: c })
            }, (c: Coupon) => c.id.toString())
          }
          .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
        }
        .scrollDirection(ScrollDirection.Horizontal)
        .width('100%')
        .height(140)
        .margin({ top: AppTokens.Spacing.lg })

        Row() {
          Button('My Coupons')
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(52)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)

          Button('Explore More')
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(52)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .margin({ left: AppTokens.Spacing.md })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#4026C6DA', 0.0], [AppTokens.Colors.background, 0.5], ['#407B61FF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CouponCard {
  private coupon: Coupon = { id: 0, title: '', value: '', colorA: '', colorB: '' }

  build() {
    Column() {
      Row() {
        Column()
          .width(14)
          .height(14)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(7)

        Text(this.coupon.title)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .alignItems(VerticalAlign.Center)

      Text(this.coupon.value)
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Redeem')
        .type(ButtonType.Normal)
        .width('100%')
        .height(40)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .width(200)
    .height(140)
    .padding(AppTokens.Spacing.lg)
    .borderRadius(AppTokens.Shapes.large)
    .linearGradient({
      angle: 90,
      colors: [[this.coupon.colorA + '30', 0.0], [this.coupon.colorB + '30', 1.0]]
    })
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
    .margin({ right: AppTokens.Spacing.lg })
  }
}