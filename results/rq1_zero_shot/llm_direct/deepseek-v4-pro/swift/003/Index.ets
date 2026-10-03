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
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', '#22C55E'),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', '#0EA5E9'),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', '#EF4444'),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', '#F59E0B')
  ]

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Column() {
          Row() {
            Blank()
            Row({ space: 4 }) {
              Rect()
                .fill('#0EA5E9')
                .width(20)
                .height(20)
                .borderRadius(4)
              Text('Analytics')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            Blank()
          }
          .width('100%')
          .padding({ top: 48, bottom: 12 })
        }
        .width('100%')
        .backgroundColor('#F7FAFC')

        Divider()
          .strokeWidth(1)
          .color('#D4D9E1')

        // Content
        Scroll() {
          Column({ space: 6 }) {
            // Date Range Selector
            Scroll() {
              Row({ space: 4 }) {
                ForEach(this.ranges, (range: string) => {
                  Button() {
                    this.selectedRange = range
                  }
                  .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D4D9E1' })
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .layoutWeight(0)
                  Text(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
                })
              }
              .width('100%')
              .padding({ top: 4, bottom: 4 })

              Row({ space: 4 }) {
                ForEach(this.ranges2, (range: string) => {
                  Button() {
                    this.selectedRange = range
                  }
                  .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D4D9E1' })
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .layoutWeight(0)
                  Text(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
                })
                Blank()
              }
              .width('100%')
              .padding({ top: 8, bottom: 8 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Comparison Options
            Row({ space: 4 }) {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')

              ForEach(this.flags, (flag: string) => {
                Button() {
                  const index = this.selectedFlags.indexOf(flag)
                  if (index >= 0) {
                    this.selectedFlags.splice(index, 1)
                  } else {
                    this.selectedFlags.push(flag)
                  }
                }
                .backgroundColor(this.selectedFlags.includes(flag) ? '#22C55E' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D4D9E1' })
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .layoutWeight(0)
                Text(flag)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedFlags.includes(flag) ? '#0F172A' : '#0B1220')
                  .maxLines(1)
              })

              Row({ space: 2 }) {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor('#0EA5E9')
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn
                  })
                  .width(40)
                  .height(24)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid - Row 1
            Row({ space: 6 }) {
              MetricCardView({ metric: this.kpis[0] })
                .layoutWeight(1)
              MetricCardView({ metric: this.kpis[1] })
                .layoutWeight(1)
            }
            .width('100%')

            // Metrics Grid - Row 2
            Row({ space: 6 }) {
              MetricCardView({ metric: this.kpis[2] })
                .layoutWeight(1)
              MetricCardView({ metric: this.kpis[3] })
                .layoutWeight(1)
            }
            .width('100%')

            // Charts Row
            Row({ space: 6 }) {
              ChartCardView({ chart: this.charts[0] })
                .layoutWeight(1)
              ChartCardView({ chart: this.charts[1] })
                .layoutWeight(1)
            }
            .width('100%')

            Blank()
              .height(80)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
        .backgroundColor('#F7FAFC')
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar
      Column({ space: 0 }) {
        Divider()
          .strokeWidth(1)
          .color('#D4D9E1')
          .opacity(0.3)

        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            this.notificationCount = 0
          }
          .backgroundColor('#22C55E')
          .borderRadius(12)
          .width(140)
          .height(44)
          Text('Mark All Read')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}

class MetricCardUi {
  id: number
  title: string
  value: string
  delta: string
  color: string

  constructor(id: number, title: string, value: string, delta: string, color: string) {
    this.id = id
    this.title = title
    this.value = value
    this.delta = delta
    this.color = color
  }
}

class ChartCardUi {
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
struct MetricCardView {
  @Prop metric: MetricCardUi

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Blank()
        Rect()
          .fill(this.metric.color)
          .width(16)
          .height(16)
          .borderRadius(4)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      Row({ space: 2 }) {
        Rect()
          .fill(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
          .width(6)
          .height(6)
          .borderRadius(2)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
      }

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .height(120)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  @Prop chart: ChartCardUi

  build() {
    Column({ space: 6 }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      Column() {
        Row({ space: 4 }) {
          Rect()
            .fill('#0EA5E9')
            .width(6)
            .height(40)
            .borderRadius(2)
          Rect()
            .fill('#22C55E')
            .width(6)
            .height(30)
            .borderRadius(2)
          Rect()
            .fill('#F59E0B')
            .width(6)
            .height(48)
            .borderRadius(2)
          Rect()
            .fill('#D4D9E1')
            .width(6)
            .height(22)
            .borderRadius(2)
          Rect()
            .fill('#0EA5E9')
            .width(6)
            .height(32)
            .borderRadius(2)
          Rect()
            .fill('#22C55E')
            .width(6)
            .height(42)
            .borderRadius(2)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(60)
      .backgroundColor(this.chart.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      Row({ space: 4 }) {
        Rect()
          .fill('#0EA5E9')
          .width(8)
          .height(8)
          .borderRadius(2)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Rect()
          .fill('#22C55E')
          .width(8)
          .height(8)
          .borderRadius(2)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .height(180)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D4D9E1' })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}