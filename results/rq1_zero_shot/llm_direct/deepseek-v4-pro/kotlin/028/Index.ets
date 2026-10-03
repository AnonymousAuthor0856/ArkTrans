@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'
  @State productivityItems: Array<ProductivityItem> = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: '#F59E0B' },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: '#475569' },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: '#EF4444' }
  ]
  @State chartData: Array<ChartData> = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  @Builder
  TopBar() {
    Row() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill('#E2E8F0')
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text('Productivity Check')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill('#E2E8F0')
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: 4, right: 4 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  FilterChipBuilder(filter: string) {
    Text(filter)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
      .textAlign(TextAlign.Center)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
      .borderRadius(8)
      .border({ width: 1, color: '#E2E8F0' })
      .onClick(() => {
        this.selectedFilter = filter
      })
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
        .margin({ bottom: 16 })

      Column() {
        Row() {
          ForEach(this.chartData, (item: ChartData) => {
            Column() {
              Column()
                .width('60%')
                .height(`${item.value * 100}%`)
                .backgroundColor('#0F172A')
                .borderRadius(8)
            }
            .width('14.28%')
            .height(120)
            .justifyContent(FlexAlign.End)
            .alignItems(HorizontalAlign.Center)
          })
        }
        .width('100%')
        .height(120)

        Row() {
          ForEach(this.chartData, (item: ChartData) => {
            Text(item.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#475569')
              .textAlign(TextAlign.Center)
              .width('14.28%')
          })
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
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

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)
            .margin({ right: 8 })

          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Progress({ value: item.progress, total: 1.0, type: ProgressType.Linear })
          .width('80%')
          .height(8)
          .color(item.statusColor)
          .backgroundColor('#F1F5F9')
          .borderRadius(4)
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
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E2E8F0' })
  }

  @Builder
  BottomBar() {
    Column() {
      Button('Submit New Form')
        .width('100%')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#0F172A')
        .borderRadius(12)
        .margin({ left: 16, right: 16, top: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              this.FilterChipBuilder(filter)
              Blank()
                .width(8)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16, bottom: 8 })

          this.ChartCard()

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.ProductivityCard(item)
            Blank()
              .height(16)
          })
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}

interface ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string
}

interface ChartData {
  label: string
  value: number
}