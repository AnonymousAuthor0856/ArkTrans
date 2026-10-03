interface CardData {
  title: string;
  itemId: string;
  fill: string;
}

@Entry
@Component
struct SupplyHub {
  @State activeFilter: string = 'All'

  private readonly cards: Array<CardData> = [
    { title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ]

  private readonly filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

  build() {
    // === Stack ===
    // props: {}
    // modifier: { width: '100%', height: '100%', backgroundColor: '#100C08' }
    // children: 1
    Stack() {
      // === Column ===
      // props: {}
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 2
      Column() {
        // === TopAppBar ===
        this.TopAppBar()

        // === ScrollView ===
        // props: {}
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: {}
          // modifier: { width: '100%', padding: { top: 18, bottom: 18 } }
          // children: 4
          Column() {
            // === FilterButtons ===
            this.FilterButtons()

            // === Text ===
            // props: { text: 'Cargo grid' }
            // modifier: { fontSize: 22, fontWeight: FontWeight.SemiBold, color: '#FBEFE0', margin: { left: 26, right: 26, top: 26 } }
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FBEFE0')
              .margin({ left: 26, right: 26, top: 26 })

            // === Grid ===
            // props: { columnsTemplate: '1fr 1fr', columnsGap: 14, rowsGap: 14 }
            // modifier: { width: '100%', margin: { left: 26, right: 26, top: 14 } }
            // children: 6
            Grid() {
              ForEach(this.cards, (card: CardData) => {
                GridItem() {
                  // === CargoCardView ===
                  this.CargoCardView(card)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(14)
            .rowsGap(14)
            .width('100%')
            .margin({ left: 26, right: 26, top: 14 })

            // === Manifest Filter Section ===
            // === Column ===
            // props: {}
            // modifier: { width: '100%', padding: { left: 26, right: 26, top: 18, bottom: 18 }, marginTop: 14 }
            // children: 2
            Column() {
              // === Text ===
              // props: { text: 'Manifest filter' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FBEFE0', opacity: 0.7 }
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0')
                .opacity(0.7)

              // === Text ===
              // props: { text: this.activeFilter }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FBEFE0', marginTop: 10 }
              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0')
                .margin({ top: 10 })
            }
            .width('100%')
            .padding({ left: 26, right: 26, top: 18, bottom: 18 })
            .backgroundColor('#2A1C14')
            .borderRadius(18)
            .margin({ left: 26, right: 26, top: 14 })
          }
          .width('100%')
          .padding({ top: 18, bottom: 18 })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#100C08')
  }

  @Builder
  TopAppBar() {
    // === ZStack ===
    // props: {}
    // modifier: { width: '100%', height: 64 }
    // children: 2
    Stack() {
      // === Rectangle ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#19110D', opacity: 0.95 }
      Rect()
        .width('100%')
        .height('100%')
        .fill('#19110D')
        .opacity(0.95)

      // === Row ===
      // props: {}
      // modifier: { width: '100%', height: '100%', padding: { left: 26, right: 26, top: 18, bottom: 18 } }
      // children: 4
      Row() {
        // === Circle ===
        // modifier: { width: 26, height: 26, backgroundColor: '#2A1C14' }
        Circle()
          .width(26)
          .height(26)
          .fill('#2A1C14')

        Blank()

        // === Column ===
        // props: { space: 2 }
        // children: 2
        Column({ space: 2 }) {
          // === Text ===
          // props: { text: 'SupplyHub' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FBEFE0' }
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')

          // === Text ===
          // props: { text: 'Logistics grid' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FBEFE0', opacity: 0.7 }
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
            .opacity(0.7)
        }

        Blank()

        // === Circle ===
        // modifier: { width: 26, height: 26, backgroundColor: '#2A1C14' }
        Circle()
          .width(26)
          .height(26)
          .fill('#2A1C14')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    }
    .width('100%')
    .height(64)
  }

  @Builder
  FilterButtons() {
    // === Scroll ===
    // props: { scrollable: ScrollDirection.Horizontal, barPosition: BarPosition.Off }
    // modifier: { width: '100%' }
    // children: 1
    Scroll() {
      // === Row ===
      // props: { space: 10 }
      // modifier: { width: '100%', padding: { left: 26, right: 26 } }
      // children: 4
      Row({ space: 10 }) {
        ForEach(this.filters, (filter: string) => {
          // === Button ===
          // props: { type: ButtonType.Normal }
          // modifier: { backgroundColor: this.activeFilter === filter ? '#C27D38' : '#2A1C14', borderRadius: 10, padding: { left: 14, right: 14, top: 6, bottom: 6 } }
          // children: 1
          Button(filter) {
            // === Text ===
            // props: { text: filter }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: this.activeFilter === filter ? '#100C08' : '#FBEFE0' }
            Text(filter)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.activeFilter === filter ? '#100C08' : '#FBEFE0')
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
          .borderRadius(10)
          .padding({ left: 14, right: 14, top: 6, bottom: 6 })
          .onClick(() => {
            this.activeFilter = filter
          })
        })
      }
      .width('100%')
      .padding({ left: 26, right: 26 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .barPosition(BarPosition.End)
    .width('100%')
  }

  @Builder
  CargoCardView(card: CardData) {
    // === Column ===
    // props: { space: 14 }
    // modifier: { width: '100%', padding: 18, backgroundColor: '#2A1C14', borderRadius: 18 }
    // children: 2
    Column({ space: 14 }) {
      // === Stack ===
      // props: {}
      // modifier: { width: '100%', height: 90, borderRadius: 10, backgroundColor: '#19110D' }
      // children: 2
      Stack() {
        // === Rectangle ===
        // modifier: { width: '100%', height: '100%', backgroundColor: '#19110D', borderRadius: 10 }
        Rect()
          .width('100%')
          .height('100%')
          .fill('#19110D')
          .borderRadius(10)

        // === Circle ===
        // modifier: { width: 60, height: 60, backgroundColor: '#F2C57C', opacity: 0.4 }
        Circle()
          .width(60)
          .height(60)
          .fill('#F2C57C')
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      .borderRadius(10)

      // === Column ===
      // props: { space: 6 }
      // children: 3
      Column({ space: 6 }) {
        // === Text ===
        // props: { text: card.title }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FBEFE0' }
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FBEFE0')

        // === Text ===
        // props: { text: card.itemId }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, color: '#FBEFE0', opacity: 0.7 }
        Text(card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FBEFE0')
          .opacity(0.7)

        // === Text ===
        // props: { text: `Fill ${card.fill}` }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#6ECE89' }
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6ECE89')
      }
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#2A1C14')
    .borderRadius(18)
  }
}