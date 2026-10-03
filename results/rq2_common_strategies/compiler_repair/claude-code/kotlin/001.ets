@Entry
@Component
struct EcommerceListPage {
  @State selectedCategory: string = 'All'
  @State activeFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterLabels: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  aboutToAppear() {
    this.products = this.buildProducts()
  }

  private products: ProductUi[] = []

  private buildProducts(): ProductUi[] {
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
    const prices: number[] = [19, 29, 9, 49, 34, 14, 42, 24]
    const ratings: string[] = ['4.5', '4.8', '4.2', '4.9', '4.3', '4.7', '4.1', '4.6']
    const badges: string[] = ['NEW', '', '', 'SALE', '', 'NEW', '', 'SALE']
    let list: ProductUi[] = []
    for (let i = 0; i < 8; i++) {
      list.push(new ProductUi(
        i,
        'Product ' + (i + 1),
        '$' + prices[i] + '.99',
        badges[i],
        ratings[i],
        palette[i % palette.length]
      ))
    }
    return list
  }

  build() {
    Column() {
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(600)
          .fontColor('#111827')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FCFCFF')

      Scroll() {
        Column() {
          Row() {
            ForEach(this.categories, (label: string) => {
              this.CategoryChip(label, this.selectedCategory === label, () => {
                this.selectedCategory = label
              })
            }, (label: string) => label)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })

          Row() {
            ForEach(this.filterLabels, (label: string) => {
              this.FilterChip(label, this.activeFilters.includes(label), () => {
                const idx = this.activeFilters.indexOf(label)
                if (idx >= 0) {
                  this.activeFilters.splice(idx, 1)
                } else {
                  this.activeFilters.push(label)
                }
              })
            }, (label: string) => label)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

          Grid() {
            ForEach(this.products, (p: ProductUi) => {
              GridItem() {
                this.ProductCard(p)
              }
            }, (p: ProductUi) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding({ left: 8, right: 8, top: 8, bottom: 16 })

          Blank()
            .height(24)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column() {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
          Text('$129.96')
            .fontSize(18)
            .fontWeight(600)
            .fontColor('#111827')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Checkout')
          .width(140)
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0F0A')
          .backgroundColor('#6CC24A')
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#FCFCFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }

  @Builder
  CategoryChip(label: string, selected: boolean, onSelect: () => void) {
    Text(label)
      .fontSize(selected ? 14 : 12)
      .fontWeight(selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(selected ? '#FFFFFF' : '#111827')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(selected ? '#6750A4' : '#FCFCFF')
      .border({ width: 1, color: '#D0D5DD' })
      .borderRadius(8)
      .onClick(() => onSelect())
  }

  @Builder
  FilterChip(label: string, active: boolean, onToggle: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? '#0A0F0A' : '#111827')
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(active ? '#6CC24A' : '#FCFCFF')
      .border({ width: 1, color: '#D0D5DD' })
      .borderRadius(4)
      .onClick(() => onToggle())
  }

  @Builder
  ProductCard(product: ProductUi) {
    Column() {
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(product.color)
      .borderRadius(8)

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .layoutWeight(1)

        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1400')
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .backgroundColor('#FFB300')
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(product.price)
        .fontSize(18)
        .fontWeight(600)
        .fontColor('#6750A4')

      Row() {
        Row()
          .width(10)
          .height(10)
          .backgroundColor('#F59E0B')
          .borderRadius(4)

        Text(product.rating + ' rating')
          .fontSize(12)
          .fontColor('#111827')
          .margin({ left: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#6750A4')
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#FCFCFF')
    .border({ width: 1, color: '#D0D5DD' })
    .borderRadius(12)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }
}

class ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string

  constructor(id: number, title: string, price: string, badge: string, rating: string, color: string) {
    this.id = id
    this.title = title
    this.price = price
    this.badge = badge
    this.rating = rating
    this.color = color
  }
}
