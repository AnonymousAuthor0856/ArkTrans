//
//  ContentView.ets
//  1
//

// MARK: - Design Tokens
interface AppColors {
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

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
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
    onSurface: '#0B1220'
  };

  static readonly TypographyTokens: AppTypography = {
    display: { size: 24, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Spacing: AppSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Shapes: AppShapes = {
    small: 6, medium: 8, large: 12
  };
}

// MARK: - Data Models
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

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedRange: string = '7 Days';
  @State selectedFlags: string[] = [];
  @State darkMode: boolean = false;
  @State notificationCount: number = 2;

  ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  ranges2: string[] = ['YTD', 'Custom'];
  flags: string[] = ['Prev Period', 'Goal'];

  kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ];

  charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        Row() {
          Blank()
          Row({ space: AppTokens.Spacing.sm }) {
            Row()
              .width(20)
              .height(20)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)

            Text('Analytics')
              .fontSize(AppTokens.TypographyTokens.display.size)
              .fontWeight(AppTokens.TypographyTokens.display.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          Blank()
        }
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppTokens.Colors.background)

        Divider()

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Date Range Selector
            Column({ space: AppTokens.Spacing.sm }) {
              Scroll() {
                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    Button(range)
                      .fontSize(this.selectedRange === range ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                      .fontWeight(this.selectedRange === range ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                      .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                      .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                      .borderRadius(AppTokens.Shapes.medium)
                      .border({ width: 1, color: AppTokens.Colors.outline })
                      .onClick(() => { this.selectedRange = range; })
                  }, (range: string) => range)
                }
                .padding({ top: 4, bottom: 4 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)

              Scroll() {
                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    Button(range)
                      .fontSize(this.selectedRange === range ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                      .fontWeight(this.selectedRange === range ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                      .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                      .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                      .borderRadius(AppTokens.Shapes.medium)
                      .border({ width: 1, color: AppTokens.Colors.outline })
                      .onClick(() => { this.selectedRange = range; })
                  }, (range: string) => range)
                  Blank()
                }
                .padding({ top: 8, bottom: 8 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }

            // Comparison Options
            Row({ space: AppTokens.Spacing.sm }) {
              Text('Compare')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.flags, (flag: string) => {
                Button(flag)
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(this.selectedFlags.includes(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                  .maxLines(1)
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .backgroundColor(this.selectedFlags.includes(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .onClick(() => {
                    if (this.selectedFlags.includes(flag)) {
                      this.selectedFlags = this.selectedFlags.filter((f: string) => f !== flag);
                    } else {
                      this.selectedFlags = this.selectedFlags.concat([flag]);
                    }
                  })
              }, (flag: string) => flag)

              // Dark Mode Toggle
              Row({ space: AppTokens.Spacing.xs }) {
                Text('Dark')
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(AppTokens.Colors.primary)
                  .width(36)
                  .height(20)
                  .scale({ x: 0.8, y: 0.8 })
                  .onChange((isOn: boolean) => { this.darkMode = isOn; })
              }
              .width('100%')
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

            Blank()
              .height(80)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar
      Column() {
        Blank()
        Column({ space: 0 }) {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.outline)
            .opacity(0.3)

          Row() {
            Column({ space: AppTokens.Spacing.xs }) {
              Text('Notifications')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.notificationCount + ' pending')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Mark All Read')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .onClick(() => { this.notificationCount = 0; })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
        }
      }
      .width('100%')
      .height('100%')
    }
  }
}

// MARK: - Metric Card View
@Component
struct MetricCardView {
  @Prop metric: MetricCardUi = new MetricCardUi(0, '', '', '', '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Row()
          .width(16)
          .height(16)
          .backgroundColor(this.metric.color)
          .borderRadius(4)
      }

      Text(this.metric.value)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Row()
          .width(6)
          .height(6)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(2)

        Text(this.metric.delta)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
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
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Chart Card View
@Component
struct ChartCardView {
  @Prop chart: ChartCardUi = new ChartCardUi(0, '', '');

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Stack() {
        Row({ space: AppTokens.Spacing.sm }) {
          Row().width(6).height(40).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
          Row().width(6).height(30).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
          Row().width(6).height(48).backgroundColor(AppTokens.Colors.tertiary).borderRadius(2)
          Row().width(6).height(22).backgroundColor(AppTokens.Colors.outline).borderRadius(2)
          Row().width(6).height(32).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
          Row().width(6).height(42).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
        }
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(this.chart.color)
      .borderRadius(AppTokens.Shapes.medium)

      // Chart legend
      Row({ space: AppTokens.Spacing.sm }) {
        Row().width(8).height(8).backgroundColor(AppTokens.Colors.primary).borderRadius(2)
        Text('Series A')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Row().width(8).height(8).backgroundColor(AppTokens.Colors.secondary).borderRadius(2)
        Text('Series B')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .height(180)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}
