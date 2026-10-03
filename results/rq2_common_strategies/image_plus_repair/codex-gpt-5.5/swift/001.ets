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
struct ContentView {
  private readonly categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private readonly filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']
  private readonly products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEDD5' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE68A' }
  ]

  @State private selectedCategory: string = 'All'
  @State private selectedFilters: string[] = ['In Stock']

  private isFilterSelected(filter: string): boolean {
    return this.selectedFilters.indexOf(filter) >= 0
  }

  private toggleFilter(filter: string): void {
    const index: number = this.selectedFilters.indexOf(filter)
    if (index >= 0) {
      this.selectedFilters.splice(index, 1)
    } else {
      this.selectedFilters.push(filter)
    }
    this.selectedFilters = this.selectedFilters.slice()
  }

  @Builder
  private CategoryButton(item: string) {
    Button(item)
      .fontSize(24)
      .fontColor(this.selectedCategory === item ? '#FFFFFF' : '#111827')
      .fontWeight(FontWeight.Medium)
      .height(62)
      .padding({ left: 23, right: 23 })
      .backgroundColor(this.selectedCategory === item ? '#6750A4' : '#FCFCFF')
      .border({
        width: 2,
        color: '#D1D5DF',
        radius: 16
      })
      .onClick(() => {
        this.selectedCategory = item
      })
  }

  @Builder
  private FilterButton(filter: string) {
    Button(filter)
      .fontSize(19)
      .fontColor(this.isFilterSelected(filter) ? '#0A160A' : '#111827')
      .fontWeight(FontWeight.Medium)
      .height(49)
      .padding({ left: 22, right: 22 })
      .backgroundColor(this.isFilterSelected(filter) ? '#6BC447' : '#FCFCFF')
      .border({
        width: 2,
        color: '#D1D5DF',
        radius: 8
      })
      .onClick(() => {
        this.toggleFilter(filter)
      })
  }

  @Builder
  private ProductCard(product: ProductUi) {
    Column({ space: 16 }) {
      Stack() {
        Text('Image')
          .fontSize(20)
          .fontColor('#4B5563')
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(product.color)
          .borderRadius(17)
      }
      .width('100%')
      .aspectRatio(1)

      Row() {
        Text(product.title)
          .fontSize(28)
          .fontColor('#111827')
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(19)
            .fontColor('#1F1400')
            .backgroundColor('#FFB300')
            .borderRadius(9)
            .padding({ left: 13, right: 13, top: 7, bottom: 7 })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Text(product.price)
        .fontSize(36)
        .fontColor('#6750A4')
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 9 }) {
        Circle()
          .width(16)
          .height(16)
          .fill('#F59E0B')

        Text(`${product.rating} rating`)
          .fontSize(22)
          .fontColor('#596170')
      }
      .width('100%')

      Button('Add to Cart')
        .fontSize(28)
        .fontColor('#FFFFFF')
        .height(72)
        .width('100%')
        .backgroundColor('#6750A4')
        .borderRadius(17)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FCFCFF')
    .border({
      width: 2,
      color: '#D1D5DF',
      radius: 25
    })
    .shadow({
      radius: 8,
      color: '#22000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private CheckoutBar() {
    Column() {
      Divider()
        .height(2)
        .color('#D1D5DF')

      Row() {
        Column({ space: 4 }) {
          Text('Subtotal')
            .fontSize(20)
            .fontColor('#596170')

          Text('$129.96')
            .fontSize(36)
            .fontColor('#111827')
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Button('Checkout')
          .fontSize(28)
          .fontColor('#0A160A')
          .fontWeight(FontWeight.Medium)
          .width(240)
          .height(80)
          .backgroundColor('#6BC447')
          .borderRadius(28)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#FCFCFF')
    }
    .width('100%')
    .backgroundColor('#FCFCFF')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Shop')
          .fontSize(44)
          .fontColor('#111827')
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .height(116)
          .textAlign(TextAlign.Center)
          .padding({ top: 34, bottom: 22 })

        Scroll() {
          Column({ space: 40 }) {
            Scroll() {
              Row({ space: 8 }) {
                ForEach(this.categories, (item: string) => {
                  this.CategoryButton(item)
                })
              }
              .padding({ left: 16, right: 16, top: 3, bottom: 3 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(70)

            Scroll() {
              Row({ space: 8 }) {
                ForEach(this.filterOptions, (filter: string) => {
                  this.FilterButton(filter)
                })
              }
              .padding({ left: 16, right: 16 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(55)

            Grid() {
              ForEach(this.products, (product: ProductUi) => {
                GridItem() {
                  this.ProductCard(product)
                }
              }, (product: ProductUi) => product.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(16)
            .columnsGap(16)
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 120 })
          }
          .width('100%')
          .padding({ top: 14 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor('#F6F7FB')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F7FB')

      this.CheckoutBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }
}
