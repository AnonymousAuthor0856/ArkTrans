import { LengthMetrics } from '@kit.ArkUI'

// MARK: - Design Tokens
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
  onSurface: '#0B1220',
}

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24,
}

// MARK: - Data Models
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

// MARK: - Metric Card Component
@Component
struct MetricCardView {
  metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' }

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Column()
          .width(16)
          .height(16)
          .borderRadius(4)
          .backgroundColor(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.xs }) {
        Column()
          .width(6)
          .height(6)
          .borderRadius(2)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)

        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error)
      }

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .height(120)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

// MARK: - Chart Card Component
@Component
struct ChartCardView {
  chart: ChartCardUi = { id: 0, title: '', color: '' }

  build() {
    Column({ space: AppSpacing.md }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .borderRadius(8)
          .backgroundColor(this.chart.color)

        Row({ space: AppSpacing.sm }) {
          Column()
            .width(6)
            .height(40)
            .borderRadius(2)
            .backgroundColor(AppColors.primary)

          Column()
            .width(6)
            .height(30)
            .borderRadius(2)
            .backgroundColor(AppColors.secondary)

          Column()
            .width(6)
            .height(48)
            .borderRadius(2)
            .backgroundColor(AppColors.tertiary)

          Column()
            .width(6)
            .height(22)
            .borderRadius(2)
            .backgroundColor(AppColors.outline)

          Column()
            .width(6)
            .height(32)
            .borderRadius(2)
            .backgroundColor(AppColors.primary)

          Column()
            .width(6)
            .height(42)
            .borderRadius(2)
            .backgroundColor(AppColors.secondary)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .layoutWeight(1)

      Row({ space: AppSpacing.sm }) {
        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(AppColors.primary)

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(AppColors.secondary)

        Text('Series B')
          .fontSize(10)
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
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedRange: string = '7 Days'
  @State selectedFlags: Set<string> = new Set()
  @State darkMode: boolean = false
  @State notificationCount: number = 2

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days']
  private ranges2: string[] = ['YTD', 'Custom']
  private flags: string[] = ['Prev Period', 'Goal']

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppColors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppColors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppColors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppColors.tertiary },
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
  ]

  @Builder
  RangeButton(range: string, verticalPad: number) {
    Button() {
      Text(range)
        .fontSize(this.selectedRange === range ? 14 : 12)
        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selectedRange === range ? AppColors.onPrimary : AppColors.onSurface)
        .padding({ left: 16, right: 16, top: verticalPad, bottom: verticalPad })
    }
    .backgroundColor(this.selectedRange === range ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({ width: 1, color: AppColors.outline, radius: 8 })
    .onClick(() => {
      this.selectedRange = range
    })
  }

  @Builder
  FlagButton(flag: string) {
    Button() {
      Text(flag)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedFlags.has(flag) ? AppColors.onSecondary : AppColors.onSurface)
        .maxLines(1)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    }
    .backgroundColor(this.selectedFlags.has(flag) ? AppColors.secondary : AppColors.surface)
    .borderRadius(6)
    .border({ width: 1, color: AppColors.outline, radius: 6 })
    .onClick(() => {
      if (this.selectedFlags.has(flag)) {
        this.selectedFlags.delete(flag)
      } else {
        this.selectedFlags.add(flag)
      }
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Header
        Row() {
          Blank()
          Row({ space: AppSpacing.sm }) {
            Column()
              .width(20)
              .height(20)
              .borderRadius(4)
              .backgroundColor(AppColors.primary)

            Text('Analytics')
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
          }

          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppColors.background)

        Divider()
          .color(AppColors.outline)

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.md }) {
            // Date Range Selector
            Scroll() {
              Column({ space: 0 }) {
                Row({ space: AppSpacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    this.RangeButton(range, 8)
                  })
                }
                .padding({ top: 4, bottom: 4 })

                Row({ space: AppSpacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    this.RangeButton(range, 10)
                  })
                  Blank()
                }
                .width('100%')
                .padding({ top: 8, bottom: 8 })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .align(Alignment.Start)

            // Comparison Options
            Row({ space: AppSpacing.sm }) {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              ForEach(this.flags, (flag: string) => {
                this.FlagButton(flag)
              })

              // Dark Mode Toggle
              Row({ space: AppSpacing.xs }) {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(AppColors.primary)
                  .width(40)
                  .height(24)
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn
                  })
              }
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid - Row 1
            Row({ space: AppSpacing.lg }) {
              MetricCardView({ metric: this.kpis[0] })
                .layoutWeight(1)
              MetricCardView({ metric: this.kpis[1] })
                .layoutWeight(1)
            }
            .width('100%')

            // Metrics Grid - Row 2
            Row({ space: AppSpacing.lg }) {
              MetricCardView({ metric: this.kpis[2] })
                .layoutWeight(1)
              MetricCardView({ metric: this.kpis[3] })
                .layoutWeight(1)
            }
            .width('100%')

            // Charts Row
            Row({ space: AppSpacing.lg }) {
              ChartCardView({ chart: this.charts[0] })
                .layoutWeight(1)
              ChartCardView({ chart: this.charts[1] })
                .layoutWeight(1)
            }
            .width('100%')

            Column()
              .height(80)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .align(Alignment.Top)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar
      Column({ space: 0 }) {
        Divider()
          .color(AppColors.outline)
          .opacity(0.3)

        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('Mark All Read')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width(140)
          .height(44)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
          .onClick(() => {
            this.notificationCount = 0
          })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}