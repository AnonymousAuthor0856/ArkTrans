// Dashboard Analytics - Corporate Dashboard style
// Converted from Kotlin Compose to ArkTS

class AppTokens {
  static class Colors {
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

  static class Spacing {
    static readonly xs: number = 2
    static readonly sm: number = 4
    static readonly md: number = 6
    static readonly lg: number = 8
    static readonly xl: number = 12
    static readonly xxl: number = 16
    static readonly xxxl: number = 24
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
struct AnalyticsDashboard {
  @State selectedRange: string = '7 Days'
  @State prevPeriodFlag: boolean = false
  @State goalFlag: boolean = false
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private readonly ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']

  private readonly kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ]

  private readonly charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
  ]

  build() {
    Column() {
      // Top App Bar
      this.TopBar()

      // Content
      Scroll() {
        Column() {
          // Range filter chips
          this.RangeChips()

          // Compare section
          this.CompareSection()

          // KPI Cards Grid
          Grid() {
            ForEach(this.kpis, (item: MetricCardUi) => {
              GridItem() {
                this.MetricCard(item)
              }
            }, (item: MetricCardUi) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.lg)
          .columnsGap(AppTokens.Spacing.lg)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Chart Cards Grid
          Grid() {
            ForEach(this.charts, (item: ChartCardUi) => {
              GridItem() {
                this.ChartCard(item)
              }
            }, (item: ChartCardUi) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.lg)
          .columnsGap(AppTokens.Spacing.lg)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xxxl })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Rect()
          .width(20)
          .height(20)
          .fill(AppTokens.Colors.primary)
          .radius(6)

        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
  }

  @Builder
  RangeChips() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
      ForEach(this.ranges, (range: string) => {
        this.RangeChip(range, range === this.selectedRange)
      }, (range: string) => range)
    }
    .width('100%')
    .margin({ bottom: AppTokens.Spacing.md })
  }

  @Builder
  RangeChip(label: string, active: boolean) {
    Text(label)
      .fontSize(active ? 14 : 12)
      .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(active ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.xl,
        right: AppTokens.Spacing.xl,
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.lg
      })
      .backgroundColor(active ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(8)
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
      .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
      .onClick(() => {
        this.selectedRange = label
      })
  }

  @Builder
  CompareSection() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ right: AppTokens.Spacing.sm })

      this.AssistChip('Prev Period', this.prevPeriodFlag)
        .margin({ right: AppTokens.Spacing.sm })
        .onClick(() => {
          this.prevPeriodFlag = !this.prevPeriodFlag
        })

      this.AssistChip('Goal', this.goalFlag)
        .margin({ right: AppTokens.Spacing.sm })
        .onClick(() => {
          this.goalFlag = !this.goalFlag
        })

      Row() {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.xs })

        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .margin({ bottom: AppTokens.Spacing.lg })
  }

  @Builder
  AssistChip(label: string, active: boolean) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.xl,
        right: AppTokens.Spacing.xl,
        top: AppTokens.Spacing.md + 2,
        bottom: AppTokens.Spacing.md + 2
      })
      .backgroundColor(active ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(6)
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
  }

  @Builder
  MetricCard(item: MetricCardUi) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        Rect()
          .width(16)
          .height(16)
          .fill(item.color)
          .radius(4)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(item.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Circle({ width: 6, height: 6 })
          .fill(item.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ right: AppTokens.Spacing.xs })

        Text(item.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(item.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.14)',
      offsetY: 1
    })
  }

  @Builder
  ChartCard(item: ChartCardUi) {
    Column() {
      Text(item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      // Chart placeholder with bars
      Stack() {
        Row() {
          Rect()
            .width(6)
            .height(40)
            .fill(AppTokens.Colors.primary)
            .radius(2)
            .margin({ right: AppTokens.Spacing.sm })

          Rect()
            .width(6)
            .height(30)
            .fill(AppTokens.Colors.secondary)
            .radius(2)
            .margin({ right: AppTokens.Spacing.sm })

          Rect()
            .width(6)
            .height(48)
            .fill(AppTokens.Colors.tertiary)
            .radius(2)
            .margin({ right: AppTokens.Spacing.sm })

          Rect()
            .width(6)
            .height(22)
            .fill(AppTokens.Colors.outline)
            .radius(2)
            .margin({ right: AppTokens.Spacing.sm })

          Rect()
            .width(6)
            .height(32)
            .fill(AppTokens.Colors.primary)
            .radius(2)
            .margin({ right: AppTokens.Spacing.sm })

          Rect()
            .width(6)
            .height(42)
            .fill(AppTokens.Colors.secondary)
            .radius(2)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(100)
      .backgroundColor(item.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)
      .margin({ top: AppTokens.Spacing.md })

      // Legend
      Row() {
        Rect()
          .width(8)
          .height(8)
          .fill(AppTokens.Colors.primary)
          .radius(2)
          .margin({ right: AppTokens.Spacing.sm })

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.sm })

        Rect()
          .width(8)
          .height(8)
          .fill(AppTokens.Colors.secondary)
          .radius(2)
          .margin({ right: AppTokens.Spacing.sm })

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.14)',
      offsetY: 1
    })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.notifCount} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Mark All Read')
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .onClick(() => {
          this.notifCount = 0
        })
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 6,
      color: 'rgba(0,0,0,0.16)',
      offsetY: -1
    })
  }
}
