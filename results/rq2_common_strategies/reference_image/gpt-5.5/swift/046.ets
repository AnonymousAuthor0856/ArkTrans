class AppColors {
  static readonly primary: number = 0xFF7B61FF
  static readonly secondary: number = 0xFF26C6DA
  static readonly tertiary: number = 0xFFFF8A80
  static readonly background: number = 0xFFF5F7FF
  static readonly surface: number = 0xFFFFFFFF
  static readonly surfaceVariant: number = 0xFFF0F2F8
  static readonly outline: number = 0xFFE0E3EB
  static readonly success: number = 0xFF22C55E
  static readonly warning: number = 0xFFF59E0B
  static readonly error: number = 0xFFEF4444
  static readonly onPrimary: number = 0xFFFFFFFF
  static readonly onSecondary: number = 0xFF0B1220
  static readonly onTertiary: number = 0xFF0B1220
  static readonly onBackground: number = 0xFF0B1220
  static readonly onSurface: number = 0xFF0B1220

  static readonly secondary25: number = 0x4026C6DA
  static readonly primary25: number = 0x407B61FF
  static readonly surface90: number = 0xE6FFFFFF

  static readonly primary18: number = 0x2E7B61FF
  static readonly secondary18: number = 0x2E26C6DA
  static readonly tertiary18: number = 0x2EFF8A80
}

class AppTypography {
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

class AppElevation {
  static readonly level2Radius: number = 10
  static readonly level2Dy: number = 6
  static readonly level2Color: number = 0x29000000
}

interface Coupon {
  id: number
  title: string
  value: string
  colorA: number
  colorB: number
}

interface MapPin {
  x: number
  y: number
  label: string
  tint: number
}

@Entry
@Component
struct CouponPackApp {
  private coupons: Coupon[] = [
    {
      id: 1,
      title: 'Grocery Pack',
      value: '-$5',
      colorA: AppColors.primary18,
      colorB: AppColors.secondary18
    },
    {
      id: 2,
      title: 'Cafe Bundle',
      value: '-15%',
      colorA: AppColors.secondary18,
      colorB: AppColors.tertiary18
    },
    {
      id: 3,
      title: 'Electro Deal',
      value: '-$20',
      colorA: AppColors.tertiary18,
      colorB: AppColors.primary18
    },
    {
      id: 4,
      title: 'Fashion Duo',
      value: '-10%',
      colorA: AppColors.secondary18,
      colorB: AppColors.primary18
    }
  ]

  private pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: AppColors.primary },
    { x: 320, y: 400, label: 'B', tint: AppColors.secondary },
    { x: 520, y: 300, label: 'C', tint: AppColors.tertiary }
  ]

  @Builder
  Dot(color: number, size: number) {
    Blank()
      .width(size)
      .height(size)
      .borderRadius(size / 2)
      .backgroundColor(color)
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Coupon Pack')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Row() {
        this.Dot(AppColors.onSurface, 20)
        Blank().layoutWeight(1)
        this.Dot(AppColors.primary, 20)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(38)
    .margin({ top: AppSpacing.lg })
  }

  @Builder
  Legend() {
    Row({ space: AppSpacing.sm }) {
      this.Dot(AppColors.primary, 10)
      Text('A')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      this.Dot(AppColors.secondary, 10)
      Text('B')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      this.Dot(AppColors.tertiary, 10)
      Text('C')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .height(28)
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.xs,
      bottom: AppSpacing.xs
    })
    .borderRadius(AppShapes.smallCornerRadius)
    .backgroundColor(AppColors.surface90)
  }

  @Builder
  MapCard() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Stack() {
        Blank()
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.xl)
      .borderRadius(AppShapes.largeCornerRadius)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level2Radius,
        color: AppElevation.level2Color,
        offsetX: 0,
        offsetY: AppElevation.level2Dy
      })

      this.Legend()
        .margin({ top: AppSpacing.xl, right: AppSpacing.xl })
    }
    .width('100%')
    .aspectRatio(16 / 9)
  }

  @Builder
  RedeemButton() {
    Row() {
      Text('Redeem')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
    }
    .width('100%')
    .height(40)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(AppShapes.mediumCornerRadius)
    .backgroundColor(AppColors.primary)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column({ space: AppSpacing.sm }) {
      Row({ space: AppSpacing.sm }) {
        this.Dot(AppColors.primary, 14)

        Text(coupon.title)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(coupon.value)
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Blank().layoutWeight(1)

      this.RedeemButton()
    }
    .width(200)
    .height(140)
    .padding(AppSpacing.lg)
    .borderRadius(AppShapes.largeCornerRadius)
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [
        [coupon.colorA, 0.0],
        [coupon.colorB, 1.0]
      ]
    })
    .shadow({
      radius: AppElevation.level2Radius,
      color: AppElevation.level2Color,
      offsetX: 0,
      offsetY: AppElevation.level2Dy
    })
  }

  @Builder
  BottomAction(label: string, bgColor: number, contentColor: number) {
    Row() {
      Text(label)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(contentColor)
    }
    .height(52)
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(AppShapes.largeCornerRadius)
    .backgroundColor(bgColor)
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Text('Nearby Packs')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .margin({ top: AppSpacing.lg })

        this.MapCard()
          .margin({ top: AppSpacing.lg })

        Text('Your Coupon Packs')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .margin({ top: 20 })

        Scroll() {
          Row({ space: AppSpacing.lg }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon)
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
        }
        .width('100%')
        .height(176)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .margin({ top: 56 })

        Blank().layoutWeight(1)

        Row({ space: AppSpacing.md }) {
          this.BottomAction('My Coupons', AppColors.secondary, AppColors.onSecondary)
          this.BottomAction('Explore More', AppColors.primary, AppColors.onPrimary)
        }
        .width('100%')
        .height(52)
        .margin({ bottom: 0 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondary25, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primary25, 1.0]
      ]
    })
  }
}