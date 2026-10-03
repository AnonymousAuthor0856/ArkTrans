interface FilterData {
  id: string;
  name: string;
}

interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage'
  private filters: FilterData[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]
  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: '#D98B8B' },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: '#D7BBA8' },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: '#A2C4C9' },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: '#B3C9A2' },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: '#D9B872' },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: '#DCD7CF' }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Scrollable Content ===
      Scroll() {
        Column() {
          // === Top Bar Section ===
          Column() {
            Text('Filter Shop').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#433E3A')
            Blank().height(12)
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(this.filters, (filter: FilterData) => {
                this.FilterChip(filter)
              })
            }.width('100%')
          }.padding({ left: 16, right: 16, top: 12, bottom: 12 })

          // === Grid Section ===
          Grid() {
            ForEach(this.items, (item: FilterItem) => {
              GridItem() {
                this.FilterCard(item)
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(12).rowsGap(12).width('100%').padding(16)
        }
      }

      // === Bottom Bar Section ===
      Row() {
        Text('3 items in cart').fontSize(14).fontColor('#433E3A')
        Blank()
        Button() {
          Row() {
            Circle({ width: 16, height: 16 }).fill('#433E3A').opacity(0.2)
            Text('Checkout').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#433E3A')
          }.alignItems(ItemAlign.Center).justifyContent(FlexAlign.Center).margin({ left: 8 })
        }.backgroundColor('#D7BBA8').borderRadius(24).shadow({ radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 })
      }.width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 }).backgroundColor('#FFF').alignItems(ItemAlign.Center).justifyContent(FlexAlign.SpaceBetween)
    }.width('100%').height('100%').backgroundColor('#F0EBE3')
  }

  @Builder
  FilterChip(filter: FilterData) {
    Column() {
      Text(filter.name).fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.selectedFilter === filter.id ? '#433E3A' : '#433E3A')
    }
    .width('auto')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .borderRadius(24)
    .border({ width: 2, color: this.selectedFilter === filter.id ? '#433E3A' : '#DCD7CF' })
    .backgroundColor(this.selectedFilter === filter.id ? '#D7BBA8' : '#FFF')
    .onClick(() => {
      this.selectedFilter = filter.id
    })
    .margin({ right: 8 })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      // Image Placeholder
      Rect({ width: '100%', height: '100%' }).fill(item.color).borderRadius(16)
      
      Column() {
        Text(item.name).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')
        Text(item.author).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#433E3A').opacity(0.6)
        Blank().height(8)
        Text(item.price).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
      }.padding(8).alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .aspectRatio(1)
    .backgroundColor('#FFF')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    .padding(8)
  }
}