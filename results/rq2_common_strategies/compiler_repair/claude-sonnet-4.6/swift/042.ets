// MARK: - AppTokens
class ColorsTokens {
  primary: string = '#0EA5E9';
  secondary: string = '#38BDF8';
  tertiary: string = '#7DD3FC';
  background: string = '#F0F9FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E0F2FE';
  outline: string = '#BAE6FD';
  success: string = '#22C55E';
  warning: string = '#FACC15';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#0F172A';
  onBackground: string = '#0F172A';
  onSurface: string = '#0F172A';
}

class TypographyTokens {
  displaySize: number = 26;
  displayWeight: FontWeight = FontWeight.Bold;
  titleSize: number = 18;
  titleWeight: FontWeight = FontWeight.Medium;
  bodySize: number = 14;
  bodyWeight: FontWeight = FontWeight.Normal;
  labelSize: number = 12;
  labelWeight: FontWeight = FontWeight.Medium;
}

class ShapesTokens {
  small: number = 6;
  medium: number = 10;
  large: number = 16;
}

class SpacingTokens {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class ElevationSpec {
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;
}

class ElevationTokens {
  level1: ElevationSpec = { radius: 4, dy: 2, opacity: 0.12 };
  level2: ElevationSpec = { radius: 8, dy: 4, opacity: 0.18 };
}

const Colors = new ColorsTokens();
const Typography = new TypographyTokens();
const Shapes = new ShapesTokens();
const Spacing = new SpacingTokens();
const Elevation = new ElevationTokens();

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
    Column({ space: Spacing.sm }) {
      Stack() {
      }
      .width(100)
      .height(100)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.medium)

      Text(this.product.name)
        .fontSize(Typography.titleSize)
        .fontWeight(Typography.titleWeight)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(Typography.bodySize)
        .fontWeight(Typography.bodyWeight)
        .fontColor(Colors.primary)

      Text(this.product.store)
        .fontSize(Typography.labelSize)
        .fontWeight(Typography.labelWeight)
        .fontColor(Colors.tertiary)

      Button('Compare')
        .fontSize(Typography.labelSize)
        .fontWeight(Typography.labelWeight)
        .fontColor(Colors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(Colors.primary)
        .borderRadius(Shapes.medium)
    }
    .padding(Spacing.md)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: Elevation.level1.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: Elevation.level1.dy,
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
        .fontSize(Typography.bodySize)
        .fontWeight(Typography.bodyWeight)
        .fontColor(Colors.onSurface)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(Typography.labelSize)
        .fontWeight(Typography.labelWeight)
        .fontColor(Colors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.small)
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  build() {
    Stack() {
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#3F38BDF8', 0.0],
          ['#F0F9FF', 0.5],
          ['#3F0EA5E9', 1.0],
        ],
      })

      Scroll() {
        Column({ space: Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(Typography.displaySize)
            .fontWeight(Typography.displayWeight)
            .fontColor(Colors.onBackground)
            .width('100%')

          Grid() {
            ForEach(products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(Spacing.md)
          .rowsGap(Spacing.md)
          .width('100%')
          .padding({ bottom: Spacing.xxl })

          Text('Price Update Log')
            .fontSize(Typography.titleSize)
            .fontWeight(Typography.titleWeight)
            .fontColor(Colors.primary)
            .width('100%')

          Column({ space: Spacing.sm }) {
            ForEach(products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .padding(Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct Index {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}