import { router } from '@kit.ArkUI';

interface CartItemData {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCartApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct RootScreen {
  private cartItems: CartItemData[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  private shipping: number = 5.99;
  private tax: number = 18.50;

  getSubtotal(): number {
    let total = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      total += this.cartItems[i].price * this.quantities[i];
    }
    return total;
  }

  getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Column()
            .width(20)
            .height(20)
            .backgroundColor('#000000')
            .borderRadius(6)

          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ left: 4 })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // Scrollable Cart Items
      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItemData, index: number) => {
            CartItemCard({
              item: item,
              quantity: this.quantities[index],
              onIncrease: () => {
                if (this.quantities[index] < 10) {
                  let newQuantities = [...this.quantities];
                  newQuantities[index]++;
                  this.quantities = newQuantities;
                }
              },
              onDecrease: () => {
                if (this.quantities[index] > 1) {
                  let newQuantities = [...this.quantities];
                  newQuantities[index]--;
                  this.quantities = newQuantities;
                }
              }
            })
              .margin({ bottom: 8 })
          })

          // Chips Row
          Row() {
            ChipButton({ label: 'Apply Coupon' })
            ChipButton({ label: 'Gift Wrap' })
              .margin({ left: 4 })
            ChipButton({ label: 'Save for Later' })
              .margin({ left: 4 })
          }
          .width('100%')
          .margin({ top: 4, bottom: 24 })
        }
        .padding({ left: 8, right: 8, top: 6 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor('#000000')
          Text('$' + this.getSubtotal().toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 6 })

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor('#000000')
          Text('$' + this.shipping.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 6 })

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor('#000000')
          Text('$' + this.tax.toFixed(2))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 6 })

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          Text('$' + this.getTotal().toFixed(2))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 8 })

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct CartItemCard {
  item: CartItemData = { id: 0, name: '', price: 0, color: '#000000' };
  quantity: number = 1;
  onIncrease: () => void = () => {};
  onDecrease: () => void = () => {};

  build() {
    Row() {
      // Product color box
      Column()
        .width(60)
        .height(60)
        .backgroundColor(this.item.color)
        .borderRadius(8)

      // Product info
      Column() {
        Text(this.item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 2 })

        Text('$' + this.item.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 4 })

        Row() {
          Column()
            .width(28)
            .height(28)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
          Column()
            .width(28)
            .height(28)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .margin({ left: 4 })
          Column()
            .width(28)
            .height(28)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 8 })

      // Quantity controls
      Column() {
        Button('+')
          .width(28)
          .height(28)
          .backgroundColor('#F5F5F5')
          .fontColor('#000000')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(6)
          .onClick(() => this.onIncrease())

        Text(this.quantity.toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 4, bottom: 4 })

        Button('-')
          .width(28)
          .height(28)
          .backgroundColor('#F5F5F5')
          .fontColor('#000000')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(6)
          .onClick(() => this.onDecrease())
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .margin({ left: 8 })

      // Remove button
      Button('Remove')
        .width(85)
        .height(36)
        .backgroundColor('#F44336')
        .fontColor('#FFFFFF')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .borderRadius(8)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding(8)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E0E0E0' })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .constraintSize({ minHeight: 100 })
  }
}

@Component
struct ChipButton {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
  }
}