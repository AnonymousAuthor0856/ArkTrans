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

const Colors = {
  primary: '#0EA5E9',
  secondary: '#22C55E',
  tertiary: '#F59E0B',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#EFF3F7',
  outline: '#D4D9E1',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#111827',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
}

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
}

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State flags: string[] = []
  @State darkSwitch: boolean = false
  @State notif: number = 2
  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']
  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: Colors.tertiary }
  ]
  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ]

  toggleFlag(label: string): void {
    const i = this.flags.indexOf(label)
    if (i >= 0) {
      this.flags.splice(i, 1)
    } else {
      this.flags.push(label)
    }
  }

  build() {
    Column() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(Colors.primary)
          .borderRadius(6)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
          ForEach(this.ranges, (r: string) => {
            Button(r)
              .fontSize(this.selectedRange === r ? 14 : 12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedRange === r ? Colors.onPrimary : Colors.onSurface)
              .backgroundColor(this.selectedRange === r ? Colors.primary : Colors.surface)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .height(36)
              .margin({ right: Spacing.sm, bottom: Spacing.xs })
              .padding({ left: Spacing.xl, right: Spacing.xl })
              .onClick(() => { this.selectedRange = r })
          }, (r: string) => r)
        }
        .width('100%')

        Blank().height(Spacing.md)

        Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
          Text('Compare')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .margin({ right: Spacing.sm })
          Button('Prev Period')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.flags.indexOf('Prev Period') >= 0 ? Colors.onSecondary : Colors.onSurface)
            .backgroundColor(this.flags.indexOf('Prev Period') >= 0 ? Colors.secondary : Colors.surface)
            .borderRadius(6)
            .border({ width: 1, color: Colors.outline })
            .height(32)
            .margin({ right: Spacing.sm, bottom: Spacing.xs })
            .onClick(() => { this.toggleFlag('Prev Period') })
          Button('Goal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.flags.indexOf('Goal') >= 0 ? Colors.onSecondary : Colors.onSurface)
            .backgroundColor(this.flags.indexOf('Goal') >= 0 ? Colors.secondary : Colors.surface)
            .borderRadius(6)
            .border({ width: 1, color: Colors.outline })
            .height(32)
            .margin({ right: Spacing.sm, bottom: Spacing.xs })
            .onClick(() => { this.toggleFlag('Goal') })
          Row({ space: Spacing.xs }) {
            Text('Dark')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
              .selectedColor(Colors.primary)
              .onChange((isOn: boolean) => { this.darkSwitch = isOn })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Blank().height(Spacing.lg)

        Grid() {
          ForEach(this.kpis, (m: MetricCardUi) => {
            Column({ space: Spacing.sm }) {
              Row() {
                Text(m.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Blank()
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
                .fontColor(Colors.onSurface)

              Row({ space: Spacing.xs }) {
                Blank()
                  .width(6)
                  .height(6)
                  .backgroundColor(m.delta.startsWith('+') ? Colors.success : Colors.error)
                  .borderRadius(6)
                Text(m.delta)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(m.delta.startsWith('+') ? Colors.success : Colors.error)
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(HorizontalAlign.Start)
          }, (m: MetricCardUi) => 'k' + m.id.toString())

          ForEach(this.charts, (c: ChartCardUi) => {
            Column({ space: Spacing.md }) {
              Text(c.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Stack() {
                Row({ space: Spacing.sm }) {
                  Blank().width(6).height(40).backgroundColor(Colors.primary).borderRadius(6)
                  Blank().width(6).height(30).backgroundColor(Colors.secondary).borderRadius(6)
                  Blank().width(6).height(48).backgroundColor(Colors.tertiary).borderRadius(6)
                  Blank().width(6).height(22).backgroundColor(Colors.outline).borderRadius(6)
                  Blank().width(6).height(32).backgroundColor(Colors.primary).borderRadius(6)
                  Blank().width(6).height(42).backgroundColor(Colors.secondary).borderRadius(6)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .aspectRatio(1.6)
              .backgroundColor(c.color)
              .borderRadius(8)

              Row({ space: Spacing.sm }) {
                Blank().width(8).height(8).backgroundColor(Colors.primary).borderRadius(6)
                Text('Series A')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Blank().width(8).height(8).backgroundColor(Colors.secondary).borderRadius(6)
                Text('Series B')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(HorizontalAlign.Start)
          }, (c: ChartCardUi) => 'c' + c.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.lg)
        .rowsGap(Spacing.lg)
        .layoutWeight(1)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(this.notif + ' pending')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
          .height(44)
          .width(140)
          .onClick(() => { this.notif = 0 })
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
