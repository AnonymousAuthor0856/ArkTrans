const PRIMARY: string = '#0EA5E9'
const SECONDARY: string = '#22C55E'
const TERTIARY: string = '#F59E0B'
const BACKGROUND: string = '#F7FAFC'
const SURFACE: string = '#FFFFFF'
const OUTLINE: string = '#D4D9E1'
const TEXT: string = '#0B1220'
const SUCCESS: string = '#16A34A'
const ERROR: string = '#EF4444'

interface MetricCard {
  title: string
  value: string
  delta: string
  color: string
}

interface ChartCard {
  title: string
  tint: string
}

@Entry
@Component
struct AnalyticsPage {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false
  @State notificationCount: number = 2
  private rangeScroller: Scroller = new Scroller()

  private readonly ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private readonly secondaryRanges: string[] = ['YTD', 'Custom']
  private readonly flags: string[] = ['Prev Period', 'Goal']
  private readonly metrics: MetricCard[] = [
    { title: 'Revenue', value: '$24,560', delta: '+8.2%', color: SECONDARY },
    { title: 'Orders', value: '1,284', delta: '+3.1%', color: PRIMARY },
    { title: 'Refunds', value: '42', delta: '-1.4%', color: ERROR },
    { title: 'Active Users', value: '8,921', delta: '+5.6%', color: TERTIARY }
  ]
  private readonly charts: ChartCard[] = [
    { title: 'Sales Trend', tint: '#E0F2FE' },
    { title: 'Conversion Funnel', tint: '#EFF6FF' }
  ]

  private isFlagSelected(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0
  }

  private toggleFlag(flag: string): void {
    if (this.isFlagSelected(flag)) {
      this.selectedFlags = this.selectedFlags.filter((item: string) => item !== flag)
    } else {
      this.selectedFlags = [...this.selectedFlags, flag]
    }
  }

  @Builder
  private RangeButton(label: string): void {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(20)
      .fontWeight(this.selectedRange === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === label ? '#FFFFFF' : TEXT)
      .backgroundColor(this.selectedRange === label ? PRIMARY : SURFACE)
      .border({ width: 1, color: OUTLINE })
      .borderRadius(16)
      .height(64)
      .padding({ left: 16, right: 16 })
      .onClick(() => {
        this.selectedRange = label
      })
  }

  @Builder
  private CompareButton(label: string): void {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isFlagSelected(label) ? '#0F172A' : TEXT)
      .backgroundColor(this.isFlagSelected(label) ? SECONDARY : SURFACE)
      .border({ width: 1, color: OUTLINE })
      .borderRadius(12)
      .height(64)
      .padding({ left: 16, right: 16 })
      .onClick(() => {
        this.toggleFlag(label)
      })
  }

  @Builder
  private MetricCard(metric: MetricCard): void {
    Column() {
      Row() {
        Text(metric.title)
          .fontSize(26)
          .fontColor(TEXT)
          .fontWeight(FontWeight.Medium)
        Blank()
        Row()
          .width(32)
          .height(32)
          .backgroundColor(metric.color)
          .borderRadius(7)
      }
      .width('100%')

      Text(metric.value)
        .fontSize(36)
        .fontColor(TEXT)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 6 })

      Row({ space: 5 }) {
        Row()
          .width(12)
          .height(12)
          .backgroundColor(metric.delta.startsWith('+') ? SUCCESS : ERROR)
          .borderRadius(4)
        Text(metric.delta)
          .fontSize(18)
          .fontColor(metric.delta.startsWith('+') ? SUCCESS : ERROR)
      }
      .margin({ top: 6 })

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(240)
    .backgroundColor(SURFACE)
    .border({ width: 1, color: OUTLINE })
    .borderRadius(20)
    .shadow({ radius: 8, color: '#22000000', offsetY: 3 })
  }

  @Builder
  private ChartBars(): void {
    Row({ space: 10 }) {
      Row().width(12).height(70).backgroundColor(PRIMARY).borderRadius(4)
      Row().width(12).height(52).backgroundColor(SECONDARY).borderRadius(4)
      Row().width(12).height(84).backgroundColor(TERTIARY).borderRadius(4)
      Row().width(12).height(40).backgroundColor(OUTLINE).borderRadius(4)
      Row().width(12).height(58).backgroundColor(PRIMARY).borderRadius(4)
      Row().width(12).height(74).backgroundColor(SECONDARY).borderRadius(4)
    }
    .alignItems(VerticalAlign.Bottom)
    .height(110)
  }

  @Builder
  private ChartCard(chart: ChartCard): void {
    Column() {
      Text(chart.title)
        .fontSize(26)
        .fontColor(TEXT)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)

      Row() {
        this.ChartBars()
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(130)
      .backgroundColor(chart.tint)
      .borderRadius(16)
      .margin({ top: 12 })

      Row({ space: 8 }) {
        Row().width(12).height(12).backgroundColor(PRIMARY).borderRadius(3)
        Text('Series A').fontSize(14).fontColor(TEXT)
        Row().width(12).height(12).backgroundColor(SECONDARY).borderRadius(3)
        Text('Series B').fontSize(14).fontColor(TEXT)
      }
      .margin({ top: 10 })
      .alignSelf(ItemAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(300)
    .backgroundColor(SURFACE)
    .border({ width: 1, color: OUTLINE })
    .borderRadius(20)
    .shadow({ radius: 8, color: '#22000000', offsetY: 3 })
  }

  build() {
    Column() {
      Row() {
        Blank()
        Row({ space: 8 }) {
          Row()
            .width(40)
            .height(40)
            .backgroundColor(PRIMARY)
            .borderRadius(9)
          Text('Analytics')
            .fontSize(46)
            .fontWeight(FontWeight.Bold)
            .fontColor(TEXT)
        }
        Blank()
      }
      .height(178)
      .padding({ top: 56 })
      .backgroundColor(BACKGROUND)
      .border({ width: { bottom: 1 }, color: '#C7CBD1' })

      Scroll() {
        Column({ space: 12 }) {
          Scroll(this.rangeScroller) {
            Column({ space: 12 }) {
              Row({ space: 8 }) {
                ForEach(this.ranges, (range: string) => {
                  this.RangeButton(range)
                }, (range: string) => range)
              }
              .padding({ top: 8 })

              Row({ space: 8 }) {
                ForEach(this.secondaryRanges, (range: string) => {
                  this.RangeButton(range)
                }, (range: string) => range)
                Blank()
              }
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Row({ space: 8 }) {
            Text('Compare')
              .fontSize(21)
              .fontColor(TEXT)
              .fontWeight(FontWeight.Medium)
            ForEach(this.flags, (flag: string) => {
              this.CompareButton(flag)
            }, (flag: string) => flag)
            Text('Dark')
              .fontSize(21)
              .fontColor(TEXT)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 0 })
            Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
              .selectedColor(PRIMARY)
              .switchPointColor('#FFFFFF')
              .width(80)
              .height(48)
              .onChange((value: boolean) => {
                this.darkMode = value
              })
          }
          .height(72)
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Grid() {
            ForEach(this.metrics, (metric: MetricCard) => {
              GridItem() {
                this.MetricCard(metric)
              }
            }, (metric: MetricCard) => metric.title)
            ForEach(this.charts, (chart: ChartCard) => {
              GridItem() {
                this.ChartCard(chart)
              }
            }, (chart: ChartCard) => chart.title)
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(16)
          .columnsGap(16)
          .width('100%')

          Blank().height(100)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 20 })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(BACKGROUND)

      Column() {
        Row()
          .height(1)
          .width('100%')
          .backgroundColor('#4DD4D9E1')
        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(19)
              .fontColor(TEXT)
            Text(`${this.notificationCount} pending`)
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT)
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
          Button('Mark All Read', { type: ButtonType.Normal })
            .fontSize(22)
            .fontColor('#0F172A')
            .backgroundColor(SECONDARY)
            .borderRadius(18)
            .height(88)
            .width(280)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .height(112)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor(SURFACE)
      }
      .width('100%')
      .shadow({ radius: 8, color: '#22000000', offsetY: -3 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
