const NAME: string = '006_DashboardAnalytics_en'
const UI_TYPE: string = 'Dashboard Analytics'
const STYLE_THEME: string = 'Corporate Dashboard'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

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

const AppRadius = {
  small: 6,
  medium: 8,
  large: 12
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

@Entry
@Component
struct DashboardAnalyticsPage {
  @State selectedRange: string = '7 Days'
  @State flags: string[] = []
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

  private hasFlag(name: string): boolean {
    return this.flags.indexOf(name) >= 0
  }

  private toggleFlag(name: string): void {
    if (this.hasFlag(name)) {
      this.flags = this.flags.filter((item: string) => item !== name)
    } else {
      this.flags = [...this.flags, name]
    }
  }

  @Builder
  private TopBar() {
    Row() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.small)

        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .lineHeight(30)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private BottomBar() {
    Row() {
      Column() {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onSurface)

        Text(`${this.notif} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .lineHeight(24)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Mark All Read', { type: ButtonType.Normal })
        .width(140)
        .height(44)
        .borderRadius(AppRadius.large)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.notif = 0
        })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 6,
      color: '#29000000',
      offsetX: 0,
      offsetY: -2
    })
  }

  @Builder
  private FilterChip(label: string) {
    Row() {
      Text(label)
        .fontSize(this.selectedRange === label ? 14 : 12)
        .fontWeight(this.selectedRange === label ? FontWeight.Medium : FontWeight.Regular)
        .lineHeight(this.selectedRange === label ? 18 : 16)
        .fontColor(this.selectedRange === label ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(32)
    .padding({ left: 12, right: 12 })
    .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.selectedRange === label ? AppColors.primary : AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selectedRange = label
    })
  }

  @Builder
  private AssistChip(label: string) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .lineHeight(14)
        .fontColor(this.hasFlag(label) ? AppColors.onSecondary : AppColors.onSurface)
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.hasFlag(label) ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppRadius.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.toggleFlag(label)
    })
  }

  @Builder
  private CompareControls() {
    Flex({ wrap: FlexWrap.Wrap }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .lineHeight(14)
        .fontColor(AppColors.onSurface)
        .margin({ right: AppSpacing.sm, top: 8, bottom: AppSpacing.xs })

      this.AssistChip('Prev Period')
      this.AssistChip('Goal')

      Row() {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onSurface)

        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .selectedColor(AppColors.primary)
          .switchPointColor(AppColors.onPrimary)
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
      }
      .height(30)
      .alignItems(VerticalAlign.Center)
      .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
    }
    .width('100%')
  }

  @Builder
  private MetricCard(metric: MetricCardUi) {
    Column() {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.onSurface)

        Blank()
          .width(16)
          .height(16)
          .backgroundColor(metric.color)
          .borderRadius(AppRadius.small)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .lineHeight(24)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })

      Row() {
        Blank()
          .width(6)
          .height(6)
          .backgroundColor(metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .borderRadius(AppRadius.small)

        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: '#24000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  private ChartCard(chart: ChartCardUi) {
    Column() {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .lineHeight(18)
        .fontColor(AppColors.onSurface)

      Stack() {
        Row() {
          Blank()
            .width(6)
            .height(40)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppRadius.small)
            .margin({ right: AppSpacing.sm })

          Blank()
            .width(6)
            .height(30)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppRadius.small)
            .margin({ right: AppSpacing.sm })

          Blank()
            .width(6)
            .height(48)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppRadius.small)
            .margin({ right: AppSpacing.sm })

          Blank()
            .width(6)
            .height(22)
            .backgroundColor(AppColors.outline)
            .borderRadius(AppRadius.small)
            .margin({ right: AppSpacing.sm })

          Blank()
            .width(6)
            .height(32)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppRadius.small)
            .margin({ right: AppSpacing.sm })

          Blank()
            .width(6)
            .height(42)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppRadius.small)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .aspectRatio(1.6)
      .alignContent(Alignment.Center)
      .backgroundColor(chart.color)
      .borderRadius(AppRadius.medium)
      .margin({ top: AppSpacing.md })

      Row() {
        Blank()
          .width(8)
          .height(8)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.small)

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onSurface)
          .margin({ right: AppSpacing.sm })

        Blank()
          .width(8)
          .height(8)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppRadius.small)

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .lineHeight(14)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: '#24000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.ranges, (range: string) => {
            this.FilterChip(range)
          }, (range: string) => range)
        }
        .width('100%')

        Blank()
          .height(AppSpacing.md)

        this.CompareControls()

        Blank()
          .height(AppSpacing.lg)

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
        .columnsGap(AppSpacing.lg)
        .rowsGap(AppSpacing.lg)
        .padding({ bottom: AppSpacing.xxxl })
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: 0
      })
      .alignItems(HorizontalAlign.Start)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}