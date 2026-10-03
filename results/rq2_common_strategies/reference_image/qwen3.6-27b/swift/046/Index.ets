// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 20
  }

  static readonly ElevationMapping = {
    level2: {
      opacity: 0.16,
      radius: 10,
      dy: 6
    }
  }
}

// CouponPackApp.ets
@Entry
@Component
struct RootScreen {
  @State coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary }
  ]

  @State pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: AppTokens.Colors.primary },
    { x: 320, y: 400, label: 'B', tint: AppTokens.Colors.secondary },
    { x: 520, y: 300, label: 'C', tint: AppTokens.Colors.tertiary }
  ]

  build() {
    Column() {
      // Top Navigation Bar
      Row() {
        Circle().width(20).height(20).fill(AppTokens.Colors.onSurface)
        Spacer()
        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
        Spacer()
        Circle().width(20).height(20).fill(AppTokens.Colors.primary)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg })

      // Main Content Area
      Column() {
        // Nearby Packs Section
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Map Card
        Stack({ alignContent: Alignment.TopEnd }) {
          // Map Background and Pins
          RelativeContainer() {
            ForEach(this.pins, (pin: MapPin) => {
              Circle()
                .width(28)
                .height(28)
                .fill(pin.tint)
                .position({ x: pin.x, y: pin.y })
            })
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .margin(AppTokens.Spacing.md)

          // Legend Overlay
          Row() {
            this.buildLegendItem(AppTokens.Colors.primary, 'A')
            this.buildLegendItem(AppTokens.Colors.secondary, 'B')
            this.buildLegendItem(AppTokens.Colors.tertiary, 'C')
          }
          .spacing(AppTokens.Spacing.sm)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor('#E6FFFFFF') // Approximating 0.9 opacity white
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .margin(AppTokens.Spacing.md)
        }
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .backgroundColor(AppTokens.Colors.surface)

        // Your Coupon Packs Section
        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)
          .margin({ top: AppTokens.Spacing.lg })

        // Horizontal Scrollable Coupons
        Scroll() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start }) {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.buildCouponCard(coupon)
            }, (item: Coupon) => item.id.toString())
          }
          .width('100%')
          .margin({ left: AppTokens.Spacing.xs })
        }
        .width('100%')
        .height(180)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Spacer()

        // Bottom Buttons
        Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.SpaceBetween }) {
          Button('My Coupons')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .layoutWeight(1)

          Button('Explore More')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        ['26C6DA', '0.25'],
        ['F5F7FF', '0.5'],
        ['7B61FF', '0.25']
      ]
    })
  }

  @Builder
  buildLegendItem(color: string, label: string) {
    Row() {
      Circle().width(10).height(10).fill(color)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ left: AppTokens.Spacing.xs })
    }
  }

  @Builder
  buildCouponCard(coupon: Coupon) {
    Column() {
      Row() {
        Circle().width(14).height(14).fill(AppTokens.Colors.primary)
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .alignItems(VerticalAlign.Center)

      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Redeem')
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(AppTokens.Shapes.mediumCornerRadius)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .width(200)
    .height(140)
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 0,
      colors: [
        [coupon.colorA, '0.18'],
        [coupon.colorB, '0.18']
      ]
    })
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
    .margin({ right: AppTokens.Spacing.lg })
  }
}

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;
}