// Index.ets

class FilterData {
  id: string = ''
  name: string = ''
}

class FilterItemData {
  id: number = 0
  name: string = ''
  author: string = ''
  price: string = ''
  color: ResourceColor = '#000000'
}

// Color tokens
const COLOR_PRIMARY: string = '#FFD7BBA8'
const COLOR_SECONDARY: string = '#FFA2C4C9'
const COLOR_TERTIARY: string = '#FFB3C9A2'
const COLOR_BACKGROUND: string = '#FFF0EBE3'
const COLOR_SURFACE: string = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT: string = '#FFE6E0D9'
const COLOR_OUTLINE: string = '#FFDCD7CF'
const COLOR_SUCCESS: string = '#FF7EA87E'
const COLOR_WARNING: string = '#FFD9B872'
const COLOR_ERROR: string = '#FFD98B8B'
const COLOR_ON_PRIMARY: string = '#FF433E3A'
const COLOR_ON_BACKGROUND: string = '#FF433E3A'
const COLOR_ON_SURFACE: string = '#FF433E3A'

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'

  private filters: FilterData[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]

  private items: FilterItemData[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: COLOR_ERROR },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: COLOR_PRIMARY },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: COLOR_SECONDARY },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: COLOR_TERTIARY },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: COLOR_WARNING },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: COLOR_OUTLINE },
  ]

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)
        .width('100%')

      Blank().height(12)

      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.filters, (filter: FilterData) => {
            FilterChip({
              filter: filter,
              isSelected: filter.id === this.selectedFilter,
              onSelect: (id: string) => {
                this.selectedFilter = id
              }
            })
          })
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(COLOR_BACKGROUND)
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(COLOR_ON_SURFACE)

      Button() {
        Row({ space: 8 }) {
          Circle({ width: 16, height: 16 })
            .fill('#33433E3A')
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_PRIMARY)
        }
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor(COLOR_PRIMARY)
      .borderRadius(24)
      .height(44)
      .padding({ left: 16, right: 16 })
      .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .shadow({ radius: 12, color: '#14000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Column() {
      this.TopBarSection()

      Grid() {
        ForEach(this.items, (item: FilterItemData) => {
          GridItem() {
            FilterCard({ item: item })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .padding(16)
      .backgroundColor(COLOR_BACKGROUND)
      .layoutWeight(1)
      .width('100%')

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}

@Component
struct FilterChip {
  filter: FilterData = { id: '', name: '' }
  isSelected: boolean = false
  onSelect: (id: string) => void = () => {}

  build() {
    Text(this.filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? COLOR_ON_PRIMARY : COLOR_ON_BACKGROUND)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? COLOR_PRIMARY : COLOR_SURFACE)
      .borderRadius(24)
      .border({
        width: 2,
        color: this.isSelected ? '#1A433E3A' : COLOR_OUTLINE,
        radius: 24
      })
      .onClick(() => {
        this.onSelect(this.filter.id)
      })
  }
}

@Component
struct FilterCard {
  item: FilterItemData = { id: 0, name: '', author: '', price: '', color: '#000000' }

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
          .fontColor(COLOR_ON_SURFACE)
          .width('100%')

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')
          .width('100%')

        Blank().height(8)

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
          .width('100%')
      }
      .padding(8)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(8)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    .width('100%')
  }
}