// Translated from Swift (SwiftUI) to ArkTS (ArkUI).
// Original file: ShoppingCartTokens + ShoppingCartAppView + ShoppingCartApp.

class Colors {
  static readonly primary: string = '#000000'
  static readonly secondary: string = '#FF6F00'
  static readonly tertiary: string = '#4CAF50'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F5F5F5'
  static readonly outline: string = '#E0E0E0'
  static readonly error: string = '#F44336'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#000000'
  static readonly onSurface: string = '#000000'
}

class Typography {
  static readonly display: number = 22
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
  static readonly label: number = 10
}

class Shapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
}

class Spacing {
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
  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius
    this.y = y
    this.opacity = opacity
  }
}

class Elevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 0.5, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 1, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 1.5, 0.16)
  static readonly level4: ShadowSpec = new ShadowSpec(8, 2, 0.18)
  static readonly level5: ShadowSpec = new ShadowSpec(10, 2.5, 0.2)
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

@Component
struct ShoppingCartAppView {
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, Colors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, Colors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, Colors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, Colors.secondary)
  ]

  @State quantities: number[] = [1, 1, 1, 1]

  private shipping: number = 5.99
  private tax: number = 18.50
  private bottomBarHeight: number = 220

  private get subtotal(): number {
    let sum: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  private get total(): number {
    return this.subtotal + this.shipping + this.tax
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()
        Scroll() {
          Column({ space: Spacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.cartItemCard(item, index)
            }, (item: CartItem) => item.id.toString())
            this.chipsRow()
          }
          .padding({ left: Spacing.lg, right: Spacing.lg })
          .padding({ top: Spacing.md })
          .padding({ bottom: this.bottomBarHeight + Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.bottomSummary()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  topBar() {
    Row({ space: Spacing.sm }) {
      Row()
        .width(20)
        .height(20)
        .borderRadius(Shapes.small)
        .backgroundColor(Colors.primary)
      Text('Shopping Cart')
        .fontSize(Typography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 30 + Spacing.xxl, bottom: 20 + Spacing.md })
  }

  @Builder
  cartItemCard(item: CartItem, index: number) {
    Row({ space: Spacing.lg }) {
      Row()
        .width(60)
        .height(60)
        .borderRadius(Shapes.medium)
        .backgroundColor(item.color)

      Column({ space: Spacing.xs }) {
        Text(item.name)
          .fontSize(Typography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .width(120)
          .maxLines(2)
          .textAlign(TextAlign.Start)
        Text('$' + item.price.toFixed(2))
          .fontSize(Typography.headline)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Row({ space: Spacing.sm }) {
          this.featureBox()
          this.featureBox()
          this.featureBox()
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: Spacing.sm }) {
        this.quantityButton('+', () => {
          if (index >= 0 && index < this.quantities.length && this.quantities[index] < 10) {
            this.quantities[index] += 1
          }
        })
        Text((index >= 0 && index < this.quantities.length) ? this.quantities[index].toString() : '1')
          .fontSize(Typography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        this.quantityButton('-', () => {
          if (index >= 0 && index < this.quantities.length && this.quantities[index] > 1) {
            this.quantities[index] -= 1
          }
        })
      }

      Button() {
        Text('Remove')
          .fontSize(Typography.label)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height('100%')
      }
      .width(85)
      .height(36)
      .borderRadius(Shapes.medium)
      .backgroundColor(Colors.error)
      .fontColor(Colors.onPrimary)
      .onClick(() => {})
    }
    .padding(Spacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .alignItems(VerticalAlign.Top)
    .borderRadius(Shapes.large)
    .backgroundColor(Colors.surface)
    .border({ width: 1, color: Colors.outline, radius: Shapes.large })
    .shadow({
      radius: Elevation.level2.radius,
      color: 'rgba(0,0,0,' + Elevation.level2.opacity + ')',
      offsetX: 0,
      offsetY: Elevation.level2.y
    })
  }

  @Builder
  featureBox() {
    Row()
      .width(28)
      .height(28)
      .borderRadius(Shapes.small)
      .backgroundColor(Colors.surfaceVariant)
  }

  @Builder
  quantityButton(symbol: string, action: () => void) {
    Button() {
      Text(symbol)
        .fontSize(Typography.title)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height('100%')
    }
    .width(28)
    .height(28)
    .borderRadius(Shapes.small)
    .backgroundColor(Colors.surfaceVariant)
    .fontColor(Colors.onSurface)
    .onClick(() => {
      action()
    })
  }

  @Builder
  chipsRow() {
    Row({ space: Spacing.sm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button() {
          Text(label)
            .fontSize(Typography.label)
            .fontWeight(FontWeight.Medium)
            .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.sm, bottom: Spacing.sm })
        }
        .borderRadius(Shapes.small)
        .backgroundColor(Colors.surface)
        .border({ width: 1, color: Colors.outline, radius: Shapes.small })
        .fontColor(Colors.onSurface)
        .onClick(() => {})
      }, (label: string) => label)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  bottomSummary() {
    Column({ space: Spacing.md }) {
      this.summaryRow('Subtotal', this.subtotal, false)
      this.summaryRow('Shipping', this.shipping, false)
      this.summaryRow('Tax', this.tax, false)
      this.summaryRow('Total', this.total, true)
      Button() {
        Text('Proceed to Checkout')
          .fontSize(Typography.title)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height(44)
      .borderRadius(Shapes.large)
      .backgroundColor(Colors.primary)
      .fontColor(Colors.onPrimary)
      .onClick(() => {})
    }
    .padding(Spacing.lg)
    .padding({ left: Spacing.lg, right: Spacing.lg })
    .padding({ bottom: Spacing.md })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .borderRadius(Shapes.large)
    .backgroundColor(Colors.surface)
    .shadow({
      radius: Elevation.level3.radius,
      color: 'rgba(0,0,0,' + Elevation.level3.opacity + ')',
      offsetX: 0,
      offsetY: Elevation.level3.y
    })
  }

  // In the Swift source, emphasize defaults to false; it is passed explicitly here.
  @Builder
  summaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? Typography.headline : Typography.body)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(Colors.onSurface)
      Blank()
      Text('$' + value.toFixed(2))
        .fontSize(emphasize ? Typography.headline : Typography.title)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
  }
}

@Entry
@Component
struct ShoppingCartApp {
  build() {
    Column() {
      ShoppingCartAppView()
    }
  }
}
