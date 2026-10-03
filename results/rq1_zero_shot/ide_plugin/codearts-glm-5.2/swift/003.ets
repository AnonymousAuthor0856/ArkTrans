class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF22C55E',
    tertiary: '#FFF59E0B',
    background: '#FFF7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEFF3F7',
    outline: '#FFD4D9E1',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FF111827',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
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

@Entry
@Component
struct ContentView {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: string[] = []
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ]

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#FFE0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#FFEFF6FF')
  ]

  private toggleFlag(flag: string) {
    let index = this.selectedFlags.indexOf(flag)
    if (index >= 0) {
      this.selectedFlags.splice(index, 1)
    } else {
      this.selectedFlags.push(flag)
    }
  }

  private isFlagSelected(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0
  }

  build() {
    Column() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(4)
          .backgroundColor(AppTokens.Colors.primary)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 4 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 48, bottom: 12 })
      .backgroundColor(AppTokens.Colors.background)

      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1)

      Scroll() {
        Column() {
          Scroll() {
            Row() {
              ForEach(this.ranges, (range: string) => {
                Text(range)
                  .fontSize(this.selectedRange === range ? 14 : 12)
                  .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .borderRadius(8)
                  .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .margin({ right: 4 })
                  .onClick(() => {
                    this.selectedRange = range
                  })
              })
              ForEach(this.ranges2, (range: string) => {
                Text(range)
                  .fontSize(this.selectedRange === range ? 14 : 12)
                  .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .borderRadius(8)
                  .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .margin({ right: 4 })
                  .onClick(() => {
                    this.selectedRange = range
                  })
              })
            }
            .padding({ top: 4, bottom: 4 })
          }
          .scrollDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)

          Row() {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)

            ForEach(this.flags, (flag: string) => {
              Text(flag)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isFlagSelected(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .borderRadius(6)
                .backgroundColor(this.isFlagSelected(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .margin({ left: 4 })
                .onClick(() => {
                  this.toggleFlag(flag)
                })
            })

            Row() {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.darkMode = isOn
                })
            }
            .alignItems(VerticalAlign.Center)
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 6, bottom: 6 })

          Row() {
            MetricCardView({
              title: this.kpis[0].title,
              value: this.kpis[0].value,
              delta: this.kpis[0].delta,
              color: this.kpis[0].color
            })
              .layoutWeight(1)
            MetricCardView({
              title: this.kpis[1].title,
              value: this.kpis[1].value,
              delta: this.kpis[1].delta,
              color: this.kpis[1].color
            })
              .layoutWeight(1)
              .margin({ left: 8 })
          }
          .width('100%')

          Row() {
            MetricCardView({
              title: this.kpis[2].title,
              value: this.kpis[2].value,
              delta: this.kpis[2].delta,
              color: this.kpis[2].color
            })
              .layoutWeight(1)
            MetricCardView({
              title: this.kpis[3].title,
              value: this.kpis[3].value,
              delta: this.kpis[3].delta,
              color: this.kpis[3].color
            })
              .layoutWeight(1)
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 8 })

          Row() {
            ChartCardView({
              title: this.charts[0].title,
              color: this.charts[0].color
            })
              .layoutWeight(1)
            ChartCardView({
              title: this.charts[1].title,
              color: this.charts[1].color
            })
              .layoutWeight(1)
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 8 })

          Column()
            .height(80)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)

        Row() {
          Column() {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('Mark All Read')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(140)
            .height(44)
            .textAlign(TextAlign.Center)
            .borderRadius(12)
            .backgroundColor(AppTokens.Colors.secondary)
            .onClick(() => {
              this.notificationCount = 0
            })
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MetricCardView {
  @Prop title: string
  @Prop value: string
  @Prop delta: string
  @Prop color: string

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
        Row()
          .width(16)
          .height(16)
          .borderRadius(4)
          .backgroundColor(this.color)
      }
      .width('100%')

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 4 })

      Row() {
        Row()
          .width(6)
          .height(6)
          .borderRadius(2)
          .backgroundColor(this.delta.charAt(0) === '+' ? AppTokens.Colors.success : AppTokens.Colors.error)
        Text(this.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.delta.charAt(0) === '+' ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ left: 2 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .height(120)
    .padding(8)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ChartCardView {
  @Prop title: string
  @Prop color: string

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Row() {
        Row() {
          Column().width(6).height(40).borderRadius(2).backgroundColor(AppTokens.Colors.primary)
          Column().width(6).height(30).borderRadius(2).backgroundColor(AppTokens.Colors.secondary).margin({ left: 4 })
          Column().width(6).height(48).borderRadius(2).backgroundColor(AppTokens.Colors.tertiary).margin({ left: 4 })
          Column().width(6).height(22).borderRadius(2).backgroundColor(AppTokens.Colors.outline).margin({ left: 4 })
          Column().width(6).height(32).borderRadius(2).backgroundColor(AppTokens.Colors.primary).margin({ left: 4 })
          Column().width(6).height(42).borderRadius(2).backgroundColor(AppTokens.Colors.secondary).margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(80)
      .borderRadius(8)
      .backgroundColor(this.color)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })

      Row() {
        Row().width(8).height(8).borderRadius(2).backgroundColor(AppTokens.Colors.primary)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 4 })
        Row().width(8).height(8).borderRadius(2).backgroundColor(AppTokens.Colors.secondary).margin({ left: 4 })
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .height(180)
    .padding(8)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
  }
}