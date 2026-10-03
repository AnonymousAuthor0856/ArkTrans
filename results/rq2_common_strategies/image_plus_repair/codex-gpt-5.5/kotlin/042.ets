const PRODUCTS: Product[] = [
  { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
  { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
  { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
  { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
  { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
  { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
]

interface Product {
  id: number
  name: string
  price: string
  store: string
}

@Entry
@Component
struct PriceComparePage {
  @State selectedId: number = -1

  @Builder
  productCard(product: Product) {
    Column({ space: 8 }) {
      Blank()
        .width(200)
        .height(200)
        .borderRadius(18)
        .backgroundColor('#E0F2FE')

      Text(product.name)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .lineHeight(42)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Text(product.price)
        .fontSize(28)
        .fontColor('#0EA5E9')
        .lineHeight(34)

      Text(product.store)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7DD3FC')
        .lineHeight(30)

      Button('Compare', { type: ButtonType.Capsule })
        .width('100%')
        .height(80)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#0EA5E9')
        .borderRadius(20)
        .margin({ top: 14 })
        .onClick(() => {
          this.selectedId = product.id
        })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20, bottom: 20 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  updateRow(product: Product) {
    Row() {
      Text(`${product.name} (${product.store})`)
        .fontSize(20)
        .fontColor('#0F172A')
        .layoutWeight(1)

      Text(product.price)
        .fontSize(18)
        .fontColor('#38BDF8')
    }
    .width('100%')
    .padding(14)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  build() {
    Scroll() {
      Column({ space: 22 }) {
        Text('Cold Gradient Price\nCompare')
          .width('100%')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .lineHeight(61)
          .margin({ bottom: 14 })

        Grid() {
          ForEach(PRODUCTS, (product: Product) => {
            GridItem() {
              this.productCard(product)
            }
          }, (product: Product) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(20)
        .rowsGap(20)
        .width('100%')

        Text('Price Update Log')
          .width('100%')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')
          .margin({ top: 10 })

        Column({ space: 8 }) {
          ForEach(PRODUCTS, (product: Product) => {
            this.updateRow(product)
          }, (product: Product) => `log-${product.id}`)
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .padding({ left: 28, right: 28, top: 30, bottom: 24 })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      direction: GradientDirection.Bottom,
      colors: [['#BDEBFF', 0.0], ['#F0F9FF', 0.5], ['#BDEBFF', 1.0]]
    })
  }
}
