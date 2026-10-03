import { router } from '@kit.ArkUI'

// Color tokens
const Colors = {
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
  error: '#D92D20',
}

interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

function generateProducts(): ProductUi[] {
  const palette = [
    '#E0E7FF',
    '#D1FAE5',
    '#FFEDD5',
    '#FDE68A',
    '#EDE9FE',
    '#FFE4E6',
    '#E2E8F0',
    '#FFFBEB',
  ]
  const prices = ['$9.99', '$14.99', '$19.99', '$24.99', '$29.99', '$34.99', '$39.99', '$44.99']
  const ratings = ['4.0', '4.3', '4.5', '4.7', '4.8', '5.0', '4.1', '4.6']
  const products: ProductUi[] = []
  for (let i = 0; i < 8; i++) {
    let badge = ''
    if (i % 3 === 0) badge = 'NEW'
    else if (i % 4 === 0) badge = 'SALE'
    products.push({
      id: i,
      title: `Product ${i + 1}`,
      price: prices[i % prices.length],
      badge: badge,
      rating: ratings[i % ratings.length],
      color: palette[i % palette.length],
    })
  }
  return products
}

@Component
struct BadgeBox {
  badge: string = ''

  build() {
    if (this.badge.length > 0) {
      Text(this.badge)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onTertiary)
        .backgroundColor(Colors.tertiary)
        .borderRadius(4)
        .padding({ left: 4, right: 4, top: 2, bottom: 2 })
    }
  }
}

@Component
struct RatingRow {
  rating: string = ''

  build() {
    Row({ space: 4 }) {
      Box()
        .width(10)
        .height(10)
        .backgroundColor(Colors.warning)
        .borderRadius(4)
      Text(`${this.rating} rating`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
    }
    .alignItems(VerticalAlign.Center)
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
    color: '#FFFFFF',
  }

  build() {
    Column({ space: 6 }) {
      // Image placeholder
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      // Title and badge row
      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onTertiary)
            .backgroundColor(Colors.tertiary)
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Colors.primary)

      // Rating
      Row({ space: 4 }) {
        Box()
          .width(10)
          .height(10)
          .backgroundColor(Colors.warning)
          .borderRadius(4)
        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      // Add to Cart button
      Button('Add to Cart')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategoryRow {
  items: string[] = []
  selected: string = 'All'
  onSelect: (label: string) => void = () => {}

  build() {
    Row({ space: 4 }) {
      ForEach(this.items, (label: string) => {
        Text(label)
          .fontSize(this.selected === label ? 14 : 12)
          .fontWeight(this.selected === label ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selected === label ? Colors.onPrimary : Colors.onSurface)
          .backgroundColor(this.selected === label ? Colors.primary : Colors.surface)
          .borderRadius(8)
          .border({ width: 1, color: Colors.outline })
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
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
  @State filters: string[] = ['In Stock']
  onToggle: (label: string) => void = () => {}

  build() {
    Row({ space: 4 }) {
      ForEach(['In Stock', 'Under $20', 'Rating 4+'], (label: string) => {
        Text(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.filters.indexOf(label) >= 0 ? Colors.onSecondary : Colors.onSurface)
          .backgroundColor(this.filters.indexOf(label) >= 0 ? Colors.secondary : Colors.surface)
          .borderRadius(4)
          .border({ width: 1, color: Colors.outline })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {
            this.onToggle(label)
          })
      }, (label: string) => label)
    }
    .width('100%')
    .constraintSize({ minHeight: 32 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomActionBar {
  subtotal: string = '$129.96'
  actionLabel: string = 'Checkout'
  onAction: () => void = () => {}

  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.subtotal)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button(this.actionLabel)
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSecondary)
        .backgroundColor(Colors.secondary)
        .borderRadius(12)
        .onClick(() => {
          this.onAction()
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor(Colors.surface)
    .shadow({ radius: 6, color: '#28000000', offsetY: -1 })
  }
}

@Entry
@Component
struct RootScreen {
  @State selected: string = 'All'
  @State filters: string[] = ['In Stock']
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private products: ProductUi[] = generateProducts()

  toggleFilter(label: string) {
    const idx = this.filters.indexOf(label)
    if (idx >= 0) {
      this.filters = this.filters.filter(f => f !== label)
    } else {
      this.filters = [...this.filters, label]
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      // Main content
      Column({ space: 0 }) {
        // Category row
        Row({ space: 4 }) {
          ForEach(this.categories, (label: string) => {
            Text(label)
              .fontSize(this.selected === label ? 14 : 12)
              .fontWeight(this.selected === label ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.selected === label ? Colors.onPrimary : Colors.onSurface)
              .backgroundColor(this.selected === label ? Colors.primary : Colors.surface)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .onClick(() => {
                this.selected = label
              })
          }, (label: string) => label)
        }
        .width('100%')
        .constraintSize({ minHeight: 36 })
        .alignItems(VerticalAlign.Center)

        // Spacer
        Blank().height(6)

        // Filter row
        Row({ space: 4 }) {
          ForEach(['In Stock', 'Under $20', 'Rating 4+'], (label: string) => {
            Text(label)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.filters.indexOf(label) >= 0 ? Colors.onSecondary : Colors.onSurface)
              .backgroundColor(this.filters.indexOf(label) >= 0 ? Colors.secondary : Colors.surface)
              .borderRadius(4)
              .border({ width: 1, color: Colors.outline })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .onClick(() => {
                this.toggleFilter(label)
              })
          }, (label: string) => label)
        }
        .width('100%')
        .constraintSize({ minHeight: 32 })
        .alignItems(VerticalAlign.Center)

        // Spacer
        Blank().height(8)

        // Product Grid
        Grid() {
          ForEach(this.products, (p: ProductUi) => {
            GridItem() {
              Column({ space: 6 }) {
                // Image placeholder
                Stack() {
                  Text('Image')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .aspectRatio(1.2)
                .backgroundColor(p.color)
                .borderRadius(8)
                .alignContent(Alignment.Center)

                // Title and badge
                Row() {
                  Text(p.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .layoutWeight(1)
                  if (p.badge.length > 0) {
                    Text(p.badge)
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onTertiary)
                      .backgroundColor(Colors.tertiary)
                      .borderRadius(4)
                      .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                  }
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)

                // Price
                Text(p.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(Colors.primary)

                // Rating
                Row({ space: 4 }) {
                  Box()
                    .width(10)
                    .height(10)
                    .backgroundColor(Colors.warning)
                    .borderRadius(4)
                  Text(`${p.rating} rating`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(VerticalAlign.Center)

                // Add to Cart button
                Button('Add to Cart')
                  .width('100%')
                  .height(40)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onPrimary)
                  .backgroundColor(Colors.primary)
                  .borderRadius(8)
              }
              .width('100%')
              .constraintSize({ minHeight: 200 })
              .padding(8)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .border({ width: 1, color: Colors.outline })
              .shadow({ radius: 4, color: '#22000000', offsetY: 1 })
              .alignItems(HorizontalAlign.Start)
            }
          }, (p: ProductUi) => p.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 16 })
      }
      .layoutWeight(1)
      .padding({ left: 8, right: 8, top: 6, bottom: 0 })
      .backgroundColor(Colors.background)
      .alignItems(HorizontalAlign.Start)

      // Bottom Action Bar
      Row() {
        Column({ space: 2 }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Checkout')
          .height(44)
          .width(140)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: '#28000000', offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}