const AppColors = {
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

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
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

@Component
struct MetricCard {
  private metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' }

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Column()
          .width(16)
          .height(16)
          .backgroundColor(this.metric.color)
          .borderRadius(4)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.xs }) {
        Column()
          .width(6)
          .height(6)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .borderRadius(2)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }
}

@Component
struct ChartCard {
  private chart: ChartCardUi = { id: 0, title: '', color: '' }

  build() {
    Column({ space: AppSpacing.md }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        Column().width(6).height(40).backgroundColor(AppColors.primary).borderRadius(2)
        Column().width(6).height(30).backgroundColor(AppColors.secondary).borderRadius(2)
        Column().width(6).height(48).backgroundColor(AppColors.tertiary).borderRadius(2)
        Column().width(6).height(22).backgroundColor(AppColors.outline).borderRadius(2)
        Column().width(6).height(32).backgroundColor(AppColors.primary).borderRadius(2)
        Column().width(6).height(42).backgroundColor(AppColors.secondary).borderRadius(2)
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(this.chart.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Row({ space: AppSpacing.sm }) {
        Column().width(8).height(8).backgroundColor(AppColors.primary).borderRadius(2)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Column().width(8).height(8).backgroundColor(AppColors.secondary).borderRadius(2)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }
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
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: '#22C55E' },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: '#0EA5E9' },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: '#EF4444' },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: '#F59E0B' }
  ]
  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ]

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(4)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        this.RangeChips()

        Blank().height(AppSpacing.md)

        this.CompareRow()

        Blank().height(AppSpacing.lg)

        Grid() {
          ForEach(this.kpis, (m: MetricCardUi) => {
            GridItem() {
              MetricCard({ metric: m })
            }
          }, (m: MetricCardUi) => m.id.toString())

          ForEach(this.charts, (c: ChartCardUi) => {
            GridItem() {
              ChartCard({ chart: c })
            }
          }, (c: ChartCardUi) => c.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.lg)
        .rowsGap(AppSpacing.lg)
        .padding({ bottom: AppSpacing.xxxl })
        .width('100%')
        .layoutWeight(1)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .layoutWeight(1)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  RangeChips() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.Wrap,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      ForEach(this.ranges, (r: string) => {
        Text(r)
          .fontSize(r === this.selectedRange ? 14 : 12)
          .fontWeight(r === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(r === this.selectedRange ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(r === this.selectedRange ? AppColors.primary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 8 })
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
          .onClick(() => {
            this.selectedRange = r
          })
      }, (r: string) => r)
    }
    .width('100%')
  }

  @Builder
  CompareRow() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.Wrap,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })

      Text('Prev Period')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.flags.includes('Prev Period') ? AppColors.onSecondary : AppColors.onSurface)
        .backgroundColor(this.flags.includes('Prev Period') ? AppColors.secondary : AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: 4 })
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
        .onClick(() => {
          const idx = this.flags.indexOf('Prev Period')
          if (idx >= 0) {
            this.flags.splice(idx, 1)
          } else {
            this.flags.push('Prev Period')
          }
        })

      Text('Goal')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.flags.includes('Goal') ? AppColors.onSecondary : AppColors.onSurface)
        .backgroundColor(this.flags.includes('Goal') ? AppColors.secondary : AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: 4 })
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
        .onClick(() => {
          const idx = this.flags.indexOf('Goal')
          if (idx >= 0) {
            this.flags.splice(idx, 1)
          } else {
            this.flags.push('Goal')
          }
        })

      Row({ space: AppSpacing.xs }) {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .selectedColor(AppColors.primary)
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.xs })
    }
    .width('100%')
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`${this.notif} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Mark All Read')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .height(44)
        .width(140)
        .onClick(() => {
          this.notif = 0
        })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}