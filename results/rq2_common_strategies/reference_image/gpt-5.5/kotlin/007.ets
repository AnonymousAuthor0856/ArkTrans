class AppColors {
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

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class AppShape {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
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
struct ShoppingCartPage {
  @State quantities: number[] = [1, 1, 1, 1]

  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, AppColors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, AppColors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, AppColors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, AppColors.secondary)
  ]

  private shipping: number = 5.99
  private tax: number = 18.50

  private getSubtotal(): number {
    let total: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      total += this.cartItems[i].price * this.quantities[i]
    }
    return total
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  private increaseQuantity(index: number): void {
    if (this.quantities[index] < 10) {
      let next: number[] = this.quantities.slice()
      next[index] = next[index] + 1
      this.quantities = next
    }
  }

  private decreaseQuantity(index: number): void {
    if (this.quantities[index] > 1) {
      let next: number[] = this.quantities.slice()
      next[index] = next[index] - 1
      this.quantities = next
    }
  }

  @Builder
  TopBar() {
    Row({ space: AppSpacing.sm }) {
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.small)

      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .lineHeight(28)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(94)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  PlaceholderSquares() {
    Row({ space: AppSpacing.sm }) {
      Blank()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.small)

      Blank()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.small)

      Blank()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.small)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuantityControls(index: number) {
    Column({ space: AppSpacing.sm }) {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('+')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width(28)
      .height(28)
      .padding(0)
      .borderRadius(AppShape.small)
      .backgroundColor(AppColors.surfaceVariant)
      .onClick((): void => {
        this.increaseQuantity(index)
      })

      Text(this.quantities[index].toString())
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .lineHeight(18)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('-')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width(28)
      .height(28)
      .padding(0)
      .borderRadius(AppShape.small)
      .backgroundColor(AppColors.surfaceVariant)
      .onClick((): void => {
        this.decreaseQuantity(index)
      })
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row({ space: AppSpacing.lg }) {
      Blank()
        .width(60)
        .height(60)
        .backgroundColor(item.color)
        .borderRadius(AppShape.medium)

      Column({ space: AppSpacing.xs }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.onSurface)
          .maxLines(2)

        Text('$' + item.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .lineHeight(24)
          .fontColor(AppColors.onSurface)

        this.PlaceholderSquares()
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      this.QuantityControls(index)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Remove')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onPrimary)
      }
      .width(85)
      .height(36)
      .padding(0)
      .borderRadius(AppShape.medium)
      .backgroundColor(AppColors.error)
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(AppSpacing.lg)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  Chip(text: string) {
    Text(text)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .lineHeight(14)
      .fontColor(AppColors.onSurface)
      .padding({
        left: 12,
        right: 12,
        top: 7,
        bottom: 7
      })
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShape.small)
      .border({
        width: 1,
        color: AppColors.outline
      })
  }

  @Builder
  ChipsRow() {
    Row({ space: AppSpacing.sm }) {
      this.Chip('Apply Coupon')
      this.Chip('Gift Wrap')
      this.Chip('Save for Later')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SummaryRow(label: string, value: string, isTotal: boolean = false) {
    Row() {
      Text(label)
        .fontSize(isTotal ? 18 : 12)
        .fontWeight(isTotal ? FontWeight.Bold : FontWeight.Regular)
        .lineHeight(isTotal ? 24 : 16)
        .fontColor(AppColors.onSurface)

      Text(value)
        .fontSize(isTotal ? 18 : 14)
        .fontWeight(isTotal ? FontWeight.Bold : FontWeight.Medium)
        .lineHeight(isTotal ? 24 : 18)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Column({ space: AppSpacing.md }) {
      this.SummaryRow('Subtotal', '$' + this.getSubtotal().toFixed(2))
      this.SummaryRow('Shipping', '$' + this.shipping.toFixed(2))
      this.SummaryRow('Tax', '$' + this.tax.toFixed(2))
      this.SummaryRow('Total', '$' + this.getTotal().toFixed(2), true)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Proceed to Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(44)
      .padding(0)
      .borderRadius(AppShape.large)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 6,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: -1.5
    })
  }

  build() {
    Column() {
      this.TopBar()

      List({ space: AppSpacing.lg }) {
        ForEach(this.cartItems, (item: CartItem, index: number) => {
          ListItem() {
            this.CartItemCard(item, index)
          }
        }, (item: CartItem) => {
          return item.id.toString()
        })

        ListItem() {
          this.ChipsRow()
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.xxxl
      })
      .backgroundColor(AppColors.background)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}