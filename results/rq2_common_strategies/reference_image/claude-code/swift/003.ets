@Entry
@Component
struct AnalyticsPage {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: Set<string> = new Set()
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppTokens.Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppTokens.Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppTokens.Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppTokens.Colors.tertiary }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Row() {
            Rect()
              .width(20)
              .height(20)
              .fill(AppTokens.Colors.primary)
              .radius(4)
            Text('Analytics')
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .margin({ left: 4, right: 4 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppTokens.Colors.background)

        Divider()
          .color(AppTokens.Colors.outline)

      // Content Scroll
      Scroll() {
        Column() {
          // Date Range Selector - Row 1
          Row() {
            ForEach(this.ranges, (range: string) => {
              Button(range)
                .fontSize(this.selectedRange === range ? 14 : 12)
                .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .margin({ right: 4 })
                .onClick(() => {
                  this.selectedRange = range
                })
            }, (range: string) => range)
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })

          // Date Range Selector - Row 2
          Row() {
            ForEach(this.ranges2, (range: string) => {
              Button(range)
                .fontSize(this.selectedRange === range ? 14 : 12)
                .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .margin({ right: 4 })
                .onClick(() => {
                  this.selectedRange = range
                })
            }, (range: string) => range)
            Blank()
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 })

          // Comparison Options
          Row() {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ right: 4 })

            ForEach(this.flags, (flag: string) => {
              Button(flag)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFlags.has(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedFlags.has(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .margin({ right: 4 })
                .maxLines(1)
                .onClick(() => {
                  if (this.selectedFlags.has(flag)) {
                    this.selectedFlags.delete(flag)
                  } else {
                    this.selectedFlags.add(flag)
                  }
                })
            }, (flag: string) => flag)

            // Dark Mode Toggle
            Row() {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ right: 2 })
              Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((value: boolean) => {
                  this.darkMode = value
                })
                .scale({ x: 0.8, y: 0.8 })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 6, bottom: 6 })

          // Metrics Grid - 2 columns
          Grid() {
            GridItem() {
              MetricCardView({ metric: this.kpis[0] })
            }
            GridItem() {
              MetricCardView({ metric: this.kpis[1] })
            }
            GridItem() {
              MetricCardView({ metric: this.kpis[2] })
            }
            GridItem() {
              MetricCardView({ metric: this.kpis[3] })
            }
            GridItem() {
              ChartCardView({ chart: this.charts[0] })
            }
            GridItem() {
              ChartCardView({ chart: this.charts[1] })
            }
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('repeat(3, auto)')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')

          Blank()
            .height(80)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)

      // Bottom Notification Bar
      Column() {
        Divider()
          .color(AppTokens.Colors.outline)
          .opacity(0.3)

        Row() {
          Column() {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text(this.notificationCount + ' pending')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 2 })

          Blank()

          Button('Mark All Read')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
      .position({ x: 0, y: 0 })
      .markAnchor({ x: 0, y: '100%' })
    }
    .width('100%')
    .height('100%')
  }
}

interface MetricCardUi {
  id: number
  title: string
  value: string
  delta: string
  color: string
}

interface ChartCardUi {
  id: number
  title: string
  color: string
}

@Component
struct MetricCardView {
  metric: MetricCardUi

  private isPositive(): boolean {
    return this.metric.delta.startsWith('+')
  }

  build() {
    Column() {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Rect()
          .width(16)
          .height(16)
          .fill(this.metric.color)
          .radius(4)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 4 })

      Row() {
        Rect()
          .width(6)
          .height(6)
          .fill(this.isPositive() ? AppTokens.Colors.success : AppTokens.Colors.error)
          .radius(2)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isPositive() ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ left: 2 })
      }
      .margin({ top: 4 })

      Blank()
    }
    .width('100%')
    .height(120)
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  chart: ChartCardUi

  build() {
    Column() {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill(this.chart.color)
          .radius(8)

        Row() {
          Rect().width(6).height(40).fill(AppTokens.Colors.primary).radius(2)
          Rect().width(6).height(30).fill(AppTokens.Colors.secondary).radius(2).margin({ left: 4 })
          Rect().width(6).height(48).fill(AppTokens.Colors.tertiary).radius(2).margin({ left: 4 })
          Rect().width(6).height(22).fill(AppTokens.Colors.outline).radius(2).margin({ left: 4 })
          Rect().width(6).height(32).fill(AppTokens.Colors.primary).radius(2).margin({ left: 4 })
          Rect().width(6).height(42).fill(AppTokens.Colors.secondary).radius(2).margin({ left: 4 })
        }
      }
      .width('100%')
      .aspectRatio(1.6)
      .margin({ top: 6 })
    }
    .width('100%')
    .height(180)
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 2 })
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
}
