@Entry
@Component
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1]
  private readonly shipping: number = 5.99
  private readonly tax: number = 18.50

  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ]

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
      // Top bar
      Row() {
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
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      // Cart items list
      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            // Item card
            Row() {
              // Product image placeholder
              Rect()
                .width(60)
                .height(60)
                .fill(item.color)
                .radius(8)

              // Item info
              Column() {
                Text(item.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                Text('$' + item.price.toFixed(2))
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor('#000000')
                  .margin({ top: 2 })
                Row() {
                  Rect().width(28).height(28).fill('#F5F5F5').radius(6)
                  Rect().width(28).height(28).fill('#F5F5F5').radius(6).margin({ left: 4 })
                  Rect().width(28).height(28).fill('#F5F5F5').radius(6).margin({ left: 4 })
                }
                .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 8 })

              // Quantity selector
              Column() {
                Button('+')
                  .width(28)
                  .height(28)
                  .backgroundColor('#F5F5F5')
                  .fontColor('#000000')
                  .fontSize(14)
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
                  .margin({ top: 4, bottom: 4 })
                Button('-')
                  .width(28)
                  .height(28)
                  .backgroundColor('#F5F5F5')
                  .fontColor('#000000')
                  .fontSize(14)
                  .borderRadius(6)
                  .onClick(() => {
                    if (this.quantities[index] > 1) {
                      this.quantities[index]--
                    }
                  })
              }
              .alignItems(HorizontalAlign.Center)
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
            .shadow({
              radius: 4,
              color: 'rgba(0,0,0,0.14)',
              offsetX: 0,
              offsetY: 1
            })
            .margin({ bottom: 8 })
          }, (item: CartItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFF')

      // Bottom summary bar
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
        .margin({ top: 6 })

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
        .margin({ top: 6 })

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
          Text('$' + this.getTotal().toFixed(2))
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 6 })

        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#EAEAEA')
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
