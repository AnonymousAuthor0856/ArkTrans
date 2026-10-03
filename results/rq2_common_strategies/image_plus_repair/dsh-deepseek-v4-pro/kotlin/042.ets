// 056*PriceCompare*en - ECommerce - Cold Gradient (en, 720x1280)

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
struct PriceComparePage {
  @State products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  @Builder
  ProductCard(p: Product) {
    Column({ space: 6 }) {
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)

      Text(p.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(p.price)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text(p.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)

      Button('Compare', { type: ButtonType.Normal })
        .width('100%')
        .height(38)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .onClick(() => {})
    }
    .width('100%')
    .padding(10)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  LogRow(p: Product) {
    Row() {
      Text(`${p.name} (${p.store})`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
      Text(p.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(10)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 14 }) {
          Text('Cold Gradient Price Compare')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                this.ProductCard(p)
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')

          Text('Price Update Log')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Column({ space: 6 }) {
            ForEach(this.products, (p: Product) => {
              this.LogRow(p)
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding(14)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#4038BDF8', 0], ['#F0F9FF', 0.5], ['#400EA5E9', 1]]
    })
  }
}
