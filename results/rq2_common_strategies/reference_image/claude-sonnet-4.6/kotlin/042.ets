const NAME: string = '056*PriceCompare*en'

class AppColors {
  static readonly primary: string = '#0EA5E9'
  static readonly primaryA25: string = '#400EA5E9'
  static readonly secondary: string = '#38BDF8'
  static readonly secondaryA25: string = '#4038BDF8'
  static readonly tertiary: string = '#7DD3FC'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly shadow: string = '#1F0F172A'
}

class Spacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

class Shapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class Elevation {
  static readonly level1Radius: number = 4
  static readonly level1Dy: number = 2
}

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

@Entry
@Component
struct PriceComparePage {
  @State products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ]

  @Builder
  ProductCard(item: Product) {
    Column({ space: Spacing.sm }) {
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(Shapes.medium)

      Text(item.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(item.price)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text(item.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)

      Button('Compare')
        .type(ButtonType.Normal)
        .width('100%')
        .height(38)
        .borderRadius(Shapes.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(Spacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: Elevation.level1Radius,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: Elevation.level1Dy
    })
  }

  @Builder
  LogRow(item: Product) {
    Row() {
      Text(`${item.name} (${item.store})`)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
        .textAlign(TextAlign.Start)

      Text(item.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .margin({ left: Spacing.md })
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(Shapes.small)
    .padding(Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column({ space: Spacing.lg }) {
      Text('Cold Gradient Price Compare')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')

      Grid() {
        ForEach(this.products, (item: Product) => {
          GridItem() {
            this.ProductCard(item)
          }
        }, (item: Product) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(Spacing.md)
      .rowsGap(Spacing.md)
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      Text('Price Update Log')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')

      List({ space: Spacing.sm }) {
        ForEach(this.products, (item: Product) => {
          ListItem() {
            this.LogRow(item)
          }
        }, (item: Product) => `log-${item.id}`)
      }
      .width('100%')
      .height(170)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondaryA25, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primaryA25, 1.0]
      ]
    })
  }
}