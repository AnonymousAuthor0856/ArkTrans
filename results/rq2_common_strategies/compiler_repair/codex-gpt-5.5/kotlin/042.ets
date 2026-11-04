class CompareProduct {
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

class CompareColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#38BDF8';
  static tertiary: string = '#7DD3FC';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BAE6FD';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  private products: CompareProduct[] = [
    new CompareProduct(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new CompareProduct(2, 'Smart Watch', '$129.99', 'ShopB'),
    new CompareProduct(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new CompareProduct(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new CompareProduct(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new CompareProduct(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  @Builder
  ProductCard(product: CompareProduct) {
    Column() {
      Text('')
        .width(100)
        .height(100)
        .backgroundColor(CompareColors.surfaceVariant)
        .borderRadius(10)
      Text(product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(CompareColors.onSurface)
        .textAlign(TextAlign.Center)
        .lineHeight(24)
        .maxLines(2)
        .margin({ top: 6 })
      Text(product.price)
        .fontSize(14)
        .fontColor(CompareColors.primary)
        .lineHeight(20)
        .margin({ top: 6 })
      Text(product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CompareColors.tertiary)
        .lineHeight(16)
        .margin({ top: 6 })
      Button('Compare')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CompareColors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(CompareColors.primary)
        .borderRadius(10)
        .margin({ top: 6 })
    }
    .width('100%')
    .padding(10)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(CompareColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  LogRow(product: CompareProduct) {
    Row() {
      Text(product.name + ' (' + product.store + ')')
        .fontSize(14)
        .fontColor(CompareColors.onSurface)
        .lineHeight(20)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Text(product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CompareColors.secondary)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(CompareColors.surface)
    .borderRadius(6)
  }

  build() {
    Column() {
      Text('Cold Gradient Price Compare')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(CompareColors.onSurface)
        .lineHeight(32)
        .width('100%')

      Grid() {
        ForEach(this.products, (product: CompareProduct) => {
          GridItem() {
            this.ProductCard(product)
          }
        }, (product: CompareProduct) => product.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('100%')
      .height(480)
      .margin({ top: 14 })

      Text('Price Update Log')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(CompareColors.primary)
        .lineHeight(24)
        .width('100%')
        .margin({ top: 14 })

      Scroll() {
        Column() {
          ForEach(this.products, (product: CompareProduct) => {
            Column() {
              this.LogRow(product)
            }
            .width('100%')
            .margin({ bottom: 6 })
          }, (product: CompareProduct) => product.id.toString())
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#4038BDF8', 0.0], [CompareColors.background, 0.5], ['#400EA5E9', 1.0]]
    })
  }
}
