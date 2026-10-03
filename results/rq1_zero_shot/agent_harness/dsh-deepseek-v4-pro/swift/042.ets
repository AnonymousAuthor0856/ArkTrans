// MARK: - AppTokens
// 统一的UI设计系统，方便修改比例和控件大小
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { radius: number; dy: number; opacity: number; elevation?: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#0EA5E9',       // 0xFF0EA5E9
    secondary: '#38BDF8',     // 0xFF38BDF8
    tertiary: '#7DD3FC',      // 0xFF7DD3FC
    background: '#F0F9FF',    // 0xFFF0F9FF
    surface: '#FFFFFF',       // 0xFFFFFFFF
    surfaceVariant: '#E0F2FE',// 0xFFE0F2FE
    outline: '#BAE6FD',       // 0xFFBAE6FD
    success: '#22C55E',       // 0xFF22C55E
    warning: '#FACC15',       // 0xFFFACC15
    error: '#EF4444',         // 0xFFEF4444
    onPrimary: '#FFFFFF',     // 0xFFFFFFFF
    onSecondary: '#1E1E1E',   // 0xFF1E1E1E
    onTertiary: '#0F172A',    // 0xFF0F172A
    onBackground: '#0F172A',  // 0xFF0F172A
    onSurface: '#0F172A'      // 0xFF0F172A
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  }

  static readonly Spacing: NumberTokens = {
    sm: 6.0, md: 10.0, lg: 14.0, xl: 20.0, xxl: 28.0
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { radius: 8.0, dy: 4.0, opacity: 0.18 }
  }
}

// MARK: - Data Model
class Product {
  id: number
  name: string
  price: string
  store: string

  constructor(id: number = 0, name: string = '', price: string = '', store: string = '') {
    this.id = id
    this.name = name
    this.price = price
    this.store = store
  }
}

// MARK: - RootScreen
@Entry
@Component
struct Index {
  products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ]

  build() {
    Stack() {
      // 背景渐变色。
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['rgba(56, 189, 248, 0.25)', 0.0],
            ['#F0F9FF', 0.5],
            ['rgba(14, 165, 233, 0.25)', 1.0]
          ]
        })

      // 整体内容可滚动。
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)

          // 对应 LazyVerticalGrid。
          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .padding({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)

          // 对应 LazyColumn。
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .padding({ bottom: 48 })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - ProductCard Component
@Component
struct ProductCard {
  product: Product = new Product()

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .padding({ top: 8.0, bottom: 8.0 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  product: Product = new Product()

  build() {
    Row() {
      Text(this.product.name + ' (' + this.product.store + ')')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Text(this.product.price)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}
