import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    displaySize: 26,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12,
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16,
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  },
  Elevation: {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.18 },
  },
};

// MARK: - Data Model
interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

const products: Product[] = [
  { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
  { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
  { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
  { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
  { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
  { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' },
];

// MARK: - ProductCard Component
@Component
struct ProductCard {
  product: Product = { id: 0, name: '', price: '', store: '' };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder image box
      Row()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .padding({ top: 8, bottom: 8 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: LengthMetrics.vp(AppTokens.Elevation.level1.radius),
      color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
      offsetX: LengthMetrics.vp(0),
      offsetY: LengthMetrics.vp(AppTokens.Elevation.level1.dy),
    })
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  product: Product = { id: 0, name: '', price: '', store: '' };

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [`${AppTokens.Colors.secondary}40`, 0.0],
            [AppTokens.Colors.background, 0.5],
            [`${AppTokens.Colors.primary}40`, 1.0],
          ],
        })

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Title
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.Typography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
            .alignSelf(ItemAlign.Start)

          // Product Grid (2 columns)
          Grid() {
            ForEach(products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xxl })

          // Section title
          Text('Price Update Log')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .alignSelf(ItemAlign.Start)

          // Log list
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}