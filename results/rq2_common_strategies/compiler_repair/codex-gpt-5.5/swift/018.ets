class FilterModel {
  id: string
  name: string

  constructor(id: string, name: string) {
    this.id = id
    this.name = name
  }
}

class FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string

  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id
    this.name = name
    this.author = author
    this.price = price
    this.color = color
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'

  private cPrimary: string = '#D7BBA8'
  private cSecondary: string = '#A2C4C9'
  private cTertiary: string = '#B3C9A2'
  private cBackground: string = '#F0EBE3'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E6E0D9'
  private cOutline: string = '#DCD7CF'
  private cWarning: string = '#D9B872'
  private cError: string = '#D98B8B'
  private cText: string = '#433E3A'
  private filters: FilterModel[] = [
    new FilterModel('vintage', 'Vintage'),
    new FilterModel('grain', 'Grain'),
    new FilterModel('b&w', 'B&W'),
    new FilterModel('neon', 'Neon')
  ]
  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', '#D98B8B'),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', '#D7BBA8'),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', '#A2C4C9'),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', '#B3C9A2'),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', '#D9B872'),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', '#DCD7CF')
  ]

  @Builder
  FilterChip(filter: FilterModel) {
    Button(filter.name)
      .height(36)
      .padding({ left: 12, right: 12 })
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === filter.id ? this.cText : this.cText)
      .backgroundColor(this.selectedFilter === filter.id ? this.cPrimary : this.cSurface)
      .border({ width: 2, color: this.selectedFilter === filter.id ? '#1A433E3A' : this.cOutline, radius: 24 })
      .margin({ right: 8 })
      .onClick(() => {
        this.selectedFilter = filter.id
      })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Rect()
        .width('100%')
        .aspectRatio(1)
        .radius(16)
        .fill(item.color)
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
          .width('100%')
        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')
          .width('100%')
          .margin({ top: 8 })
        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cPrimary)
          .width('100%')
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(8)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(this.cSurface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(this.cText)
      Blank()
      Button() {
        Row() {
          Circle()
            .width(16)
            .height(16)
            .fill('#33433E3A')
            .margin({ right: 8 })
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
        }
      }
      .height(40)
      .padding({ left: 24, right: 24 })
      .backgroundColor(this.cPrimary)
      .borderRadius(24)
      .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.cSurface)
    .shadow({ radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 })
  }

  build() {
    Column() {
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
          .width('100%')
          .margin({ bottom: 12 })
        Row() {
          ForEach(this.filters, (filter: FilterModel) => {
            this.FilterChip(filter)
          }, (filter: FilterModel) => filter.id)
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(this.cBackground)

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              this.FilterCard(item)
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor(this.cBackground)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
