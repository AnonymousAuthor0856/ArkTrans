@Entry
@Component
struct StockCalendar {
  @State selectedDay: number = 0
  @State selectedSector: string = 'All'

  private days: string[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  
  interface StockItem {
    code: string;
    name: string;
    price: string;
    change: string;
    positive: boolean;
  }

  private stocks: Array<StockItem> = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true }
  ]

  build() {
    Column() {
      // Header
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1B1F22')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 20, bottom: 20 })

      // Filter Card
      Row() {
        Column() {
          // Day Tabs
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.days, (day: string, index: number) => {
              Button(day)
                .backgroundColor(index === this.selectedDay ? '#214E34' : '#E9DFC7')
                .fontColor(index === this.selectedDay ? '#FFFFFF' : '#1B1F22')
                .borderWidth(0)
                .height(36)
                .flexShrink(1)
                .margin({ right: index < this.days.length - 1 ? 8 : 0 })
                .onClick(() => {
                  this.selectedDay = index
                })
            })
          }
          
          // Sector Chips
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            ForEach(this.sectors, (sector: string) => {
              Button(sector)
                .backgroundColor(this.selectedSector === sector ? '#2D6A4F' : '#FFFBF0')
                .fontColor(this.selectedSector === sector ? '#FFFFFF' : '#1B1F22')
                .borderWidth(1)
                .borderColor('#D2C6AA')
                .height(32)
                .margin({ left: 8, top: 12 })
                .onClick(() => {
                  this.selectedSector = sector
                })
            })
          }
        }
        .padding(12)
        .backgroundColor('#FFFBF0')
        .borderRadius(14)
        .border({ width: 1, color: '#D2C6AA' })
        .shadow({ radius: 6, color: '#23000000', offsetY: 3 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // Stock List
      List({ space: 12 }) {
        ForEach(this.stocks, (stock: StockItem) => {
          ListItem() {
            Row() {
              // Left: Icon & Info
              Row() {
                Image($r('app.media.startIcon'))
                  .width(28)
                  .height(28)
                  .borderRadius(6)
                  .objectFit(ImageFit.Cover)
                
                Column() {
                  Text(stock.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1B1F22')
                  
                  Text(stock.code)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1B1F22')
                    .margin({ top: 4 })
                }
                .margin({ left: 12 })
              }

              Blank()

              // Right: Price & Change
              Column({ alignItems: ItemAlign.End }) {
                Text(stock.price)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1B1F22')
                
                Row() {
                  Circle({ width: 8, height: 8 })
                    .fill(stock.positive ? '#2B9348' : '#D62828')
                  
                  Text(stock.change)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(stock.positive ? '#2B9348' : '#D62828')
                    .margin({ left: 4 })
                }
                .margin({ top: 4 })
              }

              // Detail Button
              Button('Detail')
                .backgroundColor('#214E34')
                .fontColor('#FFFFFF')
                .borderWidth(0)
                .height(36)
                .width(76)
                .margin({ left: 16 })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFBF0')
            .borderRadius(10)
            .border({ width: 1, color: '#D2C6AA' })
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F1E5')
  }
}