@Entry
@Component
struct Index {
  @State p: Product = new Product("Sample Item", "100.00", "Store A")

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        Text('Cold Gradient Price Compare')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        Grid() {
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for image/icon as per rules, using a colored box to represent the Box modifier
                  Row().width(100).height(100).backgroundColor('#E0F2FE').borderRadius(8)
                }.width(100).height(100)

                Text(this.p.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')

                Text(this.p.price)
                  .fontSize(16)
                  .fontColor('#0EA5E9')

                Text(this.p.store)
                  .fontSize(14)
                  .fontColor('#7DD3FC')

                Button() {
                  Text('Compare')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                }
                .width('100%')
                .backgroundColor('#0EA5E9')
                .borderRadius(8)
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')
              .padding(10)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')

        List({ space: 6 }) {
          ListItem() {
            Row({ space: 0 }) {
              Text(`${this.p.name} (${this.p.store})`)
                .fontSize(16)
                .fontColor('#0F172A')
              
              Blank()

              Text(this.p.price)
                .fontSize(14)
                .fontColor('#38BDF8')
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .padding(10)
          }
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 0.5], ['#BAE6FD', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}

class Product {
  name: string
  price: string
  store: string

  constructor(name: string, price: string, store: string) {
    this.name = name
    this.price = price
    this.store = store
  }
}