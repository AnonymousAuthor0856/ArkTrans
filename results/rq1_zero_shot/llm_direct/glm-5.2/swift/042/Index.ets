// AppTokens: 统一的UI设计系统
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
    onSurface: '#FF0F172A'
  }

  static readonly TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  }

  static readonly Spacing = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  }

  static readonly ElevationMapping = {
    level1: { radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { radius: 8.0, dy: 4.0, opacity: 0.18 }
  }
}

// Data Model
interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ];

  build() {
    Stack() {
      // 背景渐变色
      Column()
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary, 0.25],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary, 0.25]
          ]
        })
        .width('100%')
        .height('100%')

      // 整体内容可滚动
      Scroll() {
        Column() {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.lg })

          // LazyVGrid 替代为两列的 Row 循环
          ForEach(this.products, (p: Product) => {
            if (p.id % 2 === 1) {
              Row() {
                ProductCard({ product: p })
                Blank()
                if (p.id < this.products.length) {
                  ProductCard({ product: this.products[p.id] })
                } else {
                  Blank()
                }
              }
              .margin({ bottom: AppTokens.Spacing.md })
            }
          })

          Text('Price Update Log')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm })

          ForEach(this.products, (p: Product) => {
            PriceUpdateLogItem({ product: p })
              .margin({ bottom: AppTokens.Spacing.sm })
          })
        }
        .padding(AppTokens.Spacing.lg)
        .margin({ bottom: 48 })
      }
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}

// Component: ProductCard
@Component
struct ProductCard {
  private product: Product;

  build() {
    Column() {
      Rectangle()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(100)
        .height(100)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.sm })

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Compare') {
        // Action
      }
      .fontSize(AppTokens.TypographyTokens.label.size)
      .fontWeight(AppTokens.TypographyTokens.label.weight)
      .fontColor(AppTokens.Colors.onPrimary)
      .width('100%')
      .height(36)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// Component: PriceUpdateLogItem
@Component
struct PriceUpdateLogItem {
  private product: Product;

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}