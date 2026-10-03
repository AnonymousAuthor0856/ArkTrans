@Entry
@Component
struct RootScreen {
  @State products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ]

  build() {
    Column() {
      Text('Cold Gradient Price Compare')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .margin({ bottom: 14 })

      Grid() {
        ForEach(this.products, (p: Product) => {
          GridItem() {
            this.ProductCard(p)
          }
        }, (p: Product) => p.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .margin({ bottom: 14 })

      Text('Price Update Log')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0EA5E9')
        .width('100%')
        .margin({ bottom: 10 })

      List() {
        ForEach(this.products, (p: Product) => {
          ListItem() {
            Row() {
              Text(`${p.name} (${p.store})`)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#0F172A')
                .layoutWeight(1)

              Text(p.price)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#38BDF8')
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(6)
          }
        }, (p: Product) => p.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 0, color: 'transparent' })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#38BDF8', 0.0],
        ['#F0F9FF', 0.5],
        ['#0EA5E9', 1.0]
      ]
    })
  }

  @Builder
  ProductCard(p: Product) {
    Column() {
      Column() {
        Stack() {
        }
        .width(100)
        .height(100)
        .backgroundColor('#E0F2FE')
        .borderRadius(10)

        Text(p.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .textAlign(TextAlign.Center)

        Text(p.price)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#0EA5E9')
          .width('100%')
          .textAlign(TextAlign.Center)

        Text(p.store)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#7DD3FC')
          .width('100%')
          .textAlign(TextAlign.Center)

        Button('Compare')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#0EA5E9')
          .borderRadius(10)
          .width('100%')
          .height(36)
          .onClick(() => {})
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}
