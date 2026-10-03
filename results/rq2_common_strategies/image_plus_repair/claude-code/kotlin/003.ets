// Dashboard Analytics - Corporate Dashboard style
// Converted from Kotlin Compose to ArkTS

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
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppColors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppColors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppColors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppColors.tertiary)
  ]

  private readonly charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.RangeChips()

          this.CompareSection()

          Grid() {
            ForEach(this.kpis, (item: MetricCardUi) => {
              GridItem() {
                this.MetricCard(item)
              }
            }, (item: MetricCardUi) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppSpacing.lg)
          .columnsGap(AppSpacing.lg)
          .width('100%')
          .margin({ bottom: AppSpacing.lg })

          Grid() {
            ForEach(this.charts, (item: ChartCardUi) => {
              GridItem() {
                this.ChartCard(item)
              }
            }, (item: ChartCardUi) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppSpacing.lg)
          .columnsGap(AppSpacing.lg)
          .width('100%')
          .margin({ bottom: AppSpacing.xxxl })
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
      }
      .layoutWeight(1)
      .width('100%')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Rect()
          .width(20)
          .height(20)
          .fill(AppColors.primary)
          .radius(6)

        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ left: AppSpacing.sm })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  RangeChips() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
      ForEach(this.ranges, (range: string) => {
        this.RangeChip(range, range === this.selectedRange)
      }, (range: string) => range)
    }
    .width('100%')
    .margin({ bottom: AppSpacing.md })
  }

  @Builder
  RangeChip(label: string, active: boolean) {
    Text(label)
      .fontSize(active ? 14 : 12)
      .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(active ? AppColors.onPrimary : AppColors.onSurface)
      .padding({
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .backgroundColor(active ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .margin({ right: AppSpacing.sm, bottom: AppSpacing.xs })
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
        .fontColor(AppColors.onSurface)
        .margin({ right: AppSpacing.sm })

      Row() {
        this.AssistChip('Prev Period', this.prevPeriodFlag)
      }
      .margin({ right: AppSpacing.sm })
      .onClick(() => {
        this.prevPeriodFlag = !this.prevPeriodFlag
      })

      Row() {
        this.AssistChip('Goal', this.goalFlag)
      }
      .margin({ right: AppSpacing.sm })
      .onClick(() => {
        this.goalFlag = !this.goalFlag
      })

      Row() {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ right: AppSpacing.xs })

        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .margin({ bottom: AppSpacing.lg })
  }

  @Builder
  AssistChip(label: string, active: boolean) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? AppColors.onSecondary : AppColors.onSurface)
      .padding({
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.md + 2,
        bottom: AppSpacing.md + 2
      })
      .backgroundColor(active ? AppColors.secondary : AppColors.surface)
      .borderRadius(6)
      .border({
        width: 1,
        color: AppColors.outline
      })
  }

  @Builder
  MetricCard(item: MetricCardUi) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
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
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })

      Row() {
        Circle({ width: 6, height: 6 })
          .fill(item.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .margin({ right: AppSpacing.xs })

        Text(item.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(item.delta.startsWith('+') ? AppColors.success : AppColors.error)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
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
        .fontColor(AppColors.onSurface)

      Stack() {
        Row() {
          Rect()
            .width(6)
            .height(40)
            .fill(AppColors.primary)
            .radius(2)
            .margin({ right: AppSpacing.sm })

          Rect()
            .width(6)
            .height(30)
            .fill(AppColors.secondary)
            .radius(2)
            .margin({ right: AppSpacing.sm })

          Rect()
            .width(6)
            .height(48)
            .fill(AppColors.tertiary)
            .radius(2)
            .margin({ right: AppSpacing.sm })

          Rect()
            .width(6)
            .height(22)
            .fill(AppColors.outline)
            .radius(2)
            .margin({ right: AppSpacing.sm })

          Rect()
            .width(6)
            .height(32)
            .fill(AppColors.primary)
            .radius(2)
            .margin({ right: AppSpacing.sm })

          Rect()
            .width(6)
            .height(42)
            .fill(AppColors.secondary)
            .radius(2)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(100)
      .backgroundColor(item.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)
      .margin({ top: AppSpacing.md })

      Row() {
        Rect()
          .width(8)
          .height(8)
          .fill(AppColors.primary)
          .radius(2)
          .margin({ right: AppSpacing.sm })

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ right: AppSpacing.sm })

        Rect()
          .width(8)
          .height(8)
          .fill(AppColors.secondary)
          .radius(2)
          .margin({ right: AppSpacing.sm })

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
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
          .fontColor(AppColors.onSurface)

        Text(`${this.notifCount} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Mark All Read')
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .onClick(() => {
          this.notifCount = 0
        })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 6,
      color: 'rgba(0,0,0,0.16)',
      offsetY: -1
    })
  }
}
