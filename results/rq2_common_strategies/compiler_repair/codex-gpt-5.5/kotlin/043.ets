class CartItem {
  id: number;
  name: string;
  price: string;

  constructor(id: number, name: string, price: string) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

class CartColors {
  static primary: string = '#00E5FF';
  static secondary: string = '#00BFA5';
  static tertiary: string = '#69F0AE';
  static background: string = '#0A0A0A';
  static surface: string = '#121212';
  static surfaceVariant: string = '#1E1E1E';
  static outline: string = '#2C2C2C';
  static onPrimary: string = '#0A0A0A';
  static onSecondary: string = '#0A0A0A';
  static onSurface: string = '#FFFFFF';
}

@Entry
@Component
struct Index {
  @State promo: string = '';

  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', '$89.99'),
    new CartItem(2, 'Wireless Mouse', '$49.99'),
    new CartItem(3, 'Gaming Headset', '$109.99')
  ];

  @Builder
  CartCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
          .lineHeight(24)
        Text(item.price)
          .fontSize(14)
          .fontColor(CartColors.secondary)
          .lineHeight(20)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CartColors.onPrimary)
        .height(36)
        .backgroundColor(CartColors.primary)
        .borderRadius(10)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CartColors.surface)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#2600E5FF', offsetX: 0, offsetY: 2 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Row() {
        Text('Items:')
          .fontSize(14)
          .fontColor(CartColors.onSurface)
        Text('3')
          .fontSize(14)
          .fontColor(CartColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text('Total:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
        Text('$249.97')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(14)
    .backgroundColor(CartColors.surfaceVariant)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#2600E5FF', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(CartColors.primary)
        .lineHeight(34)
        .width('100%')

      ForEach(this.items, (item: CartItem) => {
        Column() {
          this.CartCard(item)
        }
        .width('100%')
        .margin({ top: 10 })
      }, (item: CartItem) => item.id.toString())

      TextInput({ text: this.promo, placeholder: 'Promo Code' })
        .width('100%')
        .height(48)
        .fontColor(CartColors.onSurface)
        .placeholderColor('#80FFFFFF')
        .backgroundColor(CartColors.surface)
        .border({ width: 1, color: CartColors.outline, radius: 10 })
        .borderRadius(10)
        .onChange((value: string) => {
          this.promo = value;
        })
        .margin({ top: 20 })

      Column() {
        this.SummaryCard()
      }
      .width('100%')
      .margin({ top: 20 })

      Button('Checkout')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(CartColors.onSecondary)
        .width('100%')
        .height(56)
        .backgroundColor(CartColors.secondary)
        .borderRadius(14)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[CartColors.background, 0.0], [CartColors.surfaceVariant, 1.0]]
    })
  }
}
