// MARK: - AppTokens
// Unified UI design system for easy ratio and control size modification
class AppTokens {
  static Colors = class {
    static readonly primary: ResourceColor = '#0EA5E9'
    static readonly secondary: ResourceColor = '#38BDF8'
    static readonly tertiary: ResourceColor = '#7DD3FC'
    static readonly background: ResourceColor = '#F0F9FF'
    static readonly surface: ResourceColor = '#FFFFFF'
    static readonly surfaceVariant: ResourceColor = '#E0F2FE'
    static readonly outline: ResourceColor = '#BAE6FD'
    static readonly success: ResourceColor = '#22C55E'
    static readonly warning: ResourceColor = '#FACC15'
    static readonly error: ResourceColor = '#EF4444'
    static readonly onPrimary: ResourceColor = '#FFFFFF'
    static readonly onSecondary: ResourceColor = '#1E1E1E'
    static readonly onTertiary: ResourceColor = '#0F172A'
    static readonly onBackground: ResourceColor = '#0F172A'
    static readonly onSurface: ResourceColor = '#0F172A'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 26
    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly titleSize: number = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Normal
    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static Shapes = class {
    static readonly small: Length = 6
    static readonly medium: Length = 10
    static readonly large: Length = 16
  }

  static Spacing = class {
    static readonly sm: Length = 6
    static readonly md: Length = 10
    static readonly lg: Length = 14
    static readonly xl: Length = 20
    static readonly xxl: Length = 28
  }

  static ElevationMapping = class {
    static readonly level1Radius: number = 4
    static readonly level1Dy: number = 2
    static readonly level1Opacity: number = 0.12
    static readonly level2Radius: number = 8
    static readonly level2Dy: number = 4
    static readonly level2Opacity: number = 0.18
  }
}

// MARK: - Data Model
interface Product {
  id: number
  name: string
  price: string
  store: string
}

// MARK: - ProductCard Component
@Component
struct ProductCard {
  product: Product

  build() {
    Column({ space: AppTokens.Spacing.sm as number }) {
      // Placeholder box
      Row() { }
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(32)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => { })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1Radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1Dy
    })
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  product: Product

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - RootScreen
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
  ]

  build() {
    Stack() {
      // Background gradient
      Column() { }
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            ['#38BDF8', 0.25],
            ['#F0F9FF', 0.5],
            ['#0EA5E9', 0.25]
          ],
          direction: GradientDirection.Bottom
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg as number }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.onBackground)

          // LazyVerticalGrid equivalent
          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.md as number)
          .columnsGap(AppTokens.Spacing.md as number)
          .padding({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)

          // LazyColumn equivalent
          Column({ space: AppTokens.Spacing.sm as number }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}
