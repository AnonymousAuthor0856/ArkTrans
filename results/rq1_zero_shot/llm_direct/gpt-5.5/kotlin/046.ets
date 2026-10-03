class AppColors {
  static readonly primary: string = '#7B61FF'
  static readonly secondary: string = '#26C6DA'
  static readonly tertiary: string = '#FF8A80'
  static readonly background: string = '#F5F7FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F0F2F8'
  static readonly outline: string = '#E0E3EB'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0B1220'
  static readonly onTertiary: string = '#0B1220'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
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
struct RootScreen {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppColors.primary, AppColors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppColors.secondary, AppColors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppColors.tertiary, AppColors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppColors.secondary, AppColors.primary)
  ]

  @State private pins: MapPin[] = [
    new MapPin(140, 220, 'A', AppColors.primary),
    new MapPin(320, 400, 'B', AppColors.secondary),
    new MapPin(520, 300, 'C', AppColors.tertiary)
  ]

  @Builder
  CircleDot(size: number, color: ResourceColor) {
    Circle()
      .width(size)
      .height(size)
      .fill(color)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Circle()
          .width(20)
          .height(20)
          .fill(AppColors.onSurface)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderRadius(24)

      Text('Coupon Pack')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button() {
        Circle()
          .width(20)
          .height(20)
          .fill(AppColors.primary)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderRadius(24)
    }
    .width('100%')
    .height(72)
    .padding({ left: 4, right: 4 })
    .backgroundColor(Color.Transparent)
  }

  @Builder
  LegendItem(color: ResourceColor, label: string) {
    Row() {
      Circle()
        .width(10)
        .height(10)
        .fill(color)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MapCard() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Stack() {
        ForEach(this.pins, (pin: MapPin) => {
          Circle()
            .width(28)
            .height(28)
            .fill(pin.tint)
            .position({
              x: `${pin.x / 720 * 100}%`,
              y: `${pin.y / 405 * 100}%`
            })
            .translate({ x: -14, y: -14 })
        }, (pin: MapPin) => pin.label)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.surfaceVariant)

      Row({ space: AppSpacing.sm }) {
        this.LegendItem(AppColors.primary, 'A')
        this.LegendItem(AppColors.secondary, 'B')
        this.LegendItem(AppColors.tertiary, 'C')
      }
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs
      })
      .backgroundColor('rgba(255,255,255,0.9)')
      .borderRadius(AppRadius.small)
      .margin({ top: AppSpacing.md, right: AppSpacing.md })
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .clip(true)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Stack() {
      Column({ space: AppSpacing.sm }) {
        Row({ space: AppSpacing.sm }) {
          Circle()
            .width(14)
            .height(14)
            .fill(AppColors.primary)

          Text(coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Button('Redeem')
          .width('100%')
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.medium)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        angle: 90,
        colors: [
          [this.alphaColor(coupon.colorA, 0.18), 0.0],
          [this.alphaColor(coupon.colorB, 0.18), 1.0]
        ]
      })
    }
    .width(200)
    .height(140)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .clip(true)
    .shadow({
      radius: 10,
      color: 'rgba(11,18,32,0.16)',
      offsetX: 0,
      offsetY: 6
    })
  }

  private alphaColor(hex: string, alpha: number): string {
    const r = parseInt(hex.substring(1, 3), 16)
    const g = parseInt(hex.substring(3, 5), 16)
    const b = parseInt(hex.substring(5, 7), 16)
    return `rgba(${r},${g},${b},${alpha})`
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppSpacing.lg }) {
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')

        this.MapCard()

        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Scroll() {
          Row({ space: AppSpacing.lg }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon)
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Blank()
          .height(AppSpacing.sm)

        Row({ space: AppSpacing.md }) {
          Button('My Coupons')
            .height(52)
            .layoutWeight(1)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppRadius.large)

          Button('Explore More')
            .height(52)
            .layoutWeight(1)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppRadius.large)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(38,198,218,0.25)', 0.0],
          [AppColors.background, 0.5],
          ['rgba(123,97,255,0.25)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}