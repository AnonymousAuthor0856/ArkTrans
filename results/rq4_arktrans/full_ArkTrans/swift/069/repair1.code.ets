@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']
  
  interface CardItem {
    title: string;
    id: string;
    fill: number;
  }

  private cards: CardItem[] = [
    { title: 'Copper stack', id: 'SH-014', fill: 78 },
    { title: 'Fiber reels', id: 'SH-022', fill: 64 },
    { title: 'Agro crates', id: 'SH-031', fill: 92 },
    { title: 'Glass kits', id: 'SH-045', fill: 51 }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Circle().width(26).height(26).fill('#2A1C14')
          Blank()
          Column({ space: 2 }) {
            Text('SupplyHub').fontColor('#FBEFE0').fontSize(16)
            Text('Logistics grid').fontColor('#FBEFE0').opacity(0.7).fontSize(12)
          }
          Blank()
          Circle().width(26).height(26).fill('#2A1C14')
        }.padding({ left: 12, right: 12, top: 16, bottom: 16 }).height(64)

        Scroll() {
          Column() {
            // Filter Chips
            Scroll() {
              Row({ space: 8 }) {
                ForEach(this.filters, (filter: string) => {
                  Button(filter)
                    .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
                    .borderRadius(8)
                    .onClick(() => { this.activeFilter = filter })
                })
              }.padding({ left: 12, right: 12 })
            }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

            // Title
            Text('Cargo grid')
              .padding({ left: 12, right: 12, top: 16, bottom: 16 })
              .fontColor('#FBEFE0')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)

            // Grid
            Grid() {
              ForEach(this.cards, (card: CardItem) => {
                GridItem() {
                  Column({ space: 8 }) {
                    Rect()
                      .height(90)
                      .borderRadius(8)
                      .fill('#19110D')
                      .overlay(
                        Circle()
                          .width(60)
                          .height(60)
                          .fill('#F2C57C')
                          .opacity(0.4)
                      )
                    
                    Column({ space: 4 }) {
                      Text(card.title).fontColor('#FBEFE0').fontSize(16)
                      Text(card.id).fontColor('#FBEFE0').opacity(0.7).fontSize(14)
                      Text(`Fill ${card.fill}%`).fontColor('#6ECE89').fontSize(12)
                    }
                  }
                  .padding(16)
                  .backgroundColor('#2A1C14')
                  .borderRadius(16)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .padding({ left: 12, right: 12 })

            // Manifest Filter Card
            Column({ space: 4 }) {
              Text('Manifest filter').fontColor('#FBEFE0').opacity(0.7).fontSize(12)
              Text(this.activeFilter).fontColor('#FBEFE0').fontSize(16)
            }
            .padding(16)
            .backgroundColor('#2A1C14')
            .opacity(0.85)
            .borderRadius(16)
            .width('100%')
            .margin({ top: 16, left: 12, right: 12 })
          }
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#140E0B')
  }
}