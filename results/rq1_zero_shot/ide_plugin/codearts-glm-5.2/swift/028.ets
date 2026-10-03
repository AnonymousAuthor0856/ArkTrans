class AppTokens {
  static readonly Colors = {
    primary: '#FF0F172A',
    secondary: '#FF475569',
    tertiary: '#FF94A3B8',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
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

@Component
struct FilterChip {
  @Prop title: string
  @Prop isSelected: boolean

  build() {
    Text(this.title)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .borderRadius(8)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Entry
@Component
struct ProductivityCheck {
  @State selectedFilter: string = 'Weekly'

  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppTokens.Colors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppTokens.Colors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppTokens.Colors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppTokens.Colors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppTokens.Colors.error)
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
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.outline)
          .margin({ left: 16 })

        Blank()

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.outline)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 4 })

      Scroll() {
        Column() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChip({ title: filter, isSelected: this.selectedFilter === filter })
                .margin({ left: filter === 'Daily' ? 0 : 8 })
                .onClick(() => {
                  this.selectedFilter = filter
                })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: 16 })

            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Column() {
                  Blank()
                  Row()
                    .width(20)
                    .height(150 * data.value)
                    .borderRadius(4)
                    .backgroundColor(AppTokens.Colors.primary)
                }
                .layoutWeight(1)
                .height(150)
                .justifyContent(FlexAlign.End)
              })
            }
            .width('100%')
            .height(150)

            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Text(data.label)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.secondary)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
              })
            }
            .width('100%')
            .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .borderRadius(16)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .margin({ left: 16, right: 16, top: 24 })

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .layoutWeight(1)

                Row() {
                  Row()
                    .width(10)
                    .height(10)
                    .borderRadius(5)
                    .backgroundColor(item.statusColor)
                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.statusColor)
                    .margin({ left: 8 })
                }
              }
              .width('100%')
              .margin({ bottom: 16 })

              Row() {
                Progress({ value: item.progress, total: 1, type: ProgressType.Linear })
                  .layoutWeight(1)
                  .height(8)
                  .color(item.statusColor)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)

                Text(`${Math.floor(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.secondary)
                  .width(40)
                  .textAlign(TextAlign.End)
                  .margin({ left: 8 })
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
            .borderRadius(12)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ left: 16, right: 16, top: 24 })
          })
        }
        .padding({ top: 16, bottom: 88 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Button('Submit New Form') {
        }
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(56)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}