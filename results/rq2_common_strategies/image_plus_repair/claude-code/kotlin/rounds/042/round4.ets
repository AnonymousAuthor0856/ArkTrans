// Cold Gradient Price Compare - ArkTS conversion
// UI_TYPE: ECommerce
// STYLE_THEME: Cold Gradient
// LANG: en
// BASELINE_SIZE: 720x1280

class ColorTokens {
  primary: string = '#0EA5E9'
  secondary: string = '#38BDF8'
  tertiary: string = '#7DD3FC'
  background: string = '#F0F9FF'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#E0F2FE'
  outline: string = '#BAE6FD'
  success: string = '#22C55E'
  warning: string = '#FACC15'
  error: string = '#EF4444'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#1E1E1E'
  onTertiary: string = '#0F172A'
  onBackground: string = '#0F172A'
  onSurface: string = '#0F172A'
}

class SpacingTokens {
  sm: number = 6
  md: number = 10
  lg: number = 14
  xl: number = 20
  xxl: number = 28
}

class ShapeTokens {
  small: number = 6
  medium: number = 10
  large: number = 24
}

class AppTokens {
  static Colors: ColorTokens = new ColorTokens()
  static Spacing: SpacingTokens = new SpacingTokens()
  static Shapes: ShapeTokens = new ShapeTokens()
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}

@Component
struct ProductCard {
  @Prop product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Column() {
      Row()
        .width(160)
        .height(160)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.md })

      Text(this.product.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })
        .maxLines(2)
        .textAlign(TextAlign.Center)

      Text(this.product.price)
        .fontSize(18)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.sm })

      Text(this.product.store)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Compare')
        .width('100%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(28)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 4
    })
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }
}

@Component
struct PriceLogRow {
  @Prop product: Product = { id: 0, name: '', price: '', store: '' }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

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
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg, top: AppTokens.Spacing.xl })

      Grid() {
        ForEach(this.products, (p: Product) => {
          GridItem() {
            ProductCard({ product: p })
          }
        }, (p: Product) => p.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.lg })

      Text('Price Update Log')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.sm })

      List() {
        ForEach(this.products, (p: Product) => {
          ListItem() {
            PriceLogRow({ product: p })
          }
        }, (p: Product) => `log-${p.id}`)
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 0, color: 'transparent' })
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.lg,
      bottom: 48
    })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4038BDF8', 0.0],
        [AppTokens.Colors.background, 0.5],
        ['#400EA5E9', 1.0]
      ]
    })
  }
}
