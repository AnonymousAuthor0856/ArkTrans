@Entry
@Component
struct Index {
  @State selectedDay: string = 'Mon'
  @State selectedSector: string = 'All'

  private days: string[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  private items: StockItem[] = [
    { name: 'Kweichow Moutai', code: '600519', price: 1687.3, change: 1.24 },
    { name: 'Ping An Bank', code: '000001', price: 12.54, change: -0.62 },
    { name: 'CATL', code: '300750', price: 192.8, change: 0.87 },
    { name: 'Ping An Ins.', code: '601318', price: 44.2, change: -1.12 },
    { name: 'CMBC', code: '600036', price: 36.9, change: 0.15 }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Blank()
          Text('Stock Calendar')
            .fontColor('#1F1F1F')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })
          Blank()
        }.width('100%').padding({ top: 40, bottom: 40 }).backgroundColor('#FDFBF7')

        Scroll() {
          Column() {
            // Top Card (Filters)
            Column() {
              Row() {
                ForEach(this.days, (day: string) => {
                  Button(day)
                    .backgroundColor(this.selectedDay === day ? '#1B4D3E' : '#EAE0C8')
                    .fontColor(this.selectedDay === day ? '#FFFFFF' : '#1F1F1F')
                    .borderRadius(8)
                    .height(44)
                    .width(70)
                    .onClick(() => { this.selectedDay = day })
                }, (item: string) => item)
              }.justifyContent(FlexAlign.SpaceBetween).width('100%')

              Row() {
                ForEach(this.sectors, (sector: string) => {
                  Button(sector)
                    .backgroundColor(this.selectedSector === sector ? '#2E6B53' : '#FDFBF7')
                    .fontColor(this.selectedSector === sector ? '#FFFFFF' : '#1F1F1F')
                    .borderWidth(1)
                    .borderColor('#D6CFC0')
                    .borderRadius(8)
                    .height(40)
                    .width(80)
                    .onClick(() => { this.selectedSector = sector })
                }, (item: string) => item)
                Blank()
              }.width('100%').margin({ top: 12 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FDFBF7')
            .borderRadius(20)
            .shadow({ radius: 8, color: '#00000010', offsetY: 4 })
            .border({ width: 1, color: '#EAE0C8' })

            // List Items
            Column({ space: 12 }) {
              ForEach(this.items, (item: StockItem) => {
                Row() {
                  // Icon Placeholder
                  Row()
                    .width(40)
                    .height(40)
                    .backgroundColor('#EAE0C8')
                    .borderRadius(8)

                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontColor('#1F1F1F')
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                    Text(item.code)
                      .fontColor('#666666')
                      .fontSize(14)
                  }.alignItems(HorizontalAlign.Start)

                  Blank()

                  Column({ space: 4 }) {
                    Text(item.price.toString())
                      .fontColor('#1F1F1F')
                      .fontSize(24)
                      .fontWeight(FontWeight.Bold)
                    
                    Row() {
                      Circle().width(8).height(8).fill(item.change >= 0 ? '#4CAF50' : '#F44336')
                      Text((item.change > 0 ? '+' : '') + item.change + '%')
                        .fontColor(item.change >= 0 ? '#4CAF50' : '#F44336')
                        .fontSize(14)
                        .margin({ left: 4 })
                    }.justifyContent(FlexAlign.End)
                  }.alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .backgroundColor('#1B4D3E')
                    .fontColor('#FFFFFF')
                    .borderRadius(8)
                    .height(44)
                    .width(90)
                    .margin({ left: 16 })
                }
                .width('100%')
                .height(80)
                .padding(16)
                .backgroundColor('#FDFBF7')
                .borderRadius(16)
                .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
                .border({ width: 1, color: '#EAE0C8' })
              }, (item: StockItem) => item.code)
            }.width('100%')
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 16, bottom: 40 })
        }
      }.width('100%').height('100%').backgroundColor('#FDFBF7')
    }.width('100%').height('100%')
  }
}

interface StockItem {
  name: string;
  code: string;
  price: number;
  change: number;
}