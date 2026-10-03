// AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#6750A4'
    export const onPrimary = '#FFFFFF'
    export const secondary = '#6CC24A'
    export const onSecondary = '#0A0F0A'
    export const tertiary = '#FFB300'
    export const onTertiary = '#1F1400'
    export const background = '#F6F7FB'
    export const onBackground = '#0F172A'
    export const surface = '#FCFCFF'
    export const onSurface = '#111827'
    export const surfaceVariant = '#EEF0F6'
    export const outline = '#D0D5DD'
    export const success = '#16A34A'
    export const warning = '#F59E0B'
    export const error = '#D92D20'
  }
  export namespace Spacing {
    export const xs = 2
    export const sm = 4
    export const md = 6
    export const lg = 8
    export const xl = 12
    export const xxl = 16
    export const xxxl = 24
  }
  export function getActiveFontSize(active: boolean): number {
    return active ? 14 : 12
  }
  export function getActiveFontWeight(active: boolean): number {
    return active ? 500 : 400
  }
  export function getActiveFontColor(active: boolean, onColor: string, surfaceColor: string): string {
    return active ? onColor : surfaceColor
  }
  export function getActiveBgColor(active: boolean, activeColor: string, inactiveColor: string): string {
    return active ? activeColor : inactiveColor
  }
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
struct CategoryRow {
  items: string[] = []
  selected: string = ''
  onSelect: (label: string) => void = () => {}

  build() {
    Row() {
      ForEach(this.items, (label: string) => {
        Text(label)
          .fontSize(AppTokens.getActiveFontSize(label === this.selected))
          .fontWeight(AppTokens.getActiveFontWeight(label === this.selected))
          .fontColor(AppTokens.getActiveFontColor(label === this.selected, AppTokens.Colors.onPrimary, AppTokens.Colors.onSurface))
          .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .backgroundColor(AppTokens.getActiveBgColor(label === this.selected, AppTokens.Colors.primary, AppTokens.Colors.surface))
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(8)
          .onClick(() => this.onSelect(label))
      }, (label: string) => label)
    }
    .width('100%')
    .height(36)
  }
}

@Component
struct FilterRow {
  filters: string[] = []
  onToggle: (label: string) => void = () => {}

  @Builder
  filterChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(500)
      .fontColor(this.filters.includes(label) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.filters.includes(label) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .borderRadius(4)
      .onClick(() => this.onToggle(label))
  }

  build() {
    Row() {
      this.filterChip('In Stock')
      this.filterChip('Under $20')
      this.filterChip('Rating 4+')
    }
    .width('100%')
    .height(32)
  }
}

@Component
struct ProductCard {
  p: ProductUi | null = null

  build() {
    Column() {
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.p ? this.p.color : '#E0E7FF')
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row() {
        Text(this.p ? this.p.title : '')
          .fontSize(14)
          .fontWeight(500)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        if (this.p && this.p.badge.length > 0) {
          Text(this.p.badge)
            .fontSize(10)
            .fontWeight(500)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(4)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Text(this.p ? this.p.price : '')
        .fontSize(18)
        .fontWeight(600)
        .fontColor(AppTokens.Colors.primary)

      Row() {
        Row()
          .width(10)
          .height(10)
          .backgroundColor(AppTokens.Colors.warning)
          .borderRadius(3)
        Text(`${this.p ? this.p.rating : ''} rating`)
          .fontSize(12)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')

      Button('Add to Cart')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(500)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }
}

@Component
struct ProductGrid {
  products: ProductUi[] = []

  build() {
    Grid() {
      ForEach(this.products, (p: ProductUi) => {
        GridItem() {
          ProductCard({ p: p })
        }
      }, (p: ProductUi) => p.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg)
    .width('100%')
  }
}

@Component
struct BottomActionBar {
  subtotal: string = ''
  actionLabel: string = ''
  onAction: () => void = () => {}

  build() {
    Row() {
      Column() {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.subtotal)
          .fontSize(18)
          .fontWeight(600)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(this.actionLabel)
        .width(140)
        .height(44)
        .fontSize(14)
        .fontWeight(500)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .onClick(() => this.onAction())
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedCategory: string = 'All'
  @State filters: string[] = ['In Stock']
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private palette: string[] = [
    '#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A',
    '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'
  ]
  private prices: string[] = ['$14.99', '$35.99', '$22.99', '$49.99', '$9.99', '$28.99', '$19.99', '$42.99']
  private ratings: string[] = ['4.0', '4.9', '4.5', '4.2', '4.7', '4.3', '4.8', '4.1']
  private productList: ProductUi[] = this.buildProducts()

  buildProducts(): ProductUi[] {
    const result: ProductUi[] = []
    for (let i = 0; i < 8; i++) {
      let badge = ''
      if (i % 3 === 0) {
        badge = 'NEW'
      } else if (i % 4 === 0) {
        badge = 'SALE'
      }
      result.push({
        id: i,
        title: `Product ${i + 1}`,
        price: this.prices[i],
        badge: badge,
        rating: this.ratings[i],
        color: this.palette[i % this.palette.length]
      })
    }
    return result
  }

  toggleFilter(label: string): void {
    const idx = this.filters.indexOf(label)
    if (idx >= 0) {
      this.filters.splice(idx, 1)
    } else {
      this.filters.push(label)
    }
  }

  build() {
    Column() {
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(600)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      Scroll() {
        Column() {
          CategoryRow({
            items: this.categories,
            selected: this.selectedCategory,
            onSelect: (label: string) => { this.selectedCategory = label }
          })
          .margin({ top: AppTokens.Spacing.md })

          FilterRow({
            filters: this.filters,
            onToggle: (label: string) => { this.toggleFilter(label) }
          })
          .margin({ top: AppTokens.Spacing.md })

          ProductGrid({ products: this.productList })
            .margin({ top: AppTokens.Spacing.lg })

          Blank(AppTokens.Spacing.xxxl)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)

      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: () => {}
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
