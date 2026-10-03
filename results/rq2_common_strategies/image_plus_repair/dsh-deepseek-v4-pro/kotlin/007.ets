interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State quantities: number[] = [1, 1, 1, 1];

  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' },
  ];

  private shipping: number = 5.99;
  private tax: number = 18.50;

  private subtotal(): number {
    let sum: number = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax;
  }

  private increment(index: number): void {
    if (this.quantities[index] < 10) {
      const next: number[] = this.quantities.slice();
      next[index] = next[index] + 1;
      this.quantities = next;
    }
  }

  private decrement(index: number): void {
    if (this.quantities[index] > 1) {
      const next: number[] = this.quantities.slice();
      next[index] = next[index] - 1;
      this.quantities = next;
    }
  }

  @Builder
  private Chip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
      .onClick(() => {})
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Row({ space: 4 }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor('#000000')
            .borderRadius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(600)
            .fontColor('#000000')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            Column() {
              Row({ space: 8 }) {
                Row()
                  .width(60)
                  .height(60)
                  .backgroundColor(item.color)
                  .borderRadius(8)

                Column({ space: 2 }) {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Text('$' + item.price.toFixed(2))
                    .fontSize(18)
                    .fontWeight(600)
                    .fontColor('#000000')
                  Row({ space: 4 }) {
                    Row()
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(6)
                    Row()
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(6)
                    Row()
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(6)
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Column({ space: 4 }) {
                  Button('+', { type: ButtonType.Normal })
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                    .backgroundColor('#F5F5F5')
                    .borderRadius(6)
                    .onClick(() => {
                      this.increment(index);
                    })
                  Text(this.quantities[index].toString())
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Button('-', { type: ButtonType.Normal })
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                    .backgroundColor('#F5F5F5')
                    .borderRadius(6)
                    .onClick(() => {
                      this.decrement(index);
                    })
                }
                .alignItems(HorizontalAlign.Center)

                Button('Remove', { type: ButtonType.Normal })
                  .width(85)
                  .height(36)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#F44336')
                  .borderRadius(8)
              }
              .width('100%')
              .padding(8)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .constraintSize({ minHeight: 100 })
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#E0E0E0' })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
          }, (item: CartItem) => item.id.toString())

          // Assist chips row
          Row({ space: 4 }) {
            this.Chip('Apply Coupon')
            this.Chip('Gift Wrap')
            this.Chip('Save for Later')
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)

      // Bottom bar
      Column({ space: 6 }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text('$' + this.subtotal().toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text('$' + this.shipping.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text('$' + this.tax.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(600)
            .fontColor('#000000')
          Blank()
          Text('$' + this.total().toFixed(2))
            .fontSize(18)
            .fontWeight(600)
            .fontColor('#000000')
        }
        .width('100%')

        Button('Proceed to Checkout', { type: ButtonType.Normal })
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#000000')
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
