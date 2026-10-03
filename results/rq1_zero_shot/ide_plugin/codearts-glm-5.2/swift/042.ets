class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF38BDF8',
    tertiary: '#FF7DD3FC',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF0F172A',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }
}

class Product {
  id: number
  name: string
  price: string
  store: string

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id
    this.name = name
    this.price = price
    this.store = store
  }
}

@Component
struct ProductCard {
  @Prop name: string
  @Prop price: string
  @Prop store: string

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.name)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.price)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.store)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }
}

@Component
struct PriceUpdateLogItem {
  @Prop name: string
  @Prop price: string
  @Prop store: string

  build() {
    Row() {
      Text(`${this.name} (${this.store})`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)

      Text(this.price)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC'),
  ]

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#4038BDF8', 0.0], [AppTokens.Colors.background, 0.5], ['#400EA5E9', 1.0]]
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Row({ space: AppTokens.Spacing.md }) {
            ProductCard({ name: this.products[0].name, price: this.products[0].price, store: this.products[0].store })
              .layoutWeight(1)
            ProductCard({ name: this.products[1].name, price: this.products[1].price, store: this.products[1].store })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: AppTokens.Spacing.md }) {
            ProductCard({ name: this.products[2].name, price: this.products[2].price, store: this.products[2].store })
              .layoutWeight(1)
            ProductCard({ name: this.products[3].name, price: this.products[3].price, store: this.products[3].store })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: AppTokens.Spacing.md }) {
            ProductCard({ name: this.products[4].name, price: this.products[4].price, store: this.products[4].store })
              .layoutWeight(1)
            ProductCard({ name: this.products[5].name, price: this.products[5].price, store: this.products[5].store })
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ name: p.name, price: p.price, store: p.store })
            })
          }
          .margin({ bottom: 48 })
        }
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}