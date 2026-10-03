@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: Array<CartItem> = [
    new CartItem(1, 'Wireless Headphones', 129.99, '#FF6F00'),
    new CartItem(2, 'Smartphone Case', 24.99, '#000000'),
    new CartItem(3, 'USB-C Cable', 19.99, '#4CAF50'),
    new CartItem(4, 'Portable Charger', 49.99, '#FF6F00')
  ]
  @State private quantities: Array<number> = [1, 1, 1, 1]
  private shipping: number = 5.99
  private tax: number = 18.50
  private bottomBarHeight: number = 220

  private getSubtotal(): number {
    let subtotal: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      subtotal += this.cartItems[i].price * this.quantities[i]
    }
    return subtotal
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  @Builder
  TopBar() {
    Row({ space: 4 }) {
      Rect()
        .fill('#000000')
        .width(20)
        .height(20)
        .borderRadius(6)
      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 24, bottom: 6 })
  }

  @Builder
  FeatureBox() {
    Rect()
      .fill('#F5F5F5')
      .width(28)
      .height(28)
      .borderRadius(6)
  }

  @Builder
  QuantityButton(symbol: string, index: number) {
    Button() {
      if (symbol === '+') {
        if (this.quantities[index] < 10) {
          this.quantities[index] += 1
        }
      } else {
        if (this.quantities[index] > 1) {
          this.quantities[index] -= 1
        }
      }
    }
    .width(28)
    .height(28)
    .backgroundColor('#F5F5F5')
    .borderRadius(6)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)

    Text(symbol)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row({ space: 8 }) {
      Rect()
        .fill(item.color)
        .width(60)
        .height(60)
        .borderRadius(8)

      Column({ space: 2 }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .width(120)
          .maxLines(2)
          .textAlign(TextAlign.Start)

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
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
        this.QuantityButton('+', index)
        Text(`${this.quantities[index]}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        this.QuantityButton('-', index)
      }
      .alignItems(HorizontalAlign.Center)

      Button() {
      }
      .width(85)
      .height(36)
      .backgroundColor('#F44336')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E0E0E0' })
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.14)', offsetY: 1 })
  }

  @Builder
  ChipsRow() {
    Row({ space: 4 }) {
      Button() {
      }
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })

      Text('Apply Coupon')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Button() {
      }
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })

      Text('Gift Wrap')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Button() {
      }
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })

      Text('Save for Later')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.Medium : FontWeight.Regular)
        .fontColor('#000000')
      Blank()
      Text(`$${value.toFixed(2)}`)
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.Medium : FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
  }

  @Builder
  BottomSummary() {
    Column({ space: 6 }) {
      this.SummaryRow('Subtotal', this.getSubtotal(), false)
      this.SummaryRow('Shipping', this.shipping, false)
      this.SummaryRow('Tax', this.tax, false)
      this.SummaryRow('Total', this.getTotal(), true)

      Button() {
      }
      .width('100%')
      .height(44)
      .backgroundColor('#000000')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text('Proceed to Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.16)', offsetY: 1.5 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: 6 }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.CartItemCard(item, index)
            }, (item: CartItem, index: number) => `${item.id}_${index}`)

            this.ChipsRow()
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: this.bottomBarHeight + 8 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        this.BottomSummary()
      }
      .width('100%')
      .padding({ left: 8, right: 8, bottom: 6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

class CartItem {
  id: number
  name: string
  price: number
  color: string

  constructor(id: number, name: string, price: number, color: string) {
    this.id = id
    this.name = name
    this.price = price
    this.color = color
  }
}