@Entry
@Component
struct FilterShopPage {
  @State selectedFilter: string = 'vintage'

  private filters: FilterData[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]

  @State filterItems: FilterItemData[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: '#D98B8B' },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: '#D7BBA8' },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: '#A2C4C9' },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: '#B3C9A2' },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: '#D9B872' },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: '#DCD7CF' }
  ]

  build() {
    Column() {
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')
        Row({ space: 8 }) {
          ForEach(this.filters, (filter: FilterData) => {
            FilterChip({ filter: filter, isSelected: this.selectedFilter === filter.id, onSelect: () => { this.selectedFilter = filter.id } })
          }, (filter: FilterData) => filter.id)
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Grid() {
        ForEach(this.filterItems, (item: FilterItemData) => {
          GridItem() {
            FilterCard({ item: item })
          }
        }, (item: FilterItemData) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .padding({ left: 16, right: 16, top: 0, bottom: 16 })
      .layoutWeight(1)

      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor('#433E3A')

        Row({ space: 8 }) {
          Circle()
            .width(16)
            .height(16)
            .fill('rgba(67,62,58,0.2)')
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#433E3A')
        }
        .alignItems(VerticalAlign.Center)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor('#D7BBA8')
        .borderRadius(24)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0EBE3')
  }
}

interface FilterData {
  id: string;
  name: string;
}

interface FilterItemData {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

@Component
struct FilterChip {
  filter: FilterData = { id: '', name: '' };
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Text(this.filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#433E3A')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? '#D7BBA8' : '#FFFFFF')
      .border({
        width: 2,
        color: this.isSelected ? 'rgba(67,62,58,0.1)' : '#DCD7CF',
        radius: 24
      })
      .borderRadius(24)
      .onClick(() => this.onSelect())
  }
}

@Component
struct FilterCard {
  item: FilterItemData = { id: 0, name: '', author: '', price: '', color: '#FFFFFF' };

  build() {
    Column() {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(16)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')
        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(67,62,58,0.6)')
          .margin({ top: 2 })
        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D7BBA8')
          .margin({ top: 8 })
      }
      .padding(8)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .padding(8)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetX: 4, offsetY: 4 })
  }
}
