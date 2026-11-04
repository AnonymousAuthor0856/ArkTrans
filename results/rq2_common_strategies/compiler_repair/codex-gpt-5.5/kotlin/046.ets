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

class CouponPin {
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

class CouponColors {
  static primary: string = '#7B61FF';
  static secondary: string = '#26C6DA';
  static tertiary: string = '#FF8A80';
  static background: string = '#F5F7FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F0F2F8';
  static outline: string = '#E0E3EB';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0B1220';
  static onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', CouponColors.primary, CouponColors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', CouponColors.secondary, CouponColors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', CouponColors.tertiary, CouponColors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', CouponColors.secondary, CouponColors.primary)
  ];

  private pins: CouponPin[] = [
    new CouponPin(140, 220, 'A', CouponColors.primary),
    new CouponPin(320, 400, 'B', CouponColors.secondary),
    new CouponPin(520, 300, 'C', CouponColors.tertiary)
  ];

  @Builder
  PinView(pin: CouponPin) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(28)
        .height(28)
        .fill(pin.tint)
      Text(pin.label)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CouponColors.onPrimary)
    }
    .width(32)
    .height(32)
    .position({ x: pin.x / 1.8, y: pin.y / 2.4 })
  }

  @Builder
  MapPanel() {
    Stack() {
      Text('')
        .width('100%')
        .height('100%')
        .backgroundColor(CouponColors.surfaceVariant)
      ForEach(this.pins, (pin: CouponPin) => {
        this.PinView(pin)
      }, (pin: CouponPin) => pin.label)
      Row({ space: 8 }) {
        Circle().width(10).height(10).fill(CouponColors.primary)
        Text('A').fontSize(12).fontColor(CouponColors.onSurface)
        Circle().width(10).height(10).fill(CouponColors.secondary)
        Text('B').fontSize(12).fontColor(CouponColors.onSurface)
        Circle().width(10).height(10).fill(CouponColors.tertiary)
        Text('C').fontSize(12).fontColor(CouponColors.onSurface)
      }
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(8)
      .position({ x: 220, y: 8 })
    }
    .width('100%')
    .aspectRatio(1.777)
    .padding(12)
    .backgroundColor(CouponColors.surface)
    .borderRadius(20)
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Row() {
        Circle()
          .width(14)
          .height(14)
          .fill(CouponColors.primary)
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(CouponColors.onSurface)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(CouponColors.onSurface)
        .lineHeight(34)
        .margin({ top: 8 })
      Button('Redeem')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CouponColors.onPrimary)
        .width('100%')
        .height(40)
        .backgroundColor(CouponColors.primary)
        .borderRadius(14)
        .margin({ top: 8 })
    }
    .width(200)
    .height(140)
    .padding(16)
    .backgroundColor(coupon.colorA)
    .opacity(0.82)
    .borderRadius(20)
    .shadow({ radius: 10, color: '#29000000', offsetX: 0, offsetY: 6 })
  }

  build() {
    Column() {
      Row() {
        Circle().width(20).height(20).fill(CouponColors.onSurface)
        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(CouponColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle().width(20).height(20).fill(CouponColors.primary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text('Nearby Packs')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(CouponColors.onSurface)
        .width('100%')
        .margin({ top: 16 })

      Column() {
        this.MapPanel()
      }
      .width('100%')
      .margin({ top: 12 })

      Text('Your Coupon Packs')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(CouponColors.onSurface)
        .width('100%')
        .margin({ top: 16 })

      Scroll() {
        Row({ space: 16 }) {
          ForEach(this.coupons, (coupon: Coupon) => {
            this.CouponCard(coupon)
          }, (coupon: Coupon) => coupon.id.toString())
        }
        .height(150)
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height(160)
      .margin({ top: 12 })

      Blank().height(8)

      Row() {
        Button('My Coupons')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CouponColors.onSecondary)
          .layoutWeight(1)
          .height(52)
          .backgroundColor(CouponColors.secondary)
          .borderRadius(20)
        Blank().width(12)
        Button('Explore More')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CouponColors.onPrimary)
          .layoutWeight(1)
          .height(52)
          .backgroundColor(CouponColors.primary)
          .borderRadius(20)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#4026C6DA', 0.0], [CouponColors.background, 0.5], ['#407B61FF', 1.0]]
    })
  }
}
