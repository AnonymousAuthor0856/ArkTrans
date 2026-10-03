@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage'
  private filters: Filter[] = [
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
    Column() {
      TopBarSection({ filters: this.filters, selectedFilter: $selectedFilter })
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor('#F0EBE3')

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F0EBE3')

      BottomBarSection()
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.08)', offsetX: 6, offsetY: 6 })
    }
    .backgroundColor('#F0EBE3')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

interface Filter {
  id: string
  name: string
}

interface FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string
}

@Component
struct TopBarSection {
  @Prop filters: Filter[]
  @Link selectedFilter: string

  build() {
    Column({ space: 12 }) {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#433E3A')

      Row({ space: 8 }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(filter.id === this.selectedFilter ? '#433E3A' : '#433E3A')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(filter.id === this.selectedFilter ? '#D7BBA8' : '#FFFFFF')
            .borderRadius(24)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter ? 'rgba(67, 62, 58, 0.1)' : '#DCD7CF'
            })
            .onClick(() => {
              this.selectedFilter = filter.id
            })
        })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct FilterCard {
  @Prop item: FilterItem

  build() {
    Column({ space: 0 }) {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(16)

      Column({ space: 8 }) {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('rgba(67, 62, 58, 0.6)')

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D7BBA8')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(8)
    }
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.05)', offsetX: 4, offsetY: 4 })
  }
}

@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .lineHeight(20)
        .fontColor('#433E3A')

      Blank()

      Row({ space: 8 }) {
        Column()
          .width(16)
          .height(16)
          .backgroundColor('rgba(67, 62, 58, 0.2)')
          .borderRadius(8)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#433E3A')
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor('#D7BBA8')
      .borderRadius(24)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.05)', offsetX: 4, offsetY: 4 })
      .onClick(() => {
        console.log('Checkout tapped')
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }
}