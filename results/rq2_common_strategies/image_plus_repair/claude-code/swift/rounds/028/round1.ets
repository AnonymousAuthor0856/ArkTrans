// Design Tokens

interface TypographyStyle {
  fontSize: number
  lineHeight: number
  letterSpacing: number
  fontWeight: number
}

interface ShadowSpec {
  radius: number
  dy: number
  opacity: number
}

namespace AppTokens {
  export class Colors {
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
    static readonly onSecondary: string = '#FFFFFF'
    static readonly onTertiary: string = '#0F172A'
    static readonly onBackground: string = '#0F172A'
    static readonly onSurface: string = '#0F172A'
  }

  export class TypographyTokens {
    static readonly display: TypographyStyle = { fontSize: 32, lineHeight: 40, letterSpacing: 0, fontWeight: FontWeight.Bold }
    static readonly headline: TypographyStyle = { fontSize: 24, lineHeight: 32, letterSpacing: 0, fontWeight: FontWeight.Bold }
    static readonly title: TypographyStyle = { fontSize: 18, lineHeight: 24, letterSpacing: 0.15, fontWeight: FontWeight.Medium }
    static readonly body: TypographyStyle = { fontSize: 16, lineHeight: 22, letterSpacing: 0.5, fontWeight: FontWeight.Regular }
    static readonly label: TypographyStyle = { fontSize: 14, lineHeight: 18, letterSpacing: 0.5, fontWeight: FontWeight.Medium }
  }

  export class Shapes {
    static readonly smallCornerRadius: number = 8
    static readonly mediumCornerRadius: number = 12
    static readonly largeCornerRadius: number = 16
  }

  export class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 16
    static readonly lg: number = 24
    static readonly xl: number = 32
    static readonly xxl: number = 48
  }

  export class ElevationMapping {
    static readonly level1: ShadowSpec = { radius: 3, dy: 1, opacity: 0.10 }
    static readonly level2: ShadowSpec = { radius: 6, dy: 2, opacity: 0.10 }
    static readonly level3: ShadowSpec = { radius: 10, dy: 4, opacity: 0.10 }
  }
}

// Data Models
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

// Custom Components

@Component
struct FilterChip {
  @Link selectedFilter: string
  title: string = ''
  isSelected: boolean = false

  build() {
    Text(this.title)
      .fontSize(AppTokens.TypographyTokens.label.fontSize)
      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.smallCornerRadius)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.selectedFilter = this.title
      })
  }
}

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  color: string = ''
  trackColor: string = ''
  barHeight: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rectangle()
        .fill(this.trackColor)
        .width('100%')
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)

      // Progress
      Rectangle()
        .fill(this.color)
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// Bar Chart Component
@Component
struct BarChart {
  chartData: ChartData[] = []
  chartHeight: number = 150

  build() {
    Column() {
      Row() {
        ForEach(this.chartData, (item: ChartData) => {
          Column() {
            Blank()
            Column() {
              Rectangle()
                .fill(AppTokens.Colors.primary)
                .width('60%')
                .height(`${item.value * 100}%`)
                .borderRadius(AppTokens.Shapes.smallCornerRadius)
            }
            .width('100%')
            .height('100%')
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .layoutWeight(1)
        }, (item: ChartData) => item.label)
      }
      .width('100%')
      .height(this.chartHeight)
      .alignItems(VerticalAlign.Bottom)

      // Labels
      Row() {
        ForEach(this.chartData, (item: ChartData) => {
          Text(item.label)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }, (item: ChartData) => item.label)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
  }
}

// Productivity Item Card
@Component
struct ProductivityItemCard {
  item: ProductivityItem = { id: 0, title: '', status: '', progress: 0, statusColor: '' }

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)
          Text(this.item.status)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(this.item.statusColor)
            .margin({ left: AppTokens.Spacing.sm })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppTokens.Spacing.md })

      Row() {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: AppTokens.Colors.surfaceVariant,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// Main Screen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'

  private filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: AppTokens.Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: AppTokens.Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: AppTokens.Colors.error }
  ]
  private chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 }, { label: 'Tue', value: 0.8 }, { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 }, { label: 'Fri', value: 0.7 }, { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]
  private topBarHeight: number = 56
  private bottomBarButtonHeight: number = 56

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.outline)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('Productivity Check')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.outline)
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`,
        offsetY: AppTokens.ElevationMapping.level3.dy
      })
      .zIndex(1)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                selectedFilter: $selectedFilter,
                title: filter,
                isSelected: this.selectedFilter === filter
              })
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            BarChart({ chartData: this.chartData, chartHeight: 150 })
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            ProductivityItemCard({ item: item })
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .padding({ bottom: this.bottomBarButtonHeight + AppTokens.Spacing.md * 2 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(this.bottomBarButtonHeight)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .padding(AppTokens.Spacing.md)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`,
        offsetY: -AppTokens.ElevationMapping.level3.dy
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
