class AppColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#38BDF8';
  static tertiary: string = '#7DD3FC';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BAE6FD';
  static success: string = '#22C55E';
  static warning: string = '#FACC15';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#0F172A';
  static onBackground: string = '#0F172A';
  static onSurface: string = '#0F172A';

  static secondary25: string = 'rgba(56, 189, 248, 0.25)';
  static primary25: string = 'rgba(14, 165, 233, 0.25)';
  static shadowLevel1: string = 'rgba(0, 0, 0, 0.12)';
}

class AppTypography {
  static display: number = 26;
  static title: number = 18;
  static body: number = 14;
  static label: number = 12;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 16;
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 20;
  static xxl: number = 28;
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
      Blank()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.product.name)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Text(this.product.price)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(this.product.store)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)
        .textAlign(TextAlign.Center)
        .width('100%')

      Button('Compare', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: AppColors.shadowLevel1,
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct PriceUpdateLogItem {
  product: Product = new Product(0, '', '', '');

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
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
struct Index {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  private productRows(): Product[][] {
    const rows: Product[][] = [];
    for (let i = 0; i < this.products.length; i += 2) {
      const row: Product[] = [this.products[i]];
      if (i + 1 < this.products.length) {
        row.push(this.products[i + 1]);
      }
      rows.push(row);
    }
    return rows;
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column({ space: AppSpacing.md }) {
            ForEach(this.productRows(), (row: Product[]) => {
              Row({ space: AppSpacing.md }) {
                ProductCard({ product: row[0] })
                  .layoutWeight(1)

                if (row.length > 1) {
                  ProductCard({ product: row[1] })
                    .layoutWeight(1)
                } else {
                  Blank()
                    .layoutWeight(1)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            }, (row: Product[]) => row[0].id.toString())
          }
          .width('100%')
          .padding({ bottom: AppSpacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')

          Column({ space: AppSpacing.sm }) {
            ForEach(this.products, (product: Product) => {
              PriceUpdateLogItem({ product: product })
            }, (product: Product) => product.id.toString())
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
        [AppColors.secondary25, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primary25, 1.0]
      ]
    })
  }
}