const NAME: string = '006_DashboardAnalytics_en';
const UI_TYPE: string = 'Dashboard Analytics';
const STYLE_THEME: string = 'Corporate Dashboard';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#22C55E';
  static readonly tertiary: string = '#F59E0B';
  static readonly background: string = '#F7FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EFF3F7';
  static readonly outline: string = '#D4D9E1';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
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
struct MainActivity {
  @State selectedRange: string = '7 Days';
  @State flags: string[] = [];
  @State darkSwitch: boolean = false;
  @State notif: number = 2;
  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];
  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppColors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppColors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppColors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppColors.tertiary)
  ];
  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
  ];

  toggleFlag(label: string): void {
    if (this.flags.includes(label)) {
      this.flags = this.flags.filter((item: string) => item !== label);
    } else {
      this.flags = [...this.flags, label];
    }
  }

  @Builder
  Header(): void {
    Row({ space: AppSpacing.sm }) {
      Rect()
        .width(20)
        .height(20)
        .fill(AppColors.primary)
        .radius(6);
      Text('Analytics')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  RangeFilters(): void {
    Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(AppSpacing.sm), cross: LengthMetrics.vp(AppSpacing.xs) } }) {
      ForEach(this.ranges, (range: string) => {
        Button(range)
          .fontSize(range === this.selectedRange ? 14 : 12)
          .fontWeight(range === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(range === this.selectedRange ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(range === this.selectedRange ? AppColors.primary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(8)
          .height(36)
          .padding({ left: 10, right: 10 })
          .onClick(() => {
            this.selectedRange = range;
          });
      }, (range: string) => range)
    }
    .width('100%');
  }

  @Builder
  CompareChip(label: string): void {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.flags.includes(label) ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.flags.includes(label) ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(6)
      .height(32)
      .padding({ left: 10, right: 10 })
      .onClick(() => {
        this.toggleFlag(label);
      });
  }

  @Builder
  Controls(): void {
    Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(AppSpacing.sm), cross: LengthMetrics.vp(AppSpacing.xs) } }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .height(32);
      this.CompareChip('Prev Period');
      this.CompareChip('Goal');
      Row({ space: AppSpacing.xs }) {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .selectedColor(AppColors.primary)
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn;
          });
      }
      .height(32)
      .alignItems(VerticalAlign.Center);
    }
    .width('100%');
  }

  @Builder
  KpiCard(metric: MetricCardUi): void {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Blank();
        Rect()
          .width(16)
          .height(16)
          .fill(metric.color)
          .radius(6);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);

      Row({ space: AppSpacing.xs }) {
        Circle()
          .width(6)
          .height(6)
          .fill(metric.delta.startsWith('+') ? AppColors.success : AppColors.error);
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? AppColors.success : AppColors.error);
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ChartBars(): void {
    Row({ space: AppSpacing.sm }) {
      Rect().width(6).height(40).fill(AppColors.primary).radius(6);
      Rect().width(6).height(30).fill(AppColors.secondary).radius(6);
      Rect().width(6).height(48).fill(AppColors.tertiary).radius(6);
      Rect().width(6).height(22).fill(AppColors.outline).radius(6);
      Rect().width(6).height(32).fill(AppColors.primary).radius(6);
      Rect().width(6).height(42).fill(AppColors.secondary).radius(6);
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center);
  }

  @Builder
  ChartCard(chart: ChartCardUi): void {
    Column({ space: AppSpacing.md }) {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);

      Stack() {
        this.ChartBars();
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(chart.color)
      .borderRadius(8)
      .alignContent(Alignment.Center);

      Row({ space: AppSpacing.sm }) {
        Rect().width(8).height(8).fill(AppColors.primary).radius(6);
        Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor(AppColors.onSurface);
        Rect().width(8).height(8).fill(AppColors.secondary).radius(6);
        Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor(AppColors.onSurface);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  DashboardGrid(): void {
    Grid() {
      ForEach(this.kpis, (metric: MetricCardUi) => {
        GridItem() {
          this.KpiCard(metric);
        }
      }, (metric: MetricCardUi) => metric.id.toString())
      ForEach(this.charts, (chart: ChartCardUi) => {
        GridItem() {
          this.ChartCard(chart);
        }
      }, (chart: ChartCardUi) => chart.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppSpacing.lg)
    .rowsGap(AppSpacing.lg)
    .padding({ bottom: AppSpacing.xxxl })
    .layoutWeight(1);
  }

  @Builder
  BottomBar(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(`${this.notif} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('Mark All Read')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width(140)
        .height(44)
        .onClick(() => {
          this.notif = 0;
        });
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.md }) {
        this.RangeFilters();
        this.Controls();
        this.DashboardGrid();
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.lg });
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
