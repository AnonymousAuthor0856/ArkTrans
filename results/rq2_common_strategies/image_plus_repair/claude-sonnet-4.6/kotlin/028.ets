interface ProductivityItemData {
  id: number
  title: string
  status: string
  progress: number
  statusColor: ResourceColor
}

interface ChartDataItem {
  label: string
  value: number
}

const colorPrimary: ResourceColor = '#0F172A'
const colorSecondary: ResourceColor = '#475569'
const colorBackground: ResourceColor = '#F8FAFC'
const colorSurface: ResourceColor = '#FFFFFF'
const colorSurfaceVariant: ResourceColor = '#F1F5F9'
const colorOutline: ResourceColor = '#E2E8F0'
const colorSuccess: ResourceColor = '#22C55E'
const colorWarning: ResourceColor = '#F59E0B'
const colorError: ResourceColor = '#EF4444'
const colorOnPrimary: ResourceColor = '#FFFFFF'
const colorOnSurface: ResourceColor = '#0F172A'

const productivityItems: ProductivityItemData[] = [
  { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: colorSuccess },
  { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: colorWarning },
  { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: colorSecondary },
  { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: colorSuccess },
  { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: colorError }
]

const chartData: ChartDataItem[] = [
  { label: 'Mon', value: 0.6 },
  { label: 'Tue', value: 0.8 },
  { label: 'Wed', value: 0.5 },
  { label: 'Thu', value: 1.0 },
  { label: 'Fri', value: 0.7 },
  { label: 'Sat', value: 0.4 },
  { label: 'Sun', value: 0.2 }
]

@Component
struct FilterChipItem {
  label: string = ''
  isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? colorOnPrimary : colorOnSurface)
      .backgroundColor(this.isSelected ? colorPrimary : colorSurface)
      .borderRadius(8)
      .border({ width: 1, color: colorOutline })
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .onClick(() => {
        this.onSelect()
      })
  }
}

@Component
struct BarChart {
  build() {
    Column() {
      Row() {
        ForEach(chartData, (data: ChartDataItem) => {
          Column() {
            Column()
              .width('60%')
              .height(`${data.value * 100}%`)
              .backgroundColor(colorPrimary)
              .borderRadius(8)
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(VerticalAlign.Bottom)

      Row() {
        ForEach(chartData, (data: ChartDataItem) => {
          Text(data.label)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorSecondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        })
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .height(150)
  }
}

@Component
struct ProductivityCard {
  item: ProductivityItemData = {
    id: 0,
    title: '',
    status: '',
    progress: 0,
    statusColor: colorPrimary
  }

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .layoutWeight(1)

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Progress({
          value: this.item.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .color(this.item.statusColor)
          .backgroundColor(colorSurfaceVariant)
          .style({ strokeWidth: 8, enableScanEffect: false })
          .layoutWeight(1)
          .borderRadius(100)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorSecondary)
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(colorSurface)
    .borderRadius(12)
    .border({ width: 1, color: colorOutline })
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly'
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(colorOutline)

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorOnSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Circle()
          .width(24)
          .height(24)
          .fill(colorOutline)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor(colorSurface)
      .alignItems(VerticalAlign.Center)

      Scroll(this.scroller) {
        Column() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChipItem({
                label: filter,
                isSelected: this.selectedFilter === filter,
                onSelect: () => {
                  this.selectedFilter = filter
                }
              })
                .margin({ right: 8 })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 24 })

          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorOnSurface)
              .margin({ bottom: 16 })

            BarChart()
          }
          .width('100%')
          .padding(16)
          .backgroundColor(colorSurface)
          .borderRadius(16)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 24 })

          ForEach(productivityItems, (item: ProductivityItemData) => {
            ProductivityCard({ item: item })
              .margin({ bottom: 16 })
          })
        }
        .padding(16)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(colorBackground)

      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnPrimary)
          .backgroundColor(colorPrimary)
          .borderRadius(12)
      }
      .padding(16)
      .backgroundColor(colorSurface)
      .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}