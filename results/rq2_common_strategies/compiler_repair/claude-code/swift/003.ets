@Entry
@Component
struct DashboardApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Design Tokens
class AppColors {
  static readonly primary: string = '#FF0EA5E9'
  static readonly secondary: string = '#FF22C55E'
  static readonly tertiary: string = '#FFF59E0B'
  static readonly background: string = '#FFF7FAFC'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFEFF3F7'
  static readonly outline: string = '#FFD4D9E1'
  static readonly success: string = '#FF16A34A'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF0F172A'
  static readonly onTertiary: string = '#FF111827'
  static readonly onBackground: string = '#FF0B1220'
  static readonly onSurface: string = '#FF0B1220'
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

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
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

// MARK: - Metric Card View
@Component
struct MetricCardView {
  @Prop metric: MetricCardUi

  @Builder colorDot(color: string, size: number, radius: number) {
    Row() { }
      .width(size)
      .height(size)
      .borderRadius(radius)
      .backgroundColor(color)
  }

  build() {
    Column() {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        this.colorDot(this.metric.color, 16, 4)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })

      Row() {
        this.colorDot(
          this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error,
          6,
          2
        )

        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(
            this.metric.delta.startsWith('+') ? AppColors.success : AppColors.error
          )
          .margin({ left: AppSpacing.xs })
      }
      .margin({ top: AppSpacing.sm })

      Blank()
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// MARK: - Chart Card View
@Component
struct ChartCardView {
  @Prop chart: ChartCardUi

  @Builder bar(color: string, width: number, height: number) {
    Row() { }
      .width(width)
      .height(height)
      .borderRadius(2)
      .backgroundColor(color)
  }

  @Builder legendDot(color: string) {
    Row() { }
      .width(8)
      .height(8)
      .borderRadius(2)
      .backgroundColor(color)
  }

  build() {
    Column() {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      // Bar chart area
      Row() {
        this.bar(AppColors.primary, 6, 40)
        this.bar(AppColors.secondary, 6, 30)
        this.bar(AppColors.tertiary, 6, 48)
        this.bar(AppColors.outline, 6, 22)
        this.bar(AppColors.primary, 6, 32)
        this.bar(AppColors.secondary, 6, 42)
      }
      .width('100%')
      .height('60%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(this.chart.color)
      .borderRadius(AppShapes.medium)
      .margin({ top: AppSpacing.md })

      // Chart legend
      Row() {
        this.legendDot(AppColors.primary)

        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ left: AppSpacing.sm })

        Row() {
          this.legendDot(AppColors.secondary)
        }
        .margin({ left: AppSpacing.sm })

        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ left: AppSpacing.sm })
      }
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .height(180)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// MARK: - Main Content View
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
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppColors.tertiary }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#FFE0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#FFEFF6FF' }
  ]

  toggleFlag(flag: string): void {
    if (this.selectedFlags.has(flag)) {
      this.selectedFlags.delete(flag)
    } else {
      this.selectedFlags.add(flag)
    }
  }

  @Builder rangeButton(range: string) {
    Button() {
      Text(range)
        .fontSize(this.selectedRange === range ? 14 : 12)
        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selectedRange === range ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(36)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.selectedRange === range ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selectedRange = range
    })
  }

  @Builder flagButton(flag: string) {
    Button() {
      Text(flag)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(
          this.selectedFlags.has(flag) ? AppColors.onSecondary : AppColors.onSurface
        )
        .maxLines(1)
    }
    .height(36)
    .padding({ left: 16, right: 16 })
    .backgroundColor(
      this.selectedFlags.has(flag) ? AppColors.secondary : AppColors.surface
    )
    .borderRadius(AppShapes.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.toggleFlag(flag)
    })
  }

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Blank()

          Row() {
            Row() { }
              .width(20)
              .height(20)
              .borderRadius(4)
              .backgroundColor(AppColors.primary)

            Text('Analytics')
              .fontSize(24)
              .fontWeight(600)
              .fontColor(AppColors.onSurface)
              .margin({ left: AppSpacing.sm })
          }

          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppColors.background)

        Divider()
          .color(AppColors.outline)

        // Content
        Scroll() {
          Column() {
            // Date Range Selector
            Scroll() {
              Column() {
                Row() {
                  ForEach(this.ranges, (range: string) => {
                    Row() {
                      this.rangeButton(range)
                    }
                    .margin({ right: AppSpacing.sm })
                  }, (range: string) => range)
                }
                .padding({ top: 4, bottom: 4 })

                Row() {
                  ForEach(this.ranges2, (range: string) => {
                    Row() {
                      this.rangeButton(range)
                    }
                    .margin({ right: AppSpacing.sm })
                  }, (range: string) => range)

                  Blank()
                }
                .padding({ top: 8, bottom: 8 })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Comparison Options
            Row() {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .margin({ right: AppSpacing.sm })

              ForEach(this.flags, (flag: string) => {
                Row() {
                  this.flagButton(flag)
                }
                .margin({ right: AppSpacing.sm })
              }, (flag: string) => flag)

              // Dark Mode Toggle
              Row() {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                  .margin({ right: AppSpacing.xs })

                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .width(40)
                  .height(24)
                  .selectedColor(AppColors.primary)
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn
                  })
              }
              .layoutWeight(1)
            }
            .padding({ top: 6, bottom: 6 })
            .width('100%')

            // Metrics Grid (2 columns)
            Row() {
              Column() {
                MetricCardView({ metric: this.kpis[0] })
                MetricCardView({ metric: this.kpis[2] })
                  .margin({ top: AppSpacing.lg })
                ChartCardView({ chart: this.charts[0] })
                  .margin({ top: AppSpacing.lg })
              }
              .layoutWeight(1)
              .margin({ right: AppSpacing.lg / 2 })

              Column() {
                MetricCardView({ metric: this.kpis[1] })
                MetricCardView({ metric: this.kpis[3] })
                  .margin({ top: AppSpacing.lg })
                ChartCardView({ chart: this.charts[1] })
                  .margin({ top: AppSpacing.lg })
              }
              .layoutWeight(1)
              .margin({ left: AppSpacing.lg / 2 })
            }
            .width('100%')

            Blank()
              .height(80)
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar
      Column() {
        Row() { }
          .width('100%')
          .height(1)
          .backgroundColor('rgba(212, 217, 225, 0.3)')

        Row() {
          Column() {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(600)
              .fontColor(AppColors.onSurface)
              .margin({ top: AppSpacing.xs })
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
          .borderRadius(AppShapes.large)
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
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: -2
        })
      }
      .width('100%')
      .position({ x: 0, y: '100%' })
      .translate({ y: '-100%' })
    }
    .width('100%')
    .height('100%')
  }
}
