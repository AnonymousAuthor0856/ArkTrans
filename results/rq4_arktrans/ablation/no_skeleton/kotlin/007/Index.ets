// src/main/ets/viewmodel/CartItem.ts
export interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

// src/main/ets/pages/MainPage.ets
@Entry
@Component
struct ShoppingCartPage {
  @State cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: '#FF6F00' },
    { id: 2, name: "Smartphone Case", price: 24.99, color: '#000000' },
    { id: 3, name: "USB-C Cable", price: 19.99, color: '#4CAF50' },
    { id: 4, name: "Portable Charger", price: 49.99, color: '#FF6F00' }
  ]
  @State quantities: number[] = [1, 1, 1, 1]

  private readonly SHIPPING: number = 5.99
  private readonly TAX: number = 18.50

  build() {
    Stack() {
      // === Scrollable Content ===
      Column() {
        // Header
        Row() {
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 16, right: 16 })

        // List of Items
        List({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            ListItem() {
              this.CartItemCard(item, index)
            }
          })

          // Chips Section
          ListItem() {
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              Button('Apply Coupon')
                .backgroundColor('#FFFFFF')
                .borderWidth(1)
                .borderColor('#E0E0E0')
                .borderRadius(6)
                .height(32)
                .margin({ bottom: 8 })
                .margin({ right: 8 })
                .fontColor('#000000')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)

              Button('Gift Wrap')
                .backgroundColor('#FFFFFF')
                .borderWidth(1)
                .borderColor('#E0E0E0')
                .borderRadius(6)
                .height(32)
                .margin({ bottom: 8 })
                .margin({ right: 8 })
                .fontColor('#000000')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)

              Button('Save for Later')
                .backgroundColor('#FFFFFF')
                .borderWidth(1)
                .borderColor('#E0E0E0')
                .borderRadius(6)
                .height(32)
                .margin({ bottom: 8 })
                .fontColor('#000000')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding({ top: 8, bottom: 16 })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 8 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // === Bottom Summary Bar ===
      Column() {
        Row() {
          Text('Subtotal').fontSize(12).fontColor('#000000')
          Blank()
          Text(`$${this.calculateSubtotal().toFixed(2)}`).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').height(24)

        Row() {
          Text('Shipping').fontSize(12).fontColor('#000000')
          Blank()
          Text(`$${this.SHIPPING.toFixed(2)}`).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').height(24)

        Row() {
          Text('Tax').fontSize(12).fontColor('#000000')
          Blank()
          Text(`$${this.TAX.toFixed(2)}`).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').height(24)

        Row() {
          Text('Total').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
          Blank()
          Text(`$${this.calculateTotal().toFixed(2)}`).fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
        }.width('100%').height(24)

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#EAEAEA')
      .shadow({ radius: 10, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row() {
      // Image Placeholder
      Image($r('app.media.startIcon'))
        .width(60)
        .height(60)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .backgroundColor(item.color)

      Column() {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 4 })

        // Decorative placeholders from screenshot
        Row() {
          Column().width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).margin({ right: 4 })
          Column().width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).margin({ right: 4 })
          Column().width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6)
        }.margin({ top: 8 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Quantity Controls
      Column() {
        Button('+')
          .width(28)
          .height(28)
          .backgroundColor('#F5F5F5')
          .fontColor('#000000')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            if (this.quantities[index] < 10) {
              this.quantities[index]++
            }
          })

        Text(`${this.quantities[index]}`)
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
          .onClick(() => {
            if (this.quantities[index] > 1) {
              this.quantities[index]--
            }
          })
      }
      .margin({ right: 16 })

      // Remove Button
      Button('Remove')
        .width(85)
        .height(36)
        .backgroundColor('#F44336')
        .fontColor('#FFFFFF')
        .borderRadius(8)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E0E0E0' })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 1 })
  }

  calculateSubtotal(): number {
    let sum = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  calculateTotal(): number {
    return this.calculateSubtotal() + this.SHIPPING + this.TAX
  }
}