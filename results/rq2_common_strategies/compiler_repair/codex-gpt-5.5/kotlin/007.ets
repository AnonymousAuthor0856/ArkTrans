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

class CartColors {
  static primary: string = '#000000';
  static secondary: string = '#FF6F00';
  static tertiary: string = '#4CAF50';
  static background: string = '#FFFFFF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F5F5F5';
  static outline: string = '#E0E0E0';
  static error: string = '#F44336';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#000000';
}

@Entry
@Component
struct Index {
  @State q1: number = 1;
  @State q2: number = 1;
  @State q3: number = 1;
  @State q4: number = 1;

  private shipping: number = 5.99;
  private tax: number = 18.50;
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, CartColors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, CartColors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, CartColors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, CartColors.secondary)
  ];

  private quantityFor(id: number): number {
    if (id === 1) {
      return this.q1;
    }
    if (id === 2) {
      return this.q2;
    }
    if (id === 3) {
      return this.q3;
    }
    return this.q4;
  }

  private changeQuantity(id: number, delta: number): void {
    if (id === 1) {
      this.q1 = Math.min(10, Math.max(1, this.q1 + delta));
    } else if (id === 2) {
      this.q2 = Math.min(10, Math.max(1, this.q2 + delta));
    } else if (id === 3) {
      this.q3 = Math.min(10, Math.max(1, this.q3 + delta));
    } else {
      this.q4 = Math.min(10, Math.max(1, this.q4 + delta));
    }
  }

  private subtotal(): number {
    let total: number = 0;
    for (let index = 0; index < this.cartItems.length; index++) {
      let item: CartItem = this.cartItems[index];
      total += item.price * this.quantityFor(item.id);
    }
    return total;
  }

  private money(value: number): string {
    return '$' + value.toFixed(2);
  }

  @Builder
  SmallChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(CartColors.onSurface)
      .lineHeight(14)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(CartColors.surface)
      .border({ width: 1, color: CartColors.outline, radius: 6 })
  }

  @Builder
  QuantityButton(label: string, itemId: number, delta: number) {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(CartColors.onSurface)
      .backgroundColor(CartColors.surfaceVariant)
      .borderRadius(6)
      .width(28)
      .height(28)
      .onClick(() => {
        this.changeQuantity(itemId, delta);
      })
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row({ space: 8 }) {
      Blank()
        .width(60)
        .height(60)
        .backgroundColor(item.color)
        .borderRadius(8)

      Column({ space: 2 }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
          .lineHeight(18)
        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
          .lineHeight(24)
        Row({ space: 4 }) {
          Blank().width(28).height(28).backgroundColor(CartColors.surfaceVariant).borderRadius(6)
          Blank().width(28).height(28).backgroundColor(CartColors.surfaceVariant).borderRadius(6)
          Blank().width(28).height(28).backgroundColor(CartColors.surfaceVariant).borderRadius(6)
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)

      Column({ space: 4 }) {
        this.QuantityButton('+', item.id, 1)
        Text(this.quantityFor(item.id).toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
          .lineHeight(18)
        this.QuantityButton('-', item.id, -1)
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(CartColors.onPrimary)
        .backgroundColor(CartColors.error)
        .borderRadius(8)
        .height(36)
        .width(85)
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(8)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CartColors.surface)
    .border({ width: 1, color: CartColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  SummaryRow(label: string, value: string, strong: boolean = false) {
    Row() {
      Text(label)
        .fontSize(strong ? 18 : 12)
        .fontWeight(strong ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(CartColors.onSurface)
        .lineHeight(strong ? 24 : 16)
      Text(value)
        .fontSize(strong ? 18 : 14)
        .fontWeight(FontWeight.Medium)
        .fontColor(CartColors.onSurface)
        .lineHeight(strong ? 24 : 18)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Row({ space: 4 }) {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(CartColors.primary)
          .borderRadius(6)
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onSurface)
          .lineHeight(28)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem) => {
            this.CartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Row({ space: 4 }) {
            this.SmallChip('Apply Coupon')
            this.SmallChip('Gift Wrap')
            this.SmallChip('Save for Later')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Blank().height(16)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')

      Column({ space: 6 }) {
        this.SummaryRow('Subtotal', this.money(this.subtotal()))
        this.SummaryRow('Shipping', this.money(this.shipping))
        this.SummaryRow('Tax', this.money(this.tax))
        this.SummaryRow('Total', this.money(this.subtotal() + this.shipping + this.tax), true)
        Button('Proceed to Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(CartColors.onPrimary)
          .backgroundColor(CartColors.primary)
          .borderRadius(12)
          .width('100%')
          .height(44)
      }
      .width('100%')
      .padding(8)
      .backgroundColor(CartColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CartColors.background)
  }
}
