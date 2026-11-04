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

@Entry
@Component
struct Index {
  @State q0: number = 1
  @State q1: number = 1
  @State q2: number = 1
  @State q3: number = 1

  private cPrimary: string = '#000000'
  private cSecondary: string = '#FF6F00'
  private cTertiary: string = '#4CAF50'
  private cBg: string = '#FFFFFF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F5F5F5'
  private cLine: string = '#E0E0E0'
  private cError: string = '#F44336'
  private shipping: number = 5.99
  private tax: number = 18.50
  private chips: string[] = ['Apply Coupon', 'Gift Wrap', 'Save for Later']
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, '#FF6F00'),
    new CartItem(2, 'Smartphone Case', 24.99, '#000000'),
    new CartItem(3, 'USB-C Cable', 19.99, '#4CAF50'),
    new CartItem(4, 'Portable Charger', 49.99, '#FF6F00')
  ]

  private quantity(index: number): number {
    if (index === 0) {
      return this.q0
    }
    if (index === 1) {
      return this.q1
    }
    if (index === 2) {
      return this.q2
    }
    return this.q3
  }

  private setQuantity(index: number, value: number): void {
    if (index === 0) {
      this.q0 = value
    } else if (index === 1) {
      this.q1 = value
    } else if (index === 2) {
      this.q2 = value
    } else {
      this.q3 = value
    }
  }

  private changeQuantity(index: number, delta: number): void {
    const next = this.quantity(index) + delta
    if (next >= 1 && next <= 10) {
      this.setQuantity(index, next)
    }
  }

  private subtotal(): number {
    return this.cartItems[0].price * this.q0 + this.cartItems[1].price * this.q1 + this.cartItems[2].price * this.q2 + this.cartItems[3].price * this.q3
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax
  }

  private money(value: number): string {
    return '$' + value.toFixed(2)
  }

  @Builder
  FeatureBox() {
    Rect()
      .width(28)
      .height(28)
      .radius(6)
      .fill(this.cSurfaceVariant)
      .margin({ right: 4 })
  }

  @Builder
  QuantityButton(symbol: string, index: number, delta: number) {
    Button(symbol)
      .width(28)
      .height(28)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.cPrimary)
      .backgroundColor(this.cSurfaceVariant)
      .borderRadius(6)
      .onClick(() => {
        this.changeQuantity(index, delta)
      })
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row() {
      Rect()
        .width(60)
        .height(60)
        .radius(8)
        .fill(item.color)
        .margin({ right: 8 })

      Column() {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cPrimary)
          .maxLines(2)
          .width(120)
        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cPrimary)
          .width('100%')
          .margin({ top: 2, bottom: 4 })
        Row() {
          this.FeatureBox()
          this.FeatureBox()
          this.FeatureBox()
        }
      }
      .layoutWeight(1)

      Column() {
        this.QuantityButton('+', index, 1)
        Text(this.quantity(index).toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cPrimary)
          .margin({ top: 4, bottom: 4 })
        this.QuantityButton('-', index, -1)
      }
      .margin({ right: 8 })

      Button('Remove')
        .width(85)
        .height(36)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor(this.cError)
        .borderRadius(8)
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(8)
    .backgroundColor(this.cSurface)
    .border({ width: 1, color: this.cLine, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .margin({ bottom: 8 })
  }

  @Builder
  Chip(label: string) {
    Button(label)
      .height(28)
      .padding({ left: 12, right: 12 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.cPrimary)
      .backgroundColor(this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 6 })
      .margin({ right: 4 })
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.cPrimary)
      Blank()
      Text(this.money(value))
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(this.cPrimary)
    }
    .width('100%')
    .margin({ bottom: 6 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
          Rect()
            .width(20)
            .height(20)
            .radius(6)
            .fill(this.cPrimary)
            .margin({ right: 4 })
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cPrimary)
          Blank()
        }
        .width('100%')
        .padding({ top: 46, bottom: 20 })

        Scroll() {
          Column() {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.CartItemCard(item, index)
            }, (item: CartItem) => item.id.toString())

            Row() {
              ForEach(this.chips, (label: string) => {
                this.Chip(label)
              }, (label: string) => label)
            }
            .width('100%')

            Blank().height(220)
          }
          .padding({ left: 8, right: 8, top: 6 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBg)

      Column() {
        this.SummaryRow('Subtotal', this.subtotal(), false)
        this.SummaryRow('Shipping', this.shipping, false)
        this.SummaryRow('Tax', this.tax, false)
        this.SummaryRow('Total', this.total(), true)
        Button('Proceed to Checkout')
          .width('100%')
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor(this.cPrimary)
          .borderRadius(12)
      }
      .width('100%')
      .padding(8)
      .backgroundColor(this.cSurface)
      .borderRadius(12)
      .shadow({ radius: 6, color: '#29000000', offsetY: 2 })
      .margin({ left: 8, right: 8, bottom: 6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBg)
  }
}
