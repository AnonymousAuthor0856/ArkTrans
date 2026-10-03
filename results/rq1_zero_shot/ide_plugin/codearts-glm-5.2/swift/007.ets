class ShoppingCartTokens {
  static readonly Colors = {
    primary: '#FF000000',
    secondary: '#FFFF6F00',
    tertiary: '#FF4CAF50',
    background: '#FFFFFFFF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF5F5F5',
    outline: '#FFE0E0E0',
    error: '#FFF44336',
    onPrimary: '#FFFFFFFF',
    onBackground: '#FF000000',
    onSurface: '#FF000000'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
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

@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, ShoppingCartTokens.Colors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, ShoppingCartTokens.Colors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, ShoppingCartTokens.Colors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, ShoppingCartTokens.Colors.secondary)
  ]

  @State quantities: number[] = [1, 1, 1, 1]

  private shipping: number = 5.99
  private tax: number = 18.50

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

  private formatPrice(value: number): string {
    return '$' + value.toFixed(2)
  }

  build() {
    Column() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(6)
          .backgroundColor(ShoppingCartTokens.Colors.primary)
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ left: 4 })
      }
      .width('100%')
      .padding({ top: 46, bottom: 26, left: 8, right: 8 })

      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            CartItemCard({
              name: item.name,
              price: item.price,
              color: item.color,
              quantity: this.quantities[index],
              onIncrease: () => {
                if (this.quantities[index] < 10) {
                  this.quantities[index] += 1
                }
              },
              onDecrease: () => {
                if (this.quantities[index] > 1) {
                  this.quantities[index] -= 1
                }
              }
            })
              .margin({ bottom: 8 })
          })

          Row() {
            Text('Apply Coupon')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ShoppingCartTokens.Colors.onSurface)
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .borderRadius(6)
              .backgroundColor(ShoppingCartTokens.Colors.surface)
              .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
            Text('Gift Wrap')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ShoppingCartTokens.Colors.onSurface)
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .borderRadius(6)
              .backgroundColor(ShoppingCartTokens.Colors.surface)
              .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
              .margin({ left: 4 })
            Text('Save for Later')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ShoppingCartTokens.Colors.onSurface)
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .borderRadius(6)
              .backgroundColor(ShoppingCartTokens.Colors.surface)
              .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
              .margin({ left: 4 })
          }
          .width('100%')
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 240 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Column() {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
          Text(this.formatPrice(this.getSubtotal()))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Shipping')
            .fontSize(12)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
          Text(this.formatPrice(this.shipping))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 6 })

        Row() {
          Text('Tax')
            .fontSize(12)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
          Text(this.formatPrice(this.tax))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 6 })

        Row() {
          Text('Total')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
          Text(this.formatPrice(this.getTotal()))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 6 })

        Text('Proceed to Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onPrimary)
          .width('100%')
          .height(44)
          .textAlign(TextAlign.Center)
          .borderRadius(12)
          .backgroundColor(ShoppingCartTokens.Colors.primary)
          .margin({ top: 6 })
      }
      .width('100%')
      .padding(8)
      .borderRadius(12)
      .backgroundColor(ShoppingCartTokens.Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartTokens.Colors.background)
  }
}

@Component
struct CartItemCard {
  @Prop name: string
  @Prop price: number
  @Prop color: string
  @Prop quantity: number
  onIncrease: () => void = () => {}
  onDecrease: () => void = () => {}

  build() {
    Row() {
      Row()
        .width(60)
        .height(60)
        .borderRadius(8)
        .backgroundColor(this.color)

      Column() {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Text('$' + this.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: 2 })

        Row() {
          Row().width(28).height(28).borderRadius(6).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
          Row().width(28).height(28).borderRadius(6).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant).margin({ left: 4 })
          Row().width(28).height(28).borderRadius(6).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant).margin({ left: 4 })
        }
        .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 8 })

      Column() {
        Text('+')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .borderRadius(6)
          .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.onIncrease()
          })
        Text(`${this.quantity}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Text('-')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .borderRadius(6)
          .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.onDecrease()
          })
      }
      .alignItems(HorizontalAlign.Center)

      Text('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .width(85)
        .height(36)
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .backgroundColor(ShoppingCartTokens.Colors.error)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding(8)
    .borderRadius(12)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
    .alignItems(VerticalAlign.Center)
  }
}