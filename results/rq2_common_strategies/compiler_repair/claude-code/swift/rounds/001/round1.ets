//
//  ECommerceApp.ets
//  ArkTS conversion of SwiftUI E-Commerce App
//

// MARK: - Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#6750A4'
    export const onPrimary: string = '#FFFFFF'
    export const secondary: string = '#6CC24A'
    export const onSecondary: string = '#0A0F0A'
    export const tertiary: string = '#FFB300'
    export const onTertiary: string = '#1F1400'
    export const background: string = '#F6F7FA'
    export const onBackground: string = '#0F172A'
    export const surface: string = '#FCFCFF'
    export const onSurface: string = '#111827'
    export const surfaceVariant: string = '#EEF0F6'
    export const outline: string = '#D0D5DD'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#D92D20'
  }

  export namespace Spacing {
    export const xs: number = 2
    export const sm: number = 4
    export const md: number = 6
    export const lg: number = 8
    export const xl: number = 12
    export const xxl: number = 16
    export const xxxl: number = 24
  }

  export namespace Shapes {
    export const small: number = 4
    export const medium: number = 8
    export const large: number = 12
  }
}

// MARK: - Data Model
interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

// MARK: - Main Page
@Entry
@Component
struct ECommercePage {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEDD5' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE68A' }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
          .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.xxxl }) {
            // Category Row
            this.CategoryRow()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Filter Row
            this.FilterRow()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Product Grid
            this.ProductGrid()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Action Bar
      Column() {
        Blank()
        this.BottomActionBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  // MARK: - Category Row
  @Builder
  CategoryRow() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.categories, (item: string) => {
          Button(item) {
            this.selectedCategory = item
          }
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.selectedCategory === item
            ? AppTokens.Colors.onPrimary
            : AppTokens.Colors.onSurface)
          .backgroundColor(this.selectedCategory === item
            ? AppTokens.Colors.primary
            : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .height(34)
        }, (item: string) => item)
      }
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50)
    .width('100%')
  }

  // MARK: - Filter Row
  @Builder
  FilterRow() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button(filter) {
            const idx = this.selectedFilters.indexOf(filter)
            if (idx >= 0) {
              this.selectedFilters.splice(idx, 1)
            } else {
              this.selectedFilters.push(filter)
            }
          }
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedFilters.includes(filter)
            ? AppTokens.Colors.onSecondary
            : AppTokens.Colors.onSurface)
          .backgroundColor(this.selectedFilters.includes(filter)
            ? AppTokens.Colors.secondary
            : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
          .height(28)
        }, (filter: string) => filter)
      }
      .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40)
    .width('100%')
  }

  // MARK: - Product Grid
  @Builder
  ProductGrid() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          this.ProductCard(product)
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg)
    .width('100%')
  }

  // MARK: - Product Card
  @Builder
  ProductCard(product: ProductUi) {
    Column({ space: AppTokens.Spacing.lg }) {
      // Product Image
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .aspectRatio(1)
          .backgroundColor(product.color)
          .borderRadius(AppTokens.Shapes.medium)

        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface + 'B3')
      }
      .width('100%')

      // Title and Badge
      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs
            })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')

      // Rating
      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 8, height: 8 })
          .fill(AppTokens.Colors.warning)

        Text(product.rating + ' rating')
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface + 'B3')
      }
      .width('100%')

      // Add to Cart Button
      Button('Add to Cart') {}
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.Colors.onPrimary)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
      .width('100%')
      .height(36)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
    .width('100%')
  }

  // MARK: - Bottom Action Bar
  @Builder
  BottomActionBar() {
    Column() {
      // Divider
      Column()
        .width('100%')
        .height(1)
        .backgroundColor(AppTokens.Colors.outline)

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface + 'B3')

          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Checkout') {}
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .width(120)
        .height(40)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.lg
      })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}
