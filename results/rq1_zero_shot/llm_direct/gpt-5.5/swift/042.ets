class AppColors {
  static readonly primary: ResourceColor = '#FF0EA5E9';
  static readonly secondary: ResourceColor = '#FF38BDF8';
  static readonly tertiary: ResourceColor = '#FF7DD3FC';
  static readonly background: ResourceColor = '#FFF0F9FF';
  static readonly surface: ResourceColor = '#FFFFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFE0F2FE';
  static readonly outline: ResourceColor = '#FFBAE6FD';
  static readonly success: ResourceColor = '#FF22C55E';
  static readonly warning: ResourceColor = '#FFFACC15';
  static readonly error: ResourceColor = '#FFEF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FF1E1E1E';
  static readonly onTertiary: ResourceColor = '#FF0F172A';
  static readonly onBackground: ResourceColor = '#FF0F172A';
  static readonly onSurface: ResourceColor = '#FF0F172A';

  static readonly primaryAlpha25: ResourceColor = '#400EA5E9';
  static readonly secondaryAlpha25: ResourceColor = '#4038BDF8';
}

class AppTypographyTokens {
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;

  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;

  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;

  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: ResourceColor;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: ResourceColor) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12, '#1F000000');
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18, '#2E000000');
}

class Product {
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

@Component
struct ProductCard {
  product: Product = new Product(0, '', '', '');

  build() {
    Column({ space: AppSpacing.sm }) {
      Rect()
        .fill(AppColors.surfaceVariant)
        .width(100)
        .height(100)
        .borderRadius(AppShapes.medium)

      Text(this.product.name)
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(AppTypographyTokens.titleWeight)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(AppColors.primary)

      Text(this.product.store)
        .fontSize(AppTypographyTokens.labelSize)
        .fontWeight(AppTypographyTokens.labelWeight)
        .fontColor(AppColors.tertiary)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Compare')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.onPrimary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 8, bottom: 8 })
      }
      .width('100%')
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
      .padding(0)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: AppElevationMapping.level1.color,
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Component
struct PriceUpdateLogItem {
  product: Product = new Product(0, '', '', '');

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTypographyTokens.labelSize)
        .fontWeight(AppTypographyTokens.labelWeight)
        .fontColor(AppColors.secondary)
        .margin({ left: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small)
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
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  build() {
    Stack() {
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTypographyTokens.displaySize)
            .fontWeight(AppTypographyTokens.displayWeight)
            .fontColor(AppColors.onBackground)

          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .padding({ bottom: AppSpacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.primary)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => `log-${p.id}`)
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondaryAlpha25, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primaryAlpha25, 1.0]
      ]
    })
  }
}