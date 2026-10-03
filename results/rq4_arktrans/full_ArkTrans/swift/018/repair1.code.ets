@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Vintage'

  private filters: string[] = ['Vintage', 'Grain', 'B&W', 'Neon']

  interface Item {
    name: string;
    author: string;
    price: string;
    color: string;
  }

  private items: Array<Item> = [
    { name: 'Redscale', author: 'UserA', price: '$4.99', color: '#D88C8C' },
    { name: 'Sepia Tone', author: 'UserB', price: '$2.99', color: '#D1BFAE' },
    { name: 'Aqua', author: 'UserC', price: '$4.00', color: '#A3C5C6' },
    { name: 'Forest', author: 'UserD', price: '$3.00', color: '#AEC59F' }
  ]

  build() {
    Stack() {
      Column() {
        // Header Section
        Column({ space: 12 }) {
          Text('Filter Shop')
            .fontColor('#433E3A')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 16 })

          Row({ space: 12 }) {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#433E3A')
                .backgroundColor(this.selectedFilter === filter ? '#D7BBA8' : '#F0EBE3')
                .borderRadius(20)
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })
                .onClick(() => {
                  this.selectedFilter = filter
                })
            })
          }.margin({ left: 16 })
        }

        // Scrollable Grid Section
        Scroll() {
          Grid() {
            ForEach(this.items, (item: Item) => {
              GridItem() {
                Column() {
                  // Color Preview Box
                  Column()
                    .width('100%')
                    .height(160)
                    .backgroundColor(item.color)
                    .borderRadius(24)

                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontColor('#433E3A')
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)

                    Text(`by ${item.author}`)
                      .fontColor('#888888')
                      .fontSize(14)
                      .opacity(0.8)

                    Text(item.price)
                      .fontColor('#D7BBA8')
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ top: 12 })
                }
                .width('100%')
                .backgroundColor('#FFFFFF')
                .borderRadius(32)
                .padding(12)
                .shadow({ radius: 10, color: '#10000000', offsetY: 4 })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .padding(16)
        }
        .layoutWeight(1)
        .backgroundColor('#F0EBE3')

        // Bottom Bar
        Row() {
          Text('3 items in cart')
            .fontColor('#433E3A')
            .fontSize(16)
            .lineHeight(24)

          Blank()

          Button() {
            Row() {
              Circle()
                .width(20)
                .height(20)
                .fill('#8C7A6B')
              
              Text('Checkout')
                .fontColor('#433E3A')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .margin({ left: 8 })
            }
            .justifyContent(FlexAlign.Center)
          }
          .backgroundColor('#D7BBA8')
          .borderRadius(30)
          .width(160)
          .height(48)
          .shadow({ radius: 10, color: '#20000000', offsetY: 4 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0EBE3')
    }
    .width('100%')
    .height('100%')
  }
}