@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly'
  private readonly filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private readonly chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]
  private readonly productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: '#F59E0B' },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: '#475569' },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: '#EF4444' }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 48, height: 48 })
          .fill('#E2E8F0')
        Text('Productivity Check')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle({ width: 48, height: 48 })
          .fill('#E2E8F0')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 24 }) {
          // Filter Chips
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
                .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
                .borderRadius(12)
                .border({ width: 1, color: '#E2E8F0' })
                .onClick(() => {
                  this.selectedFilter = filter
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 8 })

          // Weekly Throughput Card
          Column({ space: 16 }) {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')

            Column({ space: 8 }) {
              // Bar Chart
              Row() {
                ForEach(this.chartData, (item: ChartData) => {
                  Column() {
                    Column() {
                      Blank()
                      Row()
                        .width('60%')
                        .height(`${item.value * 100}%`)
                        .backgroundColor('#0F172A')
                        .borderRadius(8)
                    }
                    .width('100%')
                    .layoutWeight(1)
                    .justifyContent(FlexAlign.End)
                    .alignItems(HorizontalAlign.Center)

                    Text(item.label)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#475569')
                      .textAlign(TextAlign.Center)
                      .margin({ top: 8 })
                  }
                  .layoutWeight(1)
                })
              }
              .width('100%')
              .height(150)
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column({ space: 16 }) {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .layoutWeight(1)

                Row({ space: 8 }) {
                  Circle({ width: 10, height: 10 })
                    .fill(item.statusColor)
                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.statusColor)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              Row({ space: 8 }) {
                // Progress bar
                Stack({ alignContent: Alignment.Start }) {
                  Row()
                    .width('100%')
                    .height(8)
                    .backgroundColor('#F1F5F9')
                    .borderRadius(4)
                  Row()
                    .width(`${item.progress * 100}%`)
                    .height(8)
                    .backgroundColor(item.statusColor)
                    .borderRadius(4)
                }
                .layoutWeight(1)

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#475569')
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#E2E8F0' })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
      .scrollBar(BarState.Off)

      // Bottom Submit Button
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#0F172A')
          .borderRadius(16)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}

interface ChartData {
  label: string
  value: number
}

interface ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string
}
