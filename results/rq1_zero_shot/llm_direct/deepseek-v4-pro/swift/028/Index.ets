@Entry
@Component
struct ProductivityApp {
  build() {
    RootScreen()
  }
}

// MARK: - AppTokens
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
    body: { fontSize: 16, fontWeight: FontWeight.Regular, lineHeight: 22 },
    label: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 }
  }

  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  static readonly Elevation = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 2, opacity: 0.10 },
    level3: { radius: 10, dy: 4, opacity: 0.10 }
  }
}

// MARK: - Data Models
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

// MARK: - FilterChip Component
@Component
struct FilterChip {
  @Prop title: string
  @Prop isSelected: boolean
  onTap: () => void = () => {}

  build() {
    Button() {
      Text(this.title)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.smallCornerRadius)
        .border({ width: 1, color: AppTokens.Colors.outline })
    }
    .onClick(() => {
      this.onTap()
    })
  }
}

// MARK: - CustomLinearProgressIndicator Component
@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number
  @Prop color: string
  @Prop trackColor: string
  @Prop height: number

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.height / 2)

      Row()
        .width(`${this.progress * 100}%`)
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.height / 2)
    }
    .width('100%')
    .height(this.height)
  }
}

// MARK: - RootScreen Component
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'
  @State filters: string[] = ['Daily', 'Weekly', 'Monthly']
  @State productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: AppTokens.Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: AppTokens.Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: AppTokens.Colors.error }
  ]
  @State chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]

  private topBarHeight: number = 56
  private bottomBarButtonHeight: number = 56
  private bottomBarPadding: number = AppTokens.Spacing.md
  private bottomBarTotalHeight: number = this.bottomBarButtonHeight + this.bottomBarPadding * 2

  @Builder
  ChartBar(value: number, maxHeight: number, barWidth: number) {
    Column() {
      Blank()
        .layoutWeight(1)
      Row()
        .width(barWidth)
        .height(maxHeight * value)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.smallCornerRadius)
    }
    .width('100%')
    .height(maxHeight)
    .justifyContent(FlexAlign.End)
  }

  build() {
    Column() {
      // MARK: - Top Bar
      Row() {
        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill(AppTokens.Colors.outline)
        }
        .width(40)
        .height(40)
        .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('Productivity Check')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill(AppTokens.Colors.outline)
        }
        .width(40)
        .height(40)
        .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.Elevation.level3.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level3.opacity})`, offsetY: AppTokens.Elevation.level3.dy })
      .zIndex(1)

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.filters, (filter: string, index: number) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onTap: () => {
                  this.selectedFilter = filter
                }
              })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Weekly Throughput Card
          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart
            Column({ space: AppTokens.Spacing.sm }) {
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData, index: number) => {
                  this.ChartBar(data.value, 150, 20)
                })
              }
              .width('100%')
              .height(150)
              .alignItems(VerticalAlign.Bottom)

              // Chart Labels
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData, index: number) => {
                  Text(data.label)
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(AppTokens.Colors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
            }
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({ radius: AppTokens.Elevation.level1.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`, offsetY: AppTokens.Elevation.level1.dy })
          .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem, index: number) => {
            Column({ space: 0 }) {
              Row() {
                Text(item.title)
                  .fontSize(AppTokens.Typography.title.fontSize)
                  .fontWeight(AppTokens.Typography.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                Blank()

                Row({ space: AppTokens.Spacing.sm }) {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.statusColor)

                  Text(item.status)
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(item.statusColor)
                }
              }
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md })

              Row({ space: AppTokens.Spacing.sm }) {
                CustomLinearProgressIndicator({
                  progress: item.progress,
                  color: item.statusColor,
                  trackColor: AppTokens.Colors.surfaceVariant,
                  height: 8
                })
                .layoutWeight(1)

                Text(`${Math.floor(item.progress * 100)}%`)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: this.bottomBarTotalHeight })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // MARK: - Bottom Bar
      Column() {
        Button() {
          Text('Submit New Form')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(this.bottomBarButtonHeight)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.Elevation.level3.radius, color: `rgba(0,0,0,${AppTokens.Elevation.level3.opacity})`, offsetY: AppTokens.Elevation.level3.dy })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}