import { LengthMetrics } from '@kit.ArkUI';

// Color tokens
const COLOR_PRIMARY = '#FF7B61FF';
const COLOR_SECONDARY = '#FF26C6DA';
const COLOR_TERTIARY = '#FFFFB3A7';
const COLOR_BACKGROUND = '#FFF5F7FF';
const COLOR_SURFACE = '#FFFFFFFF';
const COLOR_SURFACE_VARIANT = '#FFF0F2F8';
const COLOR_ON_SURFACE = '#FF0B1220';
const COLOR_ON_PRIMARY = '#FFFFFFFF';
const COLOR_ON_SECONDARY = '#FF0B1220';

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

const COUPONS: CouponItem[] = [
  { id: 1, title: 'Grocery Pack', value: '-$5', colorA: COLOR_PRIMARY, colorB: COLOR_SECONDARY },
  { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: COLOR_SECONDARY, colorB: COLOR_TERTIARY },
  { id: 3, title: 'Electro Deal', value: '-$20', colorA: COLOR_TERTIARY, colorB: COLOR_PRIMARY },
  { id: 4, title: 'Fashion Duo', value: '-10%', colorA: COLOR_SECONDARY, colorB: COLOR_PRIMARY },
];

const MAP_PINS: MapPinItem[] = [
  { x: 140, y: 220, label: 'A', tint: COLOR_PRIMARY },
  { x: 320, y: 400, label: 'B', tint: COLOR_SECONDARY },
  { x: 520, y: 300, label: 'C', tint: COLOR_TERTIARY },
];

@Entry
@Component
struct Index {
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(20)
            .height(20)
            .fill(COLOR_ON_SURFACE)
        }
        .width(40)
        .height(40)
        .alignContent(Alignment.Center)

        Text('Coupon Pack')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Stack() {
          Circle()
            .width(20)
            .height(20)
            .fill(COLOR_PRIMARY)
        }
        .width(40)
        .height(40)
        .alignContent(Alignment.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(COLOR_SURFACE)

      // Main content
      Scroll() {
        Column({ space: 16 }) {
          // Nearby Packs title
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')

          // Map area
          Stack({ alignContent: Alignment.TopEnd }) {
            Canvas(this.canvasContext)
              .width('100%')
              .aspectRatio(16 / 9)
              .borderRadius(20)
              .onReady(() => {
                this.canvasContext.fillStyle = COLOR_SURFACE_VARIANT;
                this.canvasContext.fillRect(0, 0, this.canvasContext.width, this.canvasContext.height);

                MAP_PINS.forEach((pin: MapPinItem) => {
                  this.canvasContext.beginPath();
                  this.canvasContext.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
                  this.canvasContext.fillStyle = pin.tint;
                  this.canvasContext.fill();

                  this.canvasContext.fillStyle = '#FFFFFFFF';
                  this.canvasContext.font = '14px sans-serif';
                  this.canvasContext.textAlign = 'center';
                  this.canvasContext.textBaseline = 'middle';
                  this.canvasContext.fillText(pin.label, pin.x, pin.y);
                });
              })

            // Legend
            Row({ space: 8 }) {
              Circle()
                .width(10)
                .height(10)
                .fill(COLOR_PRIMARY)
              Text('A')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
              Circle()
                .width(10)
                .height(10)
                .fill(COLOR_SECONDARY)
              Text('B')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
              Circle()
                .width(10)
                .height(10)
                .fill(COLOR_TERTIARY)
              Text('C')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
            }
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .backgroundColor('#E6FFFFFF')
            .borderRadius(8)
            .margin({ top: 8, right: 8 })
          }
          .width('100%')

          // Your Coupon Packs title
          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')

          // Coupon cards horizontal scroll
          Scroll() {
            Row({ space: 16 }) {
              ForEach(COUPONS, (coupon: CouponItem) => {
                Stack() {
                  // Gradient background
                  Row()
                    .width(200)
                    .height(140)
                    .borderRadius(20)
                    .linearGradient({
                      direction: GradientDirection.Right,
                      colors: [[coupon.colorA, 0.0], [coupon.colorB, 1.0]]
                    })
                    .opacity(0.18)

                  Column({ space: 8 }) {
                    Row({ space: 8 }) {
                      Circle()
                        .width(14)
                        .height(14)
                        .fill(COLOR_PRIMARY)
                      Text(coupon.title)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(COLOR_ON_SURFACE)
                    }
                    .alignItems(VerticalAlign.Center)

                    Text(coupon.value)
                      .fontSize(28)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(COLOR_ON_SURFACE)

                    Button('Redeem')
                      .width('100%')
                      .height(40)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(COLOR_ON_PRIMARY)
                      .backgroundColor(COLOR_PRIMARY)
                      .borderRadius(14)
                  }
                  .width(200)
                  .height(140)
                  .padding(16)
                  .alignItems(HorizontalAlign.Start)
                }
                .width(200)
                .height(140)
                .borderRadius(20)
                .backgroundColor(COLOR_SURFACE)
                .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
              })
            }
            .padding({ left: 4, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // Bottom buttons
          Row({ space: 12 }) {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SECONDARY)
              .backgroundColor(COLOR_SECONDARY)
              .borderRadius(20)

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_PRIMARY)
              .backgroundColor(COLOR_PRIMARY)
              .borderRadius(20)
          }
          .width('100%')
        }
        .padding(16)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4026C6DA', 0.0],
          [COLOR_BACKGROUND, 0.5],
          ['#407B61FF', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}