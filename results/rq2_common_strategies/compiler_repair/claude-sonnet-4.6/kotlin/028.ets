import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#0F172A'
const COLOR_SECONDARY = '#475569'
const COLOR_TERTIARY = '#94A3B8'
const COLOR_BACKGROUND = '#F8FAFC'
const COLOR_SURFACE = '#FFFFFF'
const COLOR_SURFACE_VARIANT = '#F1F5F9'
const COLOR_OUTLINE = '#E2E8F0'
const COLOR_SUCCESS = '#22C55E'
const COLOR_WARNING = '#F59E0B'
const COLOR_ERROR = '#EF4444'
const COLOR_ON_PRIMARY = '#FFFFFF'
const COLOR_ON_SURFACE = '#0F172A'

// Spacing tokens
const SPACING_XS = 4
const SPACING_SM = 8
const SPACING_MD = 16
const SPACING_LG = 24

interface ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string
}

interface ChartDataItem {
  label: string
  value: number
}

const productivityItems: ProductivityItem[] = [
  { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: COLOR_SUCCESS },
  { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: COLOR_WARNING },
  { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: COLOR_SECONDARY },
  { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: COLOR_SUCCESS },
  { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: COLOR_ERROR }
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

const filters: string[] = ['Daily', 'Weekly', 'Monthly']

@Component
struct FilterChipItem {
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
      .backgroundColor(this.isSelected ? COLOR_PRIMARY : COLOR_SURFACE)
      .borderRadius(8)
      .border({ width: 1, color: COLOR_OUTLINE })
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.onSelect()
      })
  }
}

@Component
struct WeeklyThroughputCard {
  build() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)

      Blank().height(SPACING_MD)

      Column() {
        Row() {
          ForEach(chartData, (data: ChartDataItem) => {
            Column() {
              Column()
                .width('60%')
                .height(`${data.value * 100}%`)
                .backgroundColor(COLOR_PRIMARY)
                .borderRadius(8)
            }
            .width(0)
            .layoutWeight(1)
            .height('100%')
            .justifyContent(FlexAlign.End)
            .alignItems(HorizontalAlign.Center)
          })
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(VerticalAlign.Bottom)

        Blank().height(SPACING_SM)

        Row() {
          ForEach(chartData, (data: ChartDataItem) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_SECONDARY)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          })
        }
        .width('100%')
      }
      .width('100%')
      .height(150)
    }
    .width('100%')
    .padding(SPACING_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }
}

@Component
struct ProductivityCard {
  @Prop item: ProductivityItem = {
    id: 0,
    title: '',
    status: '',
    progress: 0,
    statusColor: COLOR_PRIMARY
  }

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)

          Blank().width(SPACING_SM)

          Text(this.item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(SPACING_MD)

      Row() {
        Progress({
          value: this.item.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .layoutWeight(1)
          .height(8)
          .color(this.item.statusColor)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(4)

        Blank().width(SPACING_SM)

        Text(`${Math.floor(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SECONDARY)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(SPACING_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly'

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(COLOR_OUTLINE)
          .margin({ left: SPACING_MD })

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Circle()
          .width(24)
          .height(24)
          .fill(COLOR_OUTLINE)
          .margin({ right: SPACING_MD })
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })

      // Scrollable content
      Scroll() {
        Column() {
          // Filter chips
          Row() {
            ForEach(filters, (filter: string) => {
              FilterChipItem({
                label: filter,
                isSelected: this.selectedFilter === filter,
                onSelect: () => {
                  this.selectedFilter = filter
                }
              })
              Blank().width(SPACING_SM)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: SPACING_MD, bottom: SPACING_MD })

          // Weekly Throughput Chart
          WeeklyThroughputCard()

          Blank().height(SPACING_LG)

          // Productivity Items
          ForEach(productivityItems, (item: ProductivityItem) => {
            ProductivityCard({ item: item })
            Blank().height(SPACING_MD)
          })

          Blank().height(SPACING_LG)
        }
        .width('100%')
        .padding({ left: SPACING_MD, right: SPACING_MD })
      }
      .layoutWeight(1)
      .backgroundColor(COLOR_BACKGROUND)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(12)
          .margin({ top: SPACING_MD, bottom: SPACING_MD, left: SPACING_MD, right: SPACING_MD })
      }
      .width('100%')
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 10, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}