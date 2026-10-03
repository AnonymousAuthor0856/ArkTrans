//
//  ContentView.swift
//  1
//
//  Created by hang on 2025/10/12.
//
//  Translated from SwiftUI (ContentView.swift) to ArkUI (ArkTS).
//

// MARK: - Design Tokens - Exact values from Kotlin

// SwiftUI Color(hex: 0xAARRGGBB) values map to ArkUI '#AARRGGBB' color strings.
class AppTokensColors {
  readonly primary: string = '#FF0EA5E9';
  readonly secondary: string = '#FF22C55E';
  readonly tertiary: string = '#FFF59E0B';
  readonly background: string = '#FFF7FAFC';
  readonly surface: string = '#FFFFFFFF';
  readonly surfaceVariant: string = '#FFEFF3F7';
  readonly outline: string = '#FFD4D9E1';
  readonly success: string = '#FF16A34A';
  readonly warning: string = '#FFF59E0B';
  readonly error: string = '#FFEF4444';
  readonly onPrimary: string = '#FFFFFFFF';
  readonly onSecondary: string = '#FF0F172A';
  readonly onTertiary: string = '#FF111827';
  readonly onBackground: string = '#FF0B1220';
  readonly onSurface: string = '#FF0B1220';
}

// Bundles a font size with a font weight (SwiftUI Font.system(size:weight:)).
class FontToken {
  size: number;
  weight: FontWeight;
  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTokensTypography {
  readonly display: FontToken = new FontToken(24, FontWeight.Bold);
  readonly headline: FontToken = new FontToken(18, FontWeight.Bold);
  readonly title: FontToken = new FontToken(14, FontWeight.Medium);
  readonly body: FontToken = new FontToken(12, FontWeight.Regular);
  readonly label: FontToken = new FontToken(10, FontWeight.Medium);
}

class AppTokensSpacing {
  readonly xs: number = 2;
  readonly sm: number = 4;
  readonly md: number = 6;
  readonly lg: number = 8;
  readonly xl: number = 12;
  readonly xxl: number = 16;
  readonly xxxl: number = 24;
}

// RoundedRectangle(cornerRadius:) values.
class AppTokensShapes {
  readonly small: number = 6;
  readonly medium: number = 8;
  readonly large: number = 12;
}

// Facade preserving the original AppTokens.Colors.primary-style access.
class AppTokens {
  static readonly Colors: AppTokensColors = new AppTokensColors();
  static readonly TypographyTokens: AppTokensTypography = new AppTokensTypography();
  static readonly Spacing: AppTokensSpacing = new AppTokensSpacing();
  static readonly Shapes: AppTokensShapes = new AppTokensShapes();
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

// MARK: - Metric Card View
@Component
struct MetricCardView {
  metric: MetricCardUi = new MetricCardUi(0, '', '', '', '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Rect({ width: 16, height: 16, radius: 4 })
          .fill(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Rect({ width: 6, height: 6, radius: 2 })
          .fill(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
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
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Chart Card View
@Component
struct ChartCardView {
  chart: ChartCardUi = new ChartCardUi(0, '', '');

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Stack() {
        // Bar chart representation
        Row({ space: AppTokens.Spacing.sm }) {
          Rect({ width: 6, height: 40, radius: 2 }).fill(AppTokens.Colors.primary)
          Rect({ width: 6, height: 30, radius: 2 }).fill(AppTokens.Colors.secondary)
          Rect({ width: 6, height: 48, radius: 2 }).fill(AppTokens.Colors.tertiary)
          Rect({ width: 6, height: 22, radius: 2 }).fill(AppTokens.Colors.outline)
          Rect({ width: 6, height: 32, radius: 2 }).fill(AppTokens.Colors.primary)
          Rect({ width: 6, height: 42, radius: 2 }).fill(AppTokens.Colors.secondary)
        }
      }
      .backgroundColor(this.chart.color)
      .borderRadius(AppTokens.Shapes.medium)
      .aspectRatio(1.6)
      .width('100%')

      // Chart legend
      Row({ space: AppTokens.Spacing.sm }) {
        Rect({ width: 8, height: 8, radius: 2 }).fill(AppTokens.Colors.primary)
        Text('Series A')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Rect({ width: 8, height: 8, radius: 2 }).fill(AppTokens.Colors.secondary)
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
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.outline })
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

  readonly ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  readonly ranges2: string[] = ['YTD', 'Custom'];
  readonly flags: string[] = ['Prev Period', 'Goal'];

  readonly kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ];

  readonly charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#FFE0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#FFEFF6FF')
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header - Exact replica of CenterAlignedTopAppBar
        Row() {
          Blank()
          Row({ space: AppTokens.Spacing.sm }) {
            Rect({ width: 20, height: 20, radius: 4 })
              .fill(AppTokens.Colors.primary)
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
            Scroll() {
              Row() {
                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges, (range: string) => {
                    Button({ type: ButtonType.Normal, stateEffect: false }) {
                      Text(range)
                        .fontSize(this.selectedRange === range ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                        .fontWeight(this.selectedRange === range ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    }
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.medium)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .onClick(() => {
                      this.selectedRange = range;
                    })
                  }, (range: string) => range)
                }
                .padding({ top: 4, bottom: 4 })

                Row({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.ranges2, (range: string) => {
                    Button({ type: ButtonType.Normal, stateEffect: false }) {
                      Text(range)
                        .fontSize(this.selectedRange === range ? AppTokens.TypographyTokens.title.size : AppTokens.TypographyTokens.body.size)
                        .fontWeight(this.selectedRange === range ? AppTokens.TypographyTokens.title.weight : AppTokens.TypographyTokens.body.weight)
                        .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    }
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.medium)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .onClick(() => {
                      this.selectedRange = range;
                    })
                  }, (range: string) => range)
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
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.flags, (flag: string) => {
                Button({ type: ButtonType.Normal, stateEffect: false }) {
                  Text(flag)
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(this.selectedFlags.includes(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                    .maxLines(1)
                }
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
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn;
                  })
                  .selectedColor(AppTokens.Colors.primary)
                  .scale({ x: 0.8, y: 0.8 })
              }
              .layoutWeight(1)
              .alignItems(VerticalAlign.Center)
            }
            .padding({ top: 6, bottom: 6 })

            // Metrics Grid
            Grid() {
              // First row: Revenue and Orders
              GridItem() {
                MetricCardView({ metric: this.kpis[0] })
              }
              GridItem() {
                MetricCardView({ metric: this.kpis[1] })
              }
              // Second row: Refunds and Active Users
              GridItem() {
                MetricCardView({ metric: this.kpis[2] })
              }
              GridItem() {
                MetricCardView({ metric: this.kpis[3] })
              }
              // Charts row
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

            Blank().height(80)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Notification Bar
      Column() {
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

          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text('Mark All Read')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.notificationCount = 0;
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Preview
// NOTE: SwiftUI PreviewProvider is not applicable in ArkUI; previews are
// handled by the DevEco previewer. The @Entry decorator above marks the page.

// @main
// struct DashboardApp: App {
//   var body: some Scene {
//     WindowGroup {
//       ContentView() // Replace with your main view
//     }
//   }
// }
