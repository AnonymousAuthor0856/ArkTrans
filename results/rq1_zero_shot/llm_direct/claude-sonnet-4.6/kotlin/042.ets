import { LengthMetrics } from '@kit.ArkUI'

// Token definitions
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

  export namespace TypographyTokens {
    export const displaySize: number = 26
    export const titleSize: number = 18
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 14
    export const xl: number = 20
    export const xxl: number = 28
  }

  export namespace Radius {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 16
  }
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}

@Component
struct ProductCard {
  product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Image placeholder box
      Row() {
      }
      .width(100)
      .height(100)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Radius.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .width('100%')
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
        .height(36)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct PriceLogRow {
  product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.small)
  }
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ]

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.lg }) {
        // Title
        Text('Cold Gradient Price Compare')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        // Product Grid (2 columns)
        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              ProductCard({ product: product })
            }
          }, (product: Product) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .width('100%')
        .height(this.products.length > 0 ? Math.ceil(this.products.length / 2) * (280 + AppTokens.Spacing.md) : 0)

        // Price Update Log title
        Text('Price Update Log')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')

        // Price log list
        Column({ space: AppTokens.Spacing.sm }) {
          ForEach(this.products, (product: Product) => {
            PriceLogRow({ product: product })
          }, (product: Product) => product.id.toString())
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4038BDF8', 0.0],
        ['#F0F9FF', 0.5],
        ['#400EA5E9', 1.0]
      ]
    })
    .backgroundColor(AppTokens.Colors.background)
    .scrollBar(BarState.Off)
  }
}