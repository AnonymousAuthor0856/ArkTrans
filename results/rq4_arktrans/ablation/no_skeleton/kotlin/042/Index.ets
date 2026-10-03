@Entry
@Component
struct RootScreen {
  @State products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ]

  build() {
    Column() {
      Text("Cold Gradient Price Compare")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ bottom: 14 })

      Grid() {
        ForEach(this.products, (item: Product) => {
          GridItem() {
            Column() {
              Image($r('app.media.startIcon'))
                .width(100)
                .height(100)
                .borderRadius(10)
                .backgroundColor('#E0F2FE')
                .objectFit(ImageFit.Contain)
              
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0F172A')
                .margin({ top: 6 })
              
              Text(item.price)
                .fontSize(14)
                .fontColor('#0EA5E9')
                .margin({ top: 6 })
              
              Text(item.store)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#7DD3FC')
                .margin({ top: 6 })
              
              Button("Compare")
                .width('100%')
                .backgroundColor('#0EA5E9')
                .fontColor('#FFFFFF')
                .borderRadius(10)
                .margin({ top: 6 })
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .layoutWeight(1)
      .margin({ bottom: 14 })

      Text("Price Update Log")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0EA5E9')
        .margin({ bottom: 10 })

      List() {
        ForEach(this.products, (item: Product) => {
          ListItem() {
            Row() {
              Text(`${item.name} (${item.store})`)
                .fontSize(14)
                .fontColor('#0F172A')
                .layoutWeight(1)
              
              Text(item.price)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#38BDF8')
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(6)
          }
        })
      }
      .width('100%')
      .backgroundColor('transparent')
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      angle: 90,
      colors: [['#38BDF8', 0], ['#F0F9FF', 0.5], ['#0EA5E9', 1]]
    })
  }
}

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}