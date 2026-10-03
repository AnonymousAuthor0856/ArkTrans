interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

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
  error: '#D92D20'
}

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
}

@Entry
@Component
struct Index {
  @State selected: string = 'All'
  @State filters: string[] = ['In Stock']
  @State products: ProductUi[] = []
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterLabels: string[] = ['In Stock', 'Under $20', 'Rating 4+']
  private palette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A', '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB']

  aboutToAppear(): void {
    let list: ProductUi[] = []
    for (let i = 0; i < 8; i++) {
      let badge: string = ''
      if (i % 3 === 0) {
        badge = 'NEW'
      } else if (i % 4 === 0) {
        badge = 'SALE'
      }
      const priceVal: number = 9 + Math.floor(Math.random() * 41)
      list.push({
        id: i,
        title: 'Product ' + (i + 1),
        price: '$' + priceVal + '.99',
        badge: badge,
        rating: (4 + Math.floor(Math.random() * 2)) + '.' + Math.floor(Math.random() * 10),
        color: this.palette[i % this.palette.length]
      })
    }
    this.products = list
  }

  toggleFilter(label: string): void {
    const i = this.filters.indexOf(label)
    if (i >= 0) {
      this.filters.splice(i, 1)
    } else {
      this.filters.push(label)
    }
  }

  build() {
    Column() {
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Row({ space: Spacing.sm }) {
          ForEach(this.categories, (label: string) => {
            Button(label)
              .fontSize(this.selected === label ? 14 : 12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selected === label ? Colors.onPrimary : Colors.onSurface)
              .backgroundColor(this.selected === label ? Colors.primary : Colors.surface)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .height(36)
              .padding({ left: Spacing.xl, right: Spacing.xl })
              .onClick(() => { this.selected = label })
          }, (label: string) => label)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Blank().height(Spacing.md)

        Row({ space: Spacing.sm }) {
          ForEach(this.filterLabels, (label: string) => {
            Button(label)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.filters.indexOf(label) >= 0 ? Colors.onSecondary : Colors.onSurface)
              .backgroundColor(this.filters.indexOf(label) >= 0 ? Colors.secondary : Colors.surface)
              .borderRadius(4)
              .border({ width: 1, color: Colors.outline })
              .height(32)
              .padding({ left: Spacing.lg, right: Spacing.lg })
              .onClick(() => { this.toggleFilter(label) })
          }, (label: string) => label)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Blank().height(Spacing.lg)

        Grid() {
          ForEach(this.products, (item: ProductUi) => {
            Column() {
              Stack() {
                Text('Image')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(1.2)
              .backgroundColor(item.color)
              .borderRadius(8)

              Row() {
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                if (item.badge !== '') {
                  Text(item.badge)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onTertiary)
                    .backgroundColor(Colors.tertiary)
                    .borderRadius(4)
                    .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Text(item.price)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.primary)

              Row() {
                Blank()
                  .width(10)
                  .height(10)
                  .backgroundColor(Colors.warning)
                  .borderRadius(4)
                Blank().width(Spacing.sm)
                Text(item.rating + ' rating')
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(VerticalAlign.Center)

              Button('Add to Cart')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
                .borderRadius(8)
                .width('100%')
                .height(40)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
          }, (item: ProductUi) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.lg)
        .rowsGap(Spacing.lg)
        .layoutWeight(1)
        .width('100%')

        Blank().height(Spacing.xxxl)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
          .height(44)
          .width(140)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
