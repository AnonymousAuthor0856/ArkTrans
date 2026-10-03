// E-commerce Product List with Filters
// Style: Material-You vivid
// Language: en
// Baseline: 1280x720

// Color tokens interface
interface Colors {
  primary: string
  onPrimary: string
  secondary: string
  onSecondary: string
  tertiary: string
  onTertiary: string
  background: string
  onBackground: string
  surface: string
  onSurface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
}

const COLORS: Colors = {
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

// Shape radii interface
interface Shapes {
  small: number
  medium: number
  large: number
}

const SHAPES: Shapes = {
  small: 4,
  medium: 8,
  large: 12
}

// Spacing values interface
interface Spacing {
  xs: number
  sm: number
  md: number
  lg: number
  xl: number
  xxl: number
  xxxl: number
}

const SPACING: Spacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

// Typography styles interface
interface TypographyStyles {
  display: {
    fontSize: number
    fontWeight: number
    lineHeight: number
  }
  headline: {
    fontSize: number
    fontWeight: number
    lineHeight: number
  }
  title: {
    fontSize: number
    fontWeight: number
    lineHeight: number
  }
  body: {
    fontSize: number
    fontWeight: number
    lineHeight: number
  }
  label: {
    fontSize: number
    fontWeight: number
    lineHeight: number
  }
}

const TYPOGRAPHY: TypographyStyles = {
  display: { fontSize: 22, fontWeight: 600, lineHeight: 28 },
  headline: { fontSize: 18, fontWeight: 600, lineHeight: 24 },
  title: { fontSize: 14, fontWeight: 500, lineHeight: 20 },
  body: { fontSize: 12, fontWeight: 400, lineHeight: 16 },
  label: { fontSize: 10, fontWeight: 500, lineHeight: 14 }
}

interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

@Entry
@Component
struct RootScreen {
  @State selected: string = 'All'
  @State filters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']

  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$19.99', badge: 'NEW', rating: '4.5', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$29.99', badge: '', rating: '4.8', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$39.99', badge: 'SALE', rating: '4.2', color: '#FFEDD5' },
    { id: 3, title: 'Product 4', price: '$49.99', badge: '', rating: '4.9', color: '#FDE68A' },
    { id: 4, title: 'Product 5', price: '$15.99', badge: 'NEW', rating: '4.3', color: '#EDE9FE' },
    { id: 5, title: 'Product 6', price: '$22.99', badge: '', rating: '4.6', color: '#FFE4E6' },
    { id: 6, title: 'Product 7', price: '$34.99', badge: 'SALE', rating: '4.1', color: '#E2E8F0' },
    { id: 7, title: 'Product 8', price: '$42.99', badge: '', rating: '4.7', color: '#FFFBEB' }
  ]

  build() {
    Column() {
      // Top App Bar (CenterAlignedTopAppBar equivalent)
      Row() {
        Text('Shop')
          .fontSize(TYPOGRAPHY.display.fontSize)
          .fontWeight(TYPOGRAPHY.display.fontWeight)
          .lineHeight(TYPOGRAPHY.display.lineHeight)
          .fontColor(COLORS.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLORS.surface)

      // Scrollable content area
      Scroll() {
        Column() {
          CategoryRow({
            items: this.categories,
            selected: this.selected,
            onSelect: (label: string): void => {
              this.selected = label
            }
          })
          .margin({ bottom: SPACING.md })

          FilterRow({
            filters: this.filters,
            onToggle: (label: string): void => {
              const index: number = this.filters.indexOf(label)
              if (index >= 0) {
                this.filters.splice(index, 1)
              } else {
                this.filters.push(label)
              }
            }
          })
          .margin({ bottom: SPACING.lg })

          ProductGrid({ products: this.products })
        }
        .padding({
          left: SPACING.lg,
          right: SPACING.lg,
          top: SPACING.md
        })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom ActionBar
      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: (): void => {}
      })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

@Component
struct CategoryRow {
  items: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  selected: string = 'All'
  onSelect: (label: string) => void = (label: string): void => {}

  build() {
    Row() {
      ForEach(this.items, (item: string): void => {
        FilterChip({
          label: item,
          selected: this.selected === item,
          onSelect: (): void => {
            this.onSelect(item)
          }
        })
      }, (item: string): string => item)
    }
    .width('100%')
    .constraintSize({ minHeight: 36 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct FilterChip {
  label: string = ''
  selected: boolean = false
  onSelect: () => void = (): void => {}

  build() {
    Row() {
      Text(this.label)
        .fontSize(this.selected ? TYPOGRAPHY.title.fontSize : TYPOGRAPHY.body.fontSize)
        .fontWeight(this.selected ? TYPOGRAPHY.title.fontWeight : TYPOGRAPHY.body.fontWeight)
        .lineHeight(this.selected ? TYPOGRAPHY.title.lineHeight : TYPOGRAPHY.body.lineHeight)
        .fontColor(this.selected ? COLORS.onPrimary : COLORS.onSurface)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .backgroundColor(this.selected ? COLORS.primary : COLORS.surface)
    .borderRadius(SHAPES.medium)
    .border({ width: 1, color: COLORS.outline })
    .onClick((): void => {
      this.onSelect()
    })
  }
}

@Component
struct FilterRow {
  filters: string[] = ['In Stock']
  onToggle: (label: string) => void = (label: string): void => {}

  build() {
    Row() {
      AssistChip({
        label: 'In Stock',
        active: this.filters.indexOf('In Stock') >= 0,
        onToggle: (): void => {
          this.onToggle('In Stock')
        }
      })
      AssistChip({
        label: 'Under $20',
        active: this.filters.indexOf('Under $20') >= 0,
        onToggle: (): void => {
          this.onToggle('Under $20')
        }
      })
      AssistChip({
        label: 'Rating 4+',
        active: this.filters.indexOf('Rating 4+') >= 0,
        onToggle: (): void => {
          this.onToggle('Rating 4+')
        }
      })
    }
    .width('100%')
    .constraintSize({ minHeight: 32 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct AssistChip {
  label: string = ''
  active: boolean = false
  onToggle: () => void = (): void => {}

  build() {
    Row() {
      Text(this.label)
        .fontSize(TYPOGRAPHY.label.fontSize)
        .fontWeight(TYPOGRAPHY.label.fontWeight)
        .lineHeight(TYPOGRAPHY.label.lineHeight)
        .fontColor(this.active ? COLORS.onSecondary : COLORS.onSurface)
    }
    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    .backgroundColor(this.active ? COLORS.secondary : COLORS.surface)
    .borderRadius(SHAPES.small)
    .border({ width: 1, color: COLORS.outline })
    .onClick((): void => {
      this.onToggle()
    })
  }
}

@Component
struct ProductGrid {
  products: ProductUi[] = []

  build() {
    Column() {
      ForEach(this.createPairs(), (pair: ProductUi[]): void => {
        Row() {
          ForEach(pair, (item: ProductUi): void => {
            ProductCard({ product: item })
              .layoutWeight(1)
          }, (item: ProductUi): string => item.id.toString())
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }, (pair: ProductUi[]): string => {
        if (pair.length > 0) {
          return pair[0].id.toString()
        }
        return 'empty'
      })
    }
    .width('100%')
    .padding({ bottom: SPACING.xxl })
  }

  createPairs(): ProductUi[][] {
    let result: ProductUi[][] = []
    for (let i: number = 0; i < this.products.length; i += 2) {
      let pair: ProductUi[] = []
      pair.push(this.products[i])
      if (i + 1 < this.products.length) {
        pair.push(this.products[i + 1])
      }
      result.push(pair)
    }
    return result
  }
}

@Component
struct ProductCard {
  product: ProductUi = { id: 0, title: '', price: '', badge: '', rating: '', color: '#FFFFFF' }

  build() {
    Column() {
      // Image placeholder box
      Column() {
        Text('Image')
          .fontSize(TYPOGRAPHY.label.fontSize)
          .fontWeight(TYPOGRAPHY.label.fontWeight)
          .lineHeight(TYPOGRAPHY.label.lineHeight)
          .fontColor(COLORS.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(SHAPES.medium)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Row with title and badge
      Row() {
        Text(this.product.title)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .lineHeight(TYPOGRAPHY.title.lineHeight)
          .fontColor(COLORS.onSurface)
          .layoutWeight(1)

        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(TYPOGRAPHY.label.fontSize)
            .fontWeight(TYPOGRAPHY.label.fontWeight)
            .lineHeight(TYPOGRAPHY.label.lineHeight)
            .fontColor(COLORS.onTertiary)
            .backgroundColor(COLORS.tertiary)
            .borderRadius(SHAPES.small)
            .padding({ left: SPACING.sm, right: SPACING.sm, top: SPACING.xs, bottom: SPACING.xs })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: SPACING.md })

      // Price
      Text(this.product.price)
        .fontSize(TYPOGRAPHY.headline.fontSize)
        .fontWeight(TYPOGRAPHY.headline.fontWeight)
        .lineHeight(TYPOGRAPHY.headline.lineHeight)
        .fontColor(COLORS.primary)
        .margin({ top: SPACING.md })

      // Rating row
      Row() {
        // Star icon (simplified as colored box)
        Row()
          .width(10)
          .height(10)
          .backgroundColor(COLORS.warning)
          .borderRadius(SHAPES.small)
          .margin({ right: SPACING.sm })

        Text(this.product.rating + ' rating')
          .fontSize(TYPOGRAPHY.body.fontSize)
          .fontWeight(TYPOGRAPHY.body.fontWeight)
          .lineHeight(TYPOGRAPHY.body.lineHeight)
          .fontColor(COLORS.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: SPACING.md })

      // Add to Cart button
      Button() {
        Text('Add to Cart')
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .lineHeight(TYPOGRAPHY.title.lineHeight)
          .fontColor(COLORS.onPrimary)
      }
      .width('100%')
      .height(40)
      .backgroundColor(COLORS.primary)
      .borderRadius(SHAPES.medium)
      .onClick((): void => {})
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(SPACING.lg)
    .backgroundColor(COLORS.surface)
    .borderRadius(SHAPES.large)
    .border({ width: 1, color: COLORS.outline })
  }
}

@Component
struct BottomActionBar {
  subtotal: string = '$0.00'
  actionLabel: string = 'Action'
  onAction: () => void = (): void => {}

  build() {
    Row() {
      // Subtotal column
      Column() {
        Text('Subtotal')
          .fontSize(TYPOGRAPHY.label.fontSize)
          .fontWeight(TYPOGRAPHY.label.fontWeight)
          .lineHeight(TYPOGRAPHY.label.lineHeight)
          .fontColor(COLORS.onSurface)

        Text(this.subtotal)
          .fontSize(TYPOGRAPHY.headline.fontSize)
          .fontWeight(TYPOGRAPHY.headline.fontWeight)
          .lineHeight(TYPOGRAPHY.headline.lineHeight)
          .fontColor(COLORS.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      // Action button
      Button() {
        Text(this.actionLabel)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .lineHeight(TYPOGRAPHY.title.lineHeight)
          .fontColor(COLORS.onSecondary)
      }
      .width(140)
      .height(44)
      .backgroundColor(COLORS.secondary)
      .borderRadius(SHAPES.large)
      .onClick((): void => {
        this.onAction()
      })
    }
    .width('100%')
    .height(56)
    .padding({ left: SPACING.lg, right: SPACING.lg, top: SPACING.md, bottom: SPACING.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLORS.surface)
  }
}
