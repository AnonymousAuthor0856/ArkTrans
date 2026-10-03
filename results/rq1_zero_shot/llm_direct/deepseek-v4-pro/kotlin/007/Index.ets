@Entry
@Component
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1]
  private cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: '#FF6F00' },
    { id: 2, name: "Smartphone Case", price: 24.99, color: '#000000' },
    { id: 3, name: "USB-C Cable", price: 19.99, color: '#4CAF50' },
    { id: 4, name: "Portable Charger", price: 49.99, color: '#FF6F00' }
  ]
  private shipping: number = 5.99
  private tax: number = 18.50

  private getSubtotal(): number {
    let subtotal = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      subtotal += this.cartItems[i].price * this.quantities[i]
    }
    return subtotal
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  private formatPrice(value: number): string {
    return '$' + value.toFixed(2)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Rect()
            .width(20)
            .height(20)
            .radius(6)
            .fill('#000000')
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Cart Items List
      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            Card() {
              Row({ space: 8 }) {
                Rect()
                  .width(60)
                  .height(60)
                  .radius(8)
                  .fill(item.color)

                Column({ space: 2 }) {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Text(this.formatPrice(item.price))
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Row({ space: 4 }) {
                    Rect().width(28).height(28).radius(6).fill('#F5F5F5')
                    Rect().width(28).height(28).radius(6).fill('#F5F5F5')
                    Rect().width(28).height(28).radius(6).fill('#F5F5F5')
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Column({ space: 4 }) {
                  Button('+')
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                    .backgroundColor('#F5F5F5')
                    .borderRadius(6)
                    .onClick(() => {
                      if (this.quantities[index] < 10) {
                        this.quantities[index]++
                      }
                    })
                  Text(this.quantities[index].toString())
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Button('-')
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                    .backgroundColor('#F5F5F5')
                    .borderRadius(6)
                    .onClick(() => {
                      if (this.quantities[index] > 1) {
                        this.quantities[index]--
                      }
                    })
                }
                .alignItems(HorizontalAlign.Center)

                Button('Remove')
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
            .borderRadius(12)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#E0E0E0' })
          })

          // Action Chips
          Row({ space: 4 }) {
            Button('Apply Coupon')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#E0E0E0' })
            Button('Gift Wrap')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#E0E0E0' })
            Button('Save for Later')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#E0E0E0' })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column({ space: 6 }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text(this.formatPrice(this.getSubtotal()))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text(this.formatPrice(this.shipping))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor('#000000')
          Blank()
          Text(this.formatPrice(this.tax))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          Blank()
          Text(this.formatPrice(this.getTotal()))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#000000')
          .borderRadius(12)
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.16)', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface CartItem {
  id: number
  name: string
  price: number
  color: string
}