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

@Entry
@Component
struct Index {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', '#7B61FF', '#26C6DA'),
    new Coupon(2, 'Cafe Bundle', '-15%', '#26C6DA', '#FF8A80'),
    new Coupon(3, 'Electro Deal', '-$20', '#FF8A80', '#7B61FF'),
    new Coupon(4, 'Fashion Duo', '-10%', '#26C6DA', '#7B61FF')
  ]
  private pins: MapPin[] = [
    new MapPin(140, 220, 'A', '#7B61FF'),
    new MapPin(320, 400, 'B', '#26C6DA'),
    new MapPin(520, 300, 'C', '#FF8A80')
  ]

  @Builder
  TopBar() {
    Row() {
      Button() {
        Circle().width(20).height(20).fill('#0B1220')
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)

      Text('Coupon Pack')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button() {
        Circle().width(20).height(20).fill('#7B61FF')
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .radius(20)
          .fill('#F0F2F8')

        ForEach(this.pins, (pin: MapPin) => {
          Stack() {
            Circle()
              .width(28)
              .height(28)
              .fill(pin.tint)
            Text(pin.label)
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(34)
          .height(34)
          .translate({ x: pin.x / 2 - 160, y: pin.y / 2 - 108 })
        }, (pin: MapPin) => pin.label)
      }
      .width('100%')
      .height(190)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .shadow({ radius: 10, color: '#29000000', offsetY: 6 })

      Row() {
        Circle().width(10).height(10).fill('#7B61FF')
        Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
        Circle().width(10).height(10).fill('#26C6DA').margin({ left: 8 })
        Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
        Circle().width(10).height(10).fill('#FF8A80').margin({ left: 8 })
        Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
      }
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(8)
      .margin(12)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(190)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Row() {
        Circle()
          .width(14)
          .height(14)
          .fill('#7B61FF')
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 8 })

      Button('Redeem')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(40)
        .backgroundColor('#7B61FF')
        .borderRadius(14)
        .margin({ top: 8 })
    }
    .width(200)
    .height(140)
    .padding(16)
    .linearGradient({ angle: 90, colors: [[coupon.colorA + '2E', 0.0], [coupon.colorB + '2E', 1.0]] })
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 10, color: '#29000000', offsetY: 6 })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .width('100%')

        Column() {
          this.MapArea()
        }
        .margin({ top: 16 })

        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .width('100%')
          .margin({ top: 16 })

        Scroll() {
          Row() {
            ForEach(this.coupons, (coupon: Coupon) => {
              Column() {
                this.CouponCard(coupon)
              }
              .margin({ right: 16 })
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(150)
        .margin({ top: 16 })

        Blank()

        Row() {
          Button('My Coupons')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .height(52)
            .layoutWeight(1)
            .backgroundColor('#26C6DA')
            .borderRadius(20)

          Blank().width(12)

          Button('Explore More')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .height(52)
            .layoutWeight(1)
            .backgroundColor('#7B61FF')
            .borderRadius(20)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#4026C6DA', 0.0], ['#F5F7FF', 0.5], ['#407B61FF', 1.0]]
    })
  }
}
