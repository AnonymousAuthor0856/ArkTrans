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

@Entry
@Component
struct Index {
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

  @Builder
  FilterChip(title: string, isSelected: boolean) {
    Button(title)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#FFFFFF' : '#0F172A')
      .backgroundColor(isSelected ? '#0F172A' : '#FFFFFF')
      .border({ width: 1, color: '#E2E8F0', radius: 8 })
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .height(40)
      .onClick(() => {
        this.selectedFilter = title
      })
  }

  @Builder
  ProgressBar(progress: number, color: string) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill('#F1F5F9')
      Rect()
        .width(`${Math.max(0, Math.min(100, progress * 100))}%`)
        .height(8)
        .radius(4)
        .fill(color)
    }
    .width('100%')
    .height(8)
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .width('100%')
        .margin({ bottom: 16 })

      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Column() {
            Blank()
            Rect()
              .width(18)
              .height(150 * data.value)
              .radius(8)
              .fill('#0F172A')
          }
          .layoutWeight(1)
          .height(150)
          .alignItems(HorizontalAlign.Center)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
      .height(150)
      .alignItems(VerticalAlign.Bottom)

      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Text(data.label)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#475569')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }

  @Builder
  ProductivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      Row() {
        Column() {
          this.ProgressBar(item.progress, item.statusColor)
        }
        .layoutWeight(1)

        Text(`${Math.round(item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#475569')
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0', radius: 12 })
  }

  build() {
    Column() {
      Row() {
        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill('#E2E8F0')
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill('#E2E8F0')
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
      }
      .height(56)
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })

      Scroll() {
        Column() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              Column() {
                this.FilterChip(filter, this.selectedFilter === filter)
              }
              .margin({ right: filter === 'Monthly' ? 0 : 8 })
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 24 })

          Column() {
            this.ChartCard()
          }
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 24 })

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              this.ProductivityCard(item)
            }
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 24 })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({ top: 16, bottom: 88 })
      }
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
      .scrollBar(BarState.Off)

      Column() {
        Button('Submit New Form')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('100%')
          .height(56)
          .backgroundColor('#0F172A')
          .borderRadius(12)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#1A000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
