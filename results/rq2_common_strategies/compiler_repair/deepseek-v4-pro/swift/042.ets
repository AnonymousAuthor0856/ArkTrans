@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ]

  build() {
    Stack() {
      // Background gradient (simulated with a full-screen column)
      Column() { }
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [['rgba(56,189,248,0.25)', 0], ['#FFF0F9FF', 0.5], ['rgba(14,165,233,0.25)', 1]],
          direction: GradientDirection.Bottom
        })

      // Main scrollable content
      Column({ space: 14 }) {
        // Title
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF0F172A')

        // Product grid (2 columns)
        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              Column({ space: 6 }) {
                // Image placeholder
                Button() { }
                  .width(100)
                  .height(100)
                  .backgroundColor('#FFE0F2FE')
                  .borderRadius(10)

                Text(product.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF0F172A')
                  .textAlign(TextAlign.Center)

                Text(product.price)
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .foregroundColor('#FF0EA5E9')

                Text(product.store)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF7DD3FC')

                Button() {
                  Text('Compare')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FFFFFFFF')
                    .padding({ top: 8, bottom: 8 })
                }
                .width('100%')
                .backgroundColor('#FF0EA5E9')
                .borderRadius(10)
                .onClick(() => {})
              }
              .width('100%')
              .padding({ left: 10, right: 10, top: 10, bottom: 10 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(16)
              .shadow({
                radius: 4,
                color: 'rgba(0,0,0,0.12)',
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .padding({ bottom: 28 })

        // Price Update Log section
        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF0EA5E9')

        List({ space: 6 }) {
          ForEach(this.products, (product: Product) => {
            ListItem() {
              Row({ space: 0 }) {
                Text(product.name + ' (' + product.store + ')')
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .foregroundColor('#FF0F172A')
                Blank().layoutWeight(1)
                Text(product.price)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF38BDF8')
              }
              .width('100%')
              .padding({ left: 10, right: 10, top: 10, bottom: 10 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(6)
            }
          })
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .height('100%')
      .padding(14)
    }
    .width('100%')
    .height('100%')
  }
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}