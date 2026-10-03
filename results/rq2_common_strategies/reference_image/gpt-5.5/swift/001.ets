interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: ResourceColor
}

class AppColors {
  static readonly primary: ResourceColor = '#6750A4'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly secondary: ResourceColor = '#6CC24A'
  static readonly onSecondary: ResourceColor = '#0A0F0A'
  static readonly tertiary: ResourceColor = '#FFB300'
  static readonly onTertiary: ResourceColor = '#1F1400'
  static readonly background: ResourceColor = '#F6F7FB'
  static readonly onBackground: ResourceColor = '#0F172A'
  static readonly surface: ResourceColor = '#FCFCFF'
  static readonly onSurface: ResourceColor = '#111827'
  static readonly surfaceVariant: ResourceColor = '#EEF0F6'
  static readonly outline: ResourceColor = '#D0D5DD'
  static readonly success: ResourceColor = '#16A34A'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#D92D20'
  static readonly onSurface70: ResourceColor = '#B3111827'
  static readonly shadow: ResourceColor = '#1A000000'
}

class AppTypography {
  static readonly display: number = 22
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
  static readonly label: number = 10
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

class AppRadius {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

@Entry
@Component
struct ContentView {
  @State private selectedCategory: string = 'All'
  @State private selectedFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']

  private products: ProductUi[] = [
    {
      id: 0,
      title: 'Product 1',
      price: '$14.99',
      badge: '',
      rating: '4.0',
      color: '#E0E7FF'
    },
    {
      id: 1,
      title: 'Product 2',
      price: '$35.99',
      badge: 'NEW',
      rating: '4.9',
      color: '#D1FAE5'
    },
    {
      id: 2,
      title: 'Product 3',
      price: '$12.00',
      badge: '',
      rating: '4.5',
      color: '#FFEED5'
    },
    {
      id: 3,
      title: 'Product 4',
      price: '$29.00',
      badge: '',
      rating: '4.8',
      color: '#FDE68A'
    }
  ]

  private toggleFilter(filter: string): void {
    if (this.selectedFilters.indexOf(filter) >= 0) {
      this.selectedFilters = this.selectedFilters.filter((item: string) => item !== filter)
    } else {
      this.selectedFilters = [...this.selectedFilters, filter]
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Shop')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(104)
          .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.xxxl }) {
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item
              }
            })
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                this.toggleFilter(filter)
              }
            })
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ProductGrid({ products: this.products })
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 })
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppColors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: () => {
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
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
      Row({ space: AppSpacing.sm }) {
        ForEach(this.items, (item: string) => {
          Text(item)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.selected === item ? AppColors.onPrimary : AppColors.onSurface)
            .padding({
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.lg,
              bottom: AppSpacing.lg
            })
            .backgroundColor(this.selected === item ? AppColors.primary : AppColors.surface)
            .borderRadius(AppRadius.medium)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onSelect(item)
            })
        }, (item: string) => item)
      }
      .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
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

  private isSelected(filter: string): boolean {
    return this.selectedFilters.indexOf(filter) >= 0
  }

  build() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Text(filter)
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isSelected(filter) ? AppColors.onSecondary : AppColors.onSurface)
            .padding({
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.md,
              bottom: AppSpacing.md
            })
            .backgroundColor(this.isSelected(filter) ? AppColors.secondary : AppColors.surface)
            .borderRadius(AppRadius.small)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.onToggle(filter)
            })
        }, (filter: string) => filter)
      }
      .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
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

  private getRowStarts(): number[] {
    let result: number[] = []
    for (let i = 0; i < this.products.length; i += 2) {
      result.push(i)
    }
    return result
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      ForEach(this.getRowStarts(), (start: number) => {
        Row({ space: AppSpacing.lg }) {
          ProductCard({ product: this.products[start] })
            .layoutWeight(1)

          if (start + 1 < this.products.length) {
            ProductCard({ product: this.products[start + 1] })
              .layoutWeight(1)
          } else {
            Blank()
              .layoutWeight(1)
          }
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }, (start: number) => start.toString())
    }
    .width('100%')
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
    color: '#E0E7FF'
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Image')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface70)
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(this.product.color)
      .borderRadius(AppRadius.medium)

      Row() {
        Text(this.product.title)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()

        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppRadius.small)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Text(this.product.price)
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)

      Row({ space: AppSpacing.sm }) {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.warning)

        Text(`${this.product.rating} rating`)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface70)
      }
      .alignItems(VerticalAlign.Center)

      Text('Add to Cart')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(36)
        .lineHeight(36)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadius.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 3,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BottomActionBar {
  subtotal: string = '$129.96'
  actionLabel: string = 'Checkout'
  onAction: () => void = () => {
  }

  build() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color(AppColors.outline)

      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Subtotal')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface70)

          Text(this.subtotal)
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.actionLabel)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .textAlign(TextAlign.Center)
          .width(120)
          .height(40)
          .lineHeight(40)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppRadius.large)
          .onClick(() => {
            this.onAction()
          })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}