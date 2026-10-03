const NAME: string = '001_EcommerceList_en'
const UI_TYPE: string = 'E-commerce Product List with Filters'
const STYLE_THEME: string = 'Material-You vivid'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

const AppTokens = {
  Colors: {
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
  },
  TypographyTokens: {
    display: { fontSize: 22, fontWeight: 600, lineHeight: 28, letterSpacing: 0 },
    headline: { fontSize: 18, fontWeight: 600, lineHeight: 24, letterSpacing: 0 },
    title: { fontSize: 14, fontWeight: 500, lineHeight: 20, letterSpacing: 0 },
    body: { fontSize: 12, fontWeight: 400, lineHeight: 16, letterSpacing: 0 },
    label: { fontSize: 10, fontWeight: 500, lineHeight: 14, letterSpacing: 0 }
  },
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  ElevationMapping: {
    level1: { elevation: 1, radius: 2, dy: 0.5, opacity: 0.12 },
    level2: { elevation: 2, radius: 4, dy: 1, opacity: 0.14 },
    level3: { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 },
    level4: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level5: { elevation: 5, radius: 10, dy: 2.5, opacity: 0.2 }
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

function buildProducts(): ProductUi[] {
  const palette: string[] = [
    '#E0E7FF',
    '#D1FAE5',
    '#FFEDD5',
    '#FDE68A',
    '#EDE9FE',
    '#FFE4E6',
    '#E2E8F0',
    '#FFFBEB'
  ]

  const products: ProductUi[] = []
  for (let i = 0; i < 8; i++) {
    const price: number = Math.floor(Math.random() * 41) + 9
    const ratingWhole: number = Math.floor(Math.random() * 2) + 4
    const ratingDecimal: number = Math.floor(Math.random() * 10)

    products.push({
      id: i,
      title: `Product ${i + 1}`,
      price: `$${price}.99`,
      badge: i % 3 === 0 ? 'NEW' : (i % 4 === 0 ? 'SALE' : ''),
      rating: `${ratingWhole}.${ratingDecimal}`,
      color: palette[i % palette.length]
    })
  }
  return products
}

@Entry
@Component
struct EcommerceListPage {
  @State private selected: string = 'All'
  @State private filters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private products: ProductUi[] = buildProducts()

  private toggleFilter(label: string): void {
    if (this.filters.indexOf(label) >= 0) {
      this.filters = this.filters.filter((item: string) => item !== label)
    } else {
      this.filters = [...this.filters, label]
    }
  }

  build() {
    Column() {
      Row() {
        Text('Shop')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.display.lineHeight)
          .letterSpacing(AppTokens.TypographyTokens.display.letterSpacing)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      Column() {
        CategoryRow({
          items: this.categories,
          selected: this.selected,
          onSelect: (label: string) => {
            this.selected = label
          }
        })

        Blank()
          .height(AppTokens.Spacing.md)

        FilterRow({
          filters: this.filters,
          onToggle: (label: string) => {
            this.toggleFilter(label)
          }
        })

        Blank()
          .height(AppTokens.Spacing.lg)

        ProductGrid({ products: this.products })

        Blank()
          .height(AppTokens.Spacing.xxxl)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .alignItems(HorizontalAlign.Start)

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
  @Prop items: string[] = []
  @Prop selected: string = ''
  onSelect: (label: string) => void = () => {
  }

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      ForEach(this.items, (label: string) => {
        Text(label)
          .fontSize(label === this.selected ? AppTokens.TypographyTokens.title.fontSize : AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(label === this.selected ? AppTokens.TypographyTokens.title.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
          .lineHeight(label === this.selected ? AppTokens.TypographyTokens.title.lineHeight : AppTokens.TypographyTokens.body.lineHeight)
          .fontColor(label === this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .padding({ left: 12, right: 12 })
          .height(32)
          .textAlign(TextAlign.Center)
          .backgroundColor(label === this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.onSelect(label)
          })
      }, (label: string) => label)
    }
    .width('100%')
    .constraintSize({ minHeight: 36 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct FilterRow {
  @Prop filters: string[] = []
  onToggle: (label: string) => void = () => {
  }

  @Builder
  AssistChip(label: string) {
    Text(label)
      .fontSize(AppTokens.TypographyTokens.label.fontSize)
      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
      .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
      .fontColor(this.filters.indexOf(label) >= 0 ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 10, right: 10 })
      .height(30)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.filters.indexOf(label) >= 0 ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.onToggle(label)
      })
  }

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      this.AssistChip('In Stock')
      this.AssistChip('Under $20')
      this.AssistChip('Rating 4+')
    }
    .width('100%')
    .constraintSize({ minHeight: 32 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ProductGrid {
  @Prop products: ProductUi[] = []

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
    .layoutWeight(1)
    .padding({ bottom: AppTokens.Spacing.xxl })
  }
}

@Component
struct ProductCard {
  @Prop product: ProductUi = {
    id: 0,
    title: '',
    price: '',
    badge: '',
    rating: '',
    color: '#E0E7FF'
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Image')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(AppTokens.Shapes.medium)

      Row() {
        Text(this.product.title)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (this.product.badge.length > 0) {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.product.badge)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
              .fontColor(AppTokens.Colors.onTertiary)
          }
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.small)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .lineHeight(AppTokens.TypographyTokens.headline.lineHeight)
        .fontColor(AppTokens.Colors.primary)

      Row() {
        Blank()
          .width(10)
          .height(10)
          .backgroundColor(AppTokens.Colors.warning)
          .borderRadius(AppTokens.Shapes.small)

        Blank()
          .width(AppTokens.Spacing.sm)

        Text(`${this.product.rating} rating`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Button() {
        Text('Add to Cart')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .type(ButtonType.Normal)
      .width('100%')
      .height(40)
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(AppTokens.Colors.primary)
      .onClick(() => {
      })
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#24000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

@Component
struct BottomActionBar {
  @Prop subtotal: string = ''
  @Prop actionLabel: string = ''
  onAction: () => void = () => {
  }

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text('Subtotal')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.subtotal)
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.headline.lineHeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text(this.actionLabel)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .type(ButtonType.Normal)
      .height(44)
      .width(140)
      .borderRadius(AppTokens.Shapes.large)
      .backgroundColor(AppTokens.Colors.secondary)
      .onClick(() => {
        this.onAction()
      })
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level3.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: -AppTokens.ElevationMapping.level3.dy
    })
  }
}