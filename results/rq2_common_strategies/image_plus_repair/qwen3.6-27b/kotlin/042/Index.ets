// entry/src/main/ets/pages/Index.ets

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

@Entry
@Component
struct Index {
  @State products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ];

  build() {
    Column() {
      // Header Title
      Text("Cold Gradient Price Compare")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 10 })

      // Product Grid
      Grid() {
        ForEach(this.products, (product: Product) => {
          GridItem() {
            Column() {
              // Placeholder Image Box
              Row()
                .width(100)
                .height(100)
                .backgroundColor('#E0F2FE')
                .borderRadius(10)
                .margin({ bottom: 10 })

              // Product Name
              Text(product.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0F172A')
                .textAlign(TextAlign.Center)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 5 })

              // Price
              Text(product.price)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#0EA5E9')
                .margin({ bottom: 5 })

              // Store
              Text(product.store)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#7DD3FC')
                .margin({ bottom: 10 })

              // Compare Button
              Button("Compare")
                .type(ButtonType.Capsule)
                .backgroundColor('#0EA5E9')
                .fontColor('#FFFFFF')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .width('100%')
                .height(40)
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
          }
        }, (item: Product) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .padding({ left: 14, right: 14, bottom: 20 })
      .layoutWeight(1)

      // Price Update Log Section
      Text("Price Update Log")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0EA5E9')
        .width('100%')
        .margin({ top: 10, bottom: 10 })

      List({ space: 6 }) {
        ForEach(this.products, (product: Product) => {
          ListItem() {
            Row() {
              Text(`${product.name} (${product.store})`)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#0F172A')
                .layoutWeight(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

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
        }, (item: Product) => item.id.toString())
      }
      .width('100%')
      .padding({ left: 14, right: 14, bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#38BDF8', 0], ['#F0F9FF', 0.5], ['#0EA5E9', 1]]
    })
    .padding(14)
  }
}