import { display } from '@kit.ArkUI';

@Entry
@Component
struct PriceCompareApp {
  @State products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ];

  @Builder
  ProductCard(product: Product) {
    Column({ space: 6 }) {
      Column()
        .width(100)
        .height(100)
        .borderRadius(10)
        .backgroundColor('#E0F2FE')

      Text(product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)

      Text(product.price)
        .fontSize(14)
        .fontColor('#0EA5E9')
        .textAlign(TextAlign.Center)

      Text(product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7DD3FC')
        .textAlign(TextAlign.Center)

      Button('Compare')
        .width('100%')
        .height(36)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#0EA5E9')
        .borderRadius(10)
    }
    .width('100%')
    .padding(10)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })
  }

  @Builder
  PriceLogRow(product: Product) {
    Row() {
      Text(`${product.name} (${product.store})`)
        .fontSize(14)
        .fontColor('#0F172A')
      Text(product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(6)
  }

  build() {
    Column() {
      Column() {
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ bottom: 14 })

        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              this.ProductCard(product)
            }
          }, (product: Product) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .layoutWeight(1)

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')
          .margin({ top: 14, bottom: 6 })

        List({ space: 6 }) {
          ForEach(this.products, (product: Product) => {
            ListItem() {
              this.PriceLogRow(product)
            }
          }, (product: Product) => product.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#38BDF8', 0.25], ['#F0F9FF', 0.5], ['#0EA5E9', 0.25]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}