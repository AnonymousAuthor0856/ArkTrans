// Color tokens
const ColorPrimary: string = '#FF7B61FF';
const ColorSecondary: string = '#FF26C6DA';
const ColorTertiary: string = '#FFFF8A80';
const ColorBackground: string = '#FFF5F7FF';
const ColorSurface: string = '#FFFFFFFF';
const ColorSurfaceVariant: string = '#FFF0F2F8';
const ColorOnPrimary: string = '#FFFFFFFF';
const ColorOnSecondary: string = '#FF0B1220';
const ColorOnSurface: string = '#FF0B1220';

const SpacingXs: number = 4;
const SpacingSm: number = 8;
const SpacingMd: number = 12;
const SpacingLg: number = 16;

const ShapeSmall: number = 8;
const ShapeMedium: number = 14;
const ShapeLarge: number = 20;

class CouponItem {
  id: number = 0;
  title: string = '';
  value: string = '';
  colorA: string = '';
  colorB: string = '';
}

class MapPinItem {
  x: number = 0;
  y: number = 0;
  label: string = '';
  tint: string = '';
}

const coupons: CouponItem[] = [
  { id: 1, title: 'Grocery Pack', value: '-$5', colorA: ColorPrimary, colorB: ColorSecondary },
  { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: ColorSecondary, colorB: ColorTertiary },
  { id: 3, title: 'Electro Deal', value: '-$20', colorA: ColorTertiary, colorB: ColorPrimary },
  { id: 4, title: 'Fashion Duo', value: '-10%', colorA: ColorSecondary, colorB: ColorPrimary },
];

const pins: MapPinItem[] = [
  { x: 140, y: 120, label: 'A', tint: ColorPrimary },
  { x: 260, y: 180, label: 'B', tint: ColorSecondary },
  { x: 180, y: 80, label: 'C', tint: ColorTertiary },
];

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
        Column({ space: SpacingLg }) {
          // Top navigation bar
          Row() {
            Button() {
              Circle()
                .width(20)
                .height(20)
                .fill(ColorOnSurface)
            }
            .backgroundColor(Color.Transparent)
            .padding({ left: SpacingLg })

            Blank()

            Text('Coupon Pack')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorOnSurface)

            Blank()

            Button() {
              Circle()
                .width(20)
                .height(20)
                .fill(ColorPrimary)
            }
            .backgroundColor(Color.Transparent)
            .padding({ right: SpacingLg })
          }
          .width('100%')
          .padding({ top: SpacingLg })

          // Main content area
          Column({ space: SpacingLg }) {
            // Nearby Packs text
            Text('Nearby Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorOnSurface)
              .width('100%')

            // Map area
            Stack({ alignContent: Alignment.TopEnd }) {
              // Map background
              Column() {
                // Map canvas area with pins
                Stack() {
                  // Background
                  Column() {
                  }
                  .width('100%')
                  .height('100%')
                  .backgroundColor(ColorSurfaceVariant)
                  .borderRadius(ShapeLarge)

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
                .height('100%')
                .padding(SpacingMd)
              }
              .width('100%')
              .aspectRatio(16 / 9)
              .backgroundColor(ColorSurface)
              .borderRadius(ShapeLarge)
              .shadow({
                radius: 10,
                color: '#29000000',
                offsetX: 0,
                offsetY: 6
              })

              // Legend overlay
              Row({ space: SpacingSm }) {
                Circle()
                  .width(10)
                  .height(10)
                  .fill(ColorPrimary)
                Text('A')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ColorOnSurface)

                Circle()
                  .width(10)
                  .height(10)
                  .fill(ColorSecondary)
                Text('B')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ColorOnSurface)

                Circle()
                  .width(10)
                  .height(10)
                  .fill(ColorTertiary)
                Text('C')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ColorOnSurface)
              }
              .padding({ left: SpacingMd, right: SpacingMd, top: SpacingXs, bottom: SpacingXs })
              .backgroundColor('#E6FFFFFF')
              .borderRadius(ShapeSmall)
              .margin(SpacingMd)
            }
            .width('100%')

            // Your Coupon Packs text
            Text('Your Coupon Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorOnSurface)
              .width('100%')

            // Coupon horizontal scroll
            Scroll() {
              Row({ space: SpacingLg }) {
                ForEach(coupons, (coupon: CouponItem) => {
                  Stack() {
                    // Card background
                    Column() {
                    }
                    .width(200)
                    .height(140)
                    .backgroundColor(ColorSurface)
                    .borderRadius(ShapeLarge)
                    .shadow({
                      radius: 10,
                      color: '#29000000',
                      offsetX: 0,
                      offsetY: 6
                    })

                    // Card gradient overlay
                    Column() {
                    }
                    .width(200)
                    .height(140)
                    .linearGradient({
                      direction: GradientDirection.Right,
                      colors: [
                        [coupon.colorA.substring(0, 7) + '2E', 0.0],
                        [coupon.colorB.substring(0, 7) + '2E', 1.0],
                      ]
                    })
                    .borderRadius(ShapeLarge)

                    // Card content
                    Column({ space: SpacingSm }) {
                      Row({ space: SpacingSm }) {
                        Circle()
                          .width(14)
                          .height(14)
                          .fill(ColorPrimary)
                        Text(coupon.title)
                          .fontSize(16)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(ColorOnSurface)
                      }
                      .width('100%')

                      Text(coupon.value)
                        .fontSize(28)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(ColorOnSurface)

                      Button('Redeem')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .width('100%')
                        .height(40)
                        .backgroundColor(ColorPrimary)
                        .fontColor(ColorOnPrimary)
                        .borderRadius(ShapeMedium)
                    }
                    .width(200)
                    .height(140)
                    .padding(SpacingLg)
                    .alignItems(HorizontalAlign.Start)
                  }
                  .width(200)
                  .height(140)
                })
              }
              .padding({ left: SpacingXs, right: SpacingXs })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Bottom buttons
            Row({ space: SpacingMd }) {
              Button('My Coupons')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(ColorSecondary)
                .fontColor(ColorOnSecondary)
                .borderRadius(ShapeLarge)

              Button('Explore More')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(ColorPrimary)
                .fontColor(ColorOnPrimary)
                .borderRadius(ShapeLarge)
            }
            .width('100%')
            .padding({ bottom: SpacingLg })
          }
          .padding({ left: SpacingLg, right: SpacingLg })
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
  }
}