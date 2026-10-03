import router from '@ohos.router';

interface CartItemData {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItemData[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  private shipping: number = 5.99;
  private tax: number = 18.50;

  private getSubtotal(): number {
    let total = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      total += this.cartItems[i].price * this.quantities[i];
    }
    return total;
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  @Builder
  TopBar() {
    Row({ space: 4 }) {
      Column()
        .width(20)
        .height(20)
        .borderRadius(6)
        .backgroundColor('#000000')

      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 16, bottom: 6 })
  }

  @Builder
  FeatureBox() {
    Column()
      .width(28)
      .height(28)
      .borderRadius(6)
      .backgroundColor('#F5F5F5')
  }

  @Builder
  QuantityButton(symbol: string, onAction: () => void) {
    Button(symbol)
      .width(28)
      .height(28)
      .borderRadius(6)
      .backgroundColor('#F5F5F5')
      .fontColor('#000000')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .onClick(onAction)
  }

  @Builder
  CartItemCard(item: CartItemData, index: number) {
    Row({ space: 8 }) {
      Column()
        .width(60)
        .height(60)
        .borderRadius(8)
        .backgroundColor(item.color)

      Column({ space: 2 }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)

        Text('$' + item.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Row({ space: 4 }) {
          this.FeatureBox()
          this.FeatureBox()
          this.FeatureBox()
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 4 }) {
        this.QuantityButton('+', () => {
          if (this.quantities[index] < 10) {
            let newQty = [...this.quantities];
            newQty[index] += 1;
            this.quantities = newQty;
          }
        })

        Text('' + this.quantities[index])
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        this.QuantityButton('-', () => {
          if (this.quantities[index] > 1) {
            let newQty = [...this.quantities];
            newQty[index] -= 1;
            this.quantities = newQty;
          }
        })
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .width(85)
        .height(36)
        .borderRadius(8)
        .backgroundColor('#F44336')
        .fontColor('#FFFFFF')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
    }
    .padding(8)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E0E0E0' })
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ChipsRow() {
    Row({ space: 4 }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#FFFFFF')
          .borderRadius(6)
          .border({ width: 1, color: '#E0E0E0' })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .height(28)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Normal)
        .fontColor('#000000')

      Blank()

      Text('$' + value.toFixed(2))
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
  }

  @Builder
  BottomSummary() {
    Column({ space: 6 }) {
      this.SummaryRow('Subtotal', this.getSubtotal())
      this.SummaryRow('Shipping', this.shipping)
      this.SummaryRow('Tax', this.tax)
      this.SummaryRow('Total', this.getTotal(), true)

      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .borderRadius(12)
        .backgroundColor('#000000')
        .fontColor('#FFFFFF')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
    }
    .padding(8)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: 8 }) {
            ForEach(this.cartItems, (item: CartItemData, index: number) => {
              this.CartItemCard(item, index)
            })

            this.ChipsRow()

            Column().height(230)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 8 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Column() {
        this.BottomSummary()
      }
      .padding({ left: 8, right: 8, bottom: 6 })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}