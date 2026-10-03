interface ColorPalette {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  outline: string
  error: string
  onSurface: string
}

const COLORS: ColorPalette = {
  primary: '#D7BBA8',
  secondary: '#A2C4C9',
  tertiary: '#B3C9A2',
  background: '#F0EBE3',
  surface: '#FFFFFF',
  outline: '#DCD7CF',
  error: '#D98B8B',
  onSurface: '#433E3A',
}

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
struct Index {
  @State selectedFilter: string = 'vintage'

  private filters: FilterOption[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]

  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: COLORS.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: COLORS.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: COLORS.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: COLORS.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: '#D9B872' },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: COLORS.outline }
  ]

  @Builder
  filterPill(filter: FilterOption) {
    Text(filter.name)
      .fontSize(16)
      .fontColor(filter.id === this.selectedFilter ? COLORS.onSurface : COLORS.onSurface)
      .letterSpacing(0.5)
      .textAlign(TextAlign.Center)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(filter.id === this.selectedFilter ? COLORS.primary : COLORS.surface)
      .border({
        width: 2,
        color: filter.id === this.selectedFilter ? '#433E3A1A' : COLORS.outline
      })
      .borderRadius(24)
      .onClick(() => {
        this.selectedFilter = filter.id
      })
  }

  @Builder
  filterCard(item: FilterItem) {
    Column({ space: 0 }) {
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(item.color)
        .borderRadius(16)

      Column({ space: 8 }) {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(item.author)
          .fontSize(14)
          .letterSpacing(0.5)
          .fontColor('#433E3A99')
          .width('100%')

        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(8)
      .width('100%')
    }
    .padding(8)
    .backgroundColor(COLORS.surface)
    .borderRadius(24)
    .shadow({
      radius: 8,
      color: '#0000000D',
      offsetX: 4,
      offsetY: 4
    })
  }

  build() {
    Column({ space: 0 }) {
      Column({ space: 12 }) {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .width('100%')

        Row({ space: 8 }) {
          ForEach(this.filters, (filter: FilterOption) => {
            this.filterPill(filter)
          }, (filter: FilterOption) => filter.id)
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(COLORS.background)

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              this.filterCard(item)
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLORS.background)

      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(COLORS.onSurface)

        Blank()
          .layoutWeight(1)

        Row({ space: 8 }) {
          Circle()
            .width(16)
            .height(16)
            .fill('#433E3A33')

          Text('Checkout')
            .fontSize(16)
            .fontColor(COLORS.onSurface)
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        .backgroundColor(COLORS.primary)
        .borderRadius(24)
        .shadow({
          radius: 8,
          color: '#0000000D',
          offsetX: 4,
          offsetY: 4
        })
        .onClick(() => {
          console.info('Checkout tapped')
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(COLORS.surface)
      .shadow({
        radius: 12,
        color: '#00000014',
        offsetX: 6,
        offsetY: 6
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
