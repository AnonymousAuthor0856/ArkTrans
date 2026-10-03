const NAME: string = '056*PriceCompare*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Cold Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#0EA5E9'
  static readonly secondary: string = '#38BDF8'
  static readonly tertiary: string = '#7DD3FC'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#0F172A'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'

  static readonly primaryAlpha25: string = '#400EA5E9'
  static readonly secondaryAlpha25: string = '#4038BDF8'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

class AppElevation {
  static readonly level1Radius: number = 4
  static readonly level1Dy: number = 2
  static readonly level1Color: string = '#1F0F172A'
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
  static readonly level2Color: string = '#2E0F172A'
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}

@Component
struct ProductCard {
  product: Product = {
    id: 0,
    name: '',
    price: '',
    store: ''
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Stack()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.product.name)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text(this.product.store)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)

      Button('Compare', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(36)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1Radius,
      color: AppElevation.level1Color,
      offsetX: 0,
      offsetY: AppElevation.level1Dy
    })
  }
}

@Component
struct PriceLogRow {
  product: Product = {
    id: 0,
    name: '',
    price: '',
    store: ''
  }

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .margin({ left: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small)
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
      Column({ space: AppSpacing.lg }) {
        Text('Cold Gradient Price Compare')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        Grid() {
          ForEach(this.products, (product: Product) => {
            GridItem() {
              ProductCard({ product: product })
            }
          }, (product: Product) => product.id.toString())
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .padding({ bottom: AppSpacing.xxl })

        Text('Price Update Log')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        Column({ space: AppSpacing.sm }) {
          ForEach(this.products, (product: Product) => {
            PriceLogRow({ product: product })
          }, (product: Product) => `log-${product.id}`)
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .width('100%')
      .minHeight('100%')
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondaryAlpha25, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primaryAlpha25, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }
}