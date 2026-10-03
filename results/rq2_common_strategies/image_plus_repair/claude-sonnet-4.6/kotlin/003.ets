import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#0EA5E9'
const COLOR_SECONDARY = '#22C55E'
const COLOR_TERTIARY = '#F59E0B'
const COLOR_BACKGROUND = '#F7FAFC'
const COLOR_SURFACE = '#FFFFFF'
const COLOR_SURFACE_VARIANT = '#EFF3F7'
const COLOR_OUTLINE = '#D4D9E1'
const COLOR_SUCCESS = '#16A34A'
const COLOR_ERROR = '#EF4444'
const COLOR_ON_PRIMARY = '#FFFFFF'
const COLOR_ON_SECONDARY = '#0F172A'
const COLOR_ON_SURFACE = '#0B1220'

class MetricCardUi {
  id: number = 0
  title: string = ''
  value: string = ''
  delta: string = ''
  color: string = ''
}

class ChartCardUi {
  id: number = 0
  title: string = ''
  bgColor: string = ''
}

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State flags: string[] = []
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: COLOR_SECONDARY },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: COLOR_PRIMARY },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: COLOR_ERROR },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: COLOR_TERTIARY }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', bgColor: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', bgColor: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', bgColor: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', bgColor: '#FFFBEB' }
  ]

  hasPrevPeriod(): boolean {
    return this.flags.indexOf('Prev Period') >= 0
  }

  hasGoal(): boolean {
    return this.flags.indexOf('Goal') >= 0
  }

  toggleFlag(flag: string): void {
    const idx = this.flags.indexOf(flag)
    if (idx >= 0) {
      this.flags = this.flags.filter(f => f !== flag)
    } else {
      this.flags = [...this.flags, flag]
    }
  }

  @Builder
  TopBar() {
    Row() {
      Stack() {}
      .width(20)
      .height(20)
      .backgroundColor(COLOR_PRIMARY)
      .borderRadius(6)

      Text('Analytics')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ left: 4 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Text(`${this.notifCount} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Mark All Read')
        .height(44)
        .width(140)
        .backgroundColor(COLOR_SECONDARY)
        .fontColor(COLOR_ON_SECONDARY)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .onClick(() => {
          this.notifCount = 0
        })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
  }

  @Builder
  RangeChips() {
    Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
      ForEach(this.ranges, (r: string) => {
        Text(r)
          .fontSize(this.selectedRange === r ? 14 : 12)
          .fontWeight(this.selectedRange === r ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selectedRange === r ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(this.selectedRange === r ? COLOR_PRIMARY : COLOR_SURFACE)
          .borderRadius(8)
          .border({ width: 1, color: COLOR_OUTLINE })
          .margin({ right: 4, bottom: 4 })
          .onClick(() => {
            this.selectedRange = r
          })
      })
    }
    .width('100%')
  }

  @Builder
  CompareRow() {
    Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ right: 4, bottom: 4 })

      Text('Prev Period')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.hasPrevPeriod() ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .backgroundColor(this.hasPrevPeriod() ? COLOR_SECONDARY : COLOR_SURFACE)
        .borderRadius(6)
        .border({ width: 1, color: COLOR_OUTLINE })
        .margin({ right: 4, bottom: 4 })
        .onClick(() => {
          this.toggleFlag('Prev Period')
        })

      Text('Goal')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.hasGoal() ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .backgroundColor(this.hasGoal() ? COLOR_SECONDARY : COLOR_SURFACE)
        .borderRadius(6)
        .border({ width: 1, color: COLOR_OUTLINE })
        .margin({ right: 4, bottom: 4 })
        .onClick(() => {
          this.toggleFlag('Goal')
        })

      Row() {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ right: 2 })

        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .selectedColor(COLOR_PRIMARY)
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
          .height(24)
          .width(44)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 4 })
    }
    .width('100%')
  }

  @Builder
  MetricCard(m: MetricCardUi) {
    Column() {
      Row() {
        Text(m.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Stack() {}
        .width(16)
        .height(16)
        .backgroundColor(m.color)
        .borderRadius(6)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(m.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ top: 4 })

      Row() {
        Stack() {}
        .width(6)
        .height(6)
        .backgroundColor(m.delta.startsWith('+') ? COLOR_SUCCESS : COLOR_ERROR)
        .borderRadius(3)
        .margin({ right: 2 })

        Text(m.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(m.delta.startsWith('+') ? COLOR_SUCCESS : COLOR_ERROR)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .constraintSize({ minHeight: 120 })
  }

  @Builder
  ChartCard(c: ChartCardUi) {
    Column() {
      Text(c.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ bottom: 6 })

      Stack() {
        Row() {
          Stack() {}
          .width(6)
          .height(40)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(6)
          .margin({ right: 4 })

          Stack() {}
          .width(6)
          .height(30)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(6)
          .margin({ right: 4 })

          Stack() {}
          .width(6)
          .height(48)
          .backgroundColor(COLOR_TERTIARY)
          .borderRadius(6)
          .margin({ right: 4 })

          Stack() {}
          .width(6)
          .height(22)
          .backgroundColor(COLOR_OUTLINE)
          .borderRadius(6)
          .margin({ right: 4 })

          Stack() {}
          .width(6)
          .height(32)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(6)
          .margin({ right: 4 })

          Stack() {}
          .width(6)
          .height(42)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(6)
        }
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(80)
      .backgroundColor(c.bgColor)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row() {
        Stack() {}
        .width(8)
        .height(8)
        .backgroundColor(COLOR_PRIMARY)
        .borderRadius(4)
        .margin({ right: 4 })

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ right: 8 })

        Stack() {}
        .width(8)
        .height(8)
        .backgroundColor(COLOR_SECONDARY)
        .borderRadius(4)
        .margin({ right: 4 })

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .constraintSize({ minHeight: 180 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.RangeChips()

          Blank().height(6)

          this.CompareRow()

          Blank().height(8)

          Grid() {
            ForEach(this.kpis, (m: MetricCardUi) => {
              GridItem() {
                this.MetricCard(m)
              }
            })
            ForEach(this.charts, (c: ChartCardUi) => {
              GridItem() {
                this.ChartCard(c)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')
          .layoutDirection(GridDirection.Row)

          Blank().height(24)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}