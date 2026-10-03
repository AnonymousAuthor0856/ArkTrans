@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    { title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ]

  private filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#100C08')

      Column({ space: 0 }) {
        // Top App Bar
        Row({ space: 0 }) {
          Column()
            .width(26)
            .height(26)
            .backgroundColor('#2A1C14')
            .borderRadius(13)
          Blank()
          Column({ space: 2 }) {
            Text('SupplyHub')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FBEFE0')
            Text('Logistics grid')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FBEFE0')
              .opacity(0.7)
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          Column()
            .width(26)
            .height(26)
            .backgroundColor('#2A1C14')
            .borderRadius(13)
        }
        .width('100%')
        .height(64)
        .padding({ left: 26, right: 26, top: 12, bottom: 12 })
        .backgroundColor('#19110D')

        List({ space: 26 }) {
          // Filter Buttons
          ListItem() {
            Row({ space: 10 }) {
              ForEach(this.filters, (filter: HubFilter) => {
                Button() {
                  Text(filter.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor(this.activeFilter === filter.label ? '#100C08' : '#FBEFE0')
                    .padding({ left: 14, right: 14, top: 6, bottom: 6 })
                }
                .backgroundColor(this.activeFilter === filter.label ? '#C27D38' : '#2A1C14')
                .borderRadius(10)
                .onClick(() => {
                  this.activeFilter = filter.label
                })
              })
            }
            .width('100%')
            .padding({ left: 26, right: 26 })
          }

          // Cargo Grid Header
          ListItem() {
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FBEFE0')
              .width('100%')
              .padding({ left: 26, right: 26 })
          }

          // Cargo Grid (2 columns)
          ListItem() {
            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  Column({ space: 14 }) {
                    // Image placeholder with centered circle
                    Stack({ alignContent: Alignment.Center }) {
                      Column()
                        .width('100%')
                        .height(90)
                        .backgroundColor('#19110D')
                        .borderRadius(10)
                      Column()
                        .width(60)
                        .height(60)
                        .backgroundColor('#F2C57C')
                        .opacity(0.4)
                        .borderRadius(30)
                    }
                    .width('100%')
                    .height(90)

                    Column({ space: 6 }) {
                      Text(card.title)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor('#FBEFE0')
                      Text(card.itemId)
                        .fontSize(14)
                        .foregroundColor('#FBEFE0')
                        .opacity(0.7)
                      Text('Fill ' + card.fill)
                        .fontSize(12)
                        .foregroundColor('#6ECE89')
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .padding(18)
                  .backgroundColor('#2A1C14')
                  .borderRadius(18)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(14)
            .rowsGap(14)
            .width('100%')
            .padding({ left: 26, right: 26 })
          }

          // Manifest filter section
          ListItem() {
            Column({ space: 10 }) {
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FBEFE0')
                .opacity(0.7)
              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FBEFE0')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 18, right: 18, top: 12, bottom: 12 })
            .backgroundColor('#2A1C14')
            .borderRadius(18)
            .padding({ left: 26, right: 26 })
          }

          // Bottom spacer
          ListItem() {
            Column()
              .height(26)
              .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface CargoCard {
  title: string
  itemId: string
  fill: string
}

interface HubFilter {
  label: string
}