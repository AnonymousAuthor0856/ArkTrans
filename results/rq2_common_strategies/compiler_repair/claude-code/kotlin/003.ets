@Entry
@Component
struct DashboardAnalytics {
  @State selectedRange: string = '7 Days'
  @State flags: string[] = []
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private kpis: MetricCard[] = [
    new MetricCard(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCard(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCard(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCard(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ]

  private charts: ChartCard[] = [
    new ChartCard(1, 'Sales Trend', '#E0F2FE'),
    new ChartCard(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCard(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCard(4, 'Device Breakdown', '#FFFBEB')
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Row() {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      Column() {
        // Range Filter Chips
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          ForEach(this.ranges, (r: string) => {
            FilterChip({
              label: r,
              selected: this.selectedRange === r,
              onChipClick: () => { this.selectedRange = r }
            })
          })
        }
        .width('100%')

        // Compare row with assist chips and switch
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text('Compare')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ right: AppTokens.Spacing.sm })

          AssistChip({
            label: 'Prev Period',
            active: this.flags.includes('Prev Period'),
            onChipClick: () => {
              const idx = this.flags.indexOf('Prev Period')
              if (idx >= 0) {
                this.flags.splice(idx, 1)
              } else {
                this.flags.push('Prev Period')
              }
            }
          })

          AssistChip({
            label: 'Goal',
            active: this.flags.includes('Goal'),
            onChipClick: () => {
              const idx = this.flags.indexOf('Goal')
              if (idx >= 0) {
                this.flags.splice(idx, 1)
              } else {
                this.flags.push('Goal')
              }
            }
          })

          Row() {
            Text('Dark')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ right: AppTokens.Spacing.xs })
            Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
              .selectedColor(AppTokens.Colors.primary)
              .onChange((val: boolean) => { this.darkSwitch = val })
          }
          .margin({ left: AppTokens.Spacing.sm })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.md })

        // KPI and Chart Grid
        Grid() {
          ForEach(this.kpis, (m: MetricCard) => {
            GridItem() {
              MetricCardView({ metric: m })
            }
          })
          ForEach(this.charts, (c: ChartCard) => {
            GridItem() {
              ChartCardView({ chart: c })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.lg)
        .columnsGap(AppTokens.Spacing.lg)
        .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxxl })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

      // Bottom Bar
      Row() {
        Column() {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(`${this.notifCount} pending`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .height(44)
          .width(140)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => { this.notifCount = 0 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 6,
        color: 'rgba(0,0,0,0.16)',
        offsetY: 1.5
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

class MetricCard {
  id: number
  title: string
  value: string
  delta: string
  color: ResourceColor

  constructor(id: number, title: string, value: string, delta: string, color: ResourceColor) {
    this.id = id
    this.title = title
    this.value = value
    this.delta = delta
    this.color = color
  }
}

class ChartCard {
  id: number
  title: string
  color: string

  constructor(id: number, title: string, color: string) {
    this.id = id
    this.title = title
    this.color = color
  }
}

@Component
struct FilterChip {
  label: string = ''
  selected: boolean = false
  onChipClick: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(this.selected ? 14 : 12)
      .fontWeight(this.selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .borderRadius(AppTokens.Shapes.medium)
      .onClick(() => this.onChipClick())
  }
}

@Component
struct AssistChip {
  label: string = ''
  active: boolean = false
  onChipClick: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
      .backgroundColor(this.active ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => this.onChipClick())
  }
}

@Component
struct MetricCardView {
  metric: MetricCard = new MetricCard(0, '', '', '', '#000000')

  build() {
    Column() {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Row()
          .width(16)
          .height(16)
          .backgroundColor(this.metric.color)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Row()
          .width(6)
          .height(6)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Shapes.small)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ left: AppTokens.Spacing.xs })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .height(120)
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.14)',
      offsetY: 1
    })
  }
}

@Component
struct ChartCardView {
  chart: ChartCard = new ChartCard(0, '', '#FFFFFF')

  build() {
    Column() {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      // Chart placeholder with bars
      Row() {
        Row() {
          Row()
            .width(6)
            .height(40)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm })
          Row()
            .width(6)
            .height(30)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm })
          Row()
            .width(6)
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm })
          Row()
            .width(6)
            .height(22)
            .backgroundColor(AppTokens.Colors.outline)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm })
          Row()
            .width(6)
            .height(32)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm })
          Row()
            .width(6)
            .height(42)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.small)
        }
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(this.chart.color)
      .borderRadius(AppTokens.Shapes.medium)
      .justifyContent(FlexAlign.Center)
      .margin({ top: AppTokens.Spacing.md })

      // Legend
      Row() {
        Row()
          .width(8)
          .height(8)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.xs })
        Row()
          .width(8)
          .height(8)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .margin({ left: AppTokens.Spacing.sm })
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.xs })
      }
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.14)',
      offsetY: 1
    })
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0EA5E9'
    export const secondary: string = '#22C55E'
    export const tertiary: string = '#F59E0B'
    export const background: string = '#F7FAFC'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#EFF3F7'
    export const outline: string = '#D4D9E1'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#0F172A'
    export const onTertiary: string = '#111827'
    export const onBackground: string = '#0B1220'
    export const onSurface: string = '#0B1220'
  }
  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 8
    export const large: number = 12
  }
  export namespace Spacing {
    export const xs: number = 2
    export const sm: number = 4
    export const md: number = 6
    export const lg: number = 8
    export const xl: number = 12
    export const xxl: number = 16
    export const xxxl: number = 24
  }
}
