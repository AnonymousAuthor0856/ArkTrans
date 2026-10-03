// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
    onSurface: '#0F172A'
  };

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.18 }
  };
}

// Product.ets
export class Product {
  id: number;
  name: string;
  price: string;
  store: string;

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.store = store;
  }
}

// ProductCard.ets
import { AppTokens } from './AppTokens';
import { Product } from './Product';

@Component
export struct ProductCard {
  @Prop product: Product;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder box
      Row()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .padding({ top: 8, bottom: 8 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      offsetY: AppTokens.Elevation.level1.dy,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`
    })
  }
}

// PriceUpdateLogItem.ets
import { AppTokens } from './AppTokens';
import { Product } from './Product';

@Component
export struct PriceUpdateLogItem {
  @Prop product: Product;

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Text(this.product.price)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { Product } from './Product';
import { ProductCard } from './ProductCard';
import { PriceUpdateLogItem } from './PriceUpdateLogItem';

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary, 0.25],
            [AppTokens.Colors.background, 1.0],
            [AppTokens.Colors.primary, 0.25]
          ]
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)

          // Grid of product cards
          Grid() {
            ForEach(this.products, (product: Product) => {
              GridItem() {
                ProductCard({ product: product })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .padding({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)

          // Price update log list
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (product: Product) => {
              PriceUpdateLogItem({ product: product })
            })
          }
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}