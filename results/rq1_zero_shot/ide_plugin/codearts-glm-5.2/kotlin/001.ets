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
    Column({ space: AppSpacing.md }) {
      Text('Image')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(120)
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
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)

      Row() {
        Column()
          .width(10)
          .height(10)
          .backgroundColor(AppColors.warning)
          .borderRadius(4)
        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .margin({ left: AppSpacing.sm })
      }
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40)
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
  @State filters: string[] = ['In Stock']
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private products: ProductUi[] = []

  aboutToAppear() {
    const palette: string[] = [
      '#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A',
      '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'
    ]
    for (let i = 0; i < 8; i++) {
      this.products.push({
        id: i,
        title: `Product ${i + 1}`,
        price: `$${Math.floor(Math.random() * 41) + 9}.99`,
        badge: i % 3 === 0 ? 'NEW' : (i % 4 === 0 ? 'SALE' : ''),
        rating: `${Math.floor(Math.random() * 2) + 4}.${Math.floor(Math.random() * 10)}`,
        color: palette[i % palette.length]
      })
    }
  }

  build() {
    Column() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      Column() {
        this.CategoryRow()

        Blank().height(AppSpacing.md)

        this.FilterRow()

        Blank().height(AppSpacing.lg)

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
        .padding({ bottom: AppSpacing.xxl })
        .width('100%')
        .layoutWeight(1)
      }
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .layoutWeight(1)

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  CategoryRow() {
    Row({ space: AppSpacing.sm }) {
      ForEach(this.categories, (label: string) => {
        Text(label)
          .fontSize(label === this.selectedCategory ? 14 : 12)
          .fontWeight(label === this.selectedCategory ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(label === this.selectedCategory ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(label === this.selectedCategory ? AppColors.primary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 8 })
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .onClick(() => {
            this.selectedCategory = label
          })
      }, (label: string) => label)
    }
    .width('100%')
    .height(36)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterRow() {
    Row({ space: AppSpacing.sm }) {
      this.FilterChip('In Stock')
      this.FilterChip('Under $20')
      this.FilterChip('Rating 4+')
    }
    .width('100%')
    .height(32)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.filters.includes(label) ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.filters.includes(label) ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: 4 })
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .onClick(() => {
        const idx = this.filters.indexOf(label)
        if (idx >= 0) {
          this.filters.splice(idx, 1)
        } else {
          this.filters.push(label)
        }
      })
  }

  @Builder
  BottomActionBar() {
    Row() {
      Column() {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('$129.96')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .height(44)
        .width(140)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}