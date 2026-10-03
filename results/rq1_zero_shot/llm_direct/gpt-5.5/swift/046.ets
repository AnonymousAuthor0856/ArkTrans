class AppColors {
  static readonly primary: string = '#FF7B61FF'
  static readonly secondary: string = '#FF26C6DA'
  static readonly tertiary: string = '#FFFF8A80'
  static readonly background: string = '#FFF5F7FF'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF0F2F8'
  static readonly outline: string = '#FFE0E3EB'
  static readonly success: string = '#FF22C55E'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF0B1220'
  static readonly onTertiary: string = '#FF0B1220'
  static readonly onBackground: string = '#FF0B1220'
  static readonly onSurface: string = '#FF0B1220'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 20
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 14
  static readonly largeCornerRadius: number = 20
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
  color: string

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
    this.color = color
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12, '#1F000000')
  static readonly level2: ShadowSpec = new ShadowSpec(6, 10, 6, 0.16, '#29000000')
  static readonly level3: ShadowSpec = new ShadowSpec(10, 14, 8, 0.18, '#2E000000')
}

class AppColorScheme {
  primary: string = AppColors.primary
  onPrimary: string = AppColors.onPrimary
  secondary: string = AppColors.secondary
  onSecondary: string = AppColors.onSecondary
  tertiary: string = AppColors.tertiary
  onTertiary: string = AppColors.onTertiary
  background: string = AppColors.background
  onBackground: string = AppColors.onBackground
  surface: string = AppColors.surface
  onSurface: string = AppColors.onSurface
  surfaceVariant: string = AppColors.surfaceVariant
  outline: string = AppColors.outline
  error: string = AppColors.error
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

function alphaColor(color: string, alphaHex: string): string {
  if (color.length === 9) {
    return `#${alphaHex}${color.substring(3)}`
  }
  if (color.length === 7) {
    return `#${alphaHex}${color.substring(1)}`
  }
  return color
}

@Entry
@Component
struct RootScreen {
  private appColorScheme: AppColorScheme = new AppColorScheme()

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
  private TopBar() {
    Row() {
      Stack()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor(this.appColorScheme.onSurface)
        .onClick(() => {
        })

      Blank()
        .layoutWeight(1)

      Text('Coupon Pack')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(700)
        .fontColor(this.appColorScheme.onSurface)

      Blank()
        .layoutWeight(1)

      Stack()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor(this.appColorScheme.primary)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.lg
    })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private LegendItem(color: string, label: string) {
    Circle()
      .width(10)
      .height(10)
      .fill(color)

    Text(label)
      .fontSize(AppTypographyTokens.labelSize)
      .fontWeight(500)
      .fontColor(this.appColorScheme.onSurface)
  }

  @Builder
  private MapCard() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Stack() {
        Stack() {
          ForEach(this.pins, (pin: MapPin) => {
            Circle()
              .width(28)
              .height(28)
              .fill(pin.tint)
              .position({
                x: pin.x - 14,
                y: pin.y - 14
              })
          }, (pin: MapPin) => `${pin.label}-${pin.x}-${pin.y}`)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.appColorScheme.surfaceVariant)
        .borderRadius(AppShapes.largeCornerRadius)
        .clip(true)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.md)
      .backgroundColor(this.appColorScheme.surface)
      .borderRadius(AppShapes.largeCornerRadius)
      .shadow({
        radius: AppElevationMapping.level2.radius,
        color: AppElevationMapping.level2.color,
        offsetX: 0,
        offsetY: AppElevationMapping.level2.dy
      })

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
      .backgroundColor(alphaColor(this.appColorScheme.surface, 'E6'))
      .borderRadius(AppShapes.smallCornerRadius)
      .margin(AppSpacing.md)
    }
    .width('100%')
    .aspectRatio(16 / 9)
  }

  @Builder
  private CouponCard(coupon: Coupon) {
    Stack() {
      Column({ space: AppSpacing.sm }) {
        Row({ space: AppSpacing.sm }) {
          Circle()
            .width(14)
            .height(14)
            .fill(this.appColorScheme.primary)

          Text(coupon.title)
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(500)
            .fontColor(this.appColorScheme.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(700)
          .fontColor(this.appColorScheme.onSurface)

        Stack() {
          Text('Redeem')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(500)
            .fontColor(this.appColorScheme.onPrimary)
        }
        .width('100%')
        .height(40)
        .backgroundColor(this.appColorScheme.primary)
        .borderRadius(AppShapes.mediumCornerRadius)
        .onClick(() => {
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        direction: GradientDirection.Right,
        colors: [
          [alphaColor(coupon.colorA, '2E'), 0.0],
          [alphaColor(coupon.colorB, '2E'), 1.0]
        ]
      })
      .borderRadius(AppShapes.largeCornerRadius)
    }
    .width(200)
    .height(140)
    .backgroundColor(this.appColorScheme.surface)
    .borderRadius(AppShapes.largeCornerRadius)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: AppElevationMapping.level2.color,
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    })
  }

  @Builder
  private BottomButton(title: string, backgroundColor: string, contentColor: string) {
    Stack() {
      Text(title)
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(500)
        .fontColor(contentColor)
    }
    .height(52)
    .layoutWeight(1)
    .backgroundColor(backgroundColor)
    .borderRadius(AppShapes.largeCornerRadius)
    .onClick(() => {
    })
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        this.TopBar()

        Column({ space: AppSpacing.lg }) {
          Text('Nearby Packs')
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(600)
            .fontColor(this.appColorScheme.onSurface)

          this.MapCard()

          Text('Your Coupon Packs')
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(600)
            .fontColor(this.appColorScheme.onSurface)

          Scroll() {
            Row({ space: AppSpacing.lg }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                this.CouponCard(coupon)
              }, (coupon: Coupon) => coupon.id.toString())
            }
            .padding({
              left: AppSpacing.xs,
              right: AppSpacing.xs
            })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank()
            .layoutWeight(1)
            .height(AppSpacing.sm)

          Row({ space: AppSpacing.md }) {
            this.BottomButton(
              'My Coupons',
              this.appColorScheme.secondary,
              this.appColorScheme.onSecondary
            )

            this.BottomButton(
              'Explore More',
              this.appColorScheme.primary,
              this.appColorScheme.onPrimary
            )
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [alphaColor(AppColors.secondary, '40'), 0.0],
        [AppColors.background, 0.5],
        [alphaColor(AppColors.primary, '40'), 1.0]
      ]
    })
  }
}