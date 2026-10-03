const NAME: string = '010_ShoppingCart_en'
const UI_TYPE: string = 'E-commerce Cart'
const STYLE_THEME: string = 'Minimal Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

class AppColors {
  static readonly primary: string = '#000000'
  static readonly secondary: string = '#FF6F00'
  static readonly tertiary: string = '#4CAF50'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F5F5F5'
  static readonly outline: string = '#E0E0E0'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FF9800'
  static readonly error: string = '#F44336'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#000000'
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

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 0.5, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 1, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(3, 6, 1.5, 0.16)
  static readonly level4: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18)
  static readonly level5: ShadowSpec = new ShadowSpec(5, 10, 2.5, 0.20)
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
struct RootScreen {
  @State quantities: number[] = [1, 1, 1, 1]

  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, AppColors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, AppColors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, AppColors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, AppColors.secondary)
  ]

  private shipping: number = 5.99
  private tax: number = 18.50

  private subtotal(): number {
    let value = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      value += this.cartItems[i].price * this.quantities[i]
    }
    return value
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax
  }

  @Builder
  TopBar() {
    Row() {
      Blank()

      Row({ space: AppSpacing.sm }) {
        Box()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)

        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .lineHeight(28)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ProductPlaceholders() {
    Row({ space: AppSpacing.sm }) {
      Box()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)

      Box()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)

      Box()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row({ space: AppSpacing.lg }) {
      Box()
        .width(60)
        .height(60)
        .backgroundColor(item.color)
        .borderRadius(AppShapes.medium)

      Column({ space: AppSpacing.xs }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .lineHeight(24)
          .fontColor(AppColors.onSurface)

        this.ProductPlaceholders()
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: AppSpacing.sm }) {
        Button('+')
          .width(28)
          .height(28)
          .padding(0)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .onClick(() => {
            const index = item.id - 1
            if (this.quantities[index] < 10) {
              this.quantities[index] = this.quantities[index] + 1
              this.quantities = [...this.quantities]
            }
          })

        Text(this.quantities[item.id - 1].toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.onSurface)

        Button('-')
          .width(28)
          .height(28)
          .padding(0)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .onClick(() => {
            const index = item.id - 1
            if (this.quantities[index] > 1) {
              this.quantities[index] = this.quantities[index] - 1
              this.quantities = [...this.quantities]
            }
          })
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .width(85)
        .height(36)
        .padding({ left: 0, right: 0 })
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.error)
        .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .constraintSize({ minHeight: 100 })
    .padding(AppSpacing.lg)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: AppElevation.level2.radius,
      color: '#24000000',
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  @Builder
  AssistChip(label: string) {
    Button(label)
      .height(32)
      .padding({ left: 12, right: 12 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.small)
      .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  CouponRow() {
    Row({ space: AppSpacing.sm }) {
      this.AssistChip('Apply Coupon')
      this.AssistChip('Gift Wrap')
      this.AssistChip('Save for Later')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SummaryRow(label: string, value: string, isTotal: boolean = false) {
    Row() {
      Text(label)
        .fontSize(isTotal ? 18 : 12)
        .fontWeight(isTotal ? FontWeight.SemiBold : FontWeight.Normal)
        .lineHeight(isTotal ? 24 : 16)
        .fontColor(AppColors.onSurface)

      Blank()

      Text(value)
        .fontSize(isTotal ? 18 : 14)
        .fontWeight(isTotal ? FontWeight.SemiBold : FontWeight.Medium)
        .lineHeight(isTotal ? 24 : 18)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Column({ space: AppSpacing.md }) {
      this.SummaryRow('Subtotal', `$${this.subtotal().toFixed(2)}`)
      this.SummaryRow('Shipping', `$${this.shipping.toFixed(2)}`)
      this.SummaryRow('Tax', `$${this.tax.toFixed(2)}`)
      this.SummaryRow('Total', `$${this.total().toFixed(2)}`, true)

      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevation.level3.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: -AppElevation.level3.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      List({ space: AppSpacing.lg }) {
        ForEach(this.cartItems, (item: CartItem) => {
          ListItem() {
            this.CartItemCard(item)
          }
        }, (item: CartItem) => item.id.toString())

        ListItem() {
          this.CouponRow()
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

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}