class Product {
  id: number
  name: string
  price: string
  store: string

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id
    this.name = name
    this.price = price
    this.store = store
  }
}

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
  static readonly secondaryTint: string = '#4038BDF8'
  static readonly primaryTint: string = '#400EA5E9'
  static readonly shadow: string = '#26000000'
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

@Entry
@Component
struct Index {
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ]

  @Builder
  ProductCard(product: Product) {
    Column({ space: AppSpacing.sm }) {
      Stack()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)

      Text(product.name)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .lineHeight(23)

      Text(product.price)
        .width('100%')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)

      Text(product.store)
        .width('100%')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)
        .textAlign(TextAlign.Center)

      Button('Compare', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(40)
        .borderRadius(10)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 4 })
    }
    .width('100%')
    .minHeight(244)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  PriceLogRow(product: Product) {
    Row() {
      Text(`${product.name} (${product.store})`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .margin({ left: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Cold Gradient Price Compare')
            .width('100%')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .lineHeight(34)

          Grid() {
            ForEach(this.products, (product: Product) => {
              GridItem() {
                this.ProductCard(product)
              }
            }, (product: Product) => product.id.toString())
          }
          .width('100%')
          .height(820)
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .scrollBar(BarState.Off)

          Text('Price Update Log')
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.products, (product: Product) => {
              this.PriceLogRow(product)
            }, (product: Product) => `log-${product.id}`)
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.xxl,
          bottom: 0
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondaryTint, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primaryTint, 1.0]
      ]
    })
  }
}