@Entry
@Component
struct ProductivityCheckPage {
  @State selectedFilter: string = 'Weekly'
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, '#22C55E'),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, '#F59E0B'),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, '#475569'),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, '#22C55E'),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, '#EF4444')
  ]

  private chartData: ChartData[] = [
    new ChartData('Mon', 0.6),
    new ChartData('Tue', 0.8),
    new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0),
    new ChartData('Fri', 0.7),
    new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon placeholder
        Circle({ width: 24, height: 24 })
          .fill('#E2E8F0')

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Action icon placeholder
        Circle({ width: 24, height: 24 })
          .fill('#E2E8F0')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Scrollable content
      Scroll() {
        Column({ space: 24 }) {
          // Filter chips
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
                .border({ width: 1, color: '#E2E8F0', radius: 8 })
                .borderRadius(8)
                .onClick(() => {
                  this.selectedFilter = filter
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
              .margin({ bottom: 16 })

            // Bar chart area
            Column() {
              // Bars
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Column() {
                      // Spacer at top
                    }
                    .layoutWeight(1 - data.value)

                    // The bar
                    Column() {
                    }
                    .width('60%')
                    .layoutWeight(data.value)
                    .backgroundColor('#0F172A')
                    .borderRadius(8)
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Center)
                })
              }
              .layoutWeight(1)
              .width('100%')

              // Labels
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#475569')
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                })
              }
              .width('100%')
              .margin({ top: 8 })
            }
            .width('100%')
            .height(150)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.10)', offsetY: 1 })

          // Productivity items list
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              // Title and status row
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
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')

              // Progress row
              Row({ space: 8 }) {
                // Progress bar track
                Stack({ alignContent: Alignment.Start }) {
                  // Track
                  Row() {
                  }
                  .width('100%')
                  .height(8)
                  .backgroundColor('#F1F5F9')
                  .borderRadius(999)

                  // Progress fill
                  Row() {
                  }
                  .width(`${item.progress * 100}%`)
                  .height(8)
                  .backgroundColor(item.statusColor)
                  .borderRadius(999)
                }
                .layoutWeight(1)

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#475569')
                  .width(40)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .margin({ top: 16 })
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#E2E8F0' })
            .borderRadius(12)
          })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F8FAFC')
      .scrollBar(BarState.Off)

      // Bottom bar with button
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#0F172A')
          .borderRadius(12)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.10)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}

class ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string

  constructor(id: number, title: string, status: string, progress: number, statusColor: string) {
    this.id = id
    this.title = title
    this.status = status
    this.progress = progress
    this.statusColor = statusColor
  }
}

class ChartData {
  label: string
  value: number

  constructor(label: string, value: number) {
    this.label = label
    this.value = value
  }
}
