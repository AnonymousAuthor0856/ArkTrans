const PRIMARY: string = '#11A5E0'
const GREEN: string = '#20C45A'
const ORANGE: string = '#F59E0B'
const RED: string = '#F04444'
const BG: string = '#F7FAFC'
const INK: string = '#101827'
const OUTLINE: string = '#D4DAE2'

interface Metric {
  title: string
  value: string
  delta: string
  color: string
}

interface Chart {
  title: string
  tint: string
}

@Entry
@Component
struct MainPage {
  @State selectedRange: string = '7 Days'
  @State previousPeriod: boolean = false
  @State goal: boolean = false
  @State darkMode: boolean = false
  @State pending: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']
  private metrics: Metric[] = [
    { title: 'Revenue', value: '$24,560', delta: '+8.2%', color: GREEN },
    { title: 'Orders', value: '1,284', delta: '+3.1%', color: PRIMARY },
    { title: 'Refunds', value: '42', delta: '-1.4%', color: RED },
    { title: 'Active Users', value: '8,921', delta: '+5.6%', color: ORANGE }
  ]
  private charts: Chart[] = [
    { title: 'Sales Trend', tint: '#DFF2FD' },
    { title: 'Conversion Funnel', tint: '#EFF6FF' },
    { title: 'Geo Distribution', tint: '#ECFDF5' },
    { title: 'Device Breakdown', tint: '#FFFBEB' }
  ]

  build() {
    Column() {
      this.header()
      Scroll() {
        Column({ space: 12 }) {
          this.rangeSelector()
          this.compareRow()
          this.dashboardGrid()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      this.notificationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.darkMode ? '#17202B' : BG)
  }

  @Builder
  header() {
    Row({ space: 8 }) {
      Blank()
        .width(40)
        .height(40)
        .borderRadius(11)
        .backgroundColor(PRIMARY)
      Text('Analytics')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.darkMode ? Color.White : INK)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.darkMode ? '#17202B' : Color.White)
  }

  @Builder
  rangeSelector() {
    Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row, justifyContent: FlexAlign.Start }) {
      ForEach(this.ranges, (range: string) => {
        Text(range)
          .fontSize(24)
          .fontColor(range === this.selectedRange ? Color.White : (this.darkMode ? Color.White : INK))
          .fontWeight(range === this.selectedRange ? FontWeight.Bold : FontWeight.Normal)
          .textAlign(TextAlign.Center)
          .height(64)
          .width(range === 'Today' ? 128 : range === '7 Days' ? 148 : range === '30 Days' ? 148 : range === '90 Days' ? 148 : range === 'YTD' ? 108 : 148)
          .margin({ right: 8, bottom: 12 })
          .padding({ top: 16, bottom: 16 })
          .borderRadius(15)
          .border({ width: 2, color: OUTLINE })
          .backgroundColor(range === this.selectedRange ? PRIMARY : (this.darkMode ? '#253140' : Color.White))
          .onClick(() => {
            this.selectedRange = range
          })
      }, (range: string) => range)
    }
    .width('100%')
  }

  @Builder
  compareRow() {
    Row({ space: 8 }) {
      Text('Compare')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.darkMode ? Color.White : INK)
        .margin({ right: 8 })
      this.compareButton('Prev Period', this.previousPeriod)
      this.compareButton('Goal', this.goal)
      Row({ space: 4 }) {
        Text('Dark')
          .fontSize(18)
          .fontColor(this.darkMode ? Color.White : INK)
        Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
          .width(78)
          .height(42)
          .selectedColor(PRIMARY)
          .onChange((value: boolean) => {
            this.darkMode = value
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(66)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  compareButton(label: string, active: boolean) {
    Text(label)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? '#071A12' : (this.darkMode ? Color.White : INK))
      .textAlign(TextAlign.Center)
      .width(label === 'Prev Period' ? 168 : 106)
      .height(62)
      .padding({ top: 18, bottom: 18 })
      .borderRadius(13)
      .border({ width: 2, color: OUTLINE })
      .backgroundColor(active ? GREEN : (this.darkMode ? '#253140' : Color.White))
      .onClick(() => {
        if (label === 'Prev Period') {
          this.previousPeriod = !this.previousPeriod
        } else {
          this.goal = !this.goal
        }
      })
  }

  @Builder
  dashboardGrid() {
    Grid() {
      ForEach(this.metrics, (metric: Metric) => {
        GridItem() {
          this.metricCard(metric)
        }
      }, (metric: Metric) => metric.title)
      ForEach(this.charts, (chart: Chart) => {
        GridItem() {
          this.chartCard(chart)
        }
      }, (chart: Chart) => chart.title)
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(16)
    .rowsGap(16)
    .width('100%')
  }

  @Builder
  metricCard(metric: Metric) {
    Column({ space: 8 }) {
      Row() {
        Text(metric.title)
          .fontSize(27)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.darkMode ? Color.White : INK)
        Blank()
          .layoutWeight(1)
        Blank()
          .width(32)
          .height(32)
          .borderRadius(11)
          .backgroundColor(metric.color)
      }
      .width('100%')
      Text(metric.value)
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.darkMode ? Color.White : INK)
        .alignSelf(ItemAlign.Start)
      Row({ space: 4 }) {
        Blank()
          .width(12)
          .height(12)
          .borderRadius(6)
          .backgroundColor(metric.delta.startsWith('+') ? GREEN : RED)
        Text(metric.delta)
          .fontSize(19)
          .fontColor(metric.delta.startsWith('+') ? '#149C48' : RED)
      }
      .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .height(238)
    .padding(16)
    .borderRadius(21)
    .border({ width: 2, color: OUTLINE })
    .backgroundColor(this.darkMode ? '#202C3A' : Color.White)
    .shadow({ radius: 5, color: '#25000000', offsetY: 2, offsetX: 0 })
  }

  @Builder
  chartCard(chart: Chart) {
    Column({ space: 12 }) {
      Text(chart.title)
        .fontSize(27)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.darkMode ? Color.White : INK)
        .alignSelf(ItemAlign.Start)
      Row({ space: 10 }) {
        Blank().width(7).height(40).borderRadius(4).backgroundColor(PRIMARY)
        Blank().width(7).height(30).borderRadius(4).backgroundColor(GREEN)
        Blank().width(7).height(48).borderRadius(4).backgroundColor(ORANGE)
        Blank().width(7).height(22).borderRadius(4).backgroundColor(OUTLINE)
        Blank().width(7).height(32).borderRadius(4).backgroundColor(PRIMARY)
        Blank().width(7).height(42).borderRadius(4).backgroundColor(GREEN)
      }
      .width('100%')
      .height(124)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(16)
      .backgroundColor(chart.tint)
      Row({ space: 8 }) {
        Blank().width(10).height(10).borderRadius(5).backgroundColor(PRIMARY)
        Text('Series A').fontSize(14).fontColor(this.darkMode ? Color.White : INK)
        Blank().width(10).height(10).borderRadius(5).backgroundColor(GREEN)
        Text('Series B').fontSize(14).fontColor(this.darkMode ? Color.White : INK)
      }
      .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .height(246)
    .padding(16)
    .borderRadius(21)
    .border({ width: 2, color: OUTLINE })
    .backgroundColor(this.darkMode ? '#202C3A' : Color.White)
    .shadow({ radius: 5, color: '#25000000', offsetY: 2, offsetX: 0 })
  }

  @Builder
  notificationBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Notifications')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.darkMode ? Color.White : INK)
        Text(`${this.pending} pending`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.darkMode ? Color.White : INK)
      }
      .alignItems(HorizontalAlign.Start)
      Blank().layoutWeight(1)
      Button() {
        Text('Mark All Read')
          .fontSize(20)
          .fontColor('#071A12')
          .fontWeight(FontWeight.Medium)
      }
        .width(280)
        .height(88)
        .borderRadius(26)
        .backgroundColor(GREEN)
        .onClick(() => {
          this.pending = 0
        })
    }
    .width('100%')
    .height(116)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.darkMode ? '#243443' : '#EAF8FE')
  }
}
