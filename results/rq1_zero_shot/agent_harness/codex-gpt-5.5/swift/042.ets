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
struct RootScreen {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  @Builder
  ProductCard(product: Product) {
    Column() {
      Rect()
        .width(100)
        .height(100)
        .fill('#E0F2FE')
        .radius(10)
      Text(product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .margin({ top: 6 })
      Text(product.price)
        .fontSize(14)
        .fontColor('#0EA5E9')
        .margin({ top: 6 })
      Text(product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7DD3FC')
        .margin({ top: 6 })
      Button('Compare')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#0EA5E9')
        .width('100%')
        .height(34)
        .borderRadius(10)
        .margin({ top: 6 })
    }
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  PriceUpdateLogItem(product: Product) {
    Row() {
      Text(product.name + ' (' + product.store + ')')
        .fontSize(14)
        .fontColor('#0F172A')
        .layoutWeight(1)
      Text(product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(6)
  }

  build() {
    Scroll() {
      Column() {
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
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
        .padding({ bottom: 28 })
        .margin({ top: 14 })

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')
          .width('100%')

        Column() {
          ForEach(this.products, (p: Product) => {
            this.PriceUpdateLogItem(p)
              .margin({ bottom: 6 })
          }, (p: Product) => p.id.toString())
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(14)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
