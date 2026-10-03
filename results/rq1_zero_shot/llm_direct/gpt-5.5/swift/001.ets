interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

class AppTokens {
  static readonly Colors = {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CC24A',
    onSecondary: '#0A0F0A',
    tertiary: '#FFB300',
    onTertiary: '#1F1400',
    background: '#F6F7FB',
    onBackground: '#0F172A',
    surface: '#FCFCFF',
    onSurface: '#111827',
    surfaceVariant: '#EEF0F6',
    outline: '#D0D5DD',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#D92D20'
  }

  static readonly TypographyTokens = {
    display: { size: 22, weight: FontWeight.SemiBold },
    headline: { size: 18, weight: FontWeight.SemiBold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }
}

@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']

  private getProducts(): ProductUi[] {
    const palette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A']

    return [
      { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: palette[0] },
      { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: palette[1] },
      { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: palette[2] },
      { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: palette[3] }
    ]
  }

  private toggleFilter(filter: string): void {
    if (this.selectedFilters.includes(filter)) {
      this.selectedFilters = this.selectedFilters.filter((item: string) => item !== filter)
    } else {
      this.selectedFilters = [...this.selectedFilters, filter]
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Text('Shop')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
          .backgroundColor(AppTokens.Colors.background)

        Scroll() {
          Column({ space: AppTokens.Spacing.xxxl }) {
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item
              }
            })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                this.toggleFilter(filter)
              }
            })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            ProductGrid({ products: this.getProducts() })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 })
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: () => {
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CategoryRow {
  items: string[] = []
  selected: string = ''
  onSelect: (item: string) => void = () => {
  }

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(item)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(this.selected === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.lg,
                bottom: AppTokens.Spacing.lg
              })
          }
          .backgroundColor(this.selected === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.onSelect(item)
          })
        }, (item: string) => item)
      }
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    }
    .width('100%')
    .height(50)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct FilterRow {
  selectedFilters: string[] = []
  onToggle: (filter: string) => void = () => {
  }

  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(filter)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(this.selectedFilters.includes(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.md,
                bottom: AppTokens.Spacing.md
              })
          }
          .backgroundColor(this.selectedFilters.includes(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.onToggle(filter)
          })
        }, (filter: string) => filter)
      }
      .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .width('100%')
    .height(40)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
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
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg)
    .width('100%')
    .cachedCount(4)
  }
}

@Component
struct ProductCard {
  product: ProductUi = {
    id: 0,
    title: '',
    price: '',
    badge: '',
    rating: '',
    color: '#FFFFFF'
  }

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Stack() {
        Text('Image')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(this.product.color)
      .borderRadius(AppTokens.Shapes.medium)

      Row() {
        Text(this.product.title)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
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

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.primary)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(AppTokens.Colors.warning)
          .width(8)
          .height(8)

        Text(`${this.product.rating} rating`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Button({ type: ButtonType.Normal }) {
        Text('Add to Cart')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(36)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(36)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
      .onClick(() => {
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BottomActionBar {
  subtotal: string = ''
  actionLabel: string = ''
  onAction: () => void = () => {
  }

  build() {
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color(AppTokens.Colors.outline)

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Subtotal')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)

          Text(this.subtotal)
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text(this.actionLabel)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(120)
            .height(40)
            .textAlign(TextAlign.Center)
        }
        .width(120)
        .height(40)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.onAction()
        })
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
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}