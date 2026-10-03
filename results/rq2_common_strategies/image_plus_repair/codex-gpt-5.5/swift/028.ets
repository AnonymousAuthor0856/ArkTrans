interface ProductivityItem {
  title: string
  status: string
  progress: number
  color: string
}

interface ChartItem {
  label: string
  value: number
}

@Entry
@Component
struct ProductivityCheck {
  @State selectedFilter: string = 'Weekly'

  private readonly filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private readonly chartData: ChartItem[] = [
    { label: 'Mon', value: 0.60 },
    { label: 'Tue', value: 0.80 },
    { label: 'Wed', value: 0.50 },
    { label: 'Thu', value: 1.00 },
    { label: 'Fri', value: 0.70 },
    { label: 'Sat', value: 0.40 },
    { label: 'Sun', value: 0.20 }
  ]
  private readonly productivityItems: ProductivityItem[] = [
    { title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, color: '#F59E0B' },
    { title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, color: '#475569' },
    { title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, color: '#EF4444' }
  ]

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column({ space: 24 }) {
          this.filterRow()
          this.throughputCard()
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.productivityCard(item)
          }, (item: ProductivityItem) => item.title)
        }
        .width('100%')
        .padding({ top: 16, bottom: 104 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#F8FAFC')

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  topBar() {
    Row() {
      Row()
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#E2E8F0')

      Text('Productivity Check')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Row()
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#E2E8F0')
    }
    .width('100%')
    .height(112)
    .padding({ left: 32, right: 32 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 10, color: '#190F172A', offsetY: 4, offsetX: 0 })
  }

  @Builder
  filterRow() {
    Row({ space: 16 }) {
      ForEach(this.filters, (filter: string) => {
        Button(filter)
          .height(68)
          .layoutWeight(1)
          .fontSize(28)
          .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
          .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
          .border({
            width: 2,
            color: '#E2E8F0',
            radius: 16
          })
          .borderRadius(16)
          .onClick(() => {
            this.selectedFilter = filter
          })
      }, (filter: string) => filter)
    }
    .width('100%')
    .padding({ left: 32, right: 32 })
  }

  @Builder
  throughputCard() {
    Column() {
      Text('Weekly Throughput')
        .width('100%')
        .fontSize(36)
        .fontColor('#0F172A')
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 24 })

      Row({ space: 0 }) {
        ForEach(this.chartData, (item: ChartItem) => {
          Column() {
            Blank()
              .layoutWeight(1)

            Row()
              .width('60%')
              .height(`${item.value * 100}%`)
              .borderRadius(16)
              .backgroundColor('#0F172A')
          }
          .layoutWeight(1)
          .height(300)
          .alignItems(HorizontalAlign.Center)
        }, (item: ChartItem) => item.label)
      }
      .width('100%')
      .height(300)

      Row() {
        ForEach(this.chartData, (item: ChartItem) => {
          Text(item.label)
            .layoutWeight(1)
            .fontSize(27)
            .fontColor('#475569')
            .textAlign(TextAlign.Center)
        }, (item: ChartItem) => item.label)
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('calc(100% - 64vp)')
    .padding(32)
    .borderRadius(32)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 10, color: '#190F172A', offsetY: 4, offsetX: 0 })
  }

  @Builder
  productivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(36)
          .fontColor('#0F172A')
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Row({ space: 12 }) {
          Row()
            .width(20)
            .height(20)
            .borderRadius(10)
            .backgroundColor(item.color)

          Text(item.status)
            .fontSize(27)
            .fontColor(item.color)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 24 })

      Row({ space: 16 }) {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(16)
            .borderRadius(8)
            .backgroundColor('#F1F5F9')

          Row()
            .width(`${item.progress * 100}%`)
            .height(16)
            .borderRadius(8)
            .backgroundColor(item.color)
        }
        .layoutWeight(1)
        .height(16)

        Text(`${Math.round(item.progress * 100)}%`)
          .width(72)
          .fontSize(27)
          .fontColor('#475569')
          .textAlign(TextAlign.End)
      }
      .width('100%')
    }
    .width('calc(100% - 64vp)')
    .padding(32)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .border({
      width: 2,
      color: '#E2E8F0',
      radius: 20
    })
  }

  @Builder
  bottomBar() {
    Column() {
      Button('Submit New Form')
        .width('100%')
        .height(112)
        .fontSize(36)
        .fontColor('#FFFFFF')
        .backgroundColor('#0F172A')
        .borderRadius(24)
        .onClick(() => {
          // Action placeholder for the form submission flow.
        })
    }
    .width('100%')
    .height(176)
    .padding(32)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 10, color: '#190F172A', offsetY: -4, offsetX: 0 })
  }
}
