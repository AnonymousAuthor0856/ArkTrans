@Entry
@Component
struct StockCalendarPage {
  @State selectedDay: number = 1
  @State currentSector: string = 'All'

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  private stocks: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#1B1F22')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: 12 }) {
          // Filter Card
          Column({ space: 8 }) {
            // Day Tabs
            Row({ space: 8 }) {
              ForEach(this.days, (d: DayTab) => {
                Text(d.label)
                  .fontSize(d.id === this.selectedDay ? 16 : 13)
                  .fontWeight(d.id === this.selectedDay ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(d.id === this.selectedDay ? '#FFFFFF' : '#1B1F22')
                  .width('100%')
                  .height(36)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(d.id === this.selectedDay ? '#214E34' : '#E9DFC7')
                  .borderRadius(6)
                  .onClick(() => {
                    this.selectedDay = d.id
                  })
              }, (d: DayTab) => d.id.toString())
            }
            .width('100%')

            // Sector Chips
            Row({ space: 8 }) {
              ForEach(this.sectors, (s: string) => {
                Text(s)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.currentSector === s ? '#FFFFFF' : '#1B1F22')
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor(this.currentSector === s ? '#2D6A4F' : '#FFFBF0')
                  .border({ width: 1, color: '#D2C6AA' })
                  .borderRadius(6)
                  .onClick(() => {
                    this.currentSector = s
                  })
              }, (s: string) => s)
            }
            .width('100%')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFBF0')
          .borderRadius(14)
          .border({ width: 1, color: '#D2C6AA' })
          .shadow({ radius: 6, color: 'rgba(0,0,0,0.14)', offsetY: 3 })

          // Stock List
          Column({ space: 8 }) {
            ForEach(this.stocks, (item: StockRow) => {
              Row() {
                // Left: icon + name+code
                Row({ space: 12 }) {
                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor('#E9DFC7')
                    .borderRadius(6)

                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1B1F22')
                    Text(item.code)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1B1F22')
                  }
                  .alignItems(HorizontalAlign.Start)
                }

                // Right: price+change + detail button
                Row({ space: 16 }) {
                  Column({ space: 4 }) {
                    Text(item.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1B1F22')
                    Row({ space: 4 }) {
                      Column()
                        .width(8)
                        .height(8)
                        .backgroundColor(item.positive ? '#2B9348' : '#D62828')
                        .borderRadius(2)
                      Text(item.change)
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(item.positive ? '#2B9348' : '#D62828')
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .width(76)
                    .height(36)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#214E34')
                    .borderRadius(6)
                    .onClick(() => {})
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFBF0')
              .borderRadius(10)
              .border({ width: 1, color: '#D2C6AA' })
              .shadow({ radius: 3, color: 'rgba(0,0,0,0.10)', offsetY: 1 })
            }, (item: StockRow) => item.code)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 40 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F1E5')
  }
}

interface DayTab {
  id: number
  label: string
}

interface StockRow {
  code: string
  name: string
  price: string
  change: string
  positive: boolean
}
