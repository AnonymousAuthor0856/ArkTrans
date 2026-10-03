class AppColors {
  static readonly primary: string = '#6750A4'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly secondary: string = '#6CC24A'
  static readonly onSecondary: string = '#0A0F0A'
  static readonly tertiary: string = '#FFB300'
  static readonly onTertiary: string = '#1F1400'
  static readonly background: string = '#F6F7FB'
  static readonly onBackground: string = '#0F172A'
  static readonly surface: string = '#FCFCFF'
  static readonly onSurface: string = '#111827'
  static readonly surfaceVariant: string = '#EEF0F6'
  static readonly outline: string = '#D0D5DD'
  static readonly warning: string = '#F59E0B'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string

  constructor(id: number, title: string, price: string, badge: string, rating: string, color: string) {
    this.id = id
    this.title = title
    this.price = price
    this.badge = badge
    this.rating = rating
    this.color = color
  }
}

@Entry
@Component
struct Index {
  @State private selectedCategory: string = 'All'
  @State private filters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']

  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$14.99', 'NEW', '4.0', '#E0E7FF'),
    new ProductUi(1, 'Product 2', '$35.99', '', '4.9', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$22.99', '', '4.6', '#FFEDD5'),
    new ProductUi(3, 'Product 4', '$18.99', 'NEW', '4.8', '#FDE68A'),
    new ProductUi(4, 'Product 5', '$49.99', 'SALE', '5.0', '#EDE9FE'),
    new ProductUi(5, 'Product 6', '$11.99', '', '4.4', '#FFE4E6'),
    new ProductUi(6, 'Product 7', '$27.99', 'NEW', '4.7', '#E2E8F0'),
    new ProductUi(7, 'Product 8', '$9.99', '', '4.5', '#FFFBEB')
  ]

  private isFilterSelected(label: string): boolean {
    return this.filters.indexOf(label) >= 0
  }

  private toggleFilter(label: string): void {
    if (this.isFilterSelected(label)) {
      this.filters = this.filters.filter((item: string) => item !== label)
    } else {
      this.filters = [...this.filters, label]
    }
  }

  @Builder
  private TopBar() {
    Row() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private CategoryChip(label: string) {
    Row() {
      Text(label)
        .fontSize(label === this.selectedCategory ? 14 : 12)
        .fontWeight(label === this.selectedCategory ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(label === this.selectedCategory ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(32)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(label === this.selectedCategory ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selectedCategory = label
    })
  }

  @Builder
  private CategoryRow() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.categories, (label: string) => {
          this.CategoryChip(label)
        }, (label: string) => label)
      }
      .height(40)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(54)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  private AssistFilterChip(label: string) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isFilterSelected(label) ? AppColors.onSecondary : AppColors.onSurface)
    }
    .height(32)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.isFilterSelected(label) ? AppColors.secondary : AppColors.surface)
    .borderRadius(4)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.toggleFilter(label)
    })
  }

  @Builder
  private FilterRow() {
    Row({ space: AppSpacing.sm }) {
      this.AssistFilterChip('In Stock')
      this.AssistFilterChip('Under $20')
      this.AssistFilterChip('Rating 4+')
    }
    .width('100%')
    .height(38)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private ProductCard(product: ProductUi) {
    Column({ space: AppSpacing.md }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(product.color)
      .borderRadius(12)

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        if (product.badge.length > 0) {
          Row() {
            Text(product.badge)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onTertiary)
          }
          .height(18)
          .padding({ left: 4, right: 4 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(4)
        }
      }
      .width('100%')
      .height(22)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .height(24)

      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill(AppColors.warning)

        Text(`${product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .height(18)
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#33000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  private ProductGrid() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          this.ProductCard(product)
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppSpacing.lg)
    .rowsGap(AppSpacing.lg)
    .padding({ bottom: AppSpacing.xxl })
    .scrollBar(BarState.Off)
  }

  @Builder
  private BottomActionBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('$129.96')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Checkout', { type: ButtonType.Normal, stateEffect: true })
        .width(140)
        .height(44)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(22)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#26000000', offsetX: 0, offsetY: -1 })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        this.CategoryRow()
        Blank().height(AppSpacing.md)
        this.FilterRow()
        Blank().height(AppSpacing.lg)
        this.ProductGrid()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.background)

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}