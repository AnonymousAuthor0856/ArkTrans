@Entry
@Component
struct Index {
  @State selected: string = 'day1'
  @State sectors: string[] = ["All", "Tech", "Energy", "Finance"]
  @State current: string = "All"

  // Mock data for days
  private days: DayItem[] = [
    { id: 'day1', label: 'Mon' },
    { id: 'day2', label: 'Tue' },
    { id: 'day3', label: 'Wed' }
  ]

  // Mock data for stocks
  private stocks: StockItem[] = [
    { name: 'Apple Inc.', code: 'AAPL', price: '$150.00', change: '+1.2%', positive: true },
    { name: 'Google LLC', code: 'GOOGL', price: '$2800.00', change: '-0.5%', positive: false }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        // Card Container
        Column() {
          Column({ space: 8 }) {
            // Days Row
            Row({ space: 8 }) {
              ForEach(this.days, (it: DayItem) => {
                let isActive = this.selected === it.id
                Stack({ alignContent: Alignment.Center }) {
                  Text(it.label)
                    .fontColor(isActive ? '#FFFFFF' : '#1B1F22')
                    .fontWeight(isActive ? FontWeight.Bold : FontWeight.Normal)
                }
                .width('33%')
                .height(36)
                .backgroundColor(isActive ? '#6750A4' : '#E7E0EC')
                .borderRadius(8)
                .onClick(() => {
                  this.selected = it.id
                })
              })
            }

            // Sectors Row
            Row({ space: 8 }) {
              ForEach(this.sectors, (s: string) => {
                let isActive = this.current === s
                Button(s)
                  .type(ButtonType.Capsule)
                  .backgroundColor(isActive ? '#6750A4' : '#FFFFFF')
                  .fontColor(isActive ? '#FFFFFF' : '#1B1F22')
                  .borderWidth(1)
                  .borderColor('#D9D9D9')
                  .height(32)
                  .onClick(() => {
                    this.current = s
                  })
              })
            }.width('100%')
          }.width('100%').padding(12)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        // List of Stocks
        List({ space: 8 }) {
          ForEach(this.stocks, (itx: StockItem) => {
            ListItem() {
              Column() {
                Row() {
                  Row({ space: 12 }) {
                    // Icon Placeholder
                    Stack({ alignContent: Alignment.Center }) {
                      Image($r('app.media.startIcon'))
                        .width(28)
                        .height(28)
                        .objectFit(ImageFit.Contain)
                    }
                    .width(28)
                    .height(28)
                    .backgroundColor('#E7E0EC')
                    .borderRadius(8)

                    Column({ space: 4 }) {
                      Text(itx.name)
                        .fontColor('#1B1F22')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                      Text(itx.code)
                        .fontColor('#1B1F22')
                        .fontSize(12)
                    }
                  }.alignItems(VerticalAlign.Center)

                  Blank()

                  Row({ space: 16 }) {
                    Column() {
                      Text(itx.price)
                        .fontColor('#1B1F22')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .textAlign(TextAlign.End)
                      
                      Row({ space: 4 }) {
                        Stack({ alignContent: Alignment.Center }) {
                          // Color indicator dot
                          Circle()
                            .width(8)
                            .height(8)
                            .fill(itx.positive ? '#4CAF50' : '#D62828')
                        }
                        
                        Text(itx.change)
                          .fontColor(itx.positive ? '#4CAF50' : '#D62828')
                          .fontSize(12)
                      }.alignItems(VerticalAlign.Center)
                    }.alignItems(HorizontalAlign.End)

                    Button('Detail')
                      .type(ButtonType.Capsule)
                      .backgroundColor('#6750A4')
                      .fontColor('#FFFFFF')
                      .height(36)
                      .width(76)
                      .borderRadius(16)
                  }.alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .padding(12)
                .alignItems(VerticalAlign.Center)
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000' })
              .width('100%')
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // Top App Bar Simulation
      Row() {
        Text('Stock Calendar')
          .fontColor('#1B1F22')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F1E5')
  }
}

interface DayItem {
  id: string;
  label: string;
}

interface StockItem {
  name: string;
  code: string;
  price: string;
  change: string;
  positive: boolean;
}