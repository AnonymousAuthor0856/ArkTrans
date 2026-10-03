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

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', '#7B61FF', '#26C6DA'),
    new Coupon(2, 'Cafe Bundle', '-15%', '#26C6DA', '#FF8A80'),
    new Coupon(3, 'Electro Deal', '-$20', '#FF8A80', '#7B61FF'),
    new Coupon(4, 'Fashion Duo', '-10%', '#26C6DA', '#7B61FF')
  ];
  private pins: MapPin[] = [
    new MapPin(140, 220, 'A', '#7B61FF'),
    new MapPin(320, 400, 'B', '#26C6DA'),
    new MapPin(520, 300, 'C', '#FF8A80')
  ];

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Rect()
        .width('100%')
        .aspectRatio(16 / 9)
        .fill('#F0F2F8')
        .radius(20)
      ForEach(this.pins, (pin: MapPin) => {
        Circle()
          .width(28)
          .height(28)
          .fill(pin.tint)
          .position({ x: pin.x, y: pin.y })
      }, (pin: MapPin) => pin.label)
      Row() {
        Circle().width(10).height(10).fill('#7B61FF')
        Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
        Circle().width(10).height(10).fill('#26C6DA').margin({ left: 8 })
        Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
        Circle().width(10).height(10).fill('#FF8A80').margin({ left: 8 })
        Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
      }
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(8)
      .margin(12)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Row() {
        Circle().width(14).height(14).fill('#7B61FF')
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .margin({ left: 8 })
      }
      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .margin({ top: 8 })
      Button('Redeem')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#7B61FF')
        .width('100%')
        .height(40)
        .borderRadius(14)
        .margin({ top: 8 })
    }
    .width(200)
    .height(140)
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
    .margin({ right: 16 })
  }

  build() {
    Column() {
      Row() {
        Button() { Circle().width(20).height(20).fill('#0B1220') }
          .backgroundColor(Color.Transparent)
          .padding({ left: 16 })
        Blank()
        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
        Blank()
        Button() { Circle().width(20).height(20).fill('#7B61FF') }
          .backgroundColor(Color.Transparent)
          .padding({ right: 16 })
      }
      .width('100%')
      .padding({ top: 16 })

      Column() {
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
          .width('100%')
        this.MapArea()
          .margin({ top: 16 })
        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
          .width('100%')
          .margin({ top: 16 })
        Scroll() {
          Row() {
            ForEach(this.coupons, (coupon: Coupon) => {
              this.CouponCard(coupon)
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .margin({ top: 16 })

        Blank()
        Row() {
          Button('My Coupons')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .backgroundColor('#26C6DA')
            .height(52)
            .borderRadius(20)
            .layoutWeight(1)
          Button('Explore More')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#7B61FF')
            .height(52)
            .borderRadius(20)
            .layoutWeight(1)
            .margin({ left: 12 })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FF')
  }
}
