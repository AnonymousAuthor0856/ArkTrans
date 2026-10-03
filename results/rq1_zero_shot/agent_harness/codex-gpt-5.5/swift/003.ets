class MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: string;

  constructor(id: number, title: string, value: string, delta: string, color: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.delta = delta;
    this.color = color;
  }
}

class ChartCardUi {
  id: number;
  title: string;
  color: string;

  constructor(id: number, title: string, color: string) {
    this.id = id;
    this.title = title;
    this.color = color;
  }
}

@Entry
@Component
struct ContentView {
  @State private selectedRange: string = '7 Days';
  @State private selectedFlags: string[] = [];
  @State private darkMode: boolean = false;
  @State private notificationCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  private ranges2: string[] = ['YTD', 'Custom'];
  private flags: string[] = ['Prev Period', 'Goal'];
  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', '#22C55E'),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', '#0EA5E9'),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', '#EF4444'),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', '#F59E0B')
  ];
  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
  ];

  private hasFlag(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0;
  }

  private toggleFlag(flag: string): void {
    if (this.hasFlag(flag)) {
      this.selectedFlags = this.selectedFlags.filter((item: string) => item !== flag);
    } else {
      this.selectedFlags = [...this.selectedFlags, flag];
    }
  }

  @Builder
  RangeButton(range: string, heightValue: number) {
    Button(range)
      .fontSize(this.selectedRange === range ? 14 : 12)
      .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === range ? '#FFFFFF' : '#0B1220')
      .backgroundColor(this.selectedRange === range ? '#0EA5E9' : '#FFFFFF')
      .border({ width: 1, color: '#D4D9E1', radius: 8 })
      .borderRadius(8)
      .height(heightValue)
      .padding({ left: 16, right: 16 })
      .margin({ right: 4 })
      .onClick(() => {
        this.selectedRange = range;
      })
  }

  @Builder
  Header() {
    Column() {
      Row() {
        Blank()
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill('#0EA5E9')
            .radius(4)
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        Blank()
      }
      .width('100%')
      .padding({ top: 48, bottom: 12 })
      Divider()
        .color('#D4D9E1')
        .height(1)
    }
    .backgroundColor('#F7FAFC')
  }

  @Builder
  RangeSelector() {
    Scroll() {
      Column() {
        Row() {
          ForEach(this.ranges, (range: string) => {
            this.RangeButton(range, 36)
          }, (range: string) => range)
        }
        .padding({ top: 4, bottom: 4 })
        Row() {
          ForEach(this.ranges2, (range: string) => {
            this.RangeButton(range, 40)
          }, (range: string) => range)
          Blank()
        }
        .padding({ top: 8, bottom: 8 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .scrollable(ScrollDirection.Horizontal)
  }

  @Builder
  CompareOptions() {
    Row() {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
      ForEach(this.flags, (flag: string) => {
        Button(flag)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.hasFlag(flag) ? '#0F172A' : '#0B1220')
          .backgroundColor(this.hasFlag(flag) ? '#22C55E' : '#FFFFFF')
          .border({ width: 1, color: '#D4D9E1', radius: 6 })
          .borderRadius(6)
          .height(34)
          .padding({ left: 16, right: 16 })
          .margin({ left: 4 })
          .onClick(() => {
            this.toggleFlag(flag);
          })
      }, (flag: string) => flag)
      Row() {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
          .selectedColor('#0EA5E9')
          .width(42)
          .height(24)
          .margin({ left: 2 })
          .onChange((isOn: boolean) => {
            this.darkMode = isOn;
          })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .margin({ left: 4 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ top: 6, bottom: 6 })
  }

  @Builder
  MetricCard(metric: MetricCardUi) {
    Column() {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .layoutWeight(1)
        Rect()
          .width(16)
          .height(16)
          .fill(metric.color)
          .radius(4)
      }
      .width('100%')
      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0B1220')
        .margin({ top: 4 })
      Row() {
        Rect()
          .width(6)
          .height(6)
          .radius(2)
          .fill(metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? '#16A34A' : '#EF4444')
          .margin({ left: 2 })
      }
      .margin({ top: 4 })
      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .height(120)
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column() {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .fill(chart.color)
          .radius(8)
        Row() {
          Rect().width(6).height(40).radius(2).fill('#0EA5E9')
          Rect().width(6).height(30).radius(2).fill('#22C55E').margin({ left: 4 })
          Rect().width(6).height(48).radius(2).fill('#F59E0B').margin({ left: 4 })
          Rect().width(6).height(22).radius(2).fill('#D4D9E1').margin({ left: 4 })
          Rect().width(6).height(32).radius(2).fill('#0EA5E9').margin({ left: 4 })
          Rect().width(6).height(42).radius(2).fill('#22C55E').margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .aspectRatio(1.6)
      .margin({ top: 6 })

      Row() {
        Rect().width(8).height(8).radius(2).fill('#0EA5E9')
        Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
        Rect().width(8).height(8).radius(2).fill('#22C55E').margin({ left: 4 })
        Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#0B1220').margin({ left: 4 })
      }
      .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
    .height(180)
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D4D9E1', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  DashboardGrid() {
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
    .columnsGap(8)
    .rowsGap(8)
    .width('100%')
  }

  @Builder
  NotificationBar() {
    Column() {
      Divider().color('#4DD4D9E1').height(1)
      Row() {
        Column() {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Text(this.notificationCount.toString() + ' pending')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
          .backgroundColor('#22C55E')
          .width(140)
          .height(44)
          .borderRadius(12)
          .onClick(() => {
            this.notificationCount = 0;
          })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 4, color: '#19000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.Header()
        Scroll() {
          Column() {
            this.RangeSelector()
            this.CompareOptions()
            this.DashboardGrid()
            Blank().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
        .backgroundColor('#F7FAFC')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      this.NotificationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}
