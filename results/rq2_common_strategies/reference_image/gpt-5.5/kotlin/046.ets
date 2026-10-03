class AppColors {
  static readonly primary: string = '#7B61FF'
  static readonly primary25: string = '#407B61FF'
  static readonly primary18: string = '#2E7B61FF'
  static readonly secondary: string = '#26C6DA'
  static readonly secondary25: string = '#4026C6DA'
  static readonly secondary18: string = '#2E26C6DA'
  static readonly tertiary: string = '#FF8A80'
  static readonly tertiary18: string = '#2EFF8A80'
  static readonly background: string = '#F5F7FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surface90: string = '#E6FFFFFF'
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

class Coupon {
  id: number
  title: string
  value: string
  colorA18: string
  colorB18: string

  constructor(id: number, title: string, value: string, colorA18: string, colorB18: string) {
    this.id = id
    this.title = title
    this.value = value
    this.colorA18 = colorA18
    this.colorB18 = colorB18
  }
}

@Entry
@Component
struct CouponPackPage {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppColors.primary18, AppColors.secondary18),
    new Coupon(2, 'Cafe Bundle', '-15%', AppColors.secondary18, AppColors.tertiary18),
    new Coupon(3, 'Electro Deal', '-$20', AppColors.tertiary18, AppColors.primary18),
    new Coupon(4, 'Fashion Duo', '-10%', AppColors.secondary18, AppColors.primary18)
  ]

  @Builder
  Dot(size: number, color: ResourceColor) {
    Stack() {
    }
    .width(size)
    .height(size)
    .borderRadius(size / 2)
    .backgroundColor(color)
  }

  @Builder
  LegendItem(color: ResourceColor, label: string) {
    Row({ space: AppSpacing.sm }) {
      this.Dot(10, color)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TopBar() {
    Row() {
      this.Dot(20, AppColors.onSurface)

      Text('Coupon Pack')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      this.Dot(20, AppColors.primary)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  MapPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack({ alignContent: Alignment.TopStart }) {
        this.Dot(14, AppColors.primary)
          .position({ x: '21%', y: '64%' })

        this.Dot(14, AppColors.secondary)
          .position({ x: '49%', y: '90%' })

        this.Dot(14, AppColors.tertiary)
          .position({ x: '84%', y: '76%' })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.surfaceVariant)

      Row({ space: AppSpacing.sm }) {
        this.LegendItem(AppColors.primary, 'A')
        this.LegendItem(AppColors.secondary, 'B')
        this.LegendItem(AppColors.tertiary, 'C')
      }
      .height(44)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .borderRadius(14)
      .backgroundColor(AppColors.surface90)
      .position({ x: '65%', y: 0 })
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .padding(AppSpacing.md)
    .borderRadius(20)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Stack() {
      Column({ space: AppSpacing.sm }) {
        Row({ space: AppSpacing.sm }) {
          this.Dot(14, AppColors.primary)

          Text(coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
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
          .borderRadius(14)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width(200)
    .height(140)
    .borderRadius(20)
    .clip(true)
    .backgroundColor(AppColors.surface)
    .linearGradient({
      angle: 90,
      colors: [
        [coupon.colorA18, 0.0],
        [coupon.colorB18, 1.0]
      ]
    })
    .shadow({
      radius: 10,
      color: '#29000000',
      offsetX: 0,
      offsetY: 6
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppSpacing.lg }) {
        Text('Nearby Packs')
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        this.MapPanel()

        Text('Your Coupon Packs')
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Scroll() {
          Row({ space: AppSpacing.lg }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon)
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
        }
        .width('100%')
        .height(158)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Blank()
          .height(AppSpacing.sm)

        Row({ space: AppSpacing.md }) {
          Button('My Coupons')
            .layoutWeight(1)
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(20)

          Button('Explore More')
            .layoutWeight(1)
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(20)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondary25, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primary25, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}