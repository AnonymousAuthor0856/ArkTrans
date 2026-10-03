// Color tokens
class Colors {
  static primary: string = '#FF7B61FF';
  static secondary: string = '#FF26C6DA';
  static tertiary: string = '#FFFF8A80';
  static background: string = '#FFF5F7FF';
  static surface: string = '#FFFFFFFF';
  static surfaceVariant: string = '#FFF0F2F8';
  static outline: string = '#FFE0E3EB';
  static success: string = '#FF22C55E';
  static warning: string = '#FFF59E0B';
  static error: string = '#FFEF4444';
  static onPrimary: string = '#FFFFFFFF';
  static onSecondary: string = '#FF0B1220';
  static onTertiary: string = '#FF0B1220';
  static onBackground: string = '#FF0B1220';
  static onSurface: string = '#FF0B1220';
}

class Spacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class Shapes {
  static small: number = 8;
  static medium: number = 14;
  static large: number = 20;
}

interface CouponItem {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPinItem {
  x: number;
  y: number;
  label: string;
  tint: string;
}

const coupons: CouponItem[] = [
  { id: 1, title: 'Grocery Pack', value: '-$5', colorA: Colors.primary, colorB: Colors.secondary },
  { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: Colors.secondary, colorB: Colors.tertiary },
  { id: 3, title: 'Electro Deal', value: '-$20', colorA: Colors.tertiary, colorB: Colors.primary },
  { id: 4, title: 'Fashion Duo', value: '-10%', colorA: Colors.secondary, colorB: Colors.primary },
]

const pins: MapPinItem[] = [
  { x: 140, y: 120, label: 'A', tint: Colors.primary },
  { x: 260, y: 180, label: 'B', tint: Colors.secondary },
  { x: 340, y: 100, label: 'C', tint: Colors.tertiary },
]

@Entry
@Component
struct RootScreen {
  build() {
    Stack() {
      // Background gradient
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4026C6DA', 0.0],
          ['#FFF5F7FF', 0.5],
          ['#407B61FF', 1.0],
        ]
      })

      // Main content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Top App Bar
          Row() {
            Button() {
              Circle()
                .width(20)
                .height(20)
                .fill(Colors.onSurface)
            }
            .backgroundColor(Color.Transparent)
            .padding({ left: Spacing.lg })

            Blank()

            Text('Coupon Pack')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            Blank()

            Button() {
              Circle()
                .width(20)
                .height(20)
                .fill(Colors.primary)
            }
            .backgroundColor(Color.Transparent)
            .padding({ right: Spacing.lg })
          }
          .width('100%')
          .padding({ top: Spacing.lg })

          // Main content area
          Column({ space: Spacing.lg }) {
            // Nearby Packs title
            Text('Nearby Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')

            // Map area
            Stack({ alignContent: Alignment.TopEnd }) {
              // Map background
              Stack() {
                // Map surface
                Column() {
                }
                .width('100%')
                .height('100%')
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.large)

                // Map pins
                ForEach(pins, (pin: MapPinItem) => {
                  Circle()
                    .width(28)
                    .height(28)
                    .fill(pin.tint)
                    .position({ x: pin.x, y: pin.y })
                })
              }
              .width('100%')
              .aspectRatio(16 / 9)
              .borderRadius(Shapes.large)
              .backgroundColor(Colors.surface)
              .shadow({
                radius: 10,
                color: '#29000000',
                offsetX: 0,
                offsetY: 6,
              })
              .clip(true)

              // Legend overlay
              Row({ space: Spacing.sm }) {
                Circle()
                  .width(10)
                  .height(10)
                  .fill(Colors.primary)
                Text('A')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Circle()
                  .width(10)
                  .height(10)
                  .fill(Colors.secondary)
                Text('B')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Circle()
                  .width(10)
                  .height(10)
                  .fill(Colors.tertiary)
                Text('C')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
              .backgroundColor('#E6FFFFFF')
              .borderRadius(Shapes.small)
              .margin(Spacing.md)
            }
            .width('100%')

            // Your Coupon Packs title
            Text('Your Coupon Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')

            // Coupon horizontal scroll
            Scroll() {
              Row({ space: Spacing.lg }) {
                ForEach(coupons, (coupon: CouponItem) => {
                  Stack() {
                    // Card background
                    Column() {
                    }
                    .width(200)
                    .height(140)
                    .borderRadius(Shapes.large)
                    .backgroundColor(Colors.surface)
                    .shadow({
                      radius: 10,
                      color: '#29000000',
                      offsetX: 0,
                      offsetY: 6,
                    })

                    // Card gradient overlay
                    Column() {
                    }
                    .width(200)
                    .height(140)
                    .borderRadius(Shapes.large)
                    .linearGradient({
                      direction: GradientDirection.Right,
                      colors: [
                        [coupon.colorA, 0.0],
                        [coupon.colorB, 1.0],
                      ]
                    })
                    .opacity(0.18)

                    // Card content
                    Column({ space: Spacing.sm }) {
                      Row({ space: Spacing.sm }) {
                        Circle()
                          .width(14)
                          .height(14)
                          .fill(Colors.primary)
                        Text(coupon.title)
                          .fontSize(16)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(Colors.onSurface)
                      }
                      .width('100%')

                      Text(coupon.value)
                        .fontSize(28)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(Colors.onSurface)

                      Button('Redeem')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .width('100%')
                        .height(40)
                        .backgroundColor(Colors.primary)
                        .fontColor(Colors.onPrimary)
                        .borderRadius(Shapes.medium)
                    }
                    .width(200)
                    .height(140)
                    .padding(Spacing.lg)
                    .alignItems(HorizontalAlign.Start)
                  }
                  .width(200)
                  .height(140)
                })
              }
              .padding({ left: Spacing.xs, right: Spacing.xs })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Bottom buttons
            Row({ space: Spacing.md }) {
              Button('My Coupons')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(Colors.secondary)
                .fontColor(Colors.onSecondary)
                .borderRadius(Shapes.large)

              Button('Explore More')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(Colors.primary)
                .fontColor(Colors.onPrimary)
                .borderRadius(Shapes.large)
            }
            .width('100%')
            .padding({ bottom: Spacing.lg })
          }
          .padding({ left: Spacing.lg, right: Spacing.lg })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}