import { LengthMetrics } from '@kit.ArkUI'

// Token definitions
const Colors = {
  primary: '#0F172A',
  secondary: '#475569',
  tertiary: '#94A3B8',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0F172A',
  onBackground: '#0F172A',
  onSurface: '#0F172A',
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
}

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
  { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: Colors.success },
  { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: Colors.warning },
  { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: Colors.secondary },
  { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: Colors.success },
  { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: Colors.error },
]

const chartData: ChartDataItem[] = [
  { label: 'Mon', value: 0.6 },
  { label: 'Tue', value: 0.8 },
  { label: 'Wed', value: 0.5 },
  { label: 'Thu', value: 1.0 },
  { label: 'Fri', value: 0.7 },
  { label: 'Sat', value: 0.4 },
  { label: 'Sun', value: 0.2 },
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
      .fontColor(this.isSelected ? Colors.onPrimary : Colors.onSurface)
      .backgroundColor(this.isSelected ? Colors.primary : Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: Colors.outline })
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
        .fontColor(Colors.onSurface)
        .margin({ bottom: Spacing.md })

      Column() {
        Row() {
          ForEach(chartData, (data: ChartDataItem) => {
            Column() {
              Column()
                .width('60%')
                .height(`${data.value * 100}%`)
                .backgroundColor(Colors.primary)
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

        Blank().height(Spacing.sm)

        Row() {
          ForEach(chartData, (data: ChartDataItem) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
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
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }
}

@Component
struct ProductivityCard {
  item: ProductivityItem = {
    id: 0,
    title: '',
    status: '',
    progress: 0,
    statusColor: Colors.secondary
  }

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)

        Row() {
          Circle({ width: 10, height: 10 })
            .fill(this.item.statusColor)
            .margin({ right: Spacing.sm })

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

      Blank().height(Spacing.md)

      Row() {
        Progress({
          value: this.item.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .color(this.item.statusColor)
          .backgroundColor(Colors.surfaceVariant)
          .style({ strokeWidth: 8, enableScanEffect: false })
          .layoutWeight(1)
          .borderRadius(100)

        Text(`${Math.floor(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: Spacing.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Circle({ width: 24, height: 24 })
            .fill(Colors.outline)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row() {
          Circle({ width: 24, height: 24 })
            .fill(Colors.outline)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.sm, right: Spacing.sm })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Filter Chips
          Row({ space: Spacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChipItem({
                label: filter,
                isSelected: this.selectedFilter === filter,
                onSelect: () => {
                  this.selectedFilter = filter
                }
              })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          // Weekly Throughput Chart
          WeeklyThroughputCard()

          // Productivity Items
          Column({ space: Spacing.lg }) {
            ForEach(productivityItems, (item: ProductivityItem) => {
              ProductivityCard({ item: item })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding({
          left: Spacing.md,
          right: Spacing.md,
          top: Spacing.md,
          bottom: Spacing.md
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      // Bottom Bar
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .margin({ left: Spacing.md, right: Spacing.md, top: Spacing.md, bottom: Spacing.md })
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .shadow({ radius: 10, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}