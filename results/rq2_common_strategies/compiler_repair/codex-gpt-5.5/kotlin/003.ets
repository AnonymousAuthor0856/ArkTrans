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

class DashColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#22C55E';
  static tertiary: string = '#F59E0B';
  static background: string = '#F7FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EFF3F7';
  static outline: string = '#D4D9E1';
  static success: string = '#16A34A';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0F172A';
  static onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  @State selectedRange: string = '7 Days';
  @State prevSelected: boolean = false;
  @State goalSelected: boolean = false;
  @State darkSwitch: boolean = false;
  @State notifications: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];
  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', DashColors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', DashColors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', DashColors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', DashColors.tertiary)
  ];
  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
  ];

  @Builder
  RangeChip(label: string) {
    Text(label)
      .fontSize(this.selectedRange === label ? 14 : 12)
      .fontWeight(this.selectedRange === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === label ? DashColors.onPrimary : DashColors.onSurface)
      .lineHeight(this.selectedRange === label ? 18 : 16)
      .padding({ left: 10, right: 10, top: 7, bottom: 7 })
      .backgroundColor(this.selectedRange === label ? DashColors.primary : DashColors.surface)
      .border({ width: 1, color: DashColors.outline, radius: 8 })
      .onClick(() => {
        this.selectedRange = label;
      })
  }

  @Builder
  Assist(label: string, active: boolean, action: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? DashColors.onSecondary : DashColors.onSurface)
      .lineHeight(14)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(active ? DashColors.secondary : DashColors.surface)
      .border({ width: 1, color: DashColors.outline, radius: 6 })
      .onClick(action)
  }

  @Builder
  KpiCard(metric: MetricCardUi) {
    Column({ space: 4 }) {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(DashColors.onSurface)
          .lineHeight(18)
          .layoutWeight(1)
        Blank()
          .width(16)
          .height(16)
          .backgroundColor(metric.color)
          .borderRadius(6)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(DashColors.onSurface)
        .lineHeight(24)

      Row({ space: 2 }) {
        Blank()
          .width(6)
          .height(6)
          .backgroundColor(metric.delta.startsWith('+') ? DashColors.success : DashColors.error)
          .borderRadius(6)
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? DashColors.success : DashColors.error)
          .lineHeight(14)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(8)
    .backgroundColor(DashColors.surface)
    .border({ width: 1, color: DashColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ChartBars() {
    Row({ space: 4 }) {
      Blank().width(6).height(40).backgroundColor(DashColors.primary).borderRadius(6)
      Blank().width(6).height(30).backgroundColor(DashColors.secondary).borderRadius(6)
      Blank().width(6).height(48).backgroundColor(DashColors.tertiary).borderRadius(6)
      Blank().width(6).height(22).backgroundColor(DashColors.outline).borderRadius(6)
      Blank().width(6).height(32).backgroundColor(DashColors.primary).borderRadius(6)
      Blank().width(6).height(42).backgroundColor(DashColors.secondary).borderRadius(6)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column({ space: 6 }) {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(DashColors.onSurface)
        .lineHeight(18)
      Stack() {
        this.ChartBars()
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(chart.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row({ space: 4 }) {
        Blank().width(8).height(8).backgroundColor(DashColors.primary).borderRadius(6)
        Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor(DashColors.onSurface).lineHeight(14)
        Blank().width(8).height(8).backgroundColor(DashColors.secondary).borderRadius(6)
        Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor(DashColors.onSurface).lineHeight(14)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(8)
    .backgroundColor(DashColors.surface)
    .border({ width: 1, color: DashColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      Row({ space: 4 }) {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(DashColors.primary)
          .borderRadius(6)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(DashColors.onSurface)
          .lineHeight(30)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(DashColors.surface)

      Column({ space: 8 }) {
        Row({ space: 4 }) {
          ForEach(this.ranges, (range: string) => {
            this.RangeChip(range)
          }, (range: string) => range)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row({ space: 4 }) {
          Text('Compare')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(DashColors.onSurface)
            .lineHeight(14)
            .padding({ top: 6, bottom: 6 })
          this.Assist('Prev Period', this.prevSelected, () => {
            this.prevSelected = !this.prevSelected;
          })
          this.Assist('Goal', this.goalSelected, () => {
            this.goalSelected = !this.goalSelected;
          })
          Row({ space: 2 }) {
            Text('Dark')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(DashColors.onSurface)
              .lineHeight(14)
            Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
              .selectedColor(DashColors.primary)
              .onChange((isOn: boolean) => {
                this.darkSwitch = isOn;
              })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Grid() {
          ForEach(this.kpis, (metric: MetricCardUi) => {
            GridItem() {
              this.KpiCard(metric)
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
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })

      Row() {
        Column({ space: 2 }) {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(DashColors.onSurface)
            .lineHeight(14)
          Text(this.notifications.toString() + ' pending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(DashColors.onSurface)
            .lineHeight(24)
        }
        Button('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(DashColors.onSecondary)
          .backgroundColor(DashColors.secondary)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {
            this.notifications = 0;
          })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(DashColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DashColors.background)
  }
}
