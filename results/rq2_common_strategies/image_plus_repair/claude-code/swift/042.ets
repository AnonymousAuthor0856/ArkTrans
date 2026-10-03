@Entry
@Component
struct PriceComparePage {
  @State products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['rgba(56, 189, 248, 0.25)', 0.0],
            ['#F0F9FF', 0.5],
            ['rgba(14, 165, 233, 0.25)', 1.0]
          ]
        })

      Scroll() {
        Column({ space: 14 }) {
          Text('Cold Gradient Price Compare')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .width('100%')

          Grid() {
            ForEach(this.products, (item: Product) => {
              GridItem() {
                ProductCard({ product: item })
              }
            }, (item: Product) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(10)
          .columnsGap(10)
          .width('100%')

          Text('Price Update Log')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0EA5E9')
            .width('100%')

          Column({ space: 6 }) {
            ForEach(this.products, (item: Product) => {
              PriceUpdateLogItem({ product: item })
            }, (item: Product) => item.id.toString())
          }
          .width('100%')
        }
        .padding({ left: 14, right: 14, top: 28, bottom: 48 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ProductCard {
  product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column({ space: 6 }) {
      Column()
        .width(100)
        .height(100)
        .backgroundColor('#E0F2FE')
        .borderRadius(10)

      Text(this.product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .width('100%')
        .textAlign(TextAlign.Center)

      Text(this.product.price)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#0EA5E9')
        .width('100%')
        .textAlign(TextAlign.Center)

      Text(this.product.store)
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
    }
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct PriceUpdateLogItem {
  product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#0F172A')
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
    }
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(6)
    .width('100%')
  }
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0EA5E9'
    export const secondary: string = '#38BDF8'
    export const tertiary: string = '#7DD3FC'
    export const background: string = '#F0F9FF'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E0F2FE'
    export const outline: string = '#BAE6FD'
    export const success: string = '#22C55E'
    export const warning: string = '#FACC15'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#1E1E1E'
    export const onTertiary: string = '#0F172A'
    export const onBackground: string = '#0F172A'
    export const onSurface: string = '#0F172A'
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 16
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 14
    export const xl: number = 20
    export const xxl: number = 28
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
    export const level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  }
}
