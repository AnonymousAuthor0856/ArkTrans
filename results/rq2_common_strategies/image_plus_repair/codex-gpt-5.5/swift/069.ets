interface CargoCard {
  title: string
  itemId: string
  fill: string
}

interface ColorTokens {
  background: string
  surface: string
  surfaceVariant: string
  tertiary: string
  secondary: string
  onSurface: string
  muted: string
  success: string
}

const COLORS: ColorTokens = {
  background: '#100C08',
  surface: '#19110D',
  surfaceVariant: '#2A1C14',
  tertiary: '#F2C57C',
  secondary: '#C27D38',
  onSurface: '#FBEFE0',
  muted: '#B7AA9D',
  success: '#6ECE89'
}

const CARGO_CARDS: CargoCard[] = [
  { title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
  { title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
  { title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
  { title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
  { title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
  { title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
]

const FILTERS: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All'

  @Builder
  topAppBar() {
    Row() {
      Circle()
        .width(52)
        .height(52)
        .fill(COLORS.surfaceVariant)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('SupplyHub')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)

        Text('Logistics grid')
          .fontSize(24)
          .fontColor(COLORS.muted)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(52)
        .height(52)
        .fill(COLORS.surfaceVariant)
    }
    .width('100%')
    .height(136)
    .padding({ left: 52, right: 52 })
    .backgroundColor(COLORS.surface)
  }

  @Builder
  filterButton(label: string) {
    Button(label)
      .fontSize(25)
      .fontColor(this.activeFilter === label ? COLORS.background : COLORS.onSurface)
      .height(52)
      .padding({ left: 30, right: 30 })
      .backgroundColor(this.activeFilter === label ? COLORS.secondary : COLORS.surfaceVariant)
      .borderRadius(20)
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  cargoCard(card: CargoCard) {
    Column({ space: 14 }) {
      Stack() {
        Row()
          .width('100%')
          .height(180)
          .backgroundColor(COLORS.surface)
          .borderRadius(20)

        Circle()
          .width(120)
          .height(120)
          .fill(COLORS.tertiary)
          .opacity(0.4)
      }
      .width('100%')
      .height(180)

      Column({ space: 6 }) {
        Text(card.title)
          .fontSize(31)
          .fontColor(COLORS.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(card.itemId)
          .fontSize(28)
          .fontColor(COLORS.muted)

        Text('Fill ' + card.fill)
          .fontSize(25)
          .fontColor(COLORS.success)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .padding(36)
    .backgroundColor(COLORS.surfaceVariant)
    .borderRadius(28)
  }

  build() {
    Column() {
      this.topAppBar()

      Scroll() {
        Column({ space: 28 }) {
          Scroll() {
            Row({ space: 20 }) {
              ForEach(FILTERS, (label: string) => {
                this.filterButton(label)
              }, (label: string) => label)
            }
            .padding({ left: 52, right: 52 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .height(64)

          Text('Cargo grid')
            .fontSize(43)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.onSurface)
            .width('100%')
            .padding({ left: 52, right: 52 })

          Grid() {
            ForEach(CARGO_CARDS, (card: CargoCard) => {
              GridItem() {
                this.cargoCard(card)
              }
            }, (card: CargoCard) => card.itemId)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(28)
          .rowsGap(28)
          .width('100%')
          .padding({ left: 52, right: 52 })

          Column({ space: 8 }) {
            Text('Manifest filter')
              .fontSize(19)
              .fontColor(COLORS.muted)

            Text(this.activeFilter)
              .fontSize(26)
              .fontColor(COLORS.onSurface)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 36, right: 36, top: 22, bottom: 22 })
          .backgroundColor(COLORS.surfaceVariant)
          .borderRadius(20)
          .margin({ left: 52, right: 52 })
        }
        .width('100%')
        .padding({ top: 28, bottom: 48 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
