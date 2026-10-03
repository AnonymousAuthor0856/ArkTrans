import { router } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#FFD7BBA8'
const COLOR_SECONDARY = '#FFA2C4C9'
const COLOR_TERTIARY = '#FFB3C9A2'
const COLOR_BACKGROUND = '#FFF0EBE3'
const COLOR_SURFACE = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT = '#FFE6E0D9'
const COLOR_OUTLINE = '#FFDCD7CF'
const COLOR_SUCCESS = '#FF7EA87E'
const COLOR_WARNING = '#FFD9B872'
const COLOR_ERROR = '#FFD98B8B'
const COLOR_ON_PRIMARY = '#FF433E3A'
const COLOR_ON_BACKGROUND = '#FF433E3A'
const COLOR_ON_SURFACE = '#FF433E3A'

// Spacing tokens
const SPACING_XS = 4
const SPACING_SM = 8
const SPACING_MD = 12
const SPACING_LG = 16
const SPACING_XL = 24

interface FilterData {
  id: string
  name: string
}

interface FilterItemData {
  id: number
  name: string
  author: string
  price: string
  color: string
}

@Component
struct FilterChip {
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? COLOR_ON_PRIMARY : COLOR_ON_BACKGROUND)
      .padding({ left: SPACING_MD, right: SPACING_MD, top: SPACING_SM, bottom: SPACING_SM })
      .backgroundColor(this.isSelected ? COLOR_PRIMARY : COLOR_SURFACE)
      .borderRadius(24)
      .border({
        width: 2,
        color: this.isSelected ? '#1A433E3A' : COLOR_OUTLINE
      })
      .onClick(() => {
        this.onSelect()
      })
  }
}

@Component
struct FilterCardItem {
  @Prop itemName: string = ''
  @Prop itemAuthor: string = ''
  @Prop itemPrice: string = ''
  @Prop itemColor: string = ''

  build() {
    Column() {
      // Color preview box
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.itemColor)
        .borderRadius(16)

      Column() {
        Text(this.itemName)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ bottom: 2 })

        Text(this.itemAuthor)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')

        Blank().height(SPACING_SM)

        Text(this.itemPrice)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(SPACING_SM)
    }
    .padding(SPACING_SM)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(24)
    .shadow({
      radius: 8,
      color: '#0D000000',
      offsetX: 4,
      offsetY: 4
    })
  }
}

@Component
struct TopBarSection {
  @Prop selectedFilter: string = 'vintage'
  filters: FilterData[] = []
  onFilterSelected: (id: string) => void = () => {}

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)
        .alignSelf(ItemAlign.Start)

      Blank().height(SPACING_MD)

      Row({ space: SPACING_SM }) {
        ForEach(this.filters, (filter: FilterData) => {
          FilterChip({
            label: filter.name,
            isSelected: filter.id === this.selectedFilter,
            onSelect: () => {
              this.onFilterSelected(filter.id)
            }
          })
        }, (filter: FilterData) => filter.id)
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(COLOR_ON_SURFACE)

      Button({ type: ButtonType.Normal }) {
        Row({ space: SPACING_SM }) {
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
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_SM, bottom: SPACING_SM })
      .shadow({
        radius: 8,
        color: '#0D000000',
        offsetX: 4,
        offsetY: 4
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
    .backgroundColor(COLOR_SURFACE)
    .shadow({
      radius: 12,
      color: '#14000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'

  private filters: FilterData[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'bw', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]

  private items: FilterItemData[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: COLOR_ERROR },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: COLOR_PRIMARY },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: COLOR_SECONDARY },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: COLOR_TERTIARY },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: COLOR_WARNING },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: COLOR_OUTLINE }
  ]

  build() {
    Column() {
      // Top bar
      TopBarSection({
        selectedFilter: this.selectedFilter,
        filters: this.filters,
        onFilterSelected: (id: string) => {
          this.selectedFilter = id
        }
      })

      // Grid content
      Grid() {
        ForEach(this.items, (item: FilterItemData) => {
          GridItem() {
            FilterCardItem({
              itemName: item.name,
              itemAuthor: item.author,
              itemPrice: item.price,
              itemColor: item.color
            })
          }
        }, (item: FilterItemData) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(SPACING_MD)
      .rowsGap(SPACING_MD)
      .padding(SPACING_LG)
      .layoutWeight(1)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}