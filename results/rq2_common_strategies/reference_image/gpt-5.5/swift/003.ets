class AppColors {
  static primary: string = '#0EA5E9'
  static secondary: string = '#22C55E'
  static tertiary: string = '#F59E0B'
  static background: string = '#F7FAFC'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#EFF3F7'
  static outline: string = '#D4D9E1'
  static success: string = '#16A34A'
  static warning: string = '#F59E0B'
  static error: string = '#EF4444'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#0F172A'
  static onTertiary: string = '#111827'
  static onBackground: string = '#0B1220'
  static onSurface: string = '#0B1220'
}

class AppTypography {
  static display: number = 24
  static headline: number = 18
  static title: number = 14
  static body: number = 12
  static label: number = 10
}

class AppSpacing {
  static xs: number = 2
  static sm: number = 4
  static md: number = 6
  static lg: number = 8
  static xl: number = 12
  static xxl: number = 16
  static xxxl: number = 24
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

@Component
struct MetricCardView {
  metric: MetricCardUi = new MetricCardUi(0, '', '', '', AppColors.primary)

  build() {
    Column() {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Blank()
          .width(16)
          .height(16)
          .borderRadius(4)
          .backgroundColor(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })

      Row({ space: AppSpacing.xs }) {
        Blank()
          .width(6)
          .height(6)
          .borderRadius(2)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)

        Text(this.metric.delta)
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
      }
      .margin({ top: AppSpacing.sm })

      Blank()
        .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .height(120)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct ChartCardView {
  chart: ChartCardUi = new ChartCardUi(0, '', '#E0F2FE')

  @Builder
  bar(color: string, height: number) {
    Blank()
      .width(6)
      .height(height)
      .borderRadius(2)
      .backgroundColor(color)
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Stack({ alignContent: Alignment.Center }) {
        Blank()
          .width('100%')
          .height('100%')
          .borderRadius(8)
          .backgroundColor(this.chart.color)

        Row({ space: AppSpacing.sm }) {
          this.bar(AppColors.primary, 40)
          this.bar(AppColors.secondary, 30)
          this.bar(AppColors.tertiary, 48)
          this.bar(AppColors.outline, 22)
          this.bar(AppColors.primary, 32)
          this.bar(AppColors.secondary, 42)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(90)

      Row({ space: AppSpacing.sm }) {
        Blank()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(AppColors.primary)

        Text('Series A')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(AppColors.secondary)

        Text('Series B')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .height(180)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 2
    })
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
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppColors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppColors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppColors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppColors.tertiary)
  ]

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
  ]

  private isFlagSelected(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0
  }

  private toggleFlag(flag: string): void {
    if (this.isFlagSelected(flag)) {
      this.selectedFlags = this.selectedFlags.filter((item: string) => item !== flag)
    } else {
      this.selectedFlags = this.selectedFlags.concat([flag])
    }
  }

  @Builder
  rangeChip(range: string, verticalPadding: number) {
    Text(range)
      .fontSize(this.selectedRange === range ? AppTypography.title : AppTypography.body)
      .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === range ? AppColors.onPrimary : AppColors.onSurface)
      .padding({
        left: 16,
        right: 16,
        top: verticalPadding,
        bottom: verticalPadding
      })
      .backgroundColor(this.selectedRange === range ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.selectedRange = range
      })
  }

  @Builder
  flagChip(flag: string) {
    Text(flag)
      .fontSize(AppTypography.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isFlagSelected(flag) ? AppColors.onSecondary : AppColors.onSurface)
      .maxLines(1)
      .padding({
        left: 16,
        right: 16,
        top: 10,
        bottom: 10
      })
      .backgroundColor(this.isFlagSelected(flag) ? AppColors.secondary : AppColors.surface)
      .borderRadius(6)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.toggleFlag(flag)
      })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()

          Row({ space: AppSpacing.sm }) {
            Blank()
              .width(20)
              .height(20)
              .borderRadius(4)
              .backgroundColor(AppColors.primary)

            Text('Analytics')
              .fontSize(AppTypography.display)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
          }

          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppColors.background)

        Divider()
          .strokeWidth(1)
          .color(AppColors.outline)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Column() {
                Row({ space: AppSpacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    this.rangeChip(range, 8)
                  }, (range: string) => range)
                }
                .padding({ top: 4, bottom: 4 })

                Row({ space: AppSpacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    this.rangeChip(range, 10)
                  }, (range: string) => range)

                  Blank()
                }
                .padding({ top: 8, bottom: 8 })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Row({ space: AppSpacing.sm }) {
              Text('Compare')
                .fontSize(AppTypography.label)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              ForEach(this.flags, (flag: string) => {
                this.flagChip(flag)
              }, (flag: string) => flag)

              Row({ space: AppSpacing.xs }) {
                Text('Dark')
                  .fontSize(AppTypography.label)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(AppColors.primary)
                  .scale({ x: 0.8, y: 0.8 })
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn
                  })
              }
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })
            .alignItems(VerticalAlign.Center)

            Column({ space: AppSpacing.lg }) {
              Row({ space: AppSpacing.lg }) {
                MetricCardView({ metric: this.kpis[0] })
                  .layoutWeight(1)

                MetricCardView({ metric: this.kpis[1] })
                  .layoutWeight(1)
              }
              .width('100%')

              Row({ space: AppSpacing.lg }) {
                MetricCardView({ metric: this.kpis[2] })
                  .layoutWeight(1)

                MetricCardView({ metric: this.kpis[3] })
                  .layoutWeight(1)
              }
              .width('100%')

              Row({ space: AppSpacing.lg }) {
                ChartCardView({ chart: this.charts[0] })
                  .layoutWeight(1)

                ChartCardView({ chart: this.charts[1] })
                  .layoutWeight(1)
              }
              .width('100%')
            }
            .width('100%')

            Blank()
              .height(80)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Divider()
          .strokeWidth(1)
          .color('rgba(212, 217, 225, 0.30)')

        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Notifications')
              .fontSize(AppTypography.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(this.notificationCount + ' pending')
              .fontSize(AppTypography.headline)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('Mark All Read')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .textAlign(TextAlign.Center)
            .width(140)
            .height(44)
            .borderRadius(12)
            .backgroundColor(AppColors.secondary)
            .onClick(() => {
              this.notificationCount = 0
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
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 4,
        color: 'rgba(0, 0, 0, 0.10)',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}