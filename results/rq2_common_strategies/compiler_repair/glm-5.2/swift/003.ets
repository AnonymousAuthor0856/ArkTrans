// ColorUtils.ets
export class ColorUtils {
  static fromHex(hex: number): ResourceColor {
    const red = (hex >> 16) & 0xFF;
    const green = (hex >> 8) & 0xFF;
    const blue = hex & 0xFF;
    return `rgb(${red}, ${green}, ${blue})`;
  }
}

// AppTokens.ets
interface AppColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
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

export class AppTokens {
  static Colors: AppColors = {
    primary: ColorUtils.fromHex(0xFF0EA5E9),
    secondary: ColorUtils.fromHex(0xFF22C55E),
    tertiary: ColorUtils.fromHex(0xFFF59E0B),
    background: ColorUtils.fromHex(0xFFF7FAFC),
    surface: ColorUtils.fromHex(0xFFFFFFFF),
    surfaceVariant: ColorUtils.fromHex(0xFFEFF3F7),
    outline: ColorUtils.fromHex(0xFFD4D9E1),
    success: ColorUtils.fromHex(0xFF16A34A),
    warning: ColorUtils.fromHex(0xFFF59E0B),
    error: ColorUtils.fromHex(0xFFEF4444),
    onPrimary: ColorUtils.fromHex(0xFFFFFFFF),
    onSecondary: ColorUtils.fromHex(0xFF0F172A),
    onTertiary: ColorUtils.fromHex(0xFF111827),
    onBackground: ColorUtils.fromHex(0xFF0B1220),
    onSurface: ColorUtils.fromHex(0xFF0B1220),
  };

  static Spacing: AppSpacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  };
}

// Models.ets
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

// ContentView.ets
@Entry
@Component
struct ContentView {
  @State selectedRange: string = "7 Days";
  @State selectedFlags: Set<string> = new Set();
  @State darkMode: boolean = false;
  @State notificationCount: number = 2;

  private ranges: string[] = ["Today", "7 Days", "30 Days", "90 Days"];
  private ranges2: string[] = ["YTD", "Custom"];
  private flags: string[] = ["Prev Period", "Goal"];

  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, "Revenue", "$24,560", "+8.2%", AppTokens.Colors.secondary),
    new MetricCardUi(2, "Orders", "1,284", "+3.1%", AppTokens.Colors.primary),
    new MetricCardUi(3, "Refunds", "42", "-1.4%", AppTokens.Colors.error),
    new MetricCardUi(4, "Active Users", "8,921", "+5.6%", AppTokens.Colors.tertiary)
  ];

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, "Sales Trend", ColorUtils.fromHex(0xFFE0F2FE)),
    new ChartCardUi(2, "Conversion Funnel", ColorUtils.fromHex(0xFFEFF6FF))
  ];

  toggleFlag(flag: string) {
    if (this.selectedFlags.has(flag)) {
      this.selectedFlags.delete(flag);
    } else {
      this.selectedFlags.add(flag);
    }
    // Trigger re-render
    this.selectedFlags = new Set(this.selectedFlags);
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Blank()
          Row({ space: AppTokens.Spacing.sm }) {
            Rect()
              .width(20)
              .height(20)
              .radiusWidth(4)
              .radiusHeight(4)
              .fill(AppTokens.Colors.primary)
            Text("Analytics")
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
          }
          Blank()
        }
        .width('100%')
        .padding({ top: 48, bottom: 12 })
        .backgroundColor(AppTokens.Colors.background)

        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Date Range Selector
            Scroll() {
              Column({ space: AppTokens.Spacing.md }) {
                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    Button() {
                      Text(range)
                        .fontSize(this.selectedRange === range ? 14 : 12)
                        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    }
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .onClick(() => {
                      this.selectedRange = range;
                    })
                  })
                }
                .padding({ top: 4, bottom: 4 })

                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    Button() {
                      Text(range)
                        .fontSize(this.selectedRange === range ? 14 : 12)
                        .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                    }
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .onClick(() => {
                      this.selectedRange = range;
                    })
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
              Text("Compare")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.flags, (flag: string) => {
                Button() {
                  Text(flag)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedFlags.has(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                    .maxLines(1)
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor(this.selectedFlags.has(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.toggleFlag(flag);
                })
              })

              // Dark Mode Toggle
              Row({ space: AppTokens.Spacing.xs }) {
                Text("Dark")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(AppTokens.Colors.primary)
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn;
                  })
                  .scale({ x: 0.8, y: 0.8 })
              }
              .layoutWeight(1)
            }
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid
            Grid() {
              ForEach(this.kpis, (metric: MetricCardUi) => {
                GridItem() {
                  MetricCardView({ metric: metric })
                }
              })

              ForEach(this.charts, (chart: ChartCardUi) => {
                GridItem() {
                  ChartCardView({ chart: chart })
                }
              })
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
          .strokeWidth(1)
          .opacity(0.3)

        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text("Notifications")
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`${this.notificationCount} pending`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text("Mark All Read")
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
              .textAlign(TextAlign.Center)
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
          .onClick(() => {
            this.notificationCount = 0;
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
  }
}

// MetricCardView Component
@Component
struct MetricCardView {
  private metric: MetricCardUi = new MetricCardUi(0, "", "", "", Color.Black);

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Rect()
          .width(16)
          .height(16)
          .radiusWidth(4)
          .radiusHeight(4)
          .fill(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Rect()
          .width(6)
          .height(6)
          .radiusWidth(2)
          .radiusHeight(2)
          .fill(this.metric.delta.startsWith("+") ? AppTokens.Colors.success : AppTokens.Colors.error)
        Text(this.metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.metric.delta.startsWith("+") ? AppTokens.Colors.success : AppTokens.Colors.error)
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
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 2 })
  }
}

// ChartCardView Component
@Component
struct ChartCardView {
  private chart: ChartCardUi = new ChartCardUi(0, "", Color.Black);

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Stack() {
        Column() {
          Row({ space: AppTokens.Spacing.sm }) {
            Rect().width(6).height(40).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.primary)
            Rect().width(6).height(30).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.secondary)
            Rect().width(6).height(48).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.tertiary)
            Rect().width(6).height(22).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.outline)
            Rect().width(6).height(32).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.primary)
            Rect().width(6).height(42).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.secondary)
          }
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .aspectRatio(1.6)
      .backgroundColor(this.chart.color)
      .borderRadius(8)

      // Chart legend
      Row({ space: AppTokens.Spacing.sm }) {
        Rect().width(8).height(8).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.primary)
        Text("Series A")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Rect().width(8).height(8).radiusWidth(2).radiusHeight(2).fill(AppTokens.Colors.secondary)
        Text("Series B")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
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
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 2 })
  }
}