@Entry
@Component
struct ContentView {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: Set<string> = new Set()
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: 0xFF22C55E },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: 0xFF0EA5E9 },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: 0xFFEF4444 },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: 0xFFF59E0B }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: 0xFFE0F2FE },
    { id: 2, title: 'Conversion Funnel', color: 0xFFEFF6FF }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Row({ space: 4 }) {
            Column()
              .width(20)
              .height(20)
              .borderRadius(4)
              .backgroundColor(0xFF0EA5E9)

            Text('Analytics')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(0xFF0B1220)
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(0xFFF7FAFC)

        Divider()
          .color(0xFFD4D9E1)

        // Content
        Scroll() {
          Column({ space: 6 }) {
            // Date Range Selector Row 1
            Scroll() {
              Row({ space: 4 }) {
                ForEach(this.ranges, (range: string) => {
                  Button(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                    .fontColor(this.selectedRange === range ? 0xFFFFFFFF : 0xFF0B1220)
                    .backgroundColor(this.selectedRange === range ? 0xFF0EA5E9 : 0xFFFFFFFF)
                    .borderRadius(8)
                    .border({ width: 1, color: 0xFFD4D9E1 })
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .onClick(() => {
                      this.selectedRange = range
                    })
                })
              }
              .padding({ top: 4, bottom: 4 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Date Range Selector Row 2
            Row({ space: 4 }) {
              ForEach(this.ranges2, (range: string) => {
                Button(range)
                  .fontSize(this.selectedRange === range ? 14 : 12)
                  .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedRange === range ? 0xFFFFFFFF : 0xFF0B1220)
                  .backgroundColor(this.selectedRange === range ? 0xFF0EA5E9 : 0xFFFFFFFF)
                  .borderRadius(8)
                  .border({ width: 1, color: 0xFFD4D9E1 })
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .onClick(() => {
                    this.selectedRange = range
                  })
              })
            }
            .width('100%')
            .padding({ top: 4, bottom: 4 })
            .alignItems(VerticalAlign.Center)

            // Comparison Options
            Row({ space: 4 }) {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(0xFF0B1220)

              ForEach(this.flags, (flag: string) => {
                Button(flag)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedFlags.has(flag) ? 0xFF0F172A : 0xFF0B1220)
                  .backgroundColor(this.selectedFlags.has(flag) ? 0xFF22C55E : 0xFFFFFFFF)
                  .borderRadius(6)
                  .border({ width: 1, color: 0xFFD4D9E1 })
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .onClick(() => {
                    let newFlags = new Set(this.selectedFlags)
                    if (newFlags.has(flag)) {
                      newFlags.delete(flag)
                    } else {
                      newFlags.add(flag)
                    }
                    this.selectedFlags = newFlags
                  })
              })

              Row({ space: 2 }) {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(0xFF0B1220)

                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(0xFF0EA5E9)
                  .width(40)
                  .height(24)
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn
                  })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })
            .alignItems(VerticalAlign.Center)

            // Metrics Grid
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
            .columnsGap(8)
            .rowsGap(8)
            .width('100%')

            Column()
              .height(80)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .backgroundColor(0xFFF7FAFC)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(0xFFF7FAFC)

      // Bottom Notification Bar
      Column() {
        Divider()
          .color(0x4DD4D9E1)

        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(0xFF0B1220)

            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(0xFF0B1220)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Mark All Read')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(0xFF0F172A)
            .backgroundColor(0xFF22C55E)
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(0xFFFFFFFF)
        .shadow({ radius: 4, color: 0x1A000000, offsetX: 0, offsetY: -2 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
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
  color: number
}

interface ChartCardUi {
  id: number
  title: string
  color: number
}

@Component
struct MetricCardView {
  metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: 0 }

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(0xFF0B1220)

        Blank()

        Column()
          .width(16)
          .height(16)
          .borderRadius(4)
          .backgroundColor(this.metric.color)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(0xFF0B1220)

      Row({ space: 2 }) {
        Column()
          .width(6)
          .height(6)
          .borderRadius(2)
          .backgroundColor(this.metric.delta.startsWith('+') ? 0xFF16A34A : 0xFFEF4444)

        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? 0xFF16A34A : 0xFFEF4444)
      }
      .alignItems(VerticalAlign.Center)
    }
    .padding(8)
    .width('100%')
    .height(120)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(0xFFFFFFFF)
    .borderRadius(12)
    .border({ width: 1, color: 0xFFD4D9E1 })
    .shadow({ radius: 4, color: 0x24000000, offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  chart: ChartCardUi = { id: 0, title: '', color: 0 }

  build() {
    Column({ space: 6 }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(0xFF0B1220)

      // Chart area
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .borderRadius(8)
          .backgroundColor(this.chart.color)

        Row({ space: 4 }) {
          Column()
            .width(6)
            .height(40)
            .borderRadius(2)
            .backgroundColor(0xFF0EA5E9)

          Column()
            .width(6)
            .height(30)
            .borderRadius(2)
            .backgroundColor(0xFF22C55E)

          Column()
            .width(6)
            .height(48)
            .borderRadius(2)
            .backgroundColor(0xFFF59E0B)

          Column()
            .width(6)
            .height(22)
            .borderRadius(2)
            .backgroundColor(0xFFD4D9E1)

          Column()
            .width(6)
            .height(32)
            .borderRadius(2)
            .backgroundColor(0xFF0EA5E9)

          Column()
            .width(6)
            .height(42)
            .borderRadius(2)
            .backgroundColor(0xFF22C55E)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(90)

      // Legend
      Row({ space: 4 }) {
        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(0xFF0EA5E9)

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(0xFF0B1220)

        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(0xFF22C55E)

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(0xFF0B1220)
      }
      .alignItems(VerticalAlign.Center)
    }
    .padding(8)
    .width('100%')
    .height(180)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(0xFFFFFFFF)
    .borderRadius(12)
    .border({ width: 1, color: 0xFFD4D9E1 })
    .shadow({ radius: 4, color: 0x24000000, offsetX: 0, offsetY: 2 })
  }
}