class ShoppingCartColors {
  static readonly primary: string = '#000000'
  static readonly secondary: string = '#FF6F00'
  static readonly tertiary: string = '#4CAF50'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F5F5F5'
  static readonly outline: string = '#E0E0E0'
  static readonly error: string = '#F44336'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSurface: string = '#000000'
}

class ShoppingCartTypography {
  static readonly displaySize: number = 22
  static readonly headlineSize: number = 18
  static readonly titleSize: number = 14
  static readonly bodySize: number = 12
  static readonly labelSize: number = 10
}

class ShoppingCartShapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
}

class ShoppingCartSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class ShadowSpec {
  radius: number
  y: number
  opacity: number
  color: string

  constructor(radius: number, y: number, opacity: number, color: string) {
    this.radius = radius
    this.y = y
    this.opacity = opacity
    this.color = color
  }
}

class ShoppingCartElevation {
  static readonly level2: ShadowSpec = new ShadowSpec(4, 1, 0.14, '#24000000')
  static readonly level3: ShadowSpec = new ShadowSpec(6, 1.5, 0.16, '#29000000')
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
    new CartItem(1, 'Wireless Headphones', 129.99, ShoppingCartColors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, ShoppingCartColors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, ShoppingCartColors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, ShoppingCartColors.secondary)
  ]

  @State private quantities: number[] = [1, 1, 1, 1]

  private shipping: number = 5.99
  private tax: number = 18.50
  private bottomBarHeight: number = 220

  private getSubtotal(): number {
    let result: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      result += this.cartItems[i].price * this.getQuantity(i)
    }
    return result
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  private getQuantity(index: number): number {
    if (index >= 0 && index < this.quantities.length) {
      return this.quantities[index]
    }
    return 1
  }

  private formatCurrency(value: number): string {
    return '$' + value.toFixed(2)
  }

  private increaseQuantity(index: number): void {
    if (index >= 0 && index < this.quantities.length && this.quantities[index] < 10) {
      const updated: number[] = this.quantities.slice()
      updated[index] = updated[index] + 1
      this.quantities = updated
    }
  }

  private decreaseQuantity(index: number): void {
    if (index >= 0 && index < this.quantities.length && this.quantities[index] > 1) {
      const updated: number[] = this.quantities.slice()
      updated[index] = updated[index] - 1
      this.quantities = updated
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.topBar()

        Scroll() {
          Column({ space: ShoppingCartSpacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.cartItemCard(item, index)
            }, (item: CartItem) => item.id.toString())

            this.chipsRow()
          }
          .width('100%')
          .padding({
            left: ShoppingCartSpacing.lg,
            right: ShoppingCartSpacing.lg,
            top: ShoppingCartSpacing.md,
            bottom: this.bottomBarHeight + ShoppingCartSpacing.lg
          })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      this.bottomSummary()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartColors.background)
  }

  @Builder
  private topBar() {
    Row({ space: ShoppingCartSpacing.sm }) {
      Stack()
        .width(20)
        .height(20)
        .borderRadius(ShoppingCartShapes.small)
        .backgroundColor(ShoppingCartColors.primary)

      Text('Shopping Cart')
        .fontSize(ShoppingCartTypography.displaySize)
        .fontWeight(FontWeight.Medium)
        .fontColor(ShoppingCartColors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .padding({
      top: 46,
      bottom: 26
    })
  }

  @Builder
  private cartItemCard(item: CartItem, index: number) {
    Row({ space: ShoppingCartSpacing.lg }) {
      Stack()
        .width(60)
        .height(60)
        .borderRadius(ShoppingCartShapes.medium)
        .backgroundColor(item.color)

      Column({ space: ShoppingCartSpacing.xs }) {
        Text(item.name)
          .width(120)
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartColors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.formatCurrency(item.price))
          .fontSize(ShoppingCartTypography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartColors.onSurface)

        Row({ space: ShoppingCartSpacing.sm }) {
          this.featureBox()
          this.featureBox()
          this.featureBox()
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: ShoppingCartSpacing.sm }) {
        this.quantityButton('+', index, true)

        Text(this.getQuantity(index).toString())
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartColors.onSurface)

        this.quantityButton('-', index, false)
      }
      .alignItems(HorizontalAlign.Center)

      Row() {
        Text('Remove')
          .fontSize(ShoppingCartTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartColors.onPrimary)
      }
      .width(85)
      .height(36)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(ShoppingCartShapes.medium)
      .backgroundColor(ShoppingCartColors.error)
      .onClick(() => {
      })
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(ShoppingCartSpacing.lg)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: ShoppingCartColors.outline,
      radius: ShoppingCartShapes.large
    })
    .backgroundColor(ShoppingCartColors.surface)
    .shadow({
      radius: ShoppingCartElevation.level2.radius,
      color: ShoppingCartElevation.level2.color,
      offsetX: 0,
      offsetY: ShoppingCartElevation.level2.y
    })
  }

  @Builder
  private featureBox() {
    Stack()
      .width(28)
      .height(28)
      .borderRadius(ShoppingCartShapes.small)
      .backgroundColor(ShoppingCartColors.surfaceVariant)
  }

  @Builder
  private quantityButton(symbol: string, index: number, isIncrease: boolean) {
    Row() {
      Text(symbol)
        .fontSize(ShoppingCartTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(ShoppingCartColors.onSurface)
    }
    .width(28)
    .height(28)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(ShoppingCartShapes.small)
    .backgroundColor(ShoppingCartColors.surfaceVariant)
    .onClick(() => {
      if (isIncrease) {
        this.increaseQuantity(index)
      } else {
        this.decreaseQuantity(index)
      }
    })
  }

  @Builder
  private chipsRow() {
    Row({ space: ShoppingCartSpacing.sm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Text(label)
          .fontSize(ShoppingCartTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartColors.onSurface)
          .padding({
            left: ShoppingCartSpacing.xl,
            right: ShoppingCartSpacing.xl,
            top: ShoppingCartSpacing.sm,
            bottom: ShoppingCartSpacing.sm
          })
          .border({
            width: 1,
            color: ShoppingCartColors.outline,
            radius: ShoppingCartShapes.small
          })
          .backgroundColor(ShoppingCartColors.surface)
          .onClick(() => {
          })
      }, (label: string) => label)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private bottomSummary() {
    Column() {
      Column({ space: ShoppingCartSpacing.md }) {
        this.summaryRow('Subtotal', this.getSubtotal(), false)
        this.summaryRow('Shipping', this.shipping, false)
        this.summaryRow('Tax', this.tax, false)
        this.summaryRow('Total', this.getTotal(), true)

        Row() {
          Text('Proceed to Checkout')
            .fontSize(ShoppingCartTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartColors.onPrimary)
        }
        .width('100%')
        .height(44)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .borderRadius(ShoppingCartShapes.large)
        .backgroundColor(ShoppingCartColors.primary)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding(ShoppingCartSpacing.lg)
      .borderRadius(ShoppingCartShapes.large)
      .backgroundColor(ShoppingCartColors.surface)
      .shadow({
        radius: ShoppingCartElevation.level3.radius,
        color: ShoppingCartElevation.level3.color,
        offsetX: 0,
        offsetY: ShoppingCartElevation.level3.y
      })
    }
    .width('100%')
    .padding({
      left: ShoppingCartSpacing.lg,
      right: ShoppingCartSpacing.lg,
      bottom: ShoppingCartSpacing.md
    })
  }

  @Builder
  private summaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? ShoppingCartTypography.headlineSize : ShoppingCartTypography.bodySize)
        .fontWeight(emphasize ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(ShoppingCartColors.onSurface)

      Blank()
        .layoutWeight(1)

      Text(this.formatCurrency(value))
        .fontSize(emphasize ? ShoppingCartTypography.headlineSize : ShoppingCartTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(ShoppingCartColors.onSurface)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}