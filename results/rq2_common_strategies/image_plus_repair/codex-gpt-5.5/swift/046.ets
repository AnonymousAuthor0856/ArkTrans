class AppColors {
  static readonly primary: string = '#7B61FF'
  static readonly secondary: string = '#26C6DA'
  static readonly tertiary: string = '#FF8A80'
  static readonly background: string = '#F5F7FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F0F2F8'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppTypography {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly label: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
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

@Entry
@Component
struct CouponPackApp {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', '#2E7B61FF', '#2E26C6DA'),
    new Coupon(2, 'Cafe Bundle', '-15%', '#2E26C6DA', '#2EFF8A80'),
    new Coupon(3, 'Electro Deal', '-$20', '#2EFF8A80', '#2E7B61FF'),
    new Coupon(4, 'Fashion Duo', '-10%', '#2E26C6DA', '#2E7B61FF')
  ]

  @Builder
  CircleIcon(color: string) {
    Text('')
      .width(20)
      .height(20)
      .borderRadius(10)
      .backgroundColor(color)
  }

  @Builder
  LegendItem(color: string, label: string) {
    Row({ space: AppSpacing.sm }) {
      Text('')
        .width(10)
        .height(10)
        .borderRadius(5)
        .backgroundColor(color)
      Text(label)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Text('')
          .width(14)
          .height(14)
          .borderRadius(7)
          .backgroundColor(AppColors.primary)
        Text(coupon.title)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Clip })
      }
      .width('100%')

      Text(coupon.value)
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ top: AppSpacing.sm })

      Button('Redeem')
        .width('100%')
        .height(40)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .margin({ top: AppSpacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .width(200)
    .height(140)
    .padding(AppSpacing.lg)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surface)
    .linearGradient({
      angle: 90,
      colors: [[coupon.colorA, 0], [coupon.colorB, 1]]
    })
    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        Row() {
          this.CircleIcon(AppColors.onSurface)
          Blank()
          Text('Coupon Pack')
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
          Blank()
          this.CircleIcon(AppColors.primary)
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg
        })
        .alignItems(VerticalAlign.Center)

        Column({ space: AppSpacing.lg }) {
          Text('Nearby Packs')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Stack({ alignContent: Alignment.TopEnd }) {
            Stack() {
              Text('')
                .width('100%')
                .height('100%')
                .backgroundColor(AppColors.surfaceVariant)
            }
            .width('100%')
            .height('100%')
            .padding(AppSpacing.md)

            Row({ space: AppSpacing.sm }) {
              this.LegendItem(AppColors.primary, 'A')
              this.LegendItem(AppColors.secondary, 'B')
              this.LegendItem(AppColors.tertiary, 'C')
            }
            .height(45)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
            .borderRadius(AppShapes.small)
            .backgroundColor('#E6FFFFFF')
            .margin(AppSpacing.md)
          }
          .width('100%')
          .aspectRatio(1.7777778)
          .borderRadius(AppShapes.large)
          .backgroundColor(AppColors.surface)
          .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })

          Text('Your Coupon Packs')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Bold)
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
          .height(156)
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank()
            .layoutWeight(1)

          Row({ space: AppSpacing.md }) {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.large)

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.large)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [['#4026C6DA', 0], [AppColors.background, 0.5], ['#407B61FF', 1]]
    })
  }
}
