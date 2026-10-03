import { Color, FontSize, FontWeight } from '@kit.ArkUI'

// MARK: - AppTokens (Translated from Kotlin)

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
    onSurface: '#0B1220'
  }

  static TypographyTokens = {
    display: () => ({ size: 28, weight: FontWeight.Bold }),
    headline: () => ({ size: 20, weight: FontWeight.SemiBold }),
    title: () => ({ size: 16, weight: FontWeight.Medium }),
    body: () => ({ size: 14, weight: FontWeight.Normal }),
    label: () => ({ size: 12, weight: FontWeight.Medium })
  }

  static Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 20
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 10, dy: 6, opacity: 0.16 },
    level3: { elevation: 10, radius: 14, dy: 8, opacity: 0.18 }
  }
}

// MARK: - Data Models

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

@Entry
@Component
struct RootScreen {
  // 优惠券数据，直接作为常量
  private coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary }
  ]

  // 地图标记数据
  @State pins: MapPin[] = [
    { x: 140, y: 220, label: "A", tint: AppTokens.Colors.primary },
    { x: 320, y: 400, label: "B", tint: AppTokens.Colors.secondary },
    { x: 520, y: 300, label: "C", tint: AppTokens.Colors.tertiary }
  ]

  build() {
    Stack() {
      // 背景渐变
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(38, 198, 218, 0.25)', 0],
            [AppTokens.Colors.background, 0.5],
            ['rgba(123, 97, 255, 0.25)', 1]
          ]
        })

      // 主内容 VStack
      Column() {
        // 顶部导航栏
        Row() {
          Button() {
            Circle()
              .fill(AppTokens.Colors.onSurface)
              .width(20)
              .height(20)
          }
          .padding({ left: AppTokens.Spacing.lg })

          Text("Coupon Pack")
            .font-size(AppTokens.TypographyTokens.display().size)
            .fontWeight(AppTokens.TypographyTokens.display().weight)
            .fontColor(AppTokens.Colors.onSurface)

          Button() {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(20)
              .height(20)
          }
          .padding({ right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: AppTokens.Spacing.lg })

        // 主内容区域的 VStack
        Column() {
          // "Nearby Packs" 文本
          Text("Nearby Packs")
            .font-size(AppTokens.TypographyTokens.headline().size)
            .fontWeight(AppTokens.TypographyTokens.headline().weight)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start)

          // 地图区域 Box
          Stack({ alignContent: Alignment.TopEnd }) {
            // 地图卡片背景
            Column()
              .width('100%')
              .aspectRatio(16 / 9)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .shadow({
                radius: AppTokens.ElevationMapping.level2.radius,
                color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level2.opacity + ')',
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level2.dy
              })
              .clip(true)
              .zIndex(0)

            // Canvas 用于绘制地图和图钉
            CanvasRenderingContext2D()
              .draw((ctx: CanvasRenderingContext2D, rect: Rect) => {
                // 绘制背景
                ctx.fillStyle = AppTokens.Colors.surfaceVariant
                ctx.fillRect(0, 0, rect.width, rect.height)

                // 绘制地图图钉
                for (let i = 0; i < this.pins.length; i++) {
                  const pin = this.pins[i]
                  ctx.beginPath()
                  ctx.arc(pin.x, pin.y, 14, 0, 2 * Math.PI)
                  ctx.fillStyle = pin.tint
                  ctx.fill()
                }
              })
              .width('100%')
              .height('100%')
              .padding(AppTokens.Spacing.md)
              .zIndex(1)

            // 地图上的 A B C 标签 Row
            Row() {
              ForEach(this.pins, (pin: MapPin) => {
                Row() {
                  Circle()
                    .fill(pin.tint)
                    .width(10)
                    .height(10)
                  Text(pin.label)
                    .font-size(AppTokens.TypographyTokens.label().size)
                    .fontWeight(AppTokens.TypographyTokens.label().weight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ left: AppTokens.Spacing.sm })
                }
              })
            }
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor('rgba(255, 255, 255, 0.9)')
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .margin(AppTokens.Spacing.md)
            .zIndex(2)
          }
          .width('100%')

          // "Your Coupon Packs" 文本
          Text("Your Coupon Packs")
            .font-size(AppTokens.TypographyTokens.headline().size)
            .fontWeight(AppTokens.TypographyTokens.headline().weight)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start)

          // 优惠券 LazyRow
          Scroll() {
            Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                Stack() {
                  // 卡片背景和阴影
                  Column()
                    .width(200)
                    .height(140)
                    .backgroundColor(AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.largeCornerRadius)
                    .shadow({
                      radius: AppTokens.ElevationMapping.level2.radius,
                      color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level2.opacity + ')',
                      offsetX: 0,
                      offsetY: AppTokens.ElevationMapping.level2.dy
                    })
                    .clip(true)
                    .zIndex(0)

                  // 卡片内部渐变背景
                  Column()
                    .width(200)
                    .height(140)
                    .linearGradient({
                      angle: 0,
                      colors: [
                        [coupon.colorA + '2E', 0], // 0.18 opacity approx hex 2E
                        [coupon.colorB + '2E', 1]
                      ]
                    })
                    .borderRadius(AppTokens.Shapes.largeCornerRadius)
                    .clip(true)
                    .zIndex(1)

                  // 卡片内容 VStack
                  Column() {
                    Row() {
                      Circle()
                        .fill(AppTokens.Colors.primary)
                        .width(14)
                        .height(14)
                      Text(coupon.title)
                        .font-size(AppTokens.TypographyTokens.title().size)
                        .fontWeight(AppTokens.TypographyTokens.title().weight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .margin({ left: AppTokens.Spacing.sm })
                    }
                    .alignItems(VerticalAlign.Center)

                    Text(coupon.value)
                      .font-size(AppTokens.TypographyTokens.display().size)
                      .fontWeight(AppTokens.TypographyTokens.display().weight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .margin({ top: AppTokens.Spacing.sm })

                    Button("Redeem")
                      .type(ButtonType.Normal)
                      .backgroundColor(AppTokens.Colors.primary)
                      .fontColor(AppTokens.Colors.onPrimary)
                      .font-size(AppTokens.TypographyTokens.label().size)
                      .fontWeight(AppTokens.TypographyTokens.label().weight)
                      .height(40)
                      .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                      .margin({ top: AppTokens.Spacing.sm })
                  }
                  .padding(AppTokens.Spacing.lg)
                  .alignItems(HorizontalAlign.Start)
                  .justifyContent(FlexAlign.Start)
                  .zIndex(2)
                }
                .width(200)
                .height(140)
                .margin({ right: AppTokens.Spacing.lg })
              })
            }
            .width('100%')
            .padding({ left: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .width('100%')
          .height(160) // Fixed height for scroll container to prevent layout issues
          .edgeEffect(EdgeEffect.None)

          // 底部 Spacer
          Blank()
            .height(AppTokens.Spacing.sm)

          // 底部两个按钮的 Row
          Row() {
            Button("My Coupons")
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .font-size(AppTokens.TypographyTokens.title().size)
              .fontWeight(AppTokens.TypographyTokens.title().weight)
              .height(52)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .layoutWeight(1)

            Button("Explore More")
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .font-size(AppTokens.TypographyTokens.title().size)
              .fontWeight(AppTokens.TypographyTokens.title().weight)
              .height(52)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.md })
          }
          .width('100%')
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}