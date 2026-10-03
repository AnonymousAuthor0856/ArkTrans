import { router } from '@kit.ArkUI';

// Color tokens
const Colors = {
  primary: '#FF000000',
  secondary: '#FFFF6F00',
  tertiary: '#FF4CAF50',
  background: '#FFFFFFFF',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFF5F5F5',
  outline: '#FFE0E0E0',
  success: '#FF4CAF50',
  warning: '#FFFF9800',
  error: '#FFF44336',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FFFFFFFF',
  onTertiary: '#FFFFFFFF',
  onBackground: '#FF000000',
  onSurface: '#FF000000',
};

interface CartItemData {
  id: number;
  name: string;
  price: number;
  color: string;
}

const cartItemsData: CartItemData[] = [
  { id: 1, name: 'Wireless Headphones', price: 129.99, color: Colors.secondary },
  { id: 2, name: 'Smartphone Case', price: 24.99, color: Colors.primary },
  { id: 3, name: 'USB-C Cable', price: 19.99, color: Colors.tertiary },
  { id: 4, name: 'Portable Charger', price: 49.99, color: Colors.secondary },
];

@Entry
@Component
struct RootScreen {
  @State quantities: number[] = [1, 1, 1, 1];
  private shipping: number = 5.99;
  private tax: number = 18.50;

  getSubtotal(): number {
    let sum = 0;
    for (let i = 0; i < cartItemsData.length; i++) {
      sum += cartItemsData[i].price * this.quantities[i];
    }
    return sum;
  }

  getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(Colors.primary)
            .borderRadius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      // Main content
      List({ space: 8 }) {
        ForEach(cartItemsData, (item: CartItemData, index: number) => {
          ListItem() {
            Row({ space: 8 }) {
              // Product color box
              Box()
                .width(60)
                .height(60)
                .backgroundColor(item.color)
                .borderRadius(8)

              // Product info
              Column({ space: 2 }) {
                Text(item.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text('$' + item.price.toFixed(2))
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)
                Row({ space: 4 }) {
                  Box()
                    .width(28)
                    .height(28)
                    .backgroundColor(Colors.surfaceVariant)
                    .borderRadius(6)
                  Box()
                    .width(28)
                    .height(28)
                    .backgroundColor(Colors.surfaceVariant)
                    .borderRadius(6)
                  Box()
                    .width(28)
                    .height(28)
                    .backgroundColor(Colors.surfaceVariant)
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
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(6)
                  .padding(0)
                  .onClick(() => {
                    if (this.quantities[index] < 10) {
                      let newQty = [...this.quantities];
                      newQty[index]++;
                      this.quantities = newQty;
                    }
                  })
                Text(this.quantities[index].toString())
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Button('-')
                  .width(28)
                  .height(28)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(6)
                  .padding(0)
                  .onClick(() => {
                    if (this.quantities[index] > 1) {
                      let newQty = [...this.quantities];
                      newQty[index]--;
                      this.quantities = newQty;
                    }
                  })
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)

              // Remove button
              Button('Remove')
                .height(36)
                .width(85)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.error)
                .borderRadius(8)
                .onClick(() => {})
            }
            .width('100%')
            .padding(8)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 })
          }
          .width('100%')
        }, (item: CartItemData) => item.id.toString())

        // Chips row
        ListItem() {
          Row({ space: 4 }) {
            Text('Apply Coupon')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
            Text('Gift Wrap')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
            Text('Save for Later')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')

        // Bottom spacer
        ListItem() {
          Column().height(24)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 8, right: 8, top: 6 })
      .backgroundColor(Colors.background)

      // Bottom bar
      Column({ space: 6 }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor(Colors.onSurface)
          Text('$' + this.getSubtotal().toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor(Colors.onSurface)
          Text('$' + this.shipping.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor(Colors.onSurface)
          Text('$' + this.tax.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
          Text('$' + this.getTotal().toFixed(2))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding(8)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}