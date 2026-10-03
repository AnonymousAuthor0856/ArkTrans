@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  build() {
    Stack() {
      // === ZStack (Dark Mode Background) ===
      Stack() {
        // === VStack ===
        Column({ space: 0 }) {
          // === Header ZStack ===
          Stack() {
            // === HStack ===
            Row() {
              // Left Circle
              Circle().width(26).height(26).fill('#2A1C14')
              
              Blank()
              
              // Center Texts
              Column() {
                Text('SupplyHub').fontColor('#FBEFE0').fontSize(16)
                Text('Logistics grid').fontColor('#FBEFE0').opacity(0.7).fontSize(12)
              }
              
              Blank()
              
              // Right Circle
              Circle().width(26).height(26).fill('#2A1C14')
            }.padding({ left: 12, right: 12 }).padding({ top: 8, bottom: 8 })
          }.height(64)

          // === Main Content ScrollView ===
          Scroll() {
            Column() {
              // === Horizontal Filter Scroll ===
              Scroll() {
                Row() {
                  ForEach(['All', 'Pending', 'Shipped'], (filter: string) => {
                    Button(filter)
                    .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
                    .borderRadius(8)
                    .margin({ right: 8 })
                    .onClick(() => {
                      this.activeFilter = filter
                    })
                  })
                }.padding({ left: 12, right: 12 })
              }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

              // === Section Title ===
              Text('Cargo grid').padding({ left: 12, right: 12 }).fontColor('#FBEFE0').fontSize(22)

              // === Grid of Cards ===
              Grid() {
                ForEach([
                  { title: 'Item A', id: 'ID-001', fill: '50%' },
                  { title: 'Item B', id: 'ID-002', fill: '75%' },
                  { title: 'Item C', id: 'ID-003', fill: '20%' },
                  { title: 'Item D', id: 'ID-004', fill: '90%' }
                ], (card: CardData) => {
                  GridItem() {
                    Column() {
                      // Card Image Placeholder
                      Rect().height(90).fill('#19110D').borderRadius(8)
                        .overlay(
                          Circle().width(60).height(60).fill('#F2C57C').opacity(0.4)
                        )
                      
                      // Card Details
                      Column() {
                        Text(card.title).fontColor('#FBEFE0').fontSize(16)
                        Text(card.id).fontColor('#FBEFE0').opacity(0.7).fontSize(14)
                        Text(`Fill ${card.fill}`).fontColor('#6ECE89').fontSize(12)
                      }
                    }.padding(8).backgroundColor('#19110D').borderRadius(12)
                  }
                })
              }.columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).padding({ left: 12, right: 12 })

              // === Manifest Filter Box ===
              Column() {
                Text('Manifest filter').fontColor('#FBEFE0').opacity(0.7).fontSize(12)
                Text(this.activeFilter).fontColor('#FBEFE0').fontSize(16)
              }.padding({ left: 12, right: 12 }).padding({ top: 8, bottom: 8 })
               .backgroundColor('#2A1C14').opacity(0.85).borderRadius(12)
            }.padding({ top: 8, bottom: 8 })
          }
        }
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}

interface CardData {
  title: string;
  id: string;
  fill: string;
}