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

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State prevSelected: boolean = false
  @State goalSelected: boolean = false
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private cPrimary: string = '#0EA5E9'
  private cSecondary: string = '#22C55E'
  private cTertiary: string = '#F59E0B'
  private cPageBg: string = '#F7FAFC'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#EFF3F7'
  private cLine: string = '#D4D9E1'
  private cSuccess: string = '#16A34A'
  private cError: string = '#EF4444'
  private cText: string = '#0B1220'
  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
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

  private isFlagSelected(flag: string): boolean {
    return flag === 'Prev Period' ? this.prevSelected : this.goalSelected
  }

  private toggleFlag(flag: string): void {
    if (flag === 'Prev Period') {
      this.prevSelected = !this.prevSelected
    } else {
      this.goalSelected = !this.goalSelected
    }
  }

  @Builder
  RangeButton(range: string) {
    Button(range)
      .height(34)
      .padding({ left: 16, right: 16 })
      .fontSize(this.selectedRange === range ? 14 : 12)
      .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === range ? Color.White : this.cText)
      .backgroundColor(this.selectedRange === range ? this.cPrimary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 8 })
      .margin({ right: 4 })
      .onClick(() => {
        this.selectedRange = range
      })
  }

  @Builder
  FlagButton(flag: string) {
    Button(flag)
      .height(32)
      .padding({ left: 14, right: 14 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isFlagSelected(flag) ? '#0F172A' : this.cText)
      .backgroundColor(this.isFlagSelected(flag) ? this.cSecondary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 6 })
      .margin({ right: 4 })
      .onClick(() => {
        this.toggleFlag(flag)
      })
  }

  @Builder
  MetricCard(metric: MetricCardUi) {
    Column() {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
        Blank()
        Rect()
          .width(16)
          .height(16)
          .radius(4)
          .fill(metric.color)
      }
      .width('100%')

      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cText)
        .width('100%')
        .margin({ top: 10 })

      Row() {
        Rect()
          .width(6)
          .height(6)
          .radius(2)
          .fill(metric.delta.startsWith('+') ? this.cSuccess : this.cError)
          .margin({ right: 4 })
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? this.cSuccess : this.cError)
      }
      .width('100%')
      .margin({ top: 10 })
      Blank()
    }
    .height(120)
    .padding(8)
    .backgroundColor(this.cSurface)
    .border({ width: 1, color: this.cLine, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetY: 2 })
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column() {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cText)
        .width('100%')

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .radius(8)
          .fill(chart.color)
        Row({ space: 4 }) {
          Rect().width(6).height(40).radius(2).fill(this.cPrimary)
          Rect().width(6).height(30).radius(2).fill(this.cSecondary)
          Rect().width(6).height(48).radius(2).fill(this.cTertiary)
          Rect().width(6).height(22).radius(2).fill(this.cLine)
          Rect().width(6).height(32).radius(2).fill(this.cPrimary)
          Rect().width(6).height(42).radius(2).fill(this.cSecondary)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .aspectRatio(1.6)
      .margin({ top: 6 })

      Row() {
        Rect().width(8).height(8).radius(2).fill(this.cPrimary)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .margin({ left: 4, right: 8 })
        Rect().width(8).height(8).radius(2).fill(this.cSecondary)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .margin({ left: 4 })
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .height(180)
    .padding(8)
    .backgroundColor(this.cSurface)
    .border({ width: 1, color: this.cLine, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
          Row() {
            Rect()
              .width(20)
              .height(20)
              .radius(4)
              .fill(this.cPrimary)
              .margin({ right: 4 })
            Text('Analytics')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.cText)
          }
          Blank()
        }
        .height(80)
        .padding({ top: 36, bottom: 12 })
        .backgroundColor(this.cPageBg)

        Divider().color(this.cLine)

        Scroll() {
          Column() {
            Scroll() {
              Column() {
                Row() {
                  ForEach(this.ranges, (range: string) => {
                    this.RangeButton(range)
                  }, (range: string) => range)
                }
                .padding({ top: 4, bottom: 4 })
                Row() {
                  ForEach(this.ranges2, (range: string) => {
                    this.RangeButton(range)
                  }, (range: string) => range)
                  Blank().width(20)
                }
                .padding({ top: 8, bottom: 8 })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Row() {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.cText)
                .margin({ right: 4 })
              this.FlagButton('Prev Period')
              this.FlagButton('Goal')
              Row() {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
                  .margin({ right: 2 })
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .width(44)
                  .height(28)
                  .onChange((value: boolean) => {
                    this.darkMode = value
                  })
              }
              .layoutWeight(1)
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })

            Grid() {
              ForEach(this.kpis, (metric: MetricCardUi) => {
                GridItem() {
                  this.MetricCard(metric)
                }
              }, (metric: MetricCardUi) => metric.id.toString())
              ForEach(this.charts, (chart: ChartCardUi) => {
                GridItem() {
                  this.ChartCard(chart)
                }
              }, (chart: ChartCardUi) => chart.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(8)
            .width('100%')

            Blank().height(80)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
        .backgroundColor(this.cPageBg)
      }
      .width('100%')
      .height('100%')

      Column() {
        Divider().color('#4DD4D9E1')
        Row() {
          Column() {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cText)
              .width('100%')
            Text(this.notificationCount.toString() + ' pending')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.cText)
              .width('100%')
              .margin({ top: 2 })
          }
          .layoutWeight(1)

          Button('Mark All Read')
            .width(140)
            .height(44)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
            .backgroundColor(this.cSecondary)
            .borderRadius(12)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(this.cSurface)
      }
      .width('100%')
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cPageBg)
  }
}
