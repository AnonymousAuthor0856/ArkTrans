interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const Colors: ColorTokens = {
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
};

interface MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: string;
}

interface ChartCardUi {
  id: number;
  title: string;
  color: string;
}

const kpis: MetricCardUi[] = [
  { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: Colors.secondary },
  { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: Colors.primary },
  { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: Colors.error },
  { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: Colors.tertiary },
];

const charts: ChartCardUi[] = [
  { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
  { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
];

@Component
struct MetricCardView {
  metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' };

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
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
        .fontWeight(600)
        .fontColor(Colors.onSurface)

      Row({ space: 2 }) {
        Column()
          .width(6)
          .height(6)
          .borderRadius(2)
          .backgroundColor(this.metric.delta.startsWith('+') ? Colors.success : Colors.error)

        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith('+') ? Colors.success : Colors.error)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .width('100%')
    .height(120)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  chart: ChartCardUi = { id: 0, title: '', color: '' };

  build() {
    Column({ space: 6 }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .borderRadius(8)
          .backgroundColor(this.chart.color)

        Row({ space: 4 }) {
          Column()
            .width(6)
            .height(40)
            .borderRadius(2)
            .backgroundColor(Colors.primary)
          Column()
            .width(6)
            .height(30)
            .borderRadius(2)
            .backgroundColor(Colors.secondary)
          Column()
            .width(6)
            .height(48)
            .borderRadius(2)
            .backgroundColor(Colors.tertiary)
          Column()
            .width(6)
            .height(22)
            .borderRadius(2)
            .backgroundColor(Colors.outline)
          Column()
            .width(6)
            .height(32)
            .borderRadius(2)
            .backgroundColor(Colors.primary)
          Column()
            .width(6)
            .height(42)
            .borderRadius(2)
            .backgroundColor(Colors.secondary)
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(90)

      Row({ space: 4 }) {
        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(Colors.primary)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Column()
          .width(8)
          .height(8)
          .borderRadius(2)
          .backgroundColor(Colors.secondary)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .width('100%')
    .height(180)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct ContentView {
  @State selectedRange: string = '7 Days';
  @State selectedFlags: string[] = [];
  @State darkMode: boolean = false;
  @State notificationCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  private ranges2: string[] = ['YTD', 'Custom'];
  private flags: string[] = ['Prev Period', 'Goal'];

  isFlagSelected(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0;
  }

  toggleFlag(flag: string): void {
    const idx = this.selectedFlags.indexOf(flag);
    if (idx >= 0) {
      const newFlags = [...this.selectedFlags];
      newFlags.splice(idx, 1);
      this.selectedFlags = newFlags;
    } else {
      this.selectedFlags = [...this.selectedFlags, flag];
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Blank()
          Row({ space: 4 }) {
            Column()
              .width(20)
              .height(20)
              .borderRadius(4)
              .backgroundColor(Colors.primary)
            Text('Analytics')
              .fontSize(24)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
          }
          .alignItems(VerticalAlign.Center)
          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(Colors.background)

        Divider()
          .color(Colors.outline)

        // Scrollable content
        Scroll() {
          Column({ space: 6 }) {
            // Date Range Selector Row 1
            Scroll() {
              Row({ space: 4 }) {
                ForEach(this.ranges, (range: string) => {
                  Button({ type: ButtonType.Normal }) {
                    Text(range)
                      .fontSize(this.selectedRange === range ? 14 : 12)
                      .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                      .fontColor(this.selectedRange === range ? Colors.onPrimary : Colors.onSurface)
                      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  }
                  .backgroundColor(this.selectedRange === range ? Colors.primary : Colors.surface)
                  .borderRadius(8)
                  .border({ width: 1, color: Colors.outline, radius: 8 })
                  .onClick(() => {
                    this.selectedRange = range;
                  })
                })
              }
              .padding({ top: 4, bottom: 4 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Date Range Selector Row 2
            Row({ space: 4 }) {
              ForEach(this.ranges2, (range: string) => {
                Button({ type: ButtonType.Normal }) {
                  Text(range)
                    .fontSize(this.selectedRange === range ? 14 : 12)
                    .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                    .fontColor(this.selectedRange === range ? Colors.onPrimary : Colors.onSurface)
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.selectedRange === range ? Colors.primary : Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: Colors.outline, radius: 8 })
                .onClick(() => {
                  this.selectedRange = range;
                })
              })
              Blank()
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })

            // Comparison Options
            Row({ space: 4 }) {
              Text('Compare')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)

              ForEach(this.flags, (flag: string) => {
                Button({ type: ButtonType.Normal }) {
                  Text(flag)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFlagSelected(flag) ? Colors.onSecondary : Colors.onSurface)
                    .maxLines(1)
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.isFlagSelected(flag) ? Colors.secondary : Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: Colors.outline, radius: 6 })
                .onClick(() => {
                  this.toggleFlag(flag);
                })
              })

              Row({ space: 2 }) {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(Colors.primary)
                  .width(40)
                  .height(24)
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn;
                  })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid - Row 1
            Row({ space: 8 }) {
              MetricCardView({ metric: kpis[0] })
                .layoutWeight(1)
              MetricCardView({ metric: kpis[1] })
                .layoutWeight(1)
            }
            .width('100%')

            // Metrics Grid - Row 2
            Row({ space: 8 }) {
              MetricCardView({ metric: kpis[2] })
                .layoutWeight(1)
              MetricCardView({ metric: kpis[3] })
                .layoutWeight(1)
            }
            .width('100%')

            // Charts Grid
            Row({ space: 8 }) {
              ChartCardView({ chart: charts[0] })
                .layoutWeight(1)
              ChartCardView({ chart: charts[1] })
                .layoutWeight(1)
            }
            .width('100%')

            Column()
              .height(80)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .backgroundColor(Colors.background)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Bottom Notification Bar
      Column() {
        Divider()
          .color(Colors.outline)
          .opacity(0.3)

        Row() {
          Column({ space: 2 }) {
            Text('Notifications')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(600)
              .fontColor(Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Normal }) {
            Text('Mark All Read')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSecondary)
          }
          .width(140)
          .height(44)
          .backgroundColor(Colors.secondary)
          .borderRadius(12)
          .onClick(() => {
            this.notificationCount = 0;
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}