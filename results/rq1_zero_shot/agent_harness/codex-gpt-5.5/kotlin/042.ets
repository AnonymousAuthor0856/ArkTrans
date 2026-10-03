const NAME: string = '056*PriceCompare*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#7DD3FC';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#0F172A';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
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

@Entry
@Component
struct MainActivity {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  @Builder
  ProductCard(product: Product): void {
    Column({ space: AppSpacing.sm }) {
      Rect().width(100).height(100).fill(AppColors.surfaceVariant).radius(10);
      Text(product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center);
      Text(product.price)
        .fontSize(14)
        .fontColor(AppColors.primary);
      Text(product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary);
      Button('Compare')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  LogRow(product: Product): void {
    Row() {
      Text(`${product.name} (${product.store})`)
        .fontSize(14)
        .fontColor(AppColors.onSurface);
      Blank();
      Text(product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Cold Gradient Price Compare')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      Grid() {
        ForEach(this.products, (product: Product) => {
          GridItem() {
            this.ProductCard(product);
          }
        }, (product: Product) => product.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .height('58%');
      Text('Price Update Log')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      Scroll() {
        Column({ space: AppSpacing.sm }) {
          ForEach(this.products, (product: Product) => {
            this.LogRow(product);
          }, (product: Product) => product.id.toString())
        }
      }
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
