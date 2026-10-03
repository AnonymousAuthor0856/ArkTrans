@Entry
@Component
struct Index {
  @State selected: string = "All"
  @State filters: string[] = ["In Stock"]

  private categories: string[] = ["All", "Snacks", "Drinks", "Fruits", "Bakery"]
  
  // Mock data for products to match the screenshot
  private products: ProductItem[] = [
    { id: '1', title: 'Product 1', price: '$14.99', rating: 4.0, badge: 'NEW', color: '#E8EAF6' },
    { id: '2', title: 'Product 2', price: '$35.99', rating: 4.9, badge: '', color: '#DCEDC8' },
    { id: '3', title: 'Product 3', price: '$12.50', rating: 3.5, badge: '', color: '#FFF3E0' },
    { id: '4', title: 'Product 4', price: '$8.99', rating: 4.2, badge: 'SALE', color: '#FFF9C4' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 0 }) {
        // === Header (Shop) ===
        Text('Shop')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 16 })

        // === CategoryRow ===
        Row({ space: 4 }) {
          ForEach(this.categories, (item: string) => {
            Button() {
              Text(item)
                .fontSize(16)
                .fontColor(this.selected === item ? '#FFFFFF' : '#111827')
            }
            .type(ButtonType.Normal)
            .backgroundColor(this.selected === item ? '#6750A4' : '#FFFFFF')
            .borderWidth(1)
            .borderColor('#D1D5DB')
            .borderRadius(16)
            .height(36)
            .onClick(() => {
              this.selected = item
            })
          })
        }.width('100%')

        Blank().height(16)

        // === FilterRow ===
        Row({ space: 4 }) {
          // In Stock Chip
          Button() {
            Text("In Stock")
              .fontSize(14)
              .fontColor(this.filters.includes("In Stock") ? '#FFFFFF' : '#111827')
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.filters.includes("In Stock") ? '#66BB6A' : '#FFFFFF')
          .borderWidth(1)
          .borderColor('#D1D5DB')
          .borderRadius(8)
          .height(32)
          .onClick(() => {
            if (this.filters.includes("In Stock")) {
              this.filters = this.filters.filter(f => f !== "In Stock")
            } else {
              this.filters.push("In Stock")
            }
          })

          // Under $20 Chip
          Button() {
            Text("Under $20")
              .fontSize(14)
              .fontColor(this.filters.includes("Under $20") ? '#FFFFFF' : '#111827')
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.filters.includes("Under $20") ? '#66BB6A' : '#FFFFFF')
          .borderWidth(1)
          .borderColor('#D1D5DB')
          .borderRadius(8)
          .height(32)
          .onClick(() => {
            if (this.filters.includes("Under $20")) {
              this.filters = this.filters.filter(f => f !== "Under $20")
            } else {
              this.filters.push("Under $20")
            }
          })

          // Rating 4+ Chip
          Button() {
            Text("Rating 4+")
              .fontSize(14)
              .fontColor(this.filters.includes("Rating 4+") ? '#FFFFFF' : '#111827')
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.filters.includes("Rating 4+") ? '#66BB6A' : '#FFFFFF')
          .borderWidth(1)
          .borderColor('#D1D5DB')
          .borderRadius(8)
          .height(32)
          .onClick(() => {
            if (this.filters.includes("Rating 4+")) {
              this.filters = this.filters.filter(f => f !== "Rating 4+")
            } else {
              this.filters.push("Rating 4+")
            }
          })
        }.width('100%')

        Blank().height(16)

        // === ProductGrid ===
        Grid() {
          ForEach(this.products, (p: ProductItem) => {
            GridItem() {
              Column() {
                // Image Placeholder
                Stack({ alignContent: Alignment.Center }) {
                  Text('Image')
                    .fontSize(14)
                    .fontColor('#111827')
                }
                .width('100%')
                .aspectRatio(1.2)
                .backgroundColor(p.color)
                .borderRadius(12)

                Blank().height(12)

                // Title and Badge
                Row({ space: 0 }) {
                  Text(p.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111827')
                  
                  Blank()
                  
                  if (p.badge) {
                    Text(p.badge)
                      .fontSize(12)
                      .fontColor('#1F1400')
                      .backgroundColor('#FFC107')
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .borderRadius(4)
                  }
                }.width('100%')

                // Price
                Text(p.price)
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6750A4')
                  .margin({ top: 4 })

                // Rating
                Row({ space: 4 }) {
                  Circle({ width: 10, height: 10 })
                    .fill('#F59E0B')
                  Text(`${p.rating} rating`)
                    .fontSize(14)
                    .fontColor('#111827')
                }.margin({ top: 4 })

                Blank().layoutWeight(1)

                // Add to Cart Button
                Button() {
                  Text('Add to Cart')
                    .fontSize(16)
                    .fontColor('#FFFFFF')
                }
                .type(ButtonType.Normal)
                .width('100%')
                .height(40)
                .backgroundColor('#6750A4')
                .borderRadius(12)
                .margin({ top: 12 })
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              .border({ width: 1, color: '#E5E7EB' })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')
        .layoutWeight(1) // Pushes content up, allowing scroll if needed inside a Scroll container, but here it fills space
        
        Blank().height(80) // Space for bottom bar
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F6F7FB')

      // === BottomActionBar ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Subtotal')
              .fontSize(14)
              .fontColor('#111827')
            Text('$129.96')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
          }.alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('Checkout')
              .fontSize(16)
              .fontColor('#111827') // Dark text on green button as per screenshot style usually, or white. Screenshot shows dark text.
          }
          .type(ButtonType.Normal)
          .height(44)
          .width(140)
          .backgroundColor('#66BB6A')
          .borderRadius(20)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor('#FCFCFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: '100%' }) // Position at bottom
      .translate({ y: -80 }) // Adjust based on height roughly, or use absolute positioning logic. 
      // Better approach for fixed bottom bar in Stack:
      .position({ x: 0, y: '100%' })
      .translate({ y: -70 }) // Approximate height adjustment
    }
    .width('100%')
    .height('100%')
  }
}

interface ProductItem {
  id: string;
  title: string;
  price: string;
  rating: number;
  badge: string;
  color: string;
}