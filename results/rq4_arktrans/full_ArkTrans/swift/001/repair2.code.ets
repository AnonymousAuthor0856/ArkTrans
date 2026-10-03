@Entry
@Component
struct Index {
  @State selectedCategory: string = 'All'
  @State selectedFilters: string[] = ['In Stock']

  build() {
    Stack() {
      Column() {
        // Header
        Text('Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111727')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 40, bottom: 20 })
          .backgroundColor('#F6F7FA')

        Scroll() {
          Column() {
            // Category Pills
            Row() {
              ForEach(['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'], (item: string) => {
                Button() {
                  Text(item)
                    .fontColor(this.selectedCategory === item ? '#FFFFFF' : '#111727')
                    .fontSize(16)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedCategory === item ? '#6750A3' : '#FBFBFF')
                .borderWidth(1)
                .borderColor('#D0D4DD')
                .borderRadius(12)
                .margin({ right: 8 })
                .onClick(() => {
                  this.selectedCategory = item
                })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })

            // Filter Pills
            Row() {
              ForEach(['In Stock', 'Under $20', 'Rating 4+'], (filter: string) => {
                Button() {
                  Text(filter)
                    .fontColor(this.selectedFilters.includes(filter) ? '#FFFFFF' : '#111727')
                    .fontSize(14)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedFilters.includes(filter) ? '#6CC249' : '#FBFBFF')
                .borderWidth(1)
                .borderColor('#D0D4DD')
                .borderRadius(8)
                .margin({ right: 8 })
                .onClick(() => {
                  if (this.selectedFilters.includes(filter)) {
                    this.selectedFilters = this.selectedFilters.filter(f => f !== filter)
                  } else {
                    this.selectedFilters.push(filter)
                  }
                })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })

            // Product Grid
            Grid() {
              ForEach([
                { name: 'Product 1', price: '$14.99', rating: '4.0', color: '#E0E7FF', isNew: false },
                { name: 'Product 2', price: '$35.99', rating: '4.9', color: '#DCFCE7', isNew: true },
                { name: 'Product 3', price: '$12.50', rating: '4.2', color: '#FEF3C7', isNew: false },
                { name: 'Product 4', price: '$8.99', rating: '3.8', color: '#FDE68A', isNew: false }
              ], (product: ProductItem) => {
                GridItem() {
                  Column() {
                    // Image Placeholder
                    Row() {
                      Text('Image')
                        .fontColor('#666')
                    }
                    .width('100%')
                    .height(180)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(product.color)
                    .borderRadius(12)

                    Column() {
                      Row() {
                        Text(product.name)
                          .fontSize(18)
                          .fontWeight(FontWeight.Medium)
                          .fontColor('#111727')
                        Blank()
                        if (product.isNew) {
                          Text('NEW')
                            .fontSize(10)
                            .fontColor('#FFFFFF')
                            .backgroundColor('#F59E0B')
                            .borderRadius(4)
                            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                        }
                      }
                      .width('100%')

                      Text(product.price)
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#6750A3')
                        .margin({ top: 4 })

                      Row() {
                        Circle()
                          .width(8)
                          .height(8)
                          .fill('#F59E0B')
                        Text(`${product.rating} rating`)
                          .fontSize(14)
                          .fontColor('#666')
                          .margin({ left: 4 })
                      }
                      .margin({ top: 4 })

                      Button() {
                        Text('Add to Cart')
                          .fontColor('#FFFFFF')
                          .fontSize(16)
                      }
                      .type(ButtonType.Normal)
                      .backgroundColor('#6750A3')
                      .borderRadius(12)
                      .width('100%')
                      .margin({ top: 10 })
                    }
                    .width('100%')
                    .padding(12)
                  }
                  .width('100%')
                  .backgroundColor('#FFFFFF')
                  .borderRadius(16)
                  .shadow({ radius: 4, color: '#00000010' })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(16)
            .columnsGap(16)
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 100 })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F6F7FA')

        // Bottom Bar
        Column() {
          Divider()
            .color('#D0D4DD')
            .strokeWidth(1)
          
          Row() {
            Column() {
              Text('Subtotal')
                .fontSize(12)
                .fontColor('#666')
              Text('$129.96')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111727')
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button() {
              Text('Checkout')
                .fontColor('#FFFFFF')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
            }
            .type(ButtonType.Normal)
            .backgroundColor('#6CC249')
            .borderRadius(16)
            .width(120)
            .height(48)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F7FA')
    }
    .width('100%')
    .height('100%')
  }
}

interface ProductItem {
  name: string;
  price: string;
  rating: string;
  color: string;
  isNew: boolean;
}