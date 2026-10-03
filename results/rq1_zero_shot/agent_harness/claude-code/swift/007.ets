class ShoppingCartColors {
  static primary: string = '#000000'
  static secondary: string = '#FF6F00'
  static tertiary: string = '#4CAF50'
  static background: string = '#FFFFFF'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#F5F5F5'
  static outline: string = '#E0E0E0'
  static error: string = '#F44336'
  static onPrimary: string = '#FFFFFF'
  static onBackground: string = '#000000'
  static onSurface: string = '#000000'
}

class ShoppingCartTypography {
  static displaySize: number = 22
  static displayWeight: FontWeight = FontWeight.SemiBold
  static headlineSize: number = 18
  static headlineWeight: FontWeight = FontWeight.SemiBold
  static titleSize: number = 14
  static titleWeight: FontWeight = FontWeight.Medium
  static bodySize: number = 12
  static bodyWeight: FontWeight = FontWeight.Regular
  static labelSize: number = 10
  static labelWeight: FontWeight = FontWeight.Medium
}

class ShoppingCartShapes {
  static small: number = 6
  static medium: number = 8
  static large: number = 12
}

class ShoppingCartSpacing {
  static xs: number = 2
  static sm: number = 4
  static md: number = 6
  static lg: number = 8
  static xl: number = 12
  static xxl: number = 16
  static xxxl: number = 24
}

interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

@Entry
@Component
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1]

  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: ShoppingCartColors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: ShoppingCartColors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: ShoppingCartColors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: ShoppingCartColors.secondary }
  ]

  private shipping: number = 5.99
  private tax: number = 18.50
  private bottomBarHeight: number = 220

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
    Stack({ alignContent: Alignment.Bottom }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ShoppingCartColors.background)

      Column() {
        this.topBarBuilder()

        Scroll() {
          Column({ space: ShoppingCartSpacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.cartItemCardBuilder(item, index)
            }, (item: CartItem) => item.id.toString())

            this.chipsRowBuilder()
          }
          .width('100%')
          .padding({ left: ShoppingCartSpacing.lg, right: ShoppingCartSpacing.lg })
          .padding({ top: ShoppingCartSpacing.md })
          .padding({ bottom: this.bottomBarHeight + ShoppingCartSpacing.lg })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.bottomSummaryBuilder()
        .width('100%')
        .padding({ left: ShoppingCartSpacing.lg, right: ShoppingCartSpacing.lg })
        .padding({ bottom: ShoppingCartSpacing.md })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  topBarBuilder() {
    Row({ space: ShoppingCartSpacing.sm }) {
      Row()
        .width(20)
        .height(20)
        .backgroundColor(ShoppingCartColors.primary)
        .borderRadius(ShoppingCartShapes.small)

      Text('Shopping Cart')
        .fontSize(ShoppingCartTypography.displaySize)
        .fontWeight(ShoppingCartTypography.displayWeight)
        .fontColor(ShoppingCartColors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 30 + ShoppingCartSpacing.xxl, bottom: ShoppingCartSpacing.md + 20 })
  }

  @Builder
  cartItemCardBuilder(item: CartItem, index: number) {
    Row({ space: ShoppingCartSpacing.lg }) {
      Row()
        .width(60)
        .height(60)
        .backgroundColor(item.color)
        .borderRadius(ShoppingCartShapes.medium)

      Column({ space: ShoppingCartSpacing.xs }) {
        Text(item.name)
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(ShoppingCartTypography.titleWeight)
          .fontColor(ShoppingCartColors.onSurface)
          .width(120)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text('$' + item.price.toFixed(2))
          .fontSize(ShoppingCartTypography.headlineSize)
          .fontWeight(ShoppingCartTypography.headlineWeight)
          .fontColor(ShoppingCartColors.onSurface)

        Row({ space: ShoppingCartSpacing.sm }) {
          this.featureBoxBuilder()
          this.featureBoxBuilder()
          this.featureBoxBuilder()
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: ShoppingCartSpacing.sm }) {
        Button('+')
          .width(28)
          .height(28)
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(ShoppingCartTypography.titleWeight)
          .fontColor(ShoppingCartColors.onSurface)
          .backgroundColor(ShoppingCartColors.surfaceVariant)
          .borderRadius(ShoppingCartShapes.small)
          .onClick(() => {
            if (index >= 0 && index < this.quantities.length && this.quantities[index] < 10) {
              this.quantities[index] += 1
            }
          })

        Text(this.quantities[index].toString())
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(ShoppingCartTypography.titleWeight)
          .fontColor(ShoppingCartColors.onSurface)

        Button('-')
          .width(28)
          .height(28)
          .fontSize(ShoppingCartTypography.titleSize)
          .fontWeight(ShoppingCartTypography.titleWeight)
          .fontColor(ShoppingCartColors.onSurface)
          .backgroundColor(ShoppingCartColors.surfaceVariant)
          .borderRadius(ShoppingCartShapes.small)
          .onClick(() => {
            if (index >= 0 && index < this.quantities.length && this.quantities[index] > 1) {
              this.quantities[index] -= 1
            }
          })
      }

      Button('Remove')
        .width(85)
        .height(36)
        .fontSize(ShoppingCartTypography.labelSize)
        .fontWeight(ShoppingCartTypography.labelWeight)
        .fontColor(ShoppingCartColors.onPrimary)
        .backgroundColor(ShoppingCartColors.error)
        .borderRadius(ShoppingCartShapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .minHeight(100)
    .padding(ShoppingCartSpacing.lg)
    .backgroundColor(ShoppingCartColors.surface)
    .borderRadius(ShoppingCartShapes.large)
    .border({ width: 1, color: ShoppingCartColors.outline })
    .shadow({
      radius: 4,
      color: '#24000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  featureBoxBuilder() {
    Row()
      .width(28)
      .height(28)
      .backgroundColor(ShoppingCartColors.surfaceVariant)
      .borderRadius(ShoppingCartShapes.small)
  }

  @Builder
  chipsRowBuilder() {
    Row({ space: ShoppingCartSpacing.sm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label)
          .fontSize(ShoppingCartTypography.labelSize)
          .fontWeight(ShoppingCartTypography.labelWeight)
          .fontColor(ShoppingCartColors.onSurface)
          .backgroundColor(ShoppingCartColors.surface)
          .borderRadius(ShoppingCartShapes.small)
          .border({ width: 1, color: ShoppingCartColors.outline })
          .padding({
            left: ShoppingCartSpacing.xl,
            right: ShoppingCartSpacing.xl,
            top: ShoppingCartSpacing.sm,
            bottom: ShoppingCartSpacing.sm
          })
          .onClick(() => {})
      }, (label: string) => label)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  bottomSummaryBuilder() {
    Column({ space: ShoppingCartSpacing.md }) {
      this.summaryRowBuilder('Subtotal', this.getSubtotal())
      this.summaryRowBuilder('Shipping', this.shipping)
      this.summaryRowBuilder('Tax', this.tax)
      this.summaryRowBuilder('Total', this.getTotal(), true)

      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .fontSize(ShoppingCartTypography.titleSize)
        .fontWeight(ShoppingCartTypography.titleWeight)
        .fontColor(ShoppingCartColors.onPrimary)
        .backgroundColor(ShoppingCartColors.primary)
        .borderRadius(ShoppingCartShapes.large)
        .onClick(() => {})
    }
    .width('100%')
    .padding(ShoppingCartSpacing.lg)
    .backgroundColor(ShoppingCartColors.surface)
    .borderRadius(ShoppingCartShapes.large)
    .shadow({
      radius: 6,
      color: '#29000000',
      offsetX: 0,
      offsetY: 1.5
    })
  }

  @Builder
  summaryRowBuilder(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .fontSize(emphasize ? ShoppingCartTypography.headlineSize : ShoppingCartTypography.bodySize)
        .fontWeight(emphasize ? ShoppingCartTypography.headlineWeight : ShoppingCartTypography.bodyWeight)
        .fontColor(ShoppingCartColors.onSurface)

      Blank()

      Text('$' + value.toFixed(2))
        .fontSize(emphasize ? ShoppingCartTypography.headlineSize : ShoppingCartTypography.titleSize)
        .fontWeight(emphasize ? ShoppingCartTypography.headlineWeight : ShoppingCartTypography.titleWeight)
        .fontColor(ShoppingCartColors.onSurface)
    }
    .width('100%')
  }
}
