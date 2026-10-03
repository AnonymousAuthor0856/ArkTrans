@Entry
@Component
struct Index {
  @State products: Product[] = [
    { name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        Text('Cold Gradient Price Compare')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')

        Grid() {
          ForEach(this.products, (item: Product) => {
            GridItem() {
              Column({ space: 6 }) {
                // Image Placeholder
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(80)
                    .height(80)
                    .objectFit(ImageFit.Contain)
                    .opacity(0.5)
                }
                .width(100)
                .height(100)
                .borderRadius(12)
                .backgroundColor('#E0F2FE')

                Text(item.name)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .textAlign(TextAlign.Center)

                Text(item.price)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0EA5E9')

                Text(item.store)
                  .fontSize(14)
                  .fontColor('#7DD3FC')

                Button('Compare')
                  .width('100%')
                  .height(40)
                  .backgroundColor('#0EA5E9')
                  .borderRadius(12)
                  .fontColor('#FFFFFF')
                  .onClick(() => {
                    // Handle compare action
                  })
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')
              .padding(10)
            }
          }, (item: Product) => item.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .layoutWeight(1)

        Text('Price Update Log')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')
          .width('100%')

        List({ space: 6 }) {
          ForEach(this.products, (item: Product) => {
            ListItem() {
              Row({ space: 0 }) {
                Text(`${item.name} (${item.store})`)
                  .fontSize(14)
                  .fontColor('#0F172A')
                  .layoutWeight(1)
                
                Text(item.price)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#38BDF8')
              }
              .width('100%')
              .padding(10)
              .borderRadius(8)
              .backgroundColor('#FFFFFF')
            }
          }, (item: Product) => item.name)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#BAE6FD', 0], ['#F0F9FF', 0.5], ['#BAE6FD', 1]]
      })
    }.width('100%').height('100%')
  }
}

interface Product {
  name: string;
  price: string;
  store: string;
}