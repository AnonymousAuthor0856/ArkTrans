interface Product {
  id: number
  name: string
  price: string
  store: string
}

interface ColorPalette {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  onSurface: string
}

const PRODUCTS: Product[] = [
  { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
  { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
  { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
  { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
  { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
  { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
]

const COLORS: ColorPalette = {
  primary: '#0EA5E9',
  secondary: '#38BDF8',
  tertiary: '#7DD3FC',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  onSurface: '#0F172A'
}

@Entry
@Component
struct PriceCompareApp {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Cold Gradient\nPrice Compare')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .lineHeight(48)
          .width('100%')
          .textAlign(TextAlign.Start)

        Grid() {
          ForEach(PRODUCTS, (product: Product) => {
            ProductCard({ product: product })
          }, (product: Product) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(20)
        .width('100%')

        Text('Price Update Log')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 8 })

        Column({ space: 8 }) {
          ForEach(PRODUCTS, (product: Product) => {
            PriceUpdateLogItem({ product: product })
          }, (product: Product) => `log-${product.id}`)
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .padding({ left: 28, right: 28, top: 34, bottom: 28 })
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

@Component
struct ProductCard {
  @Prop product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column({ space: 10 }) {
      Blank()
        .width(200)
        .height(200)
        .backgroundColor(COLORS.surfaceVariant)
        .borderRadius(18)

      Text(this.product.name)
        .fontSize(29)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
        .lineHeight(36)
        .textAlign(TextAlign.Center)
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(25)
        .fontColor(COLORS.primary)
        .margin({ top: 2 })

      Text(this.product.store)
        .fontSize(23)
        .fontColor(COLORS.tertiary)

      Button('Compare')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor(COLORS.primary)
        .borderRadius(18)
        .height(61)
        .width('100%')
        .margin({ top: 2 })
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
    .width('100%')
    .height(455)
    .backgroundColor(COLORS.surface)
    .borderRadius(30)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct PriceUpdateLogItem {
  @Prop product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(18)
        .fontColor(COLORS.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(17)
        .fontColor(COLORS.secondary)
        .margin({ left: 12 })
    }
    .padding(14)
    .width('100%')
    .height(52)
    .backgroundColor(COLORS.surface)
    .borderRadius(8)
  }
}
