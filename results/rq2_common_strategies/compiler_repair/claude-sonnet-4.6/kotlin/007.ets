import { router } from '@kit.ArkUI';

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
    { id: 1, name: "Wireless Headphones", price: 129.99, color: "#FFFF6F00" },
    { id: 2, name: "Smartphone Case", price: 24.99, color: "#FF000000" },
    { id: 3, name: "USB-C Cable", price: 19.99, color: "#FF4CAF50" },
    { id: 4, name: "Portable Charger", price: 49.99, color: "#FFFF6F00" }
  ];

  private shipping: number = 5.99;
  private tax: number = 18.50;

  getSubtotal(): number {
    let sum = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  formatPrice(value: number): string {
    return '$' + value.toFixed(2);
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Column()
            .width(20)
            .height(20)
            .backgroundColor('#FF000000')
            .borderRadius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF000000')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFFFF')
      .border({ width: { bottom: 1 }, color: '#FFE0E0E0' })

      // Main Content
      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            Column() {
              Row({ space: 8 }) {
                // Item color box
                Column()
                  .width(60)
                  .height(60)
                  .backgroundColor(item.color)
                  .borderRadius(8)

                // Item details
                Column({ space: 2 }) {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FF000000')
                  Text(this.formatPrice(item.price))
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FF000000')
                  Row({ space: 4 }) {
                    Column()
                      .width(28)
                      .height(28)
                      .backgroundColor('#FFF5F5F5')
                      .borderRadius(6)
                    Column()
                      .width(28)
                      .height(28)
                      .backgroundColor('#FFF5F5F5')
                      .borderRadius(6)
                    Column()
                      .width(28)
                      .height(28)
                      .backgroundColor('#FFF5F5F5')
                      .borderRadius(6)
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                // Quantity controls
                Column({ space: 4 }) {
                  Button('+')
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FF000000')
                    .backgroundColor('#FFF5F5F5')
                    .borderRadius(6)
                    .padding(0)
                    .onClick(() => {
                      if (this.quantities[index] < 10) {
                        let newQuantities = [...this.quantities];
                        newQuantities[index]++;
                        this.quantities = newQuantities;
                      }
                    })
                  Text(this.quantities[index].toString())
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FF000000')
                  Button('-')
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FF000000')
                    .backgroundColor('#FFF5F5F5')
                    .borderRadius(6)
                    .padding(0)
                    .onClick(() => {
                      if (this.quantities[index] > 1) {
                        let newQuantities = [...this.quantities];
                        newQuantities[index]--;
                        this.quantities = newQuantities;
                      }
                    })
                }
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)

                // Remove button
                Button('Remove')
                  .width(85)
                  .height(36)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFFFF')
                  .backgroundColor('#FFF44336')
                  .borderRadius(8)
              }
              .width('100%')
              .padding(8)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .constraintSize({ minHeight: 100 })
            .backgroundColor('#FFFFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#FFE0E0E0' })
            .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 })
          })

          // Chips row
          Row({ space: 4 }) {
            Text('Apply Coupon')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF000000')
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#FFE0E0E0' })

            Text('Gift Wrap')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF000000')
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#FFE0E0E0' })

            Text('Save for Later')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF000000')
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#FFE0E0E0' })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Column()
            .height(24)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFFFF')

      // Bottom Bar
      Column({ space: 6 }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor('#FF000000')
          Text(this.formatPrice(this.getSubtotal()))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor('#FF000000')
          Text(this.formatPrice(this.shipping))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor('#FF000000')
          Text(this.formatPrice(this.tax))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF000000')
          Text(this.formatPrice(this.getTotal()))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFFFF')
          .backgroundColor('#FF000000')
          .borderRadius(12)
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }
}