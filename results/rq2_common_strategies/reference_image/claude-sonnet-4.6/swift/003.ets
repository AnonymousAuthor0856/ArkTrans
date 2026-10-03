/*
 * Index.ets — ArkTS (ArkUI declarative) port of ContentView.swift
 * HarmonyOS NEXT / API 12+
 */

// ───────────────────────────── Design tokens ─────────────────────────────
class AppTokens {
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

class Spacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class Radius {
  static readonly small: number = 6;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class Typo {
  static readonly display: number = 24;   // semibold
  static readonly headline: number = 18;  // semibold
  static readonly title: number = 14;     // medium
  static readonly body: number = 12;      // regular
  static readonly label: number = 10;     // medium
}

// ───────────────────────────── Data models ─────────────────────────────
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

// ───────────────────────────── Metric card ─────────────────────────────
@Component
struct MetricCardView {
  @Prop metric: MetricCardUi = new MetricCardUi(0, '', '', '', '#FFFFFF');

  build() {
    Column({ space: Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(Typo.title)
          .fontWeight(500)
          .fontColor(AppTokens.onSurface)

        Blank()

        Row() {
        }
        .width(16)
        .height(16)
        .borderRadius(4)
        .backgroundColor(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontSize(Typo.headline)
        .fontWeight(600)
        .fontColor(AppTokens.onSurface)

      Row({ space: Spacing.xs }) {
        Row() {
        }
        .width(6)
        .height(6)
        .borderRadius(2)
        .backgroundColor(this.metric.delta.startsWith('+') ? AppTokens.success : AppTokens.error)

        Text(this.metric.delta)
          .fontSize(Typo.label)
          .fontWeight(500)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.success : AppTokens.error)
      }

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.lg)
    .height(120)
    .backgroundColor(AppTokens.surface)
    .borderRadius(Radius.large)
    .border({ width: 1, color: AppTokens.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

// ───────────────────────────── Chart card ─────────────────────────────
@Component
struct ChartCardView {
  @Prop chart: ChartCardUi = new ChartCardUi(0, '', '#FFFFFF');

  build() {
    Column({ space: Spacing.md }) {
      Text(this.chart.title)
        .fontSize(Typo.title)
        .fontWeight(500)
        .fontColor(AppTokens.onSurface)

      Stack({ alignContent: Alignment.Bottom }) {
        Row({ space: Spacing.sm }) {
          Row() {
          }.width(6).height(40).borderRadius(2).backgroundColor(AppTokens.primary)

          Row() {
          }.width(6).height(30).borderRadius(2).backgroundColor(AppTokens.secondary)

          Row() {
          }.width(6).height(48).borderRadius(2).backgroundColor(AppTokens.tertiary)

          Row() {
          }.width(6).height(22).borderRadius(2).backgroundColor(AppTokens.outline)

          Row() {
          }.width(6).height(32).borderRadius(2).backgroundColor(AppTokens.primary)

          Row() {
          }.width(6).height(42).borderRadius(2).backgroundColor(AppTokens.secondary)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: 12 })
      .backgroundColor(this.chart.color)
      .borderRadius(Radius.medium)

      Row({ space: Spacing.sm }) {
        Row() {
        }.width(8).height(8).borderRadius(2).backgroundColor(AppTokens.primary)

        Text('Series A')
          .fontSize(Typo.label)
          .fontWeight(500)
          .fontColor(AppTokens.onSurface)

        Row() {
        }.width(8).height(8).borderRadius(2).backgroundColor(AppTokens.secondary)

        Text('Series B')
          .fontSize(Typo.label)
          .fontWeight(500)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.lg)
    .height(180)
    .backgroundColor(AppTokens.surface)
    .borderRadius(Radius.large)
    .border({ width: 1, color: AppTokens.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 2 })
  }
}

// ───────────────────────────── Screen ─────────────────────────────
@Entry
@Component
struct DashboardPage {
  @State selectedRange: string = '7 Days';
  @State selectedFlags: string[] = [];
  @State darkMode: boolean = false;
  @State notificationCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days'];
  private ranges2: string[] = ['YTD', 'Custom'];
  private flags: string[] = ['Prev Period', 'Goal'];

  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.tertiary)
  ];

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF')
  ];

  private isFlagSelected(flag: string): boolean {
    return this.selectedFlags.indexOf(flag) >= 0;
  }

  private toggleFlag(flag: string): void {
    const next: string[] = this.selectedFlags.slice();
    const idx: number = next.indexOf(flag);
    if (idx >= 0) {
      next.splice(idx, 1);
    } else {
      next.push(flag);
    }
    this.selectedFlags = next;
  }

  // ── Center-aligned top app bar ──
  @Builder
  AppBar() {
    Row() {
      Row({ space: Spacing.sm }) {
        Row() {
        }
        .width(20)
        .height(20)
        .borderRadius(4)
        .backgroundColor(AppTokens.primary)

        Text('Analytics')
          .fontSize(Typo.display)
          .fontWeight(600)
          .fontColor(AppTokens.onSurface)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 48, bottom: Spacing.xl })
    .backgroundColor(AppTokens.background)
  }

  // ── Filter chip ──
  @Builder
  RangeChip(label: string, vPad: number) {
    Text(label)
      .fontSize(this.selectedRange === label ? Typo.title : Typo.body)
      .fontWeight(this.selectedRange === label ? 500 : 400)
      .fontColor(this.selectedRange === label ? AppTokens.onPrimary : AppTokens.onSurface)
      .padding({ left: 16, right: 16, top: vPad, bottom: vPad })
      .backgroundColor(this.selectedRange === label ? AppTokens.primary : AppTokens.surface)
      .borderRadius(Radius.medium)
      .border({ width: 1, color: AppTokens.outline })
      .onClick(() => {
        this.selectedRange = label;
      })
  }

  // ── Comparison chip ──
  @Builder
  FlagChip(flag: string) {
    Text(flag)
      .fontSize(Typo.label)
      .fontWeight(500)
      .fontColor(this.isFlagSelected(flag) ? AppTokens.onSecondary : AppTokens.onSurface)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .backgroundColor(this.isFlagSelected(flag) ? AppTokens.secondary : AppTokens.surface)
      .borderRadius(Radius.small)
      .border({ width: 1, color: AppTokens.outline })
      .onClick(() => {
        this.toggleFlag(flag);
      })
  }

  // ── Bottom notification bar ──
  @Builder
  NotificationBar() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color('#4DD4D9E1')

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Notifications')
            .fontSize(Typo.label)
            .fontWeight(500)
            .fontColor(AppTokens.onSurface)

          Text(`${this.notificationCount} pending`)
            .fontSize(Typo.headline)
            .fontWeight(600)
            .fontColor(AppTokens.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Mark All Read')
          .type(ButtonType.Normal)
          .borderRadius(Radius.large)
          .backgroundColor(AppTokens.secondary)
          .fontColor(AppTokens.onSecondary)
          .fontSize(Typo.title)
          .fontWeight(500)
          .width(140)
          .height(44)
          .onClick(() => {
            this.notificationCount = 0;
          })
      }
      .width('100%')
      .padding({
        left: Spacing.lg,
        right: Spacing.lg,
        top: Spacing.md,
        bottom: Spacing.md
      })
      .backgroundColor(AppTokens.surface)
    }
    .width('100%')
    .backgroundColor(AppTokens.surface)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.AppBar()

        Divider()
          .strokeWidth(1)
          .color(AppTokens.outline)

        Scroll() {
          Column({ space: Spacing.md }) {
            // ── Date range selector ──
            Scroll() {
              Column({ space: Spacing.xs }) {
                Row({ space: Spacing.sm }) {
                  ForEach(this.ranges, (item: string) => {
                    this.RangeChip(item, 8)
                  }, (item: string) => item)
                }
                .padding({ top: Spacing.sm, bottom: Spacing.sm })

                Row({ space: Spacing.sm }) {
                  ForEach(this.ranges2, (item: string) => {
                    this.RangeChip(item, 10)
                  }, (item: string) => item)
                }
                .padding({ top: Spacing.lg, bottom: Spacing.lg })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // ── Comparison options + dark mode toggle ──
            Row({ space: Spacing.sm }) {
              Text('Compare')
                .fontSize(Typo.label)
                .fontWeight(500)
                .fontColor(AppTokens.onSurface)

              ForEach(this.flags, (flag: string) => {
                this.FlagChip(flag)
              }, (flag: string) => flag)

              Row({ space: Spacing.xs }) {
                Text('Dark')
                  .fontSize(Typo.label)
                  .fontWeight(500)
                  .fontColor(AppTokens.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                  .selectedColor(AppTokens.primary)
                  .switchPointColor(AppTokens.onPrimary)
                  .scale({ x: 0.8, y: 0.8 })
                  .onChange((isOn: boolean) => {
                    this.darkMode = isOn;
                  })
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Start)
            }
            .width('100%')
            .padding({ top: Spacing.md, bottom: Spacing.md })

            // ── Metrics grid (2 columns) ──
            Row({ space: Spacing.lg }) {
              MetricCardView({ metric: this.kpis[0] }).layoutWeight(1)
              MetricCardView({ metric: this.kpis[1] }).layoutWeight(1)
            }
            .width('100%')

            Row({ space: Spacing.lg }) {
              MetricCardView({ metric: this.kpis[2] }).layoutWeight(1)
              MetricCardView({ metric: this.kpis[3] }).layoutWeight(1)
            }
            .width('100%')

            // ── Charts ──
            Row({ space: Spacing.lg }) {
              ChartCardView({ chart: this.charts[0] }).layoutWeight(1)
              ChartCardView({ chart: this.charts[1] }).layoutWeight(1)
            }
            .width('100%')

            Row() {
            }
            .height(80)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({
            left: Spacing.lg,
            right: Spacing.lg,
            top: Spacing.md,
            bottom: Spacing.md
          })
        }
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppTokens.background)
      }
      .width('100%')
      .height('100%')

      this.NotificationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}