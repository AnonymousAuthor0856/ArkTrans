interface Day {
  id: number;
  label: string;
}

interface StockItem {
  name: string;
  code: string;
  price: string;
  change: string;
  positive: boolean;
}

@Entry
@Component
struct Index {
  @State selectedDayId: number = 0
  @State currentSector: string = "All"
  @State days: Day[] = [
    { id: 0, label: 'Mon' },
    { id: 1, label: 'Tue' },
    { id: 2, label: 'Wed' },
    { id: 3, label: 'Thu' },
    { id: 4, label: 'Fri' }
  ]
  @State sectors: string[] = ["All", "Tech", "Energy", "Finance"]
  @State stockList: StockItem[] = [
    { name: 'Kweichow Moutai', code: '600519', price: '1687.3', change: '+1.24%', positive: true },
    { name: 'Ping An Bank', code: '000001', price: '12.54', change: '-0.62%', positive: false },
    { name: 'CATL', code: '300750', price: '192.8', change: '+0.87%', positive: true },
    { name: 'Ping An Ins.', code: '601318', price: '44.2', change: '-1.12%', positive: false },
    { name: 'CMBC', code: '600036', price: '36.9', change: '+0.15%', positive: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        // Header Card
        Column() {
          Column({ space: 8 }) {
            Row({ space: 8 }) {
              ForEach(this.days, (it: Day) => {
                let isActive = this.selectedDayId === it.id
                Stack({ alignContent: Alignment.Center }) {
                  Text(it.label)
                    .fontColor(isActive ? '#FFFFFF' : '#1B1F22')
                    .fontWeight(isActive ? FontWeight.Bold : FontWeight.Normal)
                }
                .width('1fr')
                .height(36)
                .backgroundColor(isActive ? '#234F38' : '#E6DCCF')
                .borderRadius(8)
              })
            }

            Row({ space: 8 }) {
              ForEach(this.sectors, (s: string) => {
                let isActive = this.currentSector === s
                Button(s)
                  .type(ButtonType.Capsule)
                  .width('1fr')
                  .height(36)
                  .backgroundColor(isActive ? '#234F38' : '#FFFFFF')
                  .fontColor(isActive ? '#FFFFFF' : '#1B1F22')
                  .borderWidth(1)
                  .borderColor('#CDBFAA')
                  .onClick(() => {
                    this.currentSector = s
                  })
              })
            }.width('100%')
          }.width('100%').padding(12)
        }
        .backgroundColor('#FFFDF5')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .border({ width: 1, color: '#E6DCCF' })

        // List
        List({ space: 12 }) {
          ForEach(this.stockList, (item: StockItem) => {
            ListItem() {
              Column() {
                Row() {
                  Row({ space: 12 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Image($r('app.media.startIcon'))
                        .width(28)
                        .height(28)
                        .objectFit(ImageFit.Contain)
                    }
                    .width(28)
                    .height(28)
                    .backgroundColor('#E6DCCF')
                    .borderRadius(6)

                    Column({ space: 4 }) {
                      Text(item.name)
                        .fontColor('#1B1F22')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                      Text(item.code)
                        .fontColor('#1B1F22')
                        .fontSize(12)
                        .opacity(0.7)
                    }
                  }

                  Row({ space: 16 }) {
                    Column({ space: 4 }) {
                      Text(item.price)
                        .fontColor('#1B1F22')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .textAlign(TextAlign.End)
                      
                      Row({ space: 4 }) {
                        Stack({ alignContent: Alignment.Center }) {
                          Circle()
                            .width(8)
                            .height(8)
                            .fill(item.positive ? '#2E7D32' : '#D62828')
                        }
                        Text(item.change)
                          .fontColor(item.positive ? '#2E7D32' : '#D62828')
                          .fontSize(12)
                          .fontWeight(FontWeight.Medium)
                      }.alignItems(VerticalAlign.Center)
                    }.alignItems(HorizontalAlign.End)

                    Button('Detail')
                      .type(ButtonType.Capsule)
                      .height(36)
                      .width(76)
                      .backgroundColor('#234F38')
                      .fontColor('#FFFFFF')
                      .fontSize(12)
                  }.alignItems(VerticalAlign.Center)
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width('100%')
                .padding(12)
              }
              .backgroundColor('#FFFDF5')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              .border({ width: 1, color: '#E6DCCF' })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // Top Bar Title
      Text('Stock Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1B1F22')
        .position({ x: 0, y: 40 })
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F1E5')
  }
}