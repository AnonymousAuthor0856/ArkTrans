import { LengthMetrics } from '@kit.ArkUI'

// MARK: - Design Tokens
class AppColors {
  static readonly primary: string = '#675AA4'
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
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#D92D20'
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

// MARK: - Data Models
interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

// MARK: - Category Row
@Component
struct CategoryRow {
  items: string[] = []
  selected: string = ''
  onSelect: (item: string) => void = () => {}

  build() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.items, (item: string) => {
          Text(item)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.selected === item ? AppColors.onPrimary : AppColors.onSurface)
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
            .backgroundColor(this.selected === item ? AppColors.primary : AppColors.surface)
            .borderRadius(8)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onSelect(item)
            })
        }, (item: string) => item)
      }
      .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50)
  }
}

// MARK: - Filter Row
@Component
struct FilterRow {
  selectedFilters: Set<string> = new Set()
  onToggle: (filter: string) => void = () => {}
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  build() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Text(filter)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedFilters.has(filter) ? AppColors.onSecondary : AppColors.onSurface)
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.md, bottom: AppSpacing.md })
            .backgroundColor(this.selectedFilters.has(filter) ? AppColors.secondary : AppColors.surface)
            .borderRadius(4)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onToggle(filter)
            })
        }, (filter: string) => filter)
      }
      .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40)
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  product: ProductUi = {
    id: 0,
    title: '',
    price: '',
    badge: '',
    rating: '',
    color: ''
  }

  build() {
    Column({ space: AppSpacing.lg }) {
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
          .fontColor($r('sys.color.font_secondary'))
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
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.primary)

      // Rating
      Row({ space: AppSpacing.sm }) {
        Circle()
          .fill(AppColors.warning)
          .width(8)
          .height(8)

        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor('#80111827')
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
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  subtotal: string = ''
  actionLabel: string = ''
  onAction: () => void = () => {}

  build() {
    Column({ space: 0 }) {
      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)

      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#80111827')

          Text(this.subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
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
          .onClick(() => {
            this.onAction()
          })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
    }
    .backgroundColor(AppColors.surface)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State private selectedCategory: string = 'All'
  @State private selectedFilters: Set<string> = new Set(['In Stock'])
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']

  private getProducts(): ProductUi[] {
    const palette: string[] = [
      '#E0E7FF',
      '#D1F9E5',
      '#FFEDCC',
      '#FDEA8A'
    ]
    return [
      { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: palette[0] },
      { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: palette[1] },
      { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: palette[2] },
      { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: palette[3] }
    ]
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .padding({ top: AppSpacing.xxl, bottom: AppSpacing.xxl })
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)

        // Content
        Scroll() {
          Column({ space: AppSpacing.xxxl }) {
            // Category Row
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item
              }
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                const newFilters = new Set(this.selectedFilters)
                if (newFilters.has(filter)) {
                  newFilters.delete(filter)
                } else {
                  newFilters.add(filter)
                }
                this.selectedFilters = newFilters
              }
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Product Grid
            Grid() {
              ForEach(this.getProducts(), (product: ProductUi) => {
                GridItem() {
                  ProductCard({ product: product })
                }
              }, (product: ProductUi) => product.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppSpacing.lg)
            .rowsGap(AppSpacing.lg)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .width('100%')

            Column()
              .height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.background)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Action Bar
      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: () => {}
      })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}