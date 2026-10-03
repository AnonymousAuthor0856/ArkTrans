@Entry
@Component
struct DashboardApp {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: '#22C55E' },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: '#0EA5E9' },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: '#EF4444' },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: '#F59E0B' }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' }
  ]

  build() {
    Stack() {
      // Main content
      Column({ space: 0 }) {
        // Header
        Row() {
          Blank()
          Row({ space: 4 }) {
            Blank().width(20).height(20).backgroundColor('#0EA5E9').borderRadius(4)
            Text('Analytics')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
          }
          Blank()
        }
        .padding({ top: 48, bottom: 12 })
        .backgroundColor('#F7FAFC')

        Divider().height(1).color('#E5E7EB')

        // Scrollable content using List
        List() {
          // Date Range Selector - first row
          ListItem() {
            Row({ space: 4 }) {
              ForEach(this.ranges, (range: string) => {
                Button() {
                  Text(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                }
                .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D4D9E1' })
                .onClick(() => { this.selectedRange = range })
              })
            }
            .padding({ top: 4, bottom: 4 })
          }

          // Date Range Selector - second row (ranges2)
          ListItem() {
            Row({ space: 4 }) {
              ForEach(this.ranges2, (range: string) => {
                Button() {
                  Text(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#D4D9E1' })
                .onClick(() => { this.selectedRange = range })
              })
              Blank()
            }
            .padding({ top: 8, bottom: 8 })
          }

          // Comparison Options row
          ListItem() {
            Row({ space: 4 }) {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              ForEach(this.flags, (flag: string) => {
                Button() {
                  Text(flag)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedFlags.indexOf(flag) !== -1 ? '#0F172A' : '#0B1220')
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.selectedFlags.indexOf(flag) !== -1 ? '#22C55E' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D4D9E1' })
                .onClick(() => {
                  let idx = this.selectedFlags.indexOf(flag)
                  if (idx !== -1) {
                    this.selectedFlags.splice(idx, 1)
                  } else {
                    this.selectedFlags.push(flag)
                  }
                })
              })
              // Dark mode toggle replaced with Button
              Button() {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
              }
              .onClick(() => { this.darkMode = !this.darkMode })
              .backgroundColor(this.darkMode ? '#0EA5E9' : '#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#D4D9E1' })
            }
            .padding({ top: 6, bottom: 6 })
          }

          // Metrics Grid
          ListItem() {
            Grid() {
              // First row: Revenue and Orders
              GridItem() {
                MetricCardView({ metric: this.kpis[0] })
              }
              GridItem() {
                MetricCardView({ metric: this.kpis[1] })
              }
              // Second row: Refunds and Active Users
              GridItem() {
                MetricCardView({ metric: this.kpis[2] })
              }
              GridItem() {
                MetricCardView({ metric: this.kpis[3] })
              }
              // Charts row
              GridItem() {
                ChartCardView({ chart: this.charts[0] })
              }
              GridItem() {
                ChartCardView({ chart: this.charts[1] })
              }
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(8)
            .width('100%')
          }

          // Bottom spacer - fix: use Column instead of Blank
          ListItem() {
            Column().height(80)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F7FAFC')
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar (overlay)
      Column({ space: 0 }) {
        Divider().height(1).color('#D4D9E1').opacity(0.3)
        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            Text(this.notificationCount.toString() + ' pending')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
          }
          Blank()
          Button() {
            Text('Mark All Read')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
              .width(140)
              .height(44)
          }
          .backgroundColor('#22C55E')
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => { this.notificationCount = 0 })
        }
        .padding({ left: 8, right: 8, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .width('100%')
      .alignSelf(ItemAlign.End) // fixed: use ItemAlign.End
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}

@Component
struct MetricCardView {
  @Prop metric: MetricCardUi

  build() {
    Column({ space: 4 }) {
      // Title row
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Blank()
        Blank().width(16).height(16).backgroundColor(this.metric.color).borderRadius(4)
      }
      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
      Row({ space: 2 }) {
        Blank().width(6).height(6).backgroundColor(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444').borderRadius(2)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
      }
      Blank()
    }
    .padding(8)
    .height(120)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#24000000' })
  }
}

@Component
struct ChartCardView {
  @Prop chart: ChartCardUi

  build() {
    Column({ space: 8 }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      // Bar chart representation
      Stack() {
        Row({ space: 4 }) {
          Blank().width(6).height(40).backgroundColor('#0EA5E9').borderRadius(2)
          Blank().width(6).height(30).backgroundColor('#22C55E').borderRadius(2)
          Blank().width(6).height(48).backgroundColor('#F59E0B').borderRadius(2)
          Blank().width(6).height(22).backgroundColor('#D4D9E1').borderRadius(2)
          Blank().width(6).height(32).backgroundColor('#0EA5E9').borderRadius(2)
          Blank().width(6).height(42).backgroundColor('#22C55E').borderRadius(2)
        }
        .padding({ left: 8 })
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(this.chart.color)
      .borderRadius(8)

      // Legend
      Row({ space: 4 }) {
        Blank().width(8).height(8).backgroundColor('#0EA5E9').borderRadius(2)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Blank().width(8).height(8).backgroundColor('#22C55E').borderRadius(2)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
    }
    .padding(8)
    .height(180)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#24000000' })
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