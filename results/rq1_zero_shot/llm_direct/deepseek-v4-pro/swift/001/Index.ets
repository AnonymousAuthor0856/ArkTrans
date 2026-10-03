@Entry
@Component
struct ECommerceApp {
  @State selectedCategory: string = 'All'
  @State selectedFilters: Set<string> = new Set(['In Stock'])
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  // Design tokens
  private primaryColor: string = '#6750A4'
  private onPrimaryColor: string = '#FFFFFF'
  private secondaryColor: string = '#6CC24A'
  private onSecondaryColor: string = '#0A0F0A'
  private tertiaryColor: string = '#FFB300'
  private onTertiaryColor: string = '#1F1400'
  private backgroundColor: string = '#F6F7FB'
  private onBackgroundColor: string = '#0F172A'
  private surfaceColor: string = '#FCFCFF'
  private onSurfaceColor: string = '#111827'
  private surfaceVariantColor: string = '#EEF0F6'
  private outlineColor: string = '#D0D5DD'
  private successColor: string = '#16A34A'
  private warningColor: string = '#F59E0B'
  private errorColor: string = '#D92D20'

  private productColors: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A']

  private products: ProductData[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEDD5' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE68A' }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(this.backgroundColor)

        // Content
        Scroll() {
          Column({ space: 24 }) {
            // Category Row
            this.CategoryRowBuilder()

            // Filter Row
            this.FilterRowBuilder()

            // Product Grid
            this.ProductGridBuilder()
          }
          .width('100%')
          .padding({ left: 8, right: 8, bottom: 100 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(this.backgroundColor)
      }
      .width('100%')
      .height('100%')

      // Bottom Action Bar
      Column() {
        Blank()
        this.BottomActionBarBuilder()
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  CategoryRowBuilder() {
    Scroll() {
      Row({ space: 4 }) {
        ForEach(this.categories, (item: string) => {
          Text(item)
            .fontSize(12)
            .fontColor(this.selectedCategory === item ? this.onPrimaryColor : this.onSurfaceColor)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedCategory === item ? this.primaryColor : this.surfaceColor)
            .borderRadius(8)
            .border({ width: 1, color: this.outlineColor })
            .onClick(() => {
              this.selectedCategory = item
            })
        })
      }
      .padding({ top: 4, bottom: 4 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(50)
    .padding({ left: 8, right: 8 })
  }

  @Builder
  FilterRowBuilder() {
    Scroll() {
      Row({ space: 4 }) {
        ForEach(this.filterOptions, (filter: string) => {
          Text(filter)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedFilters.has(filter) ? this.onSecondaryColor : this.onSurfaceColor)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor(this.selectedFilters.has(filter) ? this.secondaryColor : this.surfaceColor)
            .borderRadius(4)
            .border({ width: 1, color: this.outlineColor })
            .onClick(() => {
              if (this.selectedFilters.has(filter)) {
                this.selectedFilters.delete(filter)
              } else {
                this.selectedFilters.add(filter)
              }
            })
        })
      }
      .padding({ top: 2, bottom: 2 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(40)
    .padding({ left: 8, right: 8 })
  }

  @Builder
  ProductGridBuilder() {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        ForEach(this.products.slice(0, 2), (product: ProductData) => {
          this.ProductCardBuilder(product)
        })
      }
      .width('100%')

      Row({ space: 8 }) {
        ForEach(this.products.slice(2, 4), (product: ProductData) => {
          this.ProductCardBuilder(product)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: 8, right: 8 })
  }

  @Builder
  ProductCardBuilder(product: ProductData) {
    Column({ space: 8 }) {
      // Product Image
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(product.color)
          .borderRadius(8)

        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B0B8C4')
      }
      .width('100%')
      .aspectRatio(1)
      .borderRadius(8)

      // Title and Badge
      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .layoutWeight(1)

        if (product.badge !== '') {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onTertiaryColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tertiaryColor)
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.primaryColor)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Rating
      Row({ space: 4 }) {
        Circle()
          .width(8)
          .height(8)
          .fill(this.warningColor)

        Text(`${product.rating} rating`)
          .fontSize(12)
          .fontColor('#B0B8C4')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // Add to Cart Button
      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onPrimaryColor)
        .width('100%')
        .height(36)
        .backgroundColor(this.primaryColor)
        .borderRadius(8)
    }
    .width('48%')
    .padding(8)
    .backgroundColor(this.surfaceColor)
    .borderRadius(12)
    .border({ width: 1, color: this.outlineColor })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionBarBuilder() {
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color(this.outlineColor)

      Row() {
        Column({ space: 2 }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B0B8C4')

          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSecondaryColor)
          .width(120)
          .height(40)
          .backgroundColor(this.secondaryColor)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 8, bottom: 8 })
      .backgroundColor(this.surfaceColor)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(this.surfaceColor)
  }
}

interface ProductData {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}