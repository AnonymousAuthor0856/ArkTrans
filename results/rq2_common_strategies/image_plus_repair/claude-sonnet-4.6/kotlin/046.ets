// Color constants
const C_PRIMARY: string = '#FF7B61FF'
const C_SECONDARY: string = '#FF26C6DA'
const C_TERTIARY: string = '#FFFF8A80'
const C_BG: string = '#FFF5F7FF'
const C_SURFACE: string = '#FFFFFFFF'
const C_SURF_VAR: string = '#FFF0F2F8'
const C_ON_BG: string = '#FF0B1220'
const C_ON_PRI: string = '#FFFFFFFF'

class CouponData {
  id: number = 0
  title: string = ''
  value: string = ''
  colorA: string = ''
  colorB: string = ''

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id
    this.title = title
    this.value = value
    this.colorA = colorA
    this.colorB = colorB
  }
}

class MapPinData {
  x: number = 0
  y: number = 0
  label: string = ''
  tint: string = ''

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x
    this.y = y
    this.label = label
    this.tint = tint
  }
}

@Component
struct CouponCard {
  coupon: CouponData = new CouponData(0, '', '', '', '')

  build() {
    Stack() {
      Column() {
        Row() {
          Circle({ width: 14, height: 14 })
            .fill(C_PRIMARY)
          Text(this.coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_BG)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)

        Text(this.coupon.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_ON_BG)
          .margin({ top: 8 })

        Button('Redeem')
          .width('100%')
          .height(40)
          .backgroundColor(C_PRIMARY)
          .fontColor(C_ON_PRI)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(14)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .width('100%')
      .height('100%')
    }
    .width(200)
    .height(140)
    .borderRadius(20)
    .backgroundColor(C_SURFACE)
    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
  }
}

@Component
struct MapArea {
  pins: MapPinData[] = []

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      // Map background with pins
      Stack() {
        // Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(C_SURF_VAR)

        // Pin A
        Circle({ width: 28, height: 28 })
          .fill(C_PRIMARY)
          .position({ x: this.pins.length > 0 ? this.pins[0].x : 0, y: this.pins.length > 0 ? this.pins[0].y : 0 })

        // Pin B
        Circle({ width: 28, height: 28 })
          .fill(C_SECONDARY)
          .position({ x: this.pins.length > 1 ? this.pins[1].x : 0, y: this.pins.length > 1 ? this.pins[1].y : 0 })

        // Pin C
        Circle({ width: 28, height: 28 })
          .fill(C_TERTIARY)
          .position({ x: this.pins.length > 2 ? this.pins[2].x : 0, y: this.pins.length > 2 ? this.pins[2].y : 0 })
      }
      .width('100%')
      .height('100%')
      .borderRadius(20)
      .clip(true)

      // Legend
      Row() {
        Circle({ width: 10, height: 10 })
          .fill(C_PRIMARY)
        Text('A')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_BG)
          .margin({ left: 4 })
        Circle({ width: 10, height: 10 })
          .fill(C_SECONDARY)
          .margin({ left: 8 })
        Text('B')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_BG)
          .margin({ left: 4 })
        Circle({ width: 10, height: 10 })
          .fill(C_TERTIARY)
          .margin({ left: 8 })
        Text('C')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_BG)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(8)
      .margin({ top: 8, right: 8 })
    }
    .width('100%')
    .aspectRatio(16.0 / 9.0)
    .backgroundColor(C_SURFACE)
    .borderRadius(20)
    .padding(12)
  }
}

@Entry
@Component
struct RootScreen {
  private coupons: CouponData[] = [
    new CouponData(1, 'Grocery Pack', '-$5', C_PRIMARY, C_SECONDARY),
    new CouponData(2, 'Cafe Bundle', '-15%', C_SECONDARY, C_TERTIARY),
    new CouponData(3, 'Electro Deal', '-$20', C_TERTIARY, C_PRIMARY),
    new CouponData(4, 'Fashion Duo', '-10%', C_SECONDARY, C_PRIMARY)
  ]

  private pins: MapPinData[] = [
    new MapPinData(140, 220, 'A', C_PRIMARY),
    new MapPinData(320, 400, 'B', C_SECONDARY),
    new MapPinData(520, 300, 'C', C_TERTIARY)
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 20, height: 20 })
          .fill(C_ON_BG)
          .margin({ left: 16 })

        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_ON_BG)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Circle({ width: 20, height: 20 })
          .fill(C_PRIMARY)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(C_SURFACE)

      // Content
      Scroll() {
        Column() {
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(C_ON_BG)
            .width('100%')
            .margin({ bottom: 12 })

          MapArea({ pins: this.pins })
            .width('100%')

          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(C_ON_BG)
            .width('100%')
            .margin({ top: 16, bottom: 12 })

          Scroll() {
            Row({ space: 16 }) {
              ForEach(this.coupons, (c: CouponData) => {
                CouponCard({ coupon: c })
              })
            }
            .padding({ left: 4, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Row({ space: 12 }) {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(C_SECONDARY)
              .fontColor(C_ON_BG)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(20)

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(C_PRIMARY)
              .fontColor(C_ON_PRI)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(20)
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .padding(16)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4026C6DA', 0.0],
        ['#FFF5F7FF', 0.5],
        ['#407B61FF', 1.0]
      ]
    })
  }
}