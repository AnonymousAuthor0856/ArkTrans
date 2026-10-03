const NAME = '056*PriceCompare*en'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Cold Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#0EA5E9',
    secondary: '#38BDF8',
    tertiary: '#7DD3FC',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
  }

  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  }
}

interface Product {
  id: number
  name: string
  price: string
  store: string
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
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' },
  ]

  build() {
    Column() {
      Text('Cold Gradient Price Compare')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Grid() {
        ForEach(this.products, (p: Product) => {
          GridItem() {
            ProductCard({ product: p })
          }
        }, (p: Product) => p.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .width('100%')
      .height(420)
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .padding({ bottom: AppTokens.Spacing.xxl })
      .margin({ top: AppTokens.Spacing.lg })

      Text('Price Update Log')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.lg })

      List() {
        ForEach(this.products, (p: Product) => {
          ListItem() {
            Row() {
              Text(`${p.name} (${p.store})`)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(p.price)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.secondary)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .alignItems(VerticalAlign.Center)
          }
        }, (p: Product) => p.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [['#4038BDF8', 0.0], [AppTokens.Colors.background, 0.5], ['#400EA5E9', 1.0]]
    })
  }
}

@Component
struct ProductCard {
  private product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column() {
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .type(ButtonType.Normal)
        .width('100%')
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .alignItems(HorizontalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
  }
}