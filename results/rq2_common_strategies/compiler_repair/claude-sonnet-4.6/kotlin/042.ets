import { LengthMetrics } from '@kit.ArkUI'

interface ProductItem {
  id: number
  name: string
  price: string
  store: string
}

const AppColors = {
  primary: '#0EA5E9',
  secondary: '#38BDF8',
  tertiary: '#7DD3FC',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BAE6FD',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#0F172A',
  onBackground: '#0F172A',
  onSurface: '#0F172A',
}

const products: ProductItem[] = [
  { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
  { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
  { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
  { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
  { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
  { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' },
]

@Component
struct ProductCard {
  product: ProductItem = { id: 0, name: '', price: '', store: '' }

  build() {
    Column({ space: 6 }) {
      Row() {
      }
      .width(100)
      .height(100)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(10)

      Text(this.product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text(this.product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)

      Button('Compare')
        .width('100%')
        .height(36)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(10)
    }
    .width('100%')
    .padding(10)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct PriceLogRow {
  product: ProductItem = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
  }
}

@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column({ space: 14 }) {
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        Grid() {
          ForEach(products, (p: ProductItem) => {
            GridItem() {
              ProductCard({ product: p })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .height(products.length <= 2 ? 280 : products.length <= 4 ? 560 : 840)

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        Column({ space: 6 }) {
          ForEach(products, (p: ProductItem) => {
            PriceLogRow({ product: p })
          })
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#40' + AppColors.secondary.slice(1), 0.0],
          [AppColors.background, 0.5],
          ['#40' + AppColors.primary.slice(1), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }
}