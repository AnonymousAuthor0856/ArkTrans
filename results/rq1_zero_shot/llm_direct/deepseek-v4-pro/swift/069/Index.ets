@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]

  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#100C08')

      Column() {
        // Top App Bar
        TopAppBar()

        // Main Content
        Scroll() {
          Column({ space: 26 }) {
            // Filter Buttons
            FilterButtons({
              activeFilter: $activeFilter,
              filters: this.filters
            })

            // Cargo Grid Section
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FBEFE0')
              .padding({ left: 26, right: 26 })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  CargoCardView({ card: card })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(14)
            .rowsGap(14)
            .padding({ left: 26, right: 26 })

            // Manifest Filter Section
            Column({ space: 6 }) {
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0B3')

              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 26, right: 26, top: 18, bottom: 18 })
            .backgroundColor('#2A1C14D9')
            .borderRadius(18)
            .margin({ left: 26, right: 26 })
          }
          .width('100%')
          .padding({ top: 18, bottom: 18 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Data Models

class CargoCard {
  title: string
  itemId: string
  fill: string

  constructor(title: string, itemId: string, fill: string) {
    this.title = title
    this.itemId = itemId
    this.fill = fill
  }
}

// MARK: - Subviews

@Component
struct TopAppBar {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#19110DF2')

      Row() {
        // Navigation Icon
        Circle()
          .width(26)
          .height(26)
          .fill('#2A1C14')

        Blank()
          .layoutWeight(1)

        // Title
        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')

          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0B3')
        }

        Blank()
          .layoutWeight(1)

        // Action Icon
        Circle()
          .width(26)
          .height(26)
          .fill('#2A1C14')
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    }
    .width('100%')
    .height(64)
  }
}

@Component
struct FilterButtons {
  @Link activeFilter: string
  filters: string[] = []

  build() {
    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.filters, (filter: string) => {
          Button() {
            this.activeFilter = filter
          }
          .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
          .borderRadius(10)
          .padding({ left: 14, right: 14, top: 6, bottom: 6 })
          .type(ButtonType.Normal)
          .borderRadius(10)
          .stateEffect(false)

          Text(filter)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter ? '#100C08' : '#FBEFE0')
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
            .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
            .borderRadius(10)
            .onClick(() => {
              this.activeFilter = filter
            })
        })
      }
      .padding({ left: 26, right: 26 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard('', '', '')

  build() {
    Column({ space: 14 }) {
      // Image placeholder
      Stack() {
        Row()
          .width('100%')
          .height(90)
          .backgroundColor('#19110D')
          .borderRadius(10)

        Circle()
          .width(60)
          .height(60)
          .fill('#F2C57C66')
      }
      .width('100%')
      .height(90)

      Column({ space: 6 }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FBEFE0')

        Text(this.card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FBEFE0B3')

        Text(`Fill ${this.card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6ECE89')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(18)
    .backgroundColor('#2A1C14EB')
    .borderRadius(18)
    .width('100%')
  }
}