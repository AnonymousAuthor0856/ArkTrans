@Entry
@Component
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1]
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ]
  private readonly shipping: number = 5.99
  private readonly tax: number = 18.50

  private getSubtotal(): number {
    let sum = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill('#000000')
            .borderRadius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // Content - scrollable list
      Scroll() {
        Column({ space: 8 }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            // Cart Item Card
            Row({ space: 8 }) {
              // Product image placeholder
              Rect()
                .width(60)
                .height(60)
                .fill(item.color)
                .borderRadius(8)

              // Product info
              Column({ space: 2 }) {
                Text(item.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                Text(`$${item.price.toFixed(2)}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                // Color swatches
                Row({ space: 4 }) {
                  Rect().width(28).height(28).fill('#F5F5F5').borderRadius(6)
                  Rect().width(28).height(28).fill('#F5F5F5').borderRadius(6)
                  Rect().width(28).height(28).fill('#F5F5F5').borderRadius(6)
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Quantity controls
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

              // Remove button
              Button('Remove')
                .width(85)
                .height(36)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .backgroundColor('#F44336')
                .borderRadius(8)
                .onClick(() => {})
            }
            .width('100%')
            .padding(8)
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#E0E0E0', radius: 12 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
          }, (item: CartItem) => item.id.toString())

          // Action chips row
          Row({ space: 4 }) {
            Button('Apply Coupon')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E0E0E0', radius: 6 })
              .onClick(() => {})
            Button('Gift Wrap')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E0E0E0', radius: 6 })
              .onClick(() => {})
            Button('Save for Later')
              .height(32)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E0E0E0', radius: 6 })
              .onClick(() => {})
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFF')

      // Bottom bar - summary and checkout
      Column({ space: 6 }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor('#000000')
          Text(`$${this.getSubtotal().toFixed(2)}`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor('#000000')
          Text(`$${this.shipping.toFixed(2)}`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor('#000000')
          Text(`$${this.tax.toFixed(2)}`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          Text(`$${this.getTotal().toFixed(2)}`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Proceed to Checkout')
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
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
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
