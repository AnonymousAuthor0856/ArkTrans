// AppTokens - Design Tokens
class AppColors {
  static primary: string = '#6750A4'
  static onPrimary: string = '#FFFFFF'
  static secondary: string = '#6CC24A'
  static onSecondary: string = '#0A0F0A'
  static tertiary: string = '#FFB300'
  static onTertiary: string = '#1F1400'
  static background: string = '#F6F7FB'
  static onBackground: string = '#0F172A'
  static surface: string = '#FCFCFF'
  static onSurface: string = '#111827'
  static surfaceVariant: string = '#EEF0F6'
  static outline: string = '#D0D5DD'
  static success: string = '#16A34A'
  static warning: string = '#F59E0B'
  static error: string = '#D92C20'
}

class AppSpacing {
  static xs: number = 2
  static sm: number = 4
  static md: number = 6
  static lg: number = 8
  static xl: number = 12
  static xxl: number = 16
  static xxxl: number = 24
}

class AppRadius {
  static small: number = 4
  static medium: number = 8
  static large: number = 12
}

// Product Data Model
interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

// Product data
const productPalette: string[] = [
  '#E0E7FF',
  '#D1FAE5',
  '#FFEDD5',
  '#FDE68A'
]

const products: ProductUi[] = [
  { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: productPalette[0] },
  { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: productPalette[1] },
  { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: productPalette[2] },
  { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: productPalette[3] }
]

const categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
const filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

// Main Page Component
@Entry
@Component
struct ShopPage {
  @State selectedCategory: string = 'All'
  @State selectedFilters: Set<string> = new Set(['In Stock'])

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column() {
        // Top Bar - Shop Title
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .padding({ top: AppSpacing.xxl, bottom: AppSpacing.xxl })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)

        // Scrollable content
        Scroll() {
          Column() {
            // Category Row
            this.CategoryRowBuilder()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .margin({ bottom: AppSpacing.xxxl })

            // Filter Row
            this.FilterRowBuilder()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .margin({ bottom: AppSpacing.xxxl })

            // Product Grid
            this.ProductGridBuilder()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          }
          .width('100%')
          .padding({ bottom: 100 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Action Bar
      Column() {
        Blank()
        this.BottomActionBarBuilder('$129.96', 'Checkout')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CategoryRowBuilder() {
    Scroll() {
      Row() {
        ForEach(categories, (item: string) => {
          Button(item)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.selectedCategory === item ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.selectedCategory === item ? AppColors.primary : AppColors.surface)
            .borderRadius(AppRadius.medium)
            .border({
              width: 1,
              color: AppColors.outline
            })
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
            .onClick(() => {
              this.selectedCategory = item
            })
        }, (item: string) => item)
      }
      .space(AppSpacing.sm)
      .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50)
    .width('100%')
  }

  @Builder
  FilterRowBuilder() {
    Scroll() {
      Row() {
        ForEach(filterOptions, (filter: string) => {
          Button(filter)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedFilters.has(filter) ? AppColors.onSecondary : AppColors.onSurface)
            .backgroundColor(this.selectedFilters.has(filter) ? AppColors.secondary : AppColors.surface)
            .borderRadius(AppRadius.small)
            .border({
              width: 1,
              color: AppColors.outline
            })
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.md, bottom: AppSpacing.md })
            .onClick(() => {
              if (this.selectedFilters.has(filter)) {
                this.selectedFilters.delete(filter)
              } else {
                this.selectedFilters.add(filter)
              }
            })
        }, (filter: string) => filter)
      }
      .space(AppSpacing.sm)
      .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40)
    .width('100%')
  }

  @Builder
  ProductGridBuilder() {
    Grid() {
      ForEach(products, (product: ProductUi) => {
        GridItem() {
          this.ProductCardBuilder(product)
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppSpacing.lg)
    .rowsGap(AppSpacing.lg)
    .width('100%')
  }

  @Builder
  ProductCardBuilder(product: ProductUi) {
    Column() {
      // Product Image Placeholder
      Stack() {
        Column()
          .width('100%')
          .aspectRatio(1.0)
          .backgroundColor(product.color)
          .borderRadius(AppRadius.medium)

        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .width('100%')
      .margin({ bottom: AppSpacing.lg })

      // Title and Badge
      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)

        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppRadius.small)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ bottom: AppSpacing.lg })

      // Price
      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.primary)
        .width('100%')
        .margin({ bottom: AppSpacing.lg })

      // Rating
      Row() {
        Circle()
          .fill(AppColors.warning)
          .width(8)
          .height(8)

        Text(`${product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
          .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .margin({ bottom: AppSpacing.lg })

      // Add to Cart Button
      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadius.medium)
        .width('100%')
        .height(36)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  BottomActionBarBuilder(subtotal: string, actionLabel: string) {
    Column() {
      // Top divider
      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)
        .width('100%')

      Row() {
        Column() {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.7)
            .margin({ bottom: AppSpacing.xs })

          Text(subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button(actionLabel)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppRadius.large)
          .width(120)
          .height(40)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}
