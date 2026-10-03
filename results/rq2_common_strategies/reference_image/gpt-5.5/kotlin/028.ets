class AppColors {
  static readonly primary: string = '#0F172A'
  static readonly secondary: string = '#475569'
  static readonly tertiary: string = '#94A3B8'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSurface: string = '#0F172A'
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

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly'

  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
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
  TopBar() {
    Row() {
      Circle()
        .width(24)
        .height(24)
        .fill(AppColors.outline)

      Text('Productivity Check')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Circle()
        .width(24)
        .height(24)
        .fill(AppColors.outline)
    }
    .width('100%')
    .height(72)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterChip(filter: string) {
    Text(filter)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === filter ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .height(32)
      .padding({ left: 16, right: 16 })
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .backgroundColor(this.selectedFilter === filter ? AppColors.primary : AppColors.surface)
      .onClick(() => {
        this.selectedFilter = filter
      })
  }

  @Builder
  FilterRow() {
    Row({ space: 8 }) {
      ForEach(this.filters, (filter: string) => {
        this.FilterChip(filter)
      }, (filter: string) => filter)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)
        .width('100%')

      Blank()
        .height(16)

      Column() {
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Column() {
              Blank()
                .layoutWeight(1)

              Column()
                .width(25)
                .height(126 * data.value)
                .borderRadius(8)
                .backgroundColor(AppColors.primary)
            }
            .height(126)
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.End)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
        .height(126)
        .alignItems(VerticalAlign.Bottom)

        Blank()
          .height(8)

        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
      }
      .width('100%')
      .height(150)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: '#EEF2F7' })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ProductivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(24)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Row({ space: 8 }) {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)

          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
            .lineHeight(18)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .height(16)

      Row({ space: 12 }) {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppColors.surfaceVariant)

          Row()
            .width(`${Math.round(item.progress * 100)}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(item.statusColor)
        }
        .height(8)
        .layoutWeight(1)

        Text(`${Math.floor(item.progress * 100)}%`)
          .width(40)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  BottomBar() {
    Column() {
      Row() {
        Text('Submit New Form')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(56)
      .borderRadius(12)
      .backgroundColor(AppColors.primary)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(88)
    .padding(16)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: 24 }) {
            this.FilterRow()
            this.ChartCard()

            ForEach(this.productivityItems, (item: ProductivityItem) => {
              this.ProductivityCard(item)
            }, (item: ProductivityItem) => item.id.toString())
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 120 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}