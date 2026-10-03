// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF22C55E',
    tertiary: '#FFF59E0B',
    background: '#FFF7FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEFF3F7',
    outline: '#FFD4D9E1',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FF111827',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220',
  };

  static readonly Typography = {
    display: { size: 24, weight: FontWeight.MEDIUM },
    headline: { size: 18, weight: FontWeight.MEDIUM },
    title: { size: 14, weight: FontWeight.MEDIUM },
    body: { size: 12, weight: FontWeight.NORMAL },
    label: { size: 10, weight: FontWeight.MEDIUM },
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  };
}

export class MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: ResourceColor;

  constructor(id: number, title: string, value: string, delta: string, color: ResourceColor) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.delta = delta;
    this.color = color;
  }
}

export class ChartCardUi {
  id: number;
  title: string;
  color: ResourceColor;

  constructor(id: number, title: string, color: ResourceColor) {
    this.id = id;
    this.title = title;
    this.color = color;
  }
}

// Entry Component
@Entry
@Component
struct ContentView {
  @State private selectedRange: string = '7 Days';
  @State private selectedFlags: Set<string> = new Set();
  @State private darkMode: boolean = false;
  @State private notificationCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  private ranges2: string[] = ['YTD', 'Custom'];
  private flags: string[] = ['Prev Period', 'Goal'];

  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ];

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#FFE0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#FFEFF6FF')
  ];

  private toggleFlag(flag: string) {
    if (this.selectedFlags.has(flag)) {
      this.selectedFlags.delete(flag);
    } else {
      this.selectedFlags.add(flag);
    }
    // Trigger re-render by creating a new Set
    this.selectedFlags = new Set(this.selectedFlags);
  }

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        // Header
        Row() {
          Blank()
          Row({ space: AppTokens.Spacing.sm }) {
            Column()
              .width(20)
              .height(20)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)
            
            Text('Analytics')
              .fontSize(AppTokens.Typography.display.size)
              .fontWeight(AppTokens.Typography.display.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppTokens.Colors.background)
        
        Divider().color(AppTokens.Colors.outline)

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Date Range Selector
            Scroll() {
              Column({ space: AppTokens.Spacing.lg }) {
                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    Button(() => { this.selectedRange = range; }) {
                      Text(range)
                        .fontSize(this.selectedRange === range ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                        .fontWeight(this.selectedRange === range ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    }
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                  }
                }
                .padding({ top: 4, bottom: 4 })

                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    Button(() => { this.selectedRange = range; }) {
                      Text(range)
                        .fontSize(this.selectedRange === range ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                        .fontWeight(this.selectedRange === range ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                    }
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                  })
                  Blank()
                }
                .padding({ top: 8, bottom: 8 })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            // Comparison Options
            Row({ space: AppTokens.Spacing.sm }) {
              Text('Compare')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.flags, (flag: string) => {
                Button(() => { this.toggleFlag(flag); }) {
                  Text(flag)
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(this.selectedFlags.has(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                    .maxLines(1)
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.selectedFlags.has(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppTokens.Colors.outline })
              })

              // Dark Mode Toggle
              Row({ space: AppTokens.Spacing.xs }) {
                Text('Dark')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                
                Toggle({ type: ToggleType.Switch, isOn: $$this.darkMode })
                  .selectedColor(AppTokens.Colors.primary)
                  .scale({ x: 0.8, y: 0.8 })
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Start)
            }
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid
            Grid() {
              GridItem() { MetricCardView({ metric: this.kpis[0] }) }
              GridItem() { MetricCardView({ metric: this.kpis[1] }) }
              GridItem() { MetricCardView({ metric: this.kpis[2] }) }
              GridItem() { MetricCardView({ metric: this.kpis[3] }) }
              GridItem() { ChartCardView({ chart: this.charts[0] }) }
              GridItem() { ChartCardView({ chart: this.charts[1] }) }
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppTokens.Spacing.lg)
            .rowsGap(AppTokens.Spacing.lg)
            .padding({ bottom: 80 })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      
      // Bottom Notification Bar
      Column() {
        Divider()
          .color(AppTokens.Colors.outline)
          .opacity(0.3)
        
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Notifications')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
            
            Text(`${this.notificationCount} pending`)
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button(() => { this.notificationCount = 0; }) {
            Text('Mark All Read')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MetricCardView {
  @Prop metric: MetricCardUi;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        Column()
          .width(16)
          .height(16)
          .backgroundColor(this.metric.color)
          .borderRadius(4)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Column()
          .width(6)
          .height(6)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(2)
        
        Text(this.metric.delta)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
      
      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .height(120)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  @Prop chart: ChartCardUi;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.chart.color)
          .borderRadius(8)

        Row({ space: AppTokens.Spacing.sm }) {
          Column().width(6).height(40).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
          Column().width(6).height(30).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
          Column().width(6).height(48).backgroundColor(AppTokens.Colors.tertiary).borderRadius(2)
          Column().width(6).height(22).backgroundColor(AppTokens.Colors.outline).borderRadius(2)
          Column().width(6).height(32).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
          Column().width(6).height(42).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .aspectRatio({ ratio: 1.6 })
      .width('100%')

      Row({ space: AppTokens.Spacing.sm }) {
        Column().width(8).height(8).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
        Text('Series A')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Column().width(8).height(8).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
        Text('Series B')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .height(180)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}