const AppColors = {
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

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

@Component
struct ProductCard {
  private product: ProductUi = { id: 0, title: '', price: '', badge: '', rating: '', color: '' }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Image')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3111827')
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.product.color)
        .borderRadius(8)
        .textAlign(TextAlign.Center)

      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)

        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.xs, bottom: AppSpacing.xs })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)

      Row({ space: AppSpacing.sm }) {
        Column()
          .width(8)
          .height(8)
          .backgroundColor(AppColors.warning)
          .borderRadius(4)
        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontColor('#B3111827')
      }
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(36)
    }
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .width('100%')
  }
}

@Entry
@Component
struct Index {
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
    Column() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.xxl, bottom: AppSpacing.xxl })
        .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.xxxl }) {
          this.CategoryRow()
          this.FilterRow()

          Grid() {
            ForEach(this.products, (p: ProductUi) => {
              GridItem() {
                ProductCard({ product: p })
              }
            }, (p: ProductUi) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.lg)
          .rowsGap(AppSpacing.lg)
          .width('100%')
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: 100 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  CategoryRow() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.categories, (item: string) => {
          Text(item)
            .fontSize(12)
            .fontColor(this.selectedCategory === item ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.selectedCategory === item ? AppColors.primary : AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 8 })
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
            .onClick(() => {
              this.selectedCategory = item
            })
        }, (item: string) => item)
      }
      .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .scrollDirection(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50)
    .width('100%')
  }

  @Builder
  FilterRow() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Text(filter)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedFilters.includes(filter) ? AppColors.onSecondary : AppColors.onSurface)
            .backgroundColor(this.selectedFilters.includes(filter) ? AppColors.secondary : AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 4 })
            .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.md, bottom: AppSpacing.md })
            .onClick(() => {
              const idx = this.selectedFilters.indexOf(filter)
              if (idx >= 0) {
                this.selectedFilters.splice(idx, 1)
              } else {
                this.selectedFilters.push(filter)
              }
            })
        }, (filter: string) => filter)
      }
      .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs })
    }
    .scrollDirection(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40)
    .width('100%')
  }

  @Builder
  BottomActionBar() {
    Column() {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(AppColors.outline)

      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3111827')
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Checkout')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
          .width(120)
          .height(40)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}