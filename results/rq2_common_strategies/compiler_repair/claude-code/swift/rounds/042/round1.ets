// MARK: - AppTokens
// Unified UI design system for easy ratio and control size modification
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#0EA5E9'
    export const secondary: ResourceColor = '#38BDF8'
    export const tertiary: ResourceColor = '#7DD3FC'
    export const background: ResourceColor = '#F0F9FF'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E0F2FE'
    export const outline: ResourceColor = '#BAE6FD'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#FACC15'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#1E1E1E'
    export const onTertiary: ResourceColor = '#0F172A'
    export const onBackground: ResourceColor = '#0F172A'
    export const onSurface: ResourceColor = '#0F172A'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 26
    export const displayWeight: FontWeight = FontWeight.Bold
    export const titleSize: number = 18
    export const titleWeight: FontWeight = FontWeight.Medium
    export const bodySize: number = 14
    export const bodyWeight: FontWeight = FontWeight.Normal
    export const labelSize: number = 12
    export const labelWeight: FontWeight = FontWeight.Medium
  }

  export namespace Shapes {
    export const small: Length = 6
    export const medium: Length = 10
    export const large: Length = 16
  }

  export namespace Spacing {
    export const sm: Length = 6
    export const md: Length = 10
    export const lg: Length = 14
    export const xl: Length = 20
    export const xxl: Length = 28
  }

  export namespace ElevationMapping {
    export const level1Radius: number = 4
    export const level1Dy: number = 2
    export const level1Opacity: number = 0.12
    export const level2Radius: number = 8
    export const level2Dy: number = 4
    export const level2Opacity: number = 0.18
  }
}

// MARK: - Data Model
interface Product {
  id: number
  name: string
  price: string
  store: string
}

// MARK: - ProductCard Component
@Component
struct ProductCard {
  @Link product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm as number }) {
      // Placeholder box
      Row() { }
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.tertiary)

      Button('Compare')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(32)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => { })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1Radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1Dy
    })
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  @Link product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - RootScreen
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
    Stack() {
      // Background gradient
      Column() { }
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            ['#38BDF8', 0.25],
            ['#F0F9FF', 0.5],
            ['#0EA5E9', 0.25]
          ],
          direction: GradientDirection.Bottom
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg as number }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.onBackground)

          // LazyVerticalGrid equivalent
          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.md as number)
          .columnsGap(AppTokens.Spacing.md as number)
          .padding({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)

          // LazyColumn equivalent
          Column({ space: AppTokens.Spacing.sm as number }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}
