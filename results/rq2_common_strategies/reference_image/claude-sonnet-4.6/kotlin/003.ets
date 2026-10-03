class AppColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#22C55E';
  static tertiary: string = '#F59E0B';
  static background: string = '#F7FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EFF3F7';
  static outline: string = '#D4D9E1';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0F172A';
  static onTertiary: string = '#111827';
  static onBackground: string = '#0B1220';
  static onSurface: string = '#0B1220';
}

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
struct DashboardAnalytics {
  @State selectedRange: string = '7 Days';
  @State flags: string[] = [];
  @State darkOn: boolean = false;
  @State notificationCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];

  private barHeights: number[] = [40, 30, 48, 22, 32, 42];

  private barColors: string[] = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.tertiary,
    AppColors.outline,
    AppColors.primary,
    AppColors.secondary
  ];

  private kpiRows: MetricCardUi[][] = [
    [
      new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppColors.secondary),
      new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppColors.primary)
    ],
    [
      new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppColors.error),
      new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppColors.tertiary)
    ]
  ];

  private chartRows: ChartCardUi[][] = [
    [
      new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
      new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
    ],
    [
      new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
      new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
    ]
  ];

  private hasFlag(flag: string): boolean {
    return this.flags.indexOf(flag) >= 0;
  }

  private toggleFlag(flag: string): void {
    if (this.hasFlag(flag)) {
      this.flags = this.flags.filter((f: string) => f !== flag);
    } else {
      const next: string[] = this.flags.slice();
      next.push(flag);
      this.flags = next;
    }
  }

  @Builder
  kpiCard(card: MetricCardUi) {
    Column() {
      Row() {
        Text(card.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Row()
          .width(16)
          .height(16)
          .borderRadius(6)
          .backgroundColor(card.color)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(card.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .margin({ top: 6 })

      Row() {
        Row()
          .width(6)
          .height(6)
          .borderRadius(3)
          .backgroundColor(card.delta.startsWith('+') ? AppColors.success : AppColors.error)
        Text(card.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(card.delta.startsWith('+') ? AppColors.success : AppColors.error)
          .margin({ left: 3 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .height(120)
    .padding(8)
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  chartCard(card: ChartCardUi) {
    Column() {
      Text(card.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Column() {
        Row({ space: 4 }) {
          ForEach(this.barHeights, (h: number, idx: number) => {
            Row()
              .width(6)
              .height(h)
              .borderRadius(3)
              .backgroundColor(this.barColors[idx])
          }, (h: number, idx: number) => idx.toString())
        }
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(card.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 6 })

      Row({ space: 4 }) {
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(AppColors.primary)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ right: 4 })
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor(AppColors.secondary)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      // ---------------- Top app bar ----------------
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(6)
          .backgroundColor(AppColors.primary)
        Text('Analytics')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ left: 4 })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // ---------------- Scrollable body ----------------
      Scroll() {
        Column() {
          // range chips
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.ranges, (r: string) => {
              Text(r)
                .fontSize(this.selectedRange === r ? 14 : 12)
                .fontWeight(this.selectedRange === r ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.selectedRange === r ? AppColors.onPrimary : AppColors.onSurface)
                .backgroundColor(this.selectedRange === r ? AppColors.primary : AppColors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppColors.outline })
                .padding({ left: 16, right: 16, top: 9, bottom: 9 })
                .margin({ right: 4, bottom: 2 })
                .onClick(() => {
                  this.selectedRange = r;
                })
            }, (r: string) => r)
          }
          .width('100%')

          // compare row
          Column() {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Flex({ wrap: FlexWrap.Wrap }) {
              Text('Prev Period')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.hasFlag('Prev Period') ? AppColors.onSecondary : AppColors.onSurface)
                .backgroundColor(this.hasFlag('Prev Period') ? AppColors.secondary : AppColors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppColors.outline })
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .margin({ right: 4, bottom: 2 })
                .onClick(() => {
                  this.toggleFlag('Prev Period');
                })

              Text('Goal')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.hasFlag('Goal') ? AppColors.onSecondary : AppColors.onSurface)
                .backgroundColor(this.hasFlag('Goal') ? AppColors.secondary : AppColors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppColors.outline })
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .margin({ right: 4, bottom: 2 })
                .onClick(() => {
                  this.toggleFlag('Goal');
                })

              Row() {
                Text('Dark')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                  .margin({ right: 4 })
                Toggle({ type: ToggleType.Switch, isOn: this.darkOn })
                  .selectedColor(AppColors.primary)
                  .switchPointColor(AppColors.surface)
                  .onChange((isOn: boolean) => {
                    this.darkOn = isOn;
                  })
              }
              .alignItems(VerticalAlign.Center)
              .margin({ left: 4, bottom: 2 })
            }
            .width('100%')
            .margin({ top: 2 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 8 })

          // KPI cards (2 columns)
          ForEach(this.kpiRows, (row: MetricCardUi[], rowIdx: number) => {
            Row({ space: 8 }) {
              ForEach(row, (card: MetricCardUi) => {
                this.kpiCard(card)
              }, (card: MetricCardUi) => 'kpi-' + card.id.toString())
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 8 })
          }, (row: MetricCardUi[], rowIdx: number) => 'kpi-row-' + rowIdx.toString())

          // Chart cards (2 columns)
          ForEach(this.chartRows, (row: ChartCardUi[], rowIdx: number) => {
            Row({ space: 8 }) {
              ForEach(row, (card: ChartCardUi) => {
                this.chartCard(card)
              }, (card: ChartCardUi) => 'chart-' + card.id.toString())
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 8 })
          }, (row: ChartCardUi[], rowIdx: number) => 'chart-row-' + rowIdx.toString())
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 8, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ---------------- Bottom bar ----------------
      Row() {
        Column() {
          Text('Notifications')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(`${this.notificationCount} pending`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {
            this.notificationCount = 0;
          })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}