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

class AppColors {
  static readonly primary: string = '#0EA5E9'
  static readonly secondary: string = '#22C55E'
  static readonly tertiary: string = '#F59E0B'
  static readonly background: string = '#F7FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EFF3F7'
  static readonly outline: string = '#D4D9E1'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#111827'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days'
  @State prevPeriod: boolean = false
  @State goal: boolean = false
  @State darkSwitch: boolean = false
  @State notif: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppColors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppColors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppColors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppColors.tertiary }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ]

  chipWidth(label: string): number {
    if (label === 'Today') {
      return 64
    }
    if (label === 'YTD') {
      return 54
    }
    return 74
  }

  @Builder
  HeaderBar() {
    Row({ space: AppSpacing.sm }) {
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(AppColors.primary)
        .borderRadius(6)

      Text('Analytics')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(30)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  RangeChip(label: string) {
    Text(label)
      .width(this.chipWidth(label))
      .height(32)
      .fontSize(this.selectedRange === label ? 14 : 12)
      .fontWeight(this.selectedRange === label ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.selectedRange === label ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.selectedRange === label ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .margin({ right: AppSpacing.sm, bottom: AppSpacing.lg })
      .onClick(() => {
        this.selectedRange = label
      })
  }

  @Builder
  AssistChip(label: string, active: boolean) {
    Text(label)
      .height(32)
      .padding({ left: 16, right: 16 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? AppColors.onSecondary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .backgroundColor(active ? AppColors.secondary : AppColors.surface)
      .borderRadius(6)
      .border({ width: 1, color: AppColors.outline })
      .margin({ right: AppSpacing.sm, bottom: AppSpacing.sm })
      .onClick(() => {
        if (label === 'Prev Period') {
          this.prevPeriod = !this.prevPeriod
        } else {
          this.goal = !this.goal
        }
      })
  }

  @Builder
  MetricCard(metric: MetricCardUi) {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(18)

        Blank()
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
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)

      Row({ space: AppSpacing.xs }) {
        Blank()
          .width(6)
          .height(6)
          .backgroundColor(metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .borderRadius(6)

        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .lineHeight(14)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  Bar(color: string, heightValue: number) {
    Blank()
      .width(6)
      .height(heightValue)
      .backgroundColor(color)
      .borderRadius(6)
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column({ space: AppSpacing.md }) {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(18)

      Stack({ alignContent: Alignment.Center }) {
        Row({ space: AppSpacing.sm }) {
          this.Bar(AppColors.primary, 40)
          this.Bar(AppColors.secondary, 30)
          this.Bar(AppColors.tertiary, 48)
          this.Bar(AppColors.outline, 22)
          this.Bar(AppColors.primary, 32)
          this.Bar(AppColors.secondary, 42)
        }
        .height(72)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(96)
      .backgroundColor(chart.color)
      .borderRadius(8)

      Row({ space: AppSpacing.sm }) {
        Blank()
          .width(8)
          .height(8)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()
          .width(8)
          .height(8)
          .backgroundColor(AppColors.secondary)
          .borderRadius(6)

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(180)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  DashboardContent() {
    Column() {
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
        justifyContent: FlexAlign.Start,
        alignItems: ItemAlign.Start
      }) {
        ForEach(this.ranges, (range: string) => {
          this.RangeChip(range)
        }, (range: string) => range)
      }
      .width('100%')

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
          .lineHeight(14)
          .margin({ right: AppSpacing.sm, bottom: AppSpacing.sm })

        this.AssistChip('Prev Period', this.prevPeriod)
        this.AssistChip('Goal', this.goal)

        Row({ space: AppSpacing.xs }) {
          Text('Dark')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Switch({ type: SwitchType.Toggle, isOn: this.darkSwitch })
            .selectedColor(AppColors.primary)
            .switchPointColor(AppColors.onPrimary)
            .onChange((isOn: boolean) => {
              this.darkSwitch = isOn
            })
        }
        .height(34)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: AppSpacing.sm })
      }
      .width('100%')

      Column({ space: AppSpacing.lg }) {
        Row({ space: AppSpacing.lg }) {
          Column() {
            this.MetricCard(this.kpis[0])
          }
          .layoutWeight(1)

          Column() {
            this.MetricCard(this.kpis[1])
          }
          .layoutWeight(1)
        }
        .width('100%')

        Row({ space: AppSpacing.lg }) {
          Column() {
            this.MetricCard(this.kpis[2])
          }
          .layoutWeight(1)

          Column() {
            this.MetricCard(this.kpis[3])
          }
          .layoutWeight(1)
        }
        .width('100%')

        Row({ space: AppSpacing.lg }) {
          Column() {
            this.ChartCard(this.charts[0])
          }
          .layoutWeight(1)

          Column() {
            this.ChartCard(this.charts[1])
          }
          .layoutWeight(1)
        }
        .width('100%')

        Row({ space: AppSpacing.lg }) {
          Column() {
            this.ChartCard(this.charts[2])
          }
          .layoutWeight(1)

          Column() {
            this.ChartCard(this.charts[3])
          }
          .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .margin({ top: AppSpacing.lg, bottom: AppSpacing.xxxl })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(14)

        Text(`${this.notif} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(24)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(140)
      .height(44)
      .borderRadius(12)
      .backgroundColor(AppColors.secondary)
      .onClick(() => {
        this.notif = 0
      })
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#22000000', offsetX: 0, offsetY: -1 })
  }

  build() {
    Column() {
      this.HeaderBar()

      Scroll() {
        this.DashboardContent()
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}