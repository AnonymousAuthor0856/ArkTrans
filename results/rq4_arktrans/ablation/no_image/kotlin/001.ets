@Entry
@Component
struct Index {
  @State selected: string = "All"
  @State filters: string[] = ["In Stock"]
  @State count8: number = 0
  @State labelVal: string = ""
  @State inStockActive: boolean = false
  @State under20Active: boolean = false
  @State rating4Active: boolean = false
  @State priceTotal: number = 0
  @State imageSrc: Resource = $r('app.media.startIcon')
  @State productTitle: string = ""
  @State productBadge: string = ""
  @State productPrice: string = ""
  @State addToCartText: string = "Add to Cart"
  @State shopTitle: string = "Shop"
  @State subtotalNum: number = 129
  @State subtotalLabel: string = "Subtotal"
  @State subtotalValue: string = "$129.96"
  @State actionLabelText: string = "Checkout"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // CategoryRow
        Row({ space: 4 }) {
          ForEach(['All', 'Electronics', 'Clothing'], (item: string) => {
            Button() {
              Text(item)
                .fontColor(this.selected === item ? '#FFFFFF' : '#000000')
                .fontSize(14)
            }
            .backgroundColor(this.selected === item ? '#6750A4' : '#F5F5F5')
            .borderRadius(18)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {
              this.selected = item
            })
          }, (item: string) => item)
        }.alignItems(VerticalAlign.Center).width('100%').height(36)

        Blank().height(6)

        // FilterRow
        Row({ space: 4 }) {
          // In Stock Chip
          Button() {
            Text("In Stock")
              .fontColor(this.inStockActive ? '#FFFFFF' : '#000000')
              .fontSize(12)
          }
          .backgroundColor(this.inStockActive ? '#9FA8DA' : '#F5F5F5')
          .borderRadius(8)
          .borderWidth(1)
          .borderColor('#E0E0E0')
          .onClick(() => {
            this.inStockActive = !this.inStockActive
            if (this.inStockActive) {
              this.filters.push("In Stock")
            } else {
              const idx = this.filters.indexOf("In Stock")
              if (idx > -1) this.filters.splice(idx, 1)
            }
          })

          // Under $20 Chip
          Button() {
            Text("Under $20")
              .fontColor(this.under20Active ? '#FFFFFF' : '#000000')
              .fontSize(12)
          }
          .backgroundColor(this.under20Active ? '#9FA8DA' : '#F5F5F5')
          .borderRadius(8)
          .borderWidth(1)
          .borderColor('#E0E0E0')
          .onClick(() => {
            this.under20Active = !this.under20Active
            if (this.under20Active) {
              this.filters.push("Under $20")
            } else {
              const idx = this.filters.indexOf("Under $20")
              if (idx > -1) this.filters.splice(idx, 1)
            }
          })

          // Rating 4+ Chip
          Button() {
            Text("Rating 4+")
              .fontColor(this.rating4Active ? '#FFFFFF' : '#000000')
              .fontSize(12)
          }
          .backgroundColor(this.rating4Active ? '#9FA8DA' : '#F5F5F5')
          .borderRadius(8)
          .borderWidth(1)
          .borderColor('#E0E0E0')
          .onClick(() => {
            this.rating4Active = !this.rating4Active
            if (this.rating4Active) {
              this.filters.push("Rating 4+")
            } else {
              const idx = this.filters.indexOf("Rating 4+")
              if (idx > -1) this.filters.splice(idx, 1)
            }
          })
        }.alignItems(VerticalAlign.Center).width('100%').height(32)

        Blank().height(8)

        // ProductGrid
        Grid() {
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                // Image Box
                Stack({ alignContent: Alignment.Center }) {
                  Image(this.imageSrc)
                    .width('100%')
                    .height(100)
                    .objectFit(ImageFit.Cover)
                }.width('100%').aspectRatio(1.2).backgroundColor('#E0E0E0').borderRadius(8)

                // Title and Badge Row
                Row({ space: 0 }) {
                  Text('Product Title')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111827')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Text('New')
                      .fontSize(10)
                      .fontColor('#1F1400')
                  }.backgroundColor('#FFD8B2').padding({ left: 4, right: 4, top: 2, bottom: 2 }).borderRadius(4)
                }.alignItems(VerticalAlign.Center).width('100%')

                // Price
                Text('$29.99')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6750A4')

                // Rating Row
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Text('★')
                      .fontSize(10)
                      .fontColor('#FFFFFF')
                  }.width(10).height(10).backgroundColor('#F59E0B').borderRadius(5)
                  Blank().width(4)
                  Text('4.5 rating')
                    .fontSize(14)
                    .fontColor('#111827')
                }.alignItems(VerticalAlign.Center)

                // Add to Cart Button
                Button() {
                  Text('Add to Cart')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                }
                .backgroundColor('#6750A4')
                .borderRadius(8)
                .height(40)
                .width('100%')
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).borderWidth(1).borderColor('#E0E0E0')
          }
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Image(this.imageSrc)
                    .width('100%')
                    .height(100)
                    .objectFit(ImageFit.Cover)
                }.width('100%').aspectRatio(1.2).backgroundColor('#E0E0E0').borderRadius(8)

                Row({ space: 0 }) {
                  Text('Product Title')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111827')
                  Blank()
                  Stack({ alignContent: Alignment.Center }) {
                    Text('Sale')
                      .fontSize(10)
                      .fontColor('#1F1400')
                  }.backgroundColor('#FFD8B2').padding({ left: 4, right: 4, top: 2, bottom: 2 }).borderRadius(4)
                }.alignItems(VerticalAlign.Center).width('100%')

                Text('$19.99')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6750A4')

                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Text('★')
                      .fontSize(10)
                      .fontColor('#FFFFFF')
                  }.width(10).height(10).backgroundColor('#F59E0B').borderRadius(5)
                  Blank().width(4)
                  Text('4.8 rating')
                    .fontSize(14)
                    .fontColor('#111827')
                }.alignItems(VerticalAlign.Center)

                Button() {
                  Text('Add to Cart')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                }
                .backgroundColor('#6750A4')
                .borderRadius(8)
                .height(40)
                .width('100%')
              }.alignItems(HorizontalAlign.Start).width('100%').padding(8)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).borderWidth(1).borderColor('#E0E0E0')
          }
        }.columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).width('100%')

        Blank().height(24)
      }.alignItems(HorizontalAlign.Start).width('100%').height('100%').padding({ left: 8, right: 8, top: 6, bottom: 6 })

      // Top App Bar
      Row() {
        Text('Shop')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }.width('100%').height(56).padding({ left: 16, right: 16 }).justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)

      // Bottom Action Bar
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Subtotal')
              .fontSize(12)
              .fontColor('#111827')
            Text('$129.96')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
          }.alignItems(HorizontalAlign.Start)
          Blank()
          Button() {
            Text('Checkout')
              .fontColor('#FFFFFF')
              .fontSize(14)
          }
          .backgroundColor('#9FA8DA')
          .borderRadius(12)
          .height(44)
          .width(140)
        }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }.backgroundColor('#FCFCFF').shadow({ radius: 4, color: '#1A000000' }).position({ x: 0, y: '100%' }).translate({ y: -80 }).width('100%')
    }.width('100%').height('100%').backgroundColor('#F6F7FB')
  }
}