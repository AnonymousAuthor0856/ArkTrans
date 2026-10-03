@Entry
@Component
struct DashboardAnalytics {
  @State selectedRange: string = '7 Days'
  @State flags: string[] = []
  @State darkSwitch: boolean = false
  @State notif: number = 2

  private readonly ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private readonly kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: '#22C55E' },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: '#0EA5E9' },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: '#EF4444' },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: '#F59E0B' }
  ]

  private readonly charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ]

  private readonly primaryColor: string = '#0EA5E9'
  private readonly secondaryColor: string = '#22C55E'
  private readonly tertiaryColor: string = '#F59E0B'
  private readonly backgroundColor: string = '#F7FAFC'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly outlineColor: string = '#D4D9E1'
  private readonly successColor: string = '#16A34A'
  private readonly errorColor: string = '#EF4444'
  private readonly onSurfaceColor: string = '#0B1220'
  private readonly onPrimaryColor: string = '#FFFFFF'
  private readonly onSecondaryColor: string = '#0F172A'

  @Builder
  TopBar() {
    Row() {
      Row({ space: 4 }) {
        Box()
          .width(20)
          .height(20)
          .backgroundColor(this.primaryColor)
          .borderRadius(6)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
      }
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.surfaceColor)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
        Text(`${this.notif} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSecondaryColor)
      }
      .width(140)
      .height(44)
      .backgroundColor(this.secondaryColor)
      .borderRadius(12)
      .onClick(() => {
        this.notif = 0
      })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.surfaceColor)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }

  @Builder
  RangeChip(label: string, active: boolean) {
    Row() {
      Text(label)
        .fontSize(active ? 14 : 12)
        .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(active ? this.onPrimaryColor : this.onSurfaceColor)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .backgroundColor(active ? this.primaryColor : this.surfaceColor)
    .borderRadius(8)
    .border({ width: 1, color: this.outlineColor })
    .onClick(() => {
      this.selectedRange = label
    })
  }

  @Builder
  AssistChipView(label: string, active: boolean, onToggle: () => void) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? this.onSecondaryColor : this.onSurfaceColor)
    }
    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    .backgroundColor(active ? this.secondaryColor : this.surfaceColor)
    .borderRadius(6)
    .border({ width: 1, color: this.outlineColor })
    .onClick(onToggle)
  }

  @Builder
  MetricCard(metric: MetricCardUi) {
    Column({ space: 4 }) {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
        Box()
          .width(16)
          .height(16)
          .backgroundColor(metric.color)
          .borderRadius(6)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)

      Row({ space: 2 }) {
        Box()
          .width(6)
          .height(6)
          .backgroundColor(metric.delta.startsWith('+') ? this.successColor : this.errorColor)
          .borderRadius(6)
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? this.successColor : this.errorColor)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.surfaceColor)
    .borderRadius(12)
    .border({ width: 1, color: this.outlineColor })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column({ space: 6 }) {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)

      Column() {
        Row({ space: 4 }) {
          Box().width(6).height(40).backgroundColor(this.primaryColor).borderRadius(6)
          Box().width(6).height(30).backgroundColor(this.secondaryColor).borderRadius(6)
          Box().width(6).height(48).backgroundColor(this.tertiaryColor).borderRadius(6)
          Box().width(6).height(22).backgroundColor(this.outlineColor).borderRadius(6)
          Box().width(6).height(32).backgroundColor(this.primaryColor).borderRadius(6)
          Box().width(6).height(42).backgroundColor(this.secondaryColor).borderRadius(6)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(chart.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Row({ space: 4 }) {
        Box().width(8).height(8).backgroundColor(this.primaryColor).borderRadius(6)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
        Box().width(8).height(8).backgroundColor(this.secondaryColor).borderRadius(6)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.surfaceColor)
    .borderRadius(12)
    .border({ width: 1, color: this.outlineColor })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 6 }) {
          // Range chips
          Flex({ wrap: FlexWrap.Wrap, space: { main: 4, cross: 2 } }) {
            ForEach(this.ranges, (range: string) => {
              this.RangeChip(range, range === this.selectedRange)
            })
          }
          .width('100%')

          // Compare chips and dark switch
          Flex({ wrap: FlexWrap.Wrap, space: { main: 4, cross: 2 } }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceColor)

            this.AssistChipView('Prev Period', this.flags.includes('Prev Period'), () => {
              if (this.flags.includes('Prev Period')) {
                this.flags = this.flags.filter(f => f !== 'Prev Period')
              } else {
                this.flags = [...this.flags, 'Prev Period']
              }
            })

            this.AssistChipView('Goal', this.flags.includes('Goal'), () => {
              if (this.flags.includes('Goal')) {
                this.flags = this.flags.filter(f => f !== 'Goal')
              } else {
                this.flags = [...this.flags, 'Goal']
              }
            })

            Row({ space: 2 }) {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurfaceColor)
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .selectedColor(this.primaryColor)
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // KPI Grid
          Grid() {
            GridItem() {
              this.MetricCard(this.kpis[0])
            }
            GridItem() {
              this.MetricCard(this.kpis[1])
            }
            GridItem() {
              this.MetricCard(this.kpis[2])
            }
            GridItem() {
              this.MetricCard(this.kpis[3])
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')

          // Chart Grid
          Grid() {
            GridItem() {
              this.ChartCard(this.charts[0])
            }
            GridItem() {
              this.ChartCard(this.charts[1])
            }
            GridItem() {
              this.ChartCard(this.charts[2])
            }
            GridItem() {
              this.ChartCard(this.charts[3])
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
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