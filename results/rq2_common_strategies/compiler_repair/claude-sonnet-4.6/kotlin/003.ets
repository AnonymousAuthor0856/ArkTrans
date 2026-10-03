// Index.ets
import { router } from '@kit.ArkUI'

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

interface MetricCardData {
  id: number
  title: string
  value: string
  delta: string
  color: string
}

interface ChartCardData {
  id: number
  title: string
  bgColor: string
}

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State prevPeriodActive: boolean = false
  @State goalActive: boolean = false
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private kpis: MetricCardData[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: COLOR_SECONDARY },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: COLOR_PRIMARY },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: COLOR_ERROR },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: COLOR_TERTIARY }
  ]

  private charts: ChartCardData[] = [
    { id: 1, title: 'Sales Trend', bgColor: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', bgColor: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', bgColor: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', bgColor: '#FFFBEB' }
  ]

  @Builder
  MetricCard(m: MetricCardData) {
    Column({ space: 4 }) {
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

      Row({ space: 2 }) {
        Stack() {}
          .width(6)
          .height(6)
          .backgroundColor(m.delta.startsWith('+') ? COLOR_SUCCESS : COLOR_ERROR)
          .borderRadius(3)
        Text(m.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(m.delta.startsWith('+') ? COLOR_SUCCESS : COLOR_ERROR)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
    .constraintSize({ minHeight: 120 })
  }

  @Builder
  ChartCard(c: ChartCardData) {
    Column({ space: 6 }) {
      Text(c.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)

      Stack({ alignContent: Alignment.Center }) {
        Row({ space: 4 }) {
          Stack() {}
            .width(6)
            .height(40)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(3)
          Stack() {}
            .width(6)
            .height(30)
            .backgroundColor(COLOR_SECONDARY)
            .borderRadius(3)
          Stack() {}
            .width(6)
            .height(48)
            .backgroundColor(COLOR_TERTIARY)
            .borderRadius(3)
          Stack() {}
            .width(6)
            .height(22)
            .backgroundColor(COLOR_OUTLINE)
            .borderRadius(3)
          Stack() {}
            .width(6)
            .height(32)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(3)
          Stack() {}
            .width(6)
            .height(42)
            .backgroundColor(COLOR_SECONDARY)
            .borderRadius(3)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(80)
      .backgroundColor(c.bgColor)
      .borderRadius(8)

      Row({ space: 4 }) {
        Stack() {}
          .width(8)
          .height(8)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(4)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Stack() {}
          .width(8)
          .height(8)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(4)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
    .constraintSize({ minHeight: 180 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Stack() {}
            .width(20)
            .height(20)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(6)
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .padding({ left: 16, right: 16 })

      // Main content
      Scroll() {
        Column({ space: 0 }) {
          // Range filter chips
          Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
            ForEach(this.ranges, (r: string) => {
              Text(r)
                .fontSize(this.selectedRange === r ? 14 : 12)
                .fontWeight(this.selectedRange === r ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.selectedRange === r ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
                .backgroundColor(this.selectedRange === r ? COLOR_PRIMARY : COLOR_SURFACE)
                .borderRadius(8)
                .border({ width: 1, color: COLOR_OUTLINE })
                .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                .margin({ right: 4, bottom: 4 })
                .onClick(() => {
                  this.selectedRange = r
                })
            })
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6 })

          // Compare row
          Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)
              .margin({ right: 4, bottom: 4 })

            Text('Prev Period')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.prevPeriodActive ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
              .backgroundColor(this.prevPeriodActive ? COLOR_SECONDARY : COLOR_SURFACE)
              .borderRadius(6)
              .border({ width: 1, color: COLOR_OUTLINE })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .margin({ right: 4, bottom: 4 })
              .onClick(() => {
                this.prevPeriodActive = !this.prevPeriodActive
              })

            Text('Goal')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.goalActive ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
              .backgroundColor(this.goalActive ? COLOR_SECONDARY : COLOR_SURFACE)
              .borderRadius(6)
              .border({ width: 1, color: COLOR_OUTLINE })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .margin({ right: 4, bottom: 4 })
              .onClick(() => {
                this.goalActive = !this.goalActive
              })

            Row({ space: 2 }) {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .selectedColor(COLOR_PRIMARY)
                .switchPointColor(COLOR_ON_PRIMARY)
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn
                })
                .width(40)
                .height(22)
            }
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 4 })
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 4 })

          // KPI Grid
          Grid() {
            ForEach(this.kpis, (m: MetricCardData) => {
              GridItem() {
                this.MetricCard(m)
              }
            })
            ForEach(this.charts, (c: ChartCardData) => {
              GridItem() {
                this.ChartCard(c)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding({ left: 8, right: 8, top: 8, bottom: 24 })
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(COLOR_BACKGROUND)
      .scrollBar(BarState.Off)

      // Bottom bar
      Row() {
        Column({ space: 2 }) {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text(`${this.notifCount} pending`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {
            this.notifCount = 0
          })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}