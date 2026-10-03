@Entry
@Component
struct Index {
  @State selected: string = ''
  @State selectedFilters: string[] = []
  @State products: ProductItem[] = [
    { id: '1', name: 'Product A', price: 10.0 },
    { id: '2', name: 'Product B', price: 20.0 },
    { id: '3', name: 'Product C', price: 30.0 }
  ]

  build() {
    Stack() {
      // === NavigationView ===
      Stack() {
        // === ZStack ===
        Stack() {
          // === VStack (Main Content) ===
          Column({ space: 0 }) {
            // === Text Header ===
            Text('Shop')
              .backgroundColor('#F6F7FA')
              .width('100%')
              .padding({ top: 24, bottom: 24 })
              .fontColor('#111727')
              .fontSize(22)

            // === ScrollView (Content) ===
            Scroll() {
              // === VStack (Scroll Content) ===
              Column() {
                .padding({ bottom: 100 })
                .alignItems(HorizontalAlign.Start)
                .width('100%')

                // === Horizontal Scroll (Categories) ===
                Scroll() {
                  Row() {
                    .padding({ top: 8, bottom: 8 })
                    .spacing(8)
                    
                    ForEach(['Electronics', 'Clothing', 'Home'], (item: string) => {
                      Button() {
                        Text(item)
                          .fontColor(this.selected === item ? '#FFFFFF' : '#111727')
                      }
                      .type(ButtonType.Normal)
                      .backgroundColor(this.selected === item ? '#6750A3' : '#FBFBFF')
                      .borderWidth(1)
                      .borderColor('#D0D4DD')
                      .borderRadius(8)
                      .onClick(() => {
                        this.selected = item
                      })
                    })
                  }
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .height(50)
                .width('100%')

                // === Horizontal Scroll (Filters) ===
                Scroll() {
                  Row() {
                    .padding({ top: 4, bottom: 4 })
                    .spacing(8)

                    ForEach(['New', 'Sale', 'Popular'], (filter: string) => {
                      Button() {
                        Text(filter)
                          .fontColor(this.selectedFilters.includes(filter) ? '#FFFFFF' : '#111727')
                      }
                      .type(ButtonType.Normal)
                      .backgroundColor(this.selectedFilters.includes(filter) ? '#6CC249' : '#FBFBFF')
                      .borderWidth(1)
                      .borderColor('#D0D4DD')
                      .borderRadius(4)
                      .onClick(() => {
                        if (this.selectedFilters.includes(filter)) {
                          this.selectedFilters = this.selectedFilters.filter(f => f !== filter)
                        } else {
                          this.selectedFilters.push(filter)
                        }
                      })
                    })
                  }
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .height(40)
                .width('100%')

                // === LazyVGrid (Products) ===
                Grid() {
                  ForEach(this.products, (product: ProductItem) => {
                    GridItem() {
                      ProductCard({ product: product })
                    }
                  })
                }
                .columnsTemplate('1fr 1fr')
                .columnsGap(16)
                .rowsGap(16)
                .width('100%')
              }
            }
            .backgroundColor('#F6F7FA')
            .layoutWeight(1)
          }

          // === VStack (Bottom Bar) ===
          Column() {
            Blank()
            
            Column() {
              // === Divider ===
              Rect()
                .width('100%')
                .height(1)
                .fill('#D0D4DD')

              // === HStack (Cart Summary) ===
              Row() {
                .padding(16)
                .backgroundColor('#FFFFFF')
                
                Column() {
                  .alignItems(HorizontalAlign.Start)
                  .spacing(4)
                  
                  Text('Subtotal')
                    .fontColor('#111727')
                    .opacity(0.7)
                    .fontSize(10)
                  
                  Text('$60.00')
                    .fontColor('#111727')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                }

                Blank()

                Button() {
                  Text('Checkout')
                    .fontColor('#FFFFFF')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                }
                .type(ButtonType.Normal)
                .backgroundColor('#6CC249')
                .borderRadius(8)
                .width(120)
                .height(40)
              }
            }
          }
        }
      }
      .safeArea([SafeAreaType.SYSTEM])
    }
    .width('100%')
    .height('100%')
  }
}

interface ProductItem {
  id: string;
  name: string;
  price: number;
}

@Component
struct ProductCard {
  private product: ProductItem = { id: '', name: '', price: 0 }

  build() {
    Column() {
      Image($r('app.media.startIcon'))
        .width('100%')
        .height(100)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)
      
      Text(this.product.name)
        .margin({ top: 8 })
        .fontSize(14)
        .fontColor('#111727')
      
      Text(`$${this.product.price.toFixed(2)}`)
        .margin({ top: 4 })
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#6750A3')
    }
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .padding(8)
  }
}