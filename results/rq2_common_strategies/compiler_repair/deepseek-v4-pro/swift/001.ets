@Entry
@Component
struct ECommerceApp {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+']

  private palette: string[] = ['#E0E8FF', '#D1FAE5', '#FFEDD5', '#FDE68A']

  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: this.palette[0] },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: this.palette[1] },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: this.palette[2] },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: this.palette[3] }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#112338')
          .padding({ top: 16, bottom: 16 })
          .width('100%')
          .backgroundColor('#F5F7FB')

        // Content List
        List() {
          // Category Row
          ListItem() {
            Row({ space: 4 }) {
              ForEach(this.categories, (item: string) => {
                Button() {
                  Text(item)
                    .fontSize(12)
                    .fontColor(this.selectedCategory === item ? '#FFFFFF' : '#112338')
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                }
                .backgroundColor(this.selectedCategory === item ? '#674EA7' : '#FCFCFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D0D5DD' })
                .onClick(() => { this.selectedCategory = item })
              })
            }
            .width('100%')
            .height(50)
            .padding({ top: 4, bottom: 4 })
          }

          // Filter Row
          ListItem() {
            Row({ space: 4 }) {
              ForEach(this.filterOptions, (filter: string) => {
                Button() {
                  Text(filter)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedFilters.indexOf(filter) !== -1 ? '#0A0F0A' : '#112338')
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                }
                .backgroundColor(this.selectedFilters.indexOf(filter) !== -1 ? '#6CC24A' : '#FCFCFF')
                .borderRadius(4)
                .border({ width: 1, color: '#D0D5DD' })
                .onClick(() => {
                  let idx = this.selectedFilters.indexOf(filter)
                  if (idx !== -1) {
                    this.selectedFilters.splice(idx, 1)
                  } else {
                    this.selectedFilters.push(filter)
                  }
                })
              })
            }
            .width('100%')
            .height(40)
            .padding({ top: 2, bottom: 2 })
          }

          // Product Grid
          ListItem() {
            Grid() {
              ForEach(this.products, (product: ProductUi) => {
                GridItem() {
                  // Product Card
                  Column({ space: 8 }) {
                    // Image Placeholder
                    Stack() {
                      Text('Image')
                        .fontSize(10)
                        .fontColor('#112338')
                    }
                    .width('100%')
                    .aspectRatio(1.0)
                    .backgroundColor(product.color)
                    .borderRadius(8)

                    // Title & Badge
                    Row() {
                      Text(product.title)
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#112338')
                      Blank()
                      if (product.badge.length > 0) {
                        Text(product.badge)
                          .fontSize(10)
                          .fontWeight(FontWeight.Medium)
                          .fontColor('#1F1400')
                          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                          .backgroundColor('#FFB300')
                          .borderRadius(4)
                      }
                    }

                    // Price
                    Text(product.price)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#674EA7')

                    // Rating
                    Row({ space: 4 }) {
                      Blank().width(8).height(8).backgroundColor('#F59E0B').borderRadius(4)
                      Text(product.rating + ' rating')
                        .fontSize(12)
                        .fontColor('#112338')
                    }

                    // Add to Cart Button
                    Button() {
                      Text('Add to Cart')
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#FFFFFF')
                        .width('100%')
                        .height(36)
                    }
                    .backgroundColor('#674EA7')
                    .borderRadius(8)
                    .width('100%')
                    .height(36)
                    .onClick(() => {})
                  }
                  .padding(8)
                  .backgroundColor('#FCFCFF')
                  .borderRadius(12)
                  .border({ width: 1, color: '#D0D5DD' })
                  .shadow({ radius: 3, color: '#1A000000' })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(8)
            .width('100%')
          }

          // Space for bottom bar
          ListItem() {
            Column().height(120)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F5F7FB')
      }
      .width('100%')
      .height('100%')

      // Bottom Action Bar
      Column({ space: 0 }) {
        Divider().height(1).color('#D0D5DD')
        Row() {
          Column({ space: 4 }) {
            Text('Subtotal')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#112338')
            Text('$129.96')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#112338')
          }
          Blank()
          Button() {
            Text('Checkout')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0A0F0A')
              .width(120)
              .height(40)
          }
          .backgroundColor('#6CC24A')
          .borderRadius(12)
          .width(120)
          .height(40)
          .onClick(() => {})
        }
        .padding({ left: 8, right: 8, top: 8, bottom: 8 })
        .backgroundColor('#FCFCFF')
      }
      .backgroundColor('#FCFCFF')
    }
    .width('100%')
    .height('100%')
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