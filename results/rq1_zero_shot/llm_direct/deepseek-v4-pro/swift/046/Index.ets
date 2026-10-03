@Entry
@Component
struct RootScreen {
  @State pins: MapPin[] = [
    new MapPin(140, 220, 'A', '#7B61FF'),
    new MapPin(320, 400, 'B', '#26C6DA'),
    new MapPin(520, 300, 'C', '#FF8A80')
  ];

  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', '#7B61FF', '#26C6DA'),
    new Coupon(2, 'Cafe Bundle', '-15%', '#26C6DA', '#FF8A80'),
    new Coupon(3, 'Electro Deal', '-$20', '#FF8A80', '#7B61FF'),
    new Coupon(4, 'Fashion Duo', '-10%', '#26C6DA', '#7B61FF')
  ];

  @Builder
  MapCanvas() {
    Canvas(this.pins)
      .width('100%')
      .aspectRatio(16 / 9)
      .backgroundColor('#F0F2F8')
      .borderRadius(20)
      .onReady(() => {
        this.drawMap();
      })
  }

  private drawMap(): void {
    // Canvas drawing is handled by the Canvas component's rendering
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Circle()
          .width(14)
          .height(14)
          .fill('#7B61FF')
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .width('100%')

      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')

      Button('Redeem')
        .width('100%')
        .height(40)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#7B61FF')
        .borderRadius(14)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      angle: 90,
      colors: [[coupon.colorA, 0.18], [coupon.colorB, 0.18]]
    })
    .borderRadius(20)
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#26C6DA', 0.25], ['#F5F7FF', 1.0], ['#7B61FF', 0.25]]
        })

      // Main content
      Column({ space: 16 }) {
        // Top app bar
        Row() {
          Button() {
            Circle()
              .width(20)
              .height(20)
              .fill('#0B1220')
          }
          .margin({ left: 16 })

          Blank()

          Text('Coupon Pack')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')

          Blank()

          Button() {
            Circle()
              .width(20)
              .height(20)
              .fill('#7B61FF')
          }
          .margin({ right: 16 })
        }
        .width('100%')
        .margin({ top: 16 })

        // Main content area
        Column({ space: 16 }) {
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .width('100%')
            .textAlign(TextAlign.Start)

          // Map area
          Stack({ alignContent: Alignment.TopEnd }) {
            Column()
              .width('100%')
              .aspectRatio(16 / 9)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({
                radius: 10,
                color: 'rgba(0, 0, 0, 0.16)',
                offsetY: 6
              })

            // Map pins
            ForEach(this.pins, (pin: MapPin) => {
              Circle()
                .width(28)
                .height(28)
                .fill(pin.tint)
                .position({ x: pin.x, y: pin.y })
            })

            // Legend
            Row({ space: 8 }) {
              Circle()
                .width(10)
                .height(10)
                .fill('#7B61FF')
              Text('A')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')

              Circle()
                .width(10)
                .height(10)
                .fill('#26C6DA')
              Text('B')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')

              Circle()
                .width(10)
                .height(10)
                .fill('#FF8A80')
              Text('C')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .backgroundColor('rgba(255, 255, 255, 0.9)')
            .borderRadius(8)
            .margin(12)
          }
          .width('100%')

          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .width('100%')
            .textAlign(TextAlign.Start)

          // Coupon cards
          Scroll() {
            Row({ space: 16 }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                Column() {
                  this.CouponCard(coupon)
                }
                .width(200)
                .height(140)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .shadow({
                  radius: 10,
                  color: 'rgba(0, 0, 0, 0.16)',
                  offsetY: 6
                })
              })
            }
            .padding({ left: 4, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank()
            .height(8)

          // Bottom buttons
          Row({ space: 12 }) {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .backgroundColor('#26C6DA')
              .borderRadius(20)

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#7B61FF')
              .borderRadius(20)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.colorA = colorA;
    this.colorB = colorB;
  }
}

class MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}