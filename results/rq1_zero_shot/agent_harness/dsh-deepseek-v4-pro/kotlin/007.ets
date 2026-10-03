interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

const Colors = {
  primary: '#000000',
  secondary: '#FF6F00',
  tertiary: '#4CAF50',
  background: '#FFFFFF',
  surface: '#FFFFFF',
  surfaceVariant: '#F5F5F5',
  outline: '#E0E0E0',
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#000000',
  onSurface: '#000000'
}

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
}

@Entry
@Component
struct Index {
  @State quantities: number[] = [1, 1, 1, 1]
  private shipping: number = 5.99
  private tax: number = 18.50
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: Colors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: Colors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: Colors.secondary }
  ]

  subtotal(): number {
    let sum: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  fmt(n: number): string {
    return '$' + n.toFixed(2)
  }

  build() {
    Column() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(Colors.primary)
          .borderRadius(6)
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          ForEach(this.cartItems, (item: CartItem) => {
            Row({ space: Spacing.lg }) {
              Blank()
                .width(60)
                .height(60)
                .backgroundColor(item.color)
                .borderRadius(8)
              Column({ space: Spacing.xs }) {
                Text(item.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(this.fmt(item.price))
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)
                Row({ space: Spacing.sm }) {
                  Blank().width(28).height(28).backgroundColor(Colors.surfaceVariant).borderRadius(6)
                  Blank().width(28).height(28).backgroundColor(Colors.surfaceVariant).borderRadius(6)
                  Blank().width(28).height(28).backgroundColor(Colors.surfaceVariant).borderRadius(6)
                }
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column({ space: Spacing.sm }) {
                Button('+')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(6)
                  .width(28)
                  .height(28)
                  .onClick(() => {
                    if (this.quantities[item.id - 1] < 10) {
                      this.quantities[item.id - 1] = this.quantities[item.id - 1] + 1
                    }
                  })
                Text(this.quantities[item.id - 1].toString())
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Button('-')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(6)
                  .width(28)
                  .height(28)
                  .onClick(() => {
                    if (this.quantities[item.id - 1] > 1) {
                      this.quantities[item.id - 1] = this.quantities[item.id - 1] - 1
                    }
                  })
              }

              Button('Remove')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.error)
                .borderRadius(8)
                .height(36)
                .width(85)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(VerticalAlign.Center)
          }, (item: CartItem) => item.id.toString())

          Row({ space: Spacing.sm }) {
            Button('Apply Coupon')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
              .height(32)
            Button('Gift Wrap')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
              .height(32)
            Button('Save for Later')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .border({ width: 1, color: Colors.outline })
              .height(32)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)

      Column({ space: Spacing.md }) {
        Row() {
          Text('Subtotal')
            .fontSize(12)
            .fontColor(Colors.onSurface)
          Text(this.fmt(this.subtotal()))
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
          Text(this.fmt(this.shipping))
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
          Text(this.fmt(this.tax))
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
          Text(this.fmt(this.subtotal() + this.shipping + this.tax))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Proceed to Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .width('100%')
          .height(44)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
