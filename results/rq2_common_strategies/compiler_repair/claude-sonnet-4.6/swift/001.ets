// Design Tokens
class AppColors {
  static primary: string = '#675199'
  static onPrimary: string = '#FFFFFF'
  static secondary: string = '#6CC24A'
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

class Spacing {
  static xs: number = 2
  static sm: number = 4
  static md: number = 6
  static lg: number = 8
  static xl: number = 12
  static xxl: number = 16
  static xxxl: number = 24
}

interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

const productList: ProductUi[] = [
  { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
  { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1F7E5' },
  { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEEDD' },
  { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE98A' },
]

const categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
const filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  toggleFilter(filter: string) {
    const idx = this.selectedFilters.indexOf(filter)
    if (idx >= 0) {
      this.selectedFilters = this.selectedFilters.filter((f: string) => f !== filter)
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
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: Spacing.xxl, bottom: Spacing.xxl })
          .backgroundColor(AppColors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: Spacing.xxxl }) {
            // Category Row
            CategoryRow({
              items: categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item
              }
            })
            .padding({ left: Spacing.lg, right: Spacing.lg })

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                this.toggleFilter(filter)
              }
            })
            .padding({ left: Spacing.lg, right: Spacing.lg })

            // Product Grid
            ProductGrid({ products: productList })
              .padding({ left: Spacing.lg, right: Spacing.lg })

            // Bottom padding for action bar
            Column().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
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
struct CategoryRow {
  items: string[] = []
  selected: string = ''
  onSelect: (item: string) => void = (_item: string) => {}

  build() {
    Scroll() {
      Row({ space: Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Text(item)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.selected === item ? AppColors.onPrimary : AppColors.onSurface)
            .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
            .backgroundColor(this.selected === item ? AppColors.primary : AppColors.surface)
            .borderRadius(8)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onSelect(item)
            })
        })
      }
      .padding({ top: Spacing.sm, bottom: Spacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(50)
  }
}

@Component
struct FilterRow {
  selectedFilters: string[] = []
  onToggle: (filter: string) => void = (_filter: string) => {}

  isSelected(filter: string): boolean {
    return this.selectedFilters.indexOf(filter) >= 0
  }

  build() {
    Scroll() {
      Row({ space: Spacing.sm }) {
        ForEach(filterOptions, (filter: string) => {
          Text(filter)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isSelected(filter) ? AppColors.onSecondary : AppColors.onSurface)
            .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.md, bottom: Spacing.md })
            .backgroundColor(this.isSelected(filter) ? AppColors.secondary : AppColors.surface)
            .borderRadius(4)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onToggle(filter)
            })
        })
      }
      .padding({ top: Spacing.xs, bottom: Spacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(40)
  }
}

@Component
struct ProductGrid {
  products: ProductUi[] = []

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(Spacing.lg)
    .rowsGap(Spacing.lg)
    .width('100%')
  }
}

@Component
struct ProductCard {
  product: ProductUi = { id: 0, title: '', price: '', badge: '', rating: '', color: '#FFFFFF' }

  build() {
    Column({ space: Spacing.lg }) {
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
          .fontColor('#B3111826')
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
            .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)

      // Rating
      Row({ space: Spacing.sm }) {
        Circle()
          .fill(AppColors.warning)
          .width(8)
          .height(8)

        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3111826')
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
        .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.lg)
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
      // Divider
      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)

      Row() {
        // Subtotal info
        Column({ space: Spacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3111826')

          Text(this.subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Checkout Button
        Text(this.actionLabel)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width(120)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: Spacing.lg })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}