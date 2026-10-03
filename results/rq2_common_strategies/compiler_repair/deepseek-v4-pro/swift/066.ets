@Entry
@Component
struct StockCalendarApp {
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

  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F8F1E5')

      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Text('Stock Calendar')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#1B1F22')
            .padding({ top: 40, bottom: 40 })
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .backgroundColor('#F8F1E5')

        List({ space: 12 }) {
          ListItem() {
            Column({ space: 12 }) {
              Row({ space: 12 }) {
                ForEach(this.days, (day: DayTab) => {
                  Button() {
                    Text(day.label)
                      .fontSize(day.id === this.selectedDayId ? 16 : 13)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor(day.id === this.selectedDayId ? '#FFFFFF' : '#1B1F22')
                      .width('100%')
                      .height(36)
                      .textAlign(TextAlign.Center)
                  }
                  .layoutWeight(1)
                  .height(36)
                  .backgroundColor(day.id === this.selectedDayId ? '#214E34' : '#E9DFC7')
                  .borderRadius(6)
                  .onClick(() => {
                    this.selectedDayId = day.id
                  })
                })
              }
              .width('100%')

              Row({ space: 8 }) {
                ForEach(this.sectors, (sector: string) => {
                  Button() {
                    Text(sector)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor(sector === this.currentSector ? '#FFFFFF' : '#1B1F22')
                      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                      .textAlign(TextAlign.Center)
                  }
                  .backgroundColor(sector === this.currentSector ? '#2D6A4F' : '#FFFBF0')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D2C6AA' })
                  .onClick(() => {
                    this.currentSector = sector
                  })
                })
                Blank()
              }
              .width('100%')
            }
            .padding(12)
            .width('100%')
            .backgroundColor('#FFFBF0')
            .borderRadius(14)
            .border({ width: 1, color: '#D2C6AA' })
            .shadow({ radius: 6, color: '#24000000', offsetY: 3 })
          }

          ForEach(this.stocks, (stock: StockRow) => {
            ListItem() {
              Row({ space: 12 }) {
                Row({ space: 12 }) {
                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor('#E9DFC7')
                    .borderRadius(6)
                    .alignSelf(ItemAlign.Center)

                  Column({ space: 4 }) {
                    Text(stock.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#1B1F22')
                    Text(stock.code)
                      .fontSize(11)
                      .foregroundColor('#1B1F22')
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .layoutWeight(1)
                .alignItems(VerticalAlign.Center)

                Row({ space: 16 }) {
                  Column() {
                    Text(stock.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#1B1F22')
                      .textAlign(TextAlign.End)
                    Row({ space: 4 }) {
                      Column()
                        .width(8)
                        .height(8)
                        .borderRadius(4)
                        .backgroundColor(stock.positive ? '#2B9348' : '#D62828')
                        .alignSelf(ItemAlign.Center)
                      Text(stock.change)
                        .fontSize(11)
                        .foregroundColor(stock.positive ? '#2B9348' : '#D62828')
                    }
                    .justifyContent(FlexAlign.End)
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button() {
                    Text('Detail')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#FFFFFF')
                      .width(76)
                      .height(36)
                      .textAlign(TextAlign.Center)
                  }
                  .width(76)
                  .height(36)
                  .backgroundColor('#214E34')
                  .borderRadius(6)
                  .alignSelf(ItemAlign.Center)
                }
                .alignItems(VerticalAlign.Center)
              }
              .padding(12)
              .width('100%')
              .height(72)
              .backgroundColor('#FFFBF0')
              .borderRadius(10)
              .border({ width: 1, color: '#D2C6AA' })
              .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 12, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
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