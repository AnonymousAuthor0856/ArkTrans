interface FilterOption {
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

@Entry
@Component
struct MainPage {
  @State private selectedFilter: string = 'vintage'

  private readonly filters: FilterOption[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]

  private readonly filterItems: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: '#D98B8B' },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: '#D7BBA8' },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: '#A2C4C9' },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: '#B3C9A2' },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: '#D9B872' },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: '#DCD7CF' }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.header()
        Grid() {
          ForEach(this.filterItems, (item: FilterItem) => {
            GridItem() {
              this.filterCard(item)
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(24)
        .rowsGap(24)
        .layoutWeight(1)
        .padding({ left: 32, right: 32, bottom: 156 })
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0EBE3')

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  header() {
    Column({ space: 24 }) {
      Text('Filter Shop')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor('#433E3A')
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: 16 }) {
        ForEach(this.filters, (filter: FilterOption) => {
          Text(filter.name)
            .fontSize(25)
            .fontWeight(FontWeight.Medium)
            .fontColor('#433E3A')
            .textAlign(TextAlign.Center)
            .height(60)
            .padding({ left: 22, right: 22 })
            .backgroundColor(filter.id === this.selectedFilter ? '#D7BBA8' : '#FFFFFF')
            .border({
              width: 3,
              color: filter.id === this.selectedFilter ? '#CDB09D' : '#DCD7CF',
              radius: 34
            })
            .borderRadius(34)
            .onClick(() => {
              this.selectedFilter = filter.id
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 28, bottom: 28 })
  }

  @Builder
  filterCard(item: FilterItem) {
    Column() {
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(item.color)
        .borderRadius(32)

      Column({ space: 2 }) {
        Text(item.name)
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(item.author)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#918D89')
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(item.price)
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D7BBA8')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(46)
    .padding(16)
    .shadow({
      radius: 12,
      color: '#18000000',
      offsetX: 0,
      offsetY: 6
    })
  }

  @Builder
  bottomBar() {
    Row() {
      Text('3 items in cart')
        .fontSize(28)
        .fontColor('#433E3A')
        .fontWeight(FontWeight.Normal)

      Button({ type: ButtonType.Capsule }) {
        Row({ space: 16 }) {
          Row()
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor('#B9A08F')

          Text('Checkout')
            .fontSize(31)
            .fontColor('#433E3A')
            .fontWeight(FontWeight.Medium)
        }
      }
      .width(282)
      .height(82)
      .backgroundColor('#D7BBA8')
      .shadow({
        radius: 12,
        color: '#26000000',
        offsetX: 0,
        offsetY: 6
      })
      .onClick(() => {
        // Checkout is intentionally a visual action in this single-screen conversion.
      })
    }
    .width('100%')
    .height(144)
    .padding({ left: 32, right: 32 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 12,
      color: '#22000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}
