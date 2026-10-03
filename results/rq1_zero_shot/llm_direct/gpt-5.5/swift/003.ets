interface MetricCardUi {
  id: number
  title: string
  value: string
  delta: string
  color: ResourceColor
}

interface ChartCardUi {
  id: number
  title: string
  color: ResourceColor
}

class AppTokens {
  static Colors = class {
    static primary: ResourceColor = 0xFF0EA5E9
    static secondary: ResourceColor = 0xFF22C55E
    static tertiary: ResourceColor = 0xFFF59E0B
    static background: ResourceColor = 0xFFF7FAFC
    static surface: ResourceColor = 0xFFFFFFFF
    static surfaceVariant: ResourceColor = 0xFFEFF3F7
    static outline: ResourceColor = 0xFFD4D9E1
    static success: ResourceColor = 0xFF16A34A
    static warning: ResourceColor = 0xFFF59E0B
    static error: ResourceColor = 0xFFEF4444
    static onPrimary: ResourceColor = 0xFFFFFFFF
    static onSecondary: ResourceColor = 0xFF0F172A
    static onTertiary: ResourceColor = 0xFF111827
    static onBackground: ResourceColor = 0xFF0B1220
    static onSurface: ResourceColor = 0xFF0B1220
  }

  static TypographyTokens = class {
    static displaySize: number = 24
    static headlineSize: number = 18
    static titleSize: number = 14
    static bodySize: number = 12
    static labelSize: number = 10
  }

  static Spacing = class {
    static xs: number = 2
    static sm: number = 4
    static md: number = 6
    static lg: number = 8
    static xl: number = 12
    static xxl: number = 16
    static xxxl: number = 24
  }

  static Shapes = class {
    static small: number = 6
    static medium: number = 8
    static large: number = 12
  }
}

@Component
struct MetricCardView {
  metric: MetricCardUi = {
    id: 0,
    title: '',
    value: '',
    delta: '',
    color: AppTokens.Colors.primary
  }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Rect()
          .width(16)
          .height(16)
          .radius(4)
          .fill(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Rect()
          .width(6)
          .height(6)
          .radius(2)
          .fill(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)

        Text(this.metric.delta)
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .height(120)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
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
  chart: ChartCardUi = {
    id: 0,
    title: '',
    color: AppTokens.Colors.surfaceVariant
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .radius(AppTokens.Shapes.medium)
          .fill(this.chart.color)

        Row({ space: AppTokens.Spacing.sm }) {
          Rect()
            .width(6)
            .height(40)
            .radius(2)
            .fill(AppTokens.Colors.primary)

          Rect()
            .width(6)
            .height(30)
            .radius(2)
            .fill(AppTokens.Colors.secondary)

          Rect()
            .width(6)
            .height(48)
            .radius(2)
            .fill(AppTokens.Colors.tertiary)

          Rect()
            .width(6)
            .height(22)
            .radius(2)
            .fill(AppTokens.Colors.outline)

          Rect()
            .width(6)
            .height(32)
            .radius(2)
            .fill(AppTokens.Colors.primary)

          Rect()
            .width(6)
            .height(42)
            .radius(2)
            .fill(AppTokens.Colors.secondary)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .layoutWeight(1)

      Row({ space: AppTokens.Spacing.sm }) {
        Rect()
          .width(8)
          .height(8)
          .radius(2)
          .fill(AppTokens.Colors.primary)

        Text('Series A')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Rect()
          .width(8)
          .height(8)
          .radius(2)
          .fill(AppTokens.Colors.secondary)

        Text('Series B')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .height(180)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
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
    {
      id: 1,
      title: 'Revenue',
      value: '$24,560',
      delta: '+8.2%',
      color: AppTokens.Colors.secondary
    },
    {
      id: 2,
      title: 'Orders',
      value: '1,284',
      delta: '+3.1%',
      color: AppTokens.Colors.primary
    },
    {
      id: 3,
      title: 'Refunds',
      value: '42',
      delta: '-1.4%',
      color: AppTokens.Colors.error
    },
    {
      id: 4,
      title: 'Active Users',
      value: '8,921',
      delta: '+5.6%',
      color: AppTokens.Colors.tertiary
    }
  ]

  private charts: ChartCardUi[] = [
    {
      id: 1,
      title: 'Sales Trend',
      color: 0xFFE0F2FE
    },
    {
      id: 2,
      title: 'Conversion Funnel',
      color: 0xFFEFF6FF
    }
  ]

  private hasFlag(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0
  }

  private toggleFlag(flag: string): void {
    const index = this.selectedFlags.indexOf(flag)
    if (index >= 0) {
      this.selectedFlags.splice(index, 1)
      this.selectedFlags = [...this.selectedFlags]
    } else {
      this.selectedFlags = [...this.selectedFlags, flag]
    }
  }

  @Builder
  DateRangeButton(range: string, verticalPadding: number) {
    Button() {
      Text(range)
        .fontSize(this.selectedRange === range ? AppTokens.TypographyTokens.titleSize : AppTokens.TypographyTokens.bodySize)
        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({
          left: 16,
          right: 16,
          top: verticalPadding,
          bottom: verticalPadding
        })
    }
    .type(ButtonType.Normal)
    .borderRadius(AppTokens.Shapes.medium)
    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .onClick(() => {
      this.selectedRange = range
    })
  }

  @Builder
  FlagButton(flag: string) {
    Button() {
      Text(flag)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.hasFlag(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({
          left: 16,
          right: 16,
          top: 10,
          bottom: 10
        })
    }
    .type(ButtonType.Normal)
    .borderRadius(AppTokens.Shapes.small)
    .backgroundColor(this.hasFlag(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .onClick(() => {
      this.toggleFlag(flag)
    })
  }

  @Builder
  MainContent() {
    Column() {
      Row() {
        Blank()

        Row({ space: AppTokens.Spacing.sm }) {
          Rect()
            .width(20)
            .height(20)
            .radius(4)
            .fill(AppTokens.Colors.primary)

          Text('Analytics')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Blank()
      }
      .width('100%')
      .padding({
        top: 48,
        bottom: 12
      })
      .backgroundColor(AppTokens.Colors.background)

      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1)

      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Scroll() {
            Column() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.ranges, (range: string) => {
                  this.DateRangeButton(range, 8)
                }, (range: string) => range)
              }
              .padding({
                top: 4,
                bottom: 4
              })

              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.ranges2, (range: string) => {
                  this.DateRangeButton(range, 10)
                }, (range: string) => range)

                Blank()
              }
              .padding({
                top: 8,
                bottom: 8
              })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Row({ space: AppTokens.Spacing.sm }) {
            Text('Compare')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)

            ForEach(this.flags, (flag: string) => {
              this.FlagButton(flag)
            }, (flag: string) => flag)

            Row({ space: AppTokens.Spacing.xs }) {
              Text('Dark')
                .fontSize(AppTokens.TypographyTokens.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              Toggle({
                type: ToggleType.Switch,
                isOn: this.darkMode
              })
                .selectedColor(AppTokens.Colors.primary)
                .scale({ x: 0.8, y: 0.8 })
                .onChange((isOn: boolean) => {
                  this.darkMode = isOn
                })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({
            top: 6,
            bottom: 6
          })

          Grid() {
            GridItem() {
              MetricCardView({ metric: this.kpis[0] })
            }

            GridItem() {
              MetricCardView({ metric: this.kpis[1] })
            }

            GridItem() {
              MetricCardView({ metric: this.kpis[2] })
            }

            GridItem() {
              MetricCardView({ metric: this.kpis[3] })
            }

            GridItem() {
              ChartCardView({ chart: this.charts[0] })
            }

            GridItem() {
              ChartCardView({ chart: this.charts[1] })
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.lg)
          .rowsGap(AppTokens.Spacing.lg)
          .width('100%')

          Blank()
            .height(80)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  BottomNotificationBar() {
    Column() {
      Divider()
        .color('rgba(212, 217, 225, 0.3)')
        .strokeWidth(1)

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text(`${this.notificationCount} pending`)
            .fontSize(AppTokens.TypographyTokens.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text('Mark All Read')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .type(ButtonType.Normal)
        .width(140)
        .height(44)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.secondary)
        .onClick(() => {
          this.notificationCount = 0
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
        radius: 4,
        color: 'rgba(0, 0, 0, 0.1)',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      this.MainContent()
      this.BottomNotificationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}