// CargoCard.ets
@Entry
@Component
struct CargoCard {
  @State activeFilter: string = 'All'

  private cards: Array<CargoItem> = [
    { title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ]

  private filters: Array<string> = ['All', 'Atlantic', 'Pacific', 'Inland']

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: 26 }) {
          FilterButtons({ activeFilter: this.activeFilter, filters: this.filters })

          Text('Cargo grid')
            .font({ size: 22, weight: FontWeight.Bold })
            .foregroundColor('#FBEFE0')
            .padding({ left: 26, right: 26 })

          GridComponent({ cards: this.cards })

          ManifestFilter({ activeFilter: this.activeFilter })
        }
        .padding({ top: 18, bottom: 18 })
      }
    }
    .backgroundColor('#100C08')
    .width('100%')
    .height('100%')
  }
}

interface CargoItem {
  title: string
  itemId: string
  fill: string
}

// TopAppBar.ets
@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .fill('#2A1C14')
        .width(26)
        .height(26)

      Blank()

      Column() {
        Text('SupplyHub')
          .font({ size: 16, weight: FontWeight.Medium })
          .foregroundColor('#FBEFE0')

        Text('Logistics grid')
          .font({ size: 12, weight: FontWeight.Medium })
          .foregroundColor('#FBEFE0')
          .opacity(0.7)
      }

      Blank()

      Circle()
        .fill('#2A1C14')
        .width(26)
        .height(26)
    }
    .width('100%')
    .height(64)
    .padding({ left: 26, right: 26 })
    .backgroundColor('#19110D')
  }
}

// FilterButtons.ets
@Component
struct FilterButtons {
  @Link activeFilter: string
  @Prop filters: Array<string>

  build() {
    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.filters, (filter: string) => {
          Button(filter)
            .onClick(() => {
              this.activeFilter = filter
            })
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter ? '#100C08' : '#FBEFE0')
            .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
            .borderRadius(10)
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
        })
      }
      .padding({ left: 26, right: 26 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

// GridComponent.ets
@Component
struct GridComponent {
  @Prop cards: Array<CargoItem>

  build() {
    GridContainer() {
      ForEach(this.cards, (card: CargoItem) => {
        GridItem() {
          CargoCardView({ card: card })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('auto auto auto')
    .columnsGap(14)
    .rowsGap(14)
    .padding({ left: 26, right: 26 })
  }
}

// CargoCardView.ets
@Component
struct CargoCardView {
  @Prop card: CargoItem

  build() {
    Column({ space: 14 }) {
      // Image placeholder
      Stack() {
        Rect()
          .fill('#19110D')
          .height(90)
          .borderRadius(10)
        
        Circle()
          .fill('#F2C57C')
          .opacity(0.4)
          .width(60)
          .height(60)
      }
      .height(90)
      .borderRadius(10)

      Column({ space: 6 }) {
        Text(this.card.title)
          .font({ size: 16, weight: FontWeight.Medium })
          .foregroundColor('#FBEFE0')

        Text(this.card.itemId)
          .font({ size: 14, weight: FontWeight.Normal })
          .foregroundColor('#FBEFE0')
          .opacity(0.7)

        Text(`Fill ${this.card.fill}`)
          .font({ size: 12, weight: FontWeight.Medium })
          .foregroundColor('#6ECE89')
      }
    }
    .padding(18)
    .backgroundColor('#2A1C14')
    .borderRadius(18)
  }
}

// ManifestFilter.ets
@Component
struct ManifestFilter {
  @Prop activeFilter: string

  build() {
    Column({ space: 10 }) {
      Text('Manifest filter')
        .font({ size: 12, weight: FontWeight.Medium })
        .foregroundColor('#FBEFE0')
        .opacity(0.7)

      Text(this.activeFilter)
        .font({ size: 16, weight: FontWeight.Medium })
        .foregroundColor('#FBEFE0')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    .backgroundColor('#2A1C14')
    .borderRadius(18)
    .margin({ left: 26, right: 26 })
  }
}