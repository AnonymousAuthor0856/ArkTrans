// AppTokens.ets - Design tokens equivalent
class AppTokens {
  static readonly Colors = {
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

  static readonly Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Medium, lineHeight: 30 },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 },
  };

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12,
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

// Data Models
class MetricCardUi {
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

class ChartCardUi {
  id: number;
  title: string;
  color: ResourceColor;

  constructor(id: number, title: string, color: ResourceColor) {
    this.id = id;
    this.title = title;
    this.color = color;
  }
}

// Main Entry Pages
@Entry
@Component
struct RootScreen {
  @State selectedRange: string = '7 Days';
  @State flags: string[] = [];
  @State darkSwitch: boolean = false;
  @State notif: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];
  
  private kpis: MetricCardUi[] = [
    new MetricCardUi(1, 'Revenue', '$24,560', '+8.2%', AppTokens.Colors.secondary),
    new MetricCardUi(2, 'Orders', '1,284', '+3.1%', AppTokens.Colors.primary),
    new MetricCardUi(3, 'Refunds', '42', '-1.4%', AppTokens.Colors.error),
    new MetricCardUi(4, 'Active Users', '8,921', '+5.6%', AppTokens.Colors.tertiary)
  ];

  private charts: ChartCardUi[] = [
    new ChartCardUi(1, 'Sales Trend', '#E0F2FE'),
    new ChartCardUi(2, 'Conversion Funnel', '#EFF6FF'),
    new ChartCardUi(3, 'Geo Distribution', '#ECFDF5'),
    new ChartCardUi(4, 'Device Breakdown', '#FFFBEB')
  ];

  toggleFlag(flag: string) {
    const index = this.flags.indexOf(flag);
    if (index === -1) {
      this.flags.push(flag);
    } else {
      this.flags.splice(index, 1);
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Text('Analytics')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.ranges, (r: string) => {
              Text(r)
                .fontSize(this.selectedRange === r ? AppTokens.Typography.title.fontSize : AppTokens.Typography.body.fontSize)
                .fontWeight(this.selectedRange === r ? AppTokens.Typography.title.fontWeight : AppTokens.Typography.body.fontWeight)
                .fontColor(this.selectedRange === r ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedRange === r ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
                .onClick(() => { this.selectedRange = r; })
            })
          }
          .width('100%')

          // Compare Flags
          Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
            Text('Compare')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ right: AppTokens.Spacing.sm })

            Text('Prev Period')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(this.flags.includes('Prev Period') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .backgroundColor(this.flags.includes('Prev Period') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
              .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
              .onClick(() => this.toggleFlag('Prev Period'))

            Text('Goal')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(this.flags.includes('Goal') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .backgroundColor(this.flags.includes('Goal') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
              .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
              .onClick(() => this.toggleFlag('Goal'))

            Row() {
              Text('Dark')
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ right: AppTokens.Spacing.xs })
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => this.darkSwitch = isOn)
            }
            .margin({ bottom: AppTokens.Spacing.xs })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          // KPI Grid
          Grid() {
            ForEach(this.kpis, (m: MetricCardUi) => {
              GridItem() {
                this.MetricCard(m)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.lg)
          .rowsGap(AppTokens.Spacing.lg)
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })

          // Charts Grid
          Grid() {
            ForEach(this.charts, (c: ChartCardUi) => {
              GridItem() {
                this.ChartCard(c)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.lg)
          .rowsGap(AppTokens.Spacing.lg)
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg, bottom: 80 }) // Space for bottom bar
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom Bar
      Row() {
        Column() {
          Text('Notifications')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(`${this.notif} pending`)
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Mark All Read')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .height(44)
          .width(140)
          .onClick(() => { this.notif = 0; })
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder MetricCard(m: MetricCardUi) {
    Column() {
      Row() {
        Text(m.title)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Box()
          .width(16)
          .height(16)
          .backgroundColor(m.color)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')

      Text(m.value)
        .fontSize(AppTokens.Typography.headline.fontSize)
        .fontWeight(AppTokens.Typography.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Box()
          .width(6)
          .height(6)
          .backgroundColor(m.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Shapes.small)
          .margin({ right: AppTokens.Spacing.xs })
        Text(m.delta)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(m.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height(120)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
  }

  @Builder ChartCard(c: ChartCardUi) {
    Column() {
      Text(c.title)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      // Chart Placeholder
      Row() {
        Box().width(6).height(40).backgroundColor(AppTokens.Colors.primary).borderRadius(AppTokens.Shapes.small)
        Box().width(6).height(30).backgroundColor(AppTokens.Colors.secondary).borderRadius(AppTokens.Shapes.small)
        Box().width(6).height(48).backgroundColor(AppTokens.Colors.tertiary).borderRadius(AppTokens.Shapes.small)
        Box().width(6).height(22).backgroundColor(AppTokens.Colors.outline).borderRadius(AppTokens.Shapes.small)
        Box().width(6).height(32).backgroundColor(AppTokens.Colors.primary).borderRadius(AppTokens.Shapes.small)
        Box().width(6).height(42).backgroundColor(AppTokens.Colors.secondary).borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(100)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(c.color)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.md })

      // Legend
      Row() {
        Row() {
          Box().width(8).height(8).backgroundColor(AppTokens.Colors.primary).borderRadius(AppTokens.Shapes.small).margin({ right: AppTokens.Spacing.xs })
          Text('Series A')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .margin({ right: AppTokens.Spacing.sm })

        Row() {
          Box().width(8).height(8).backgroundColor(AppTokens.Colors.secondary).borderRadius(AppTokens.Shapes.small).margin({ right: AppTokens.Spacing.xs })
          Text('Series B')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
      }
      .margin({ top: AppTokens.Spacing.md })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height(180)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
  }
}