// Design Tokens
class AppColors {
  static primary: string = '#6750A4'
  static onPrimary: string = '#FFFFFF'
  static secondary: string = '#6CC34A'
  static onSecondary: string = '#0A0F0A'
  static tertiary: string = '#FFB300'
  static onTertiary: string = '#1F1400'
  static background: string = '#F6F7FB'
  static onBackground: string = '#0F172A'
  static surface: string = '#FCFCFF'
  static onSurface: string = '#111826'
  static surfaceVariant: string = '#EEF0F6'
  static outline: string = '#D0D5DD'
  static success: string = '#16A34A'
  static warning: string = '#F59E0B'
  static error: string = '#D92D20'
}

const SpacingXs: number = 2
const SpacingSm: number = 4
const SpacingMd: number = 6
const SpacingLg: number = 8
const SpacingXl: number = 12
const SpacingXxl: number = 16
const SpacingXxxl: number = 24

class ProductUi {
  id: number = 0
  title: string = ''
  price: string = ''
  badge: string = ''
  rating: string = ''
  color: string = '#FFFFFF'
}

@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1F7E5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEEDD' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDED8A' },
  ]

  isFilterSelected(filter: string): boolean {
    return this.selectedFilters.indexOf(filter) >= 0
  }

  toggleFilter(filter: string) {
    const idx = this.selectedFilters.indexOf(filter)
    if (idx >= 0) {
      const newFilters = [...this.selectedFilters]
      newFilters.splice(idx, 1)
      this.selectedFilters = newFilters
    } else {
      this.selectedFilters = [...this.selectedFilters, filter]
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: SpacingXxl, bottom: SpacingXxl })
          .backgroundColor(AppColors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: SpacingXxxl }) {
            // Category Row
            Scroll() {
              Row({ space: SpacingSm }) {
                ForEach(this.categories, (item: string) => {
                  Text(item)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(this.selectedCategory === item ? AppColors.onPrimary : AppColors.onSurface)
                    .padding({ left: SpacingXl, right: SpacingXl, top: SpacingLg, bottom: SpacingLg })
                    .backgroundColor(this.selectedCategory === item ? AppColors.primary : AppColors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: AppColors.outline })
                    .onClick(() => {
                      this.selectedCategory = item
                    })
                })
              }
              .padding({ top: SpacingSm, bottom: SpacingSm })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(50)
            .padding({ left: SpacingLg, right: SpacingLg })

            // Filter Row
            Scroll() {
              Row({ space: SpacingSm }) {
                ForEach(this.filterOptions, (filter: string) => {
                  Text(filter)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFilterSelected(filter) ? AppColors.onSecondary : AppColors.onSurface)
                    .padding({ left: SpacingXl, right: SpacingXl, top: SpacingMd, bottom: SpacingMd })
                    .backgroundColor(this.isFilterSelected(filter) ? AppColors.secondary : AppColors.surface)
                    .borderRadius(4)
                    .border({ width: 1, color: AppColors.outline })
                    .onClick(() => {
                      this.toggleFilter(filter)
                    })
                })
              }
              .padding({ top: SpacingXs, bottom: SpacingXs })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(40)
            .padding({ left: SpacingLg, right: SpacingLg })

            // Product Grid
            Grid() {
              ForEach(this.products, (product: ProductUi) => {
                GridItem() {
                  ProductCard({ product: product })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(SpacingLg)
            .rowsGap(SpacingLg)
            .width('100%')
            .padding({ left: SpacingLg, right: SpacingLg })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ bottom: 100 })
        }
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.background)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Action Bar
      BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout' })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ProductCard {
  product: ProductUi = new ProductUi()

  build() {
    Column({ space: SpacingLg }) {
      // Product Image
      Stack() {
        Column()
          .width('100%')
          .aspectRatio(1)
          .backgroundColor(this.product.color)
          .borderRadius(8)

        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#11182699')
      }
      .width('100%')
      .aspectRatio(1)

      // Title and Badge
      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .padding({ left: SpacingMd, right: SpacingMd, top: SpacingXs, bottom: SpacingXs })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)

      // Rating
      Row({ space: SpacingSm }) {
        Circle()
          .fill(AppColors.warning)
          .width(8)
          .height(8)

        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor('#11182699')
      }
      .alignItems(VerticalAlign.Center)

      // Add to Cart Button
      Text('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')
        .height(36)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(SpacingLg)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .width('100%')
  }
}

@Component
struct BottomActionBar {
  subtotal: string = ''
  actionLabel: string = ''

  build() {
    Column({ space: 0 }) {
      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)

      Row() {
        Column({ space: SpacingXs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#11182699')

          Text(this.subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.actionLabel)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width(120)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: SpacingLg, right: SpacingLg, top: SpacingLg, bottom: SpacingLg })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}