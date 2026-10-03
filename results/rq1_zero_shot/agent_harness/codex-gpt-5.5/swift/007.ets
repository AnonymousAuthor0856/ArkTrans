class CartItem {
  id: number;
  name: string;
  price: number;
  color: string;

  constructor(id: number, name: string, price: number, color: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.color = color;
  }
}

@Entry
@Component
struct ShoppingCartAppView {
  @State private quantities: number[] = [1, 1, 1, 1];

  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, '#FF6F00'),
    new CartItem(2, 'Smartphone Case', 24.99, '#000000'),
    new CartItem(3, 'USB-C Cable', 19.99, '#4CAF50'),
    new CartItem(4, 'Portable Charger', 49.99, '#FF6F00')
  ];
  private shipping: number = 5.99;
  private tax: number = 18.50;

  private subtotal(): number {
    let sum = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax;
  }

  private money(value: number): string {
    return '$' + value.toFixed(2);
  }

  private changeQuantity(index: number, delta: number): void {
    const next = this.quantities.slice();
    const current = next[index];
    const updated = current + delta;
    if (updated >= 1 && updated <= 10) {
      next[index] = updated;
      this.quantities = next;
    }
  }

  @Builder
  FeatureBox() {
    Rect()
      .width(28)
      .height(28)
      .radius(6)
      .fill('#F5F5F5')
  }

  @Builder
  QuantityButton(symbol: string, index: number, delta: number) {
    Button(symbol)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .backgroundColor('#F5F5F5')
      .width(28)
      .height(28)
      .borderRadius(6)
      .onClick(() => {
        this.changeQuantity(index, delta);
      })
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row() {
      Rect()
        .width(60)
        .height(60)
        .radius(8)
        .fill(item.color)

      Column() {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .width(120)
          .maxLines(2)
        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#000000')
          .margin({ top: 2 })
        Row() {
          this.FeatureBox()
          this.FeatureBox().margin({ left: 4 })
          this.FeatureBox().margin({ left: 4 })
        }
        .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 8 })

      Column() {
        this.QuantityButton('+', index, 1)
        Text(this.quantities[index].toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 4, bottom: 4 })
        this.QuantityButton('-', index, -1)
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#F44336')
        .width(85)
        .height(36)
        .borderRadius(8)
        .margin({ left: 8 })
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E0E0E0', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ChipsRow() {
    Row() {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0', radius: 6 })
          .borderRadius(6)
          .height(28)
          .padding({ left: 12, right: 12 })
          .margin({ right: 4 })
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.SemiBold : FontWeight.Regular)
        .fontColor('#000000')
      Blank()
      Text(this.money(value))
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.SemiBold : FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
  }

  @Builder
  BottomSummary() {
    Column() {
      this.SummaryRow('Subtotal', this.subtotal(), false)
      this.SummaryRow('Shipping', this.shipping, false).margin({ top: 6 })
      this.SummaryRow('Tax', this.tax, false).margin({ top: 6 })
      this.SummaryRow('Total', this.total(), true).margin({ top: 6 })
      Button('Proceed to Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#000000')
        .width('100%')
        .height(44)
        .borderRadius(12)
        .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 1.5 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill('#000000')
            .radius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
            .margin({ left: 4 })
        }
        .justifyContent(FlexAlign.Center)
        .padding({ top: 46, bottom: 26 })

        Scroll() {
          Column() {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.CartItemCard(item, index)
                .margin({ bottom: 8 })
            }, (item: CartItem) => item.id.toString())
            this.ChipsRow()
            Blank().height(228)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 228 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      this.BottomSummary()
        .margin({ left: 8, right: 8, bottom: 6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
