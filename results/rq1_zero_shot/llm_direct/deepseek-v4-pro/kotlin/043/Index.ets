import { display } from '@kit.ArkUI';

@Entry
@Component
struct ShoppingCartPage {
  @State promoCode: string = '';
  private items: Array<CartItem> = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];

  private getTotal(): number {
    let total = 0;
    for (let item of this.items) {
      total += item.price;
    }
    return total;
  }

  private formatPrice(price: number): string {
    return '$' + price.toFixed(2);
  }

  build() {
    Column() {
      // Header
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .margin({ top: 20, bottom: 10 })
        .padding({ left: 14, right: 14 })

      // Cart Items
      ForEach(this.items, (item: CartItem) => {
        Row() {
          Column() {
            Text(item.name)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
            Text(this.formatPrice(item.price))
              .fontSize(14)
              .fontColor('#00BFA5')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button('Remove')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A0A')
            .backgroundColor('#00E5FF')
            .borderRadius(10)
            .height(36)
            .padding({ left: 16, right: 16 })
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#121212')
        .borderRadius(14)
        .margin({ bottom: 10 })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }, (item: CartItem) => item.id.toString())

      // Promo Code Input
      TextInput({ text: this.promoCode, placeholder: 'Promo Code' })
        .width('100%')
        .height(48)
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .margin({ top: 10, bottom: 10 })
        .placeholderColor('#80FFFFFF')
        .placeholderFont({ size: 14 })
        .fontColor('#FFFFFF')
        .fontSize(14)
        .onChange((value: string) => {
          this.promoCode = value;
        })

      // Summary Card
      Column() {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .layoutWeight(1)
          Text(this.items.length.toString())
            .fontSize(14)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 6 })

        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .layoutWeight(1)
          Text(this.formatPrice(this.getTotal()))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .margin({ top: 10, bottom: 10 })

      // Checkout Button
      Button('Checkout')
        .width('100%')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .backgroundColor('#00BFA5')
        .borderRadius(14)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 14, right: 14, top: 10, bottom: 10 })
    .linearGradient({
      angle: 180,
      colors: [['#0A0A0A', 0], ['#1E1E1E', 1]]
    })
    .backgroundColor('#0A0A0A')
  }
}

class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}