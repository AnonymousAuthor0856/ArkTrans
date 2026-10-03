// AppTokens.ets - Design Tokens equivalent
class AppTokens {
  static readonly Colors = {
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
    onSurface: '#0F172A'
  }

  static readonly Typography = {
    display: { fontSize: 32, fontWeight: FontWeight.Bold, lineHeight: 40 },
    headline: { fontSize: 24, fontWeight: FontWeight.Medium, lineHeight: 32 },
    title: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 22 },
    label: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 }
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }
}

// Data Models
class ProductivityItem {
  id: number = 0
  title: string = ''
  status: string = ''
  progress: number = 0
  statusColor: string = ''

  constructor(id: number, title: string, status: string, progress: number, statusColor: string) {
    this.id = id
    this.title = title
    this.status = status
    this.progress = progress
    this.statusColor = statusColor
  }
}

class ChartData {
  label: string = ''
  value: number = 0

  constructor(label: string, value: number) {
    this.label = label
    this.value = value
  }
}

// State Management
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'
  @State productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppTokens.Colors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppTokens.Colors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppTokens.Colors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppTokens.Colors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppTokens.Colors.error)
  ]
  
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private chartData: ChartData[] = [
    new ChartData('Mon', 0.6), new ChartData('Tue', 0.8), new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0), new ChartData('Fri', 0.7), new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.outline)
          .margin({ left: AppTokens.Spacing.md })

        Text('Productivity Check')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.outline)
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content List
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(this.selectedFilter === filter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedFilter === filter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.selectedFilter = filter
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg })

          // Weekly Throughput Chart Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart Bars
            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Column() {
                  // Empty space to push bar down
                  Column().layoutWeight(1 - data.value)
                  // The Bar
                  Column()
                    .width('60%')
                    .layoutWeight(data.value)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.small)
                }
                .layoutWeight(1)
                .height(150)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.End)
              })
            }
            .width('100%')
            .height(150)
            .alignItems(VerticalAlign.Bottom)

            // Chart Labels
            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Text(data.label)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.secondary)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .margin({ top: AppTokens.Spacing.sm })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ bottom: AppTokens.Spacing.lg })
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

          // Productivity Items List
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(AppTokens.Typography.title.fontSize)
                  .fontWeight(AppTokens.Typography.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .layoutWeight(1)

                Row() {
                  Row()
                    .width(10)
                    .height(10)
                    .borderRadius(5)
                    .backgroundColor(item.statusColor)
                    .margin({ right: AppTokens.Spacing.sm })

                  Text(item.status)
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(item.statusColor)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Row() {
                // Progress Bar Track
                Column() {
                  // Progress Bar Fill
                  Column()
                    .width(`${item.progress * 100}%`)
                    .height(8)
                    .backgroundColor(item.statusColor)
                    .borderRadius(4)
                }
                .layoutWeight(1)
                .height(8)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(4)
                .margin({ right: AppTokens.Spacing.sm })

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.secondary)
                  .width(40)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .margin({ top: AppTokens.Spacing.md })
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ bottom: AppTokens.Spacing.lg })
          })
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .align(Alignment.Top)

      // Bottom Bar
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}