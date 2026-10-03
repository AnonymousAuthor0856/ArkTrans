class AppColors {
  static readonly primary: string = '#7B61FF'
  static readonly secondary: string = '#26C6DA'
  static readonly tertiary: string = '#FF8A80'
  static readonly primarySoft: string = 'rgba(123, 97, 255, 0.18)'
  static readonly secondarySoft: string = 'rgba(38, 198, 218, 0.18)'
  static readonly tertiarySoft: string = 'rgba(255, 138, 128, 0.18)'
  static readonly background: string = '#F5F7FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F0F2F8'
  static readonly onSurface: string = '#0B1220'
  static readonly onPrimary: string = '#FFFFFF'
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

@Entry
@Component
struct CouponPackPage {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppColors.primarySoft, AppColors.secondarySoft),
    new Coupon(2, 'Cafe Bundle', '-15%', AppColors.secondarySoft, AppColors.tertiarySoft),
    new Coupon(3, 'Electro Deal', '-$20', AppColors.tertiarySoft, AppColors.primarySoft),
    new Coupon(4, 'Fashion Duo', '-10%', AppColors.secondarySoft, AppColors.primarySoft)
  ]

  private pins: MapPin[] = [
    new MapPin(0.23, 0.69, 'A', AppColors.primary),
    new MapPin(0.52, 0.86, 'B', AppColors.secondary),
    new MapPin(0.86, 0.94, 'C', AppColors.tertiary)
  ]

  @Builder
  Header() {
    Row() {
      Circle()
        .width(40)
        .height(40)
        .fill(AppColors.onSurface)

      Text('Coupon Pack')
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Circle()
        .width(40)
        .height(40)
        .fill(AppColors.primary)
    }
    .width('100%')
    .height(112)
    .padding({ left: 32, right: 36, top: 28 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  LegendItem(color: string, label: string) {
    Row({ space: 14 }) {
      Circle()
        .width(20)
        .height(20)
        .fill(color)

      Text(label)
        .fontSize(23)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MapPanel() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Column() {
        Stack() {
          Rect()
            .width('100%')
            .height('100%')
            .fill(AppColors.surfaceVariant)

          ForEach(this.pins, (pin: MapPin) => {
            Circle()
              .width(28)
              .height(28)
              .fill(pin.tint)
              .position({ x: `${pin.x * 100}%`, y: `${pin.y * 100}%` })
              .translate({ x: -14, y: -14 })
          }, (pin: MapPin) => pin.label)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)

      Row({ space: 18 }) {
        this.LegendItem(AppColors.primary, 'A')
        this.LegendItem(AppColors.secondary, 'B')
        this.LegendItem(AppColors.tertiary, 'C')
      }
      .height(44)
      .padding({ left: 22, right: 22 })
      .margin({ top: 24, right: 24 })
      .borderRadius(16)
      .backgroundColor('rgba(255, 255, 255, 0.92)')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.8)
    .borderRadius(36)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Stack() {
      Column({ space: 22 }) {
        Row({ space: 16 }) {
          Circle()
            .width(28)
            .height(28)
            .fill(AppColors.primary)

          Text(coupon.title)
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Button('Redeem')
          .width('100%')
          .height(80)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(28)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 32, right: 32, top: 38, bottom: 32 })
      .linearGradient({
        direction: GradientDirection.Right,
        colors: [
          [coupon.colorA, 0.0],
          [coupon.colorB, 1.0]
        ]
      })
    }
    .width(402)
    .height(280)
    .borderRadius(36)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 18, color: 'rgba(11, 18, 32, 0.18)', offsetX: 0, offsetY: 8 })
    .clip(true)
  }

  build() {
    Column() {
      this.Header()

      Column({ space: 30 }) {
        Text('Nearby Packs')
          .width('100%')
          .fontSize(39)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ top: 12 })

        this.MapPanel()

        Text('Your Coupon Packs')
          .width('100%')
          .fontSize(39)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ top: 6 })

        Scroll() {
          Row({ space: 32 }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon)
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: 8, right: 32, top: 10, bottom: 20 })
        }
        .width('100%')
        .height(314)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Blank()
          .height(30)

        Row({ space: 24 }) {
          Button('My Coupons')
            .layoutWeight(1)
            .height(104)
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.secondary)
            .borderRadius(36)

          Button('Explore More')
            .layoutWeight(1)
            .height(104)
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(36)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 32, right: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(38, 198, 218, 0.25)', 0.0],
        [AppColors.background, 0.48],
        ['rgba(123, 97, 255, 0.25)', 1.0]
      ]
    })
  }
}
