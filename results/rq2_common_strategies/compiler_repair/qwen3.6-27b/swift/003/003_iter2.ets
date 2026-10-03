import { Font, FontWeight } from '@kit.ArkUI';

// MARK: - Design Tokens
interface AppTokenColors {
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

interface AppTokenTypographyItem {
  size: number;
  weight: FontWeight;
}

interface AppTokenTypography {
  display: AppTokenTypographyItem;
  headline: AppTokenTypographyItem;
  title: AppTokenTypographyItem;
  body: AppTokenTypographyItem;
  label: AppTokenTypographyItem;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensConfig {
  Colors: AppTokenColors;
  Typography: AppTokenTypography;
  Spacing: AppTokenSpacing;
  Shapes: AppTokenShapes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
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
  },
  Typography: {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  }
};

// MARK: - Data Models
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

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppTokens.Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppTokens.Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppTokens.Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppTokens.Colors.tertiary }
  ];

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' }
  ];

  build() {
    Column() {
      // Header
      Row() {
        Blank()
        Row() {
          Rectangle()
            .fill(AppTokens.Colors.primary)
            .width(20)
            .height(20)
            .borderRadius(4)
          
          Text('Analytics')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .margin({ left: AppTokens.Spacing.sm })
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
            Column() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.ranges, (range: string) => {
                  Button(range)
                    .onClick(() => {
                      this.selectedRange = range;
                    })
                    .fontSize(this.selectedRange === range ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                    .fontWeight(this.selectedRange === range ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                    .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderWidth(1)
                    .borderColor(AppTokens.Colors.outline)
                    .borderRadius(AppTokens.Shapes.medium)
                    .margin({ right: AppTokens.Spacing.sm })
                })
              }
              .padding({ top: 4, bottom: 4 })

              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.ranges2, (range: string) => {
                  Button(range)
                    .onClick(() => {
                      this.selectedRange = range;
                    })
                    .fontSize(this.selectedRange === range ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                    .fontWeight(this.selectedRange === range ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                    .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .borderWidth(1)
                    .borderColor(AppTokens.Colors.outline)
                    .borderRadius(AppTokens.Shapes.medium)
                    .margin({ right: AppTokens.Spacing.sm })
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
            Text('Compare')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
            
            ForEach(this.flags, (flag: string) => {
              Button(flag)
                .onClick(() => {
                  const index = this.selectedFlags.indexOf(flag);
                  if (index > -1) {
                    this.selectedFlags.splice(index, 1);
                  } else {
                    this.selectedFlags.push(flag);
                  }
                })
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.selectedFlags.includes(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedFlags.includes(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .borderRadius(AppTokens.Shapes.small)
                .margin({ right: AppTokens.Spacing.sm })
            })

            Row({ space: AppTokens.Spacing.xs }) {
              Text('Dark')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
              
              Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
                .onChange((isOn: boolean) => {
                  this.darkMode = isOn;
                })
                .selectedColor(AppTokens.Colors.primary)
                .scale({ x: 0.8, y: 0.8 })
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Start)
          }
          .padding({ top: 6, bottom: 6 })

          // Metrics Grid
          GridContainer() {
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
          .rowsTemplate('auto auto auto')
          .gutters({ row: AppTokens.Spacing.lg, column: AppTokens.Spacing.lg })
          
          Blank().height(80)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      // Bottom Notification Bar
      Column() {
        Row()
          .height(1)
          .backgroundColor(Color('#D4D9E1').withOpacity(0.3))
        
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Notifications')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
            
            Text(`${this.notificationCount} pending`)
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          
          Blank()
          
          Button('Mark All Read')
            .onClick(() => {
              this.notificationCount = 0;
            })
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .width(140)
            .height(44)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#0000001A', offsetY: -2 })
      }
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct MetricCardView {
  @Prop metric: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' };

  aboutToAppear() {
    // Initialization if needed, though passed via constructor in newer versions or prop
  }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.metric.title)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        Rectangle()
          .fill(this.metric.color)
          .width(16)
          .height(16)
          .borderRadius(4)
      }
      
      Text(this.metric.value)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Row({ space: AppTokens.Spacing.xs }) {
        Rectangle()
          .fill(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .width(6)
          .height(6)
          .borderRadius(2)
        
        Text(this.metric.delta)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
      
      Blank()
    }
    .padding(AppTokens.Spacing.lg)
    .height(120)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#00000024', offsetY: 2 })
  }
}

@Component
struct ChartCardView {
  @Prop chart: ChartCardUi = { id: 0, title: '', color: '' };

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.chart.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Stack({ alignContent: Alignment.Bottom }) {
        Rectangle()
          .fill(this.chart.color)
          .borderRadius(AppTokens.Shapes.medium)
        
        Row({ space: AppTokens.Spacing.sm }) {
          Rectangle().fill(AppTokens.Colors.primary).width(6).height(40).borderRadius(2)
          Rectangle().fill(AppTokens.Colors.secondary).width(6).height(30).borderRadius(2)
          Rectangle().fill(AppTokens.Colors.tertiary).width(6).height(48).borderRadius(2)
          Rectangle().fill(AppTokens.Colors.outline).width(6).height(22).borderRadius(2)
          Rectangle().fill(AppTokens.Colors.primary).width(6).height(32).borderRadius(2)
          Rectangle().fill(AppTokens.Colors.secondary).width(6).height(42).borderRadius(2)
        }
        .justifyContent(FlexAlign.Center)
      }
      .aspectRatio(1.6)
      .width('100%')
      
      Row({ space: AppTokens.Spacing.sm }) {
        Rectangle().fill(AppTokens.Colors.primary).width(8).height(8).borderRadius(2)
        Text('Series A').fontSize(AppTokens.Typography.label.size).fontWeight(AppTokens.Typography.label.weight).fontColor(AppTokens.Colors.onSurface)
        
        Rectangle().fill(AppTokens.Colors.secondary).width(8).height(8).borderRadius(2)
        Text('Series B').fontSize(AppTokens.Typography.label.size).fontWeight(AppTokens.Typography.label.weight).fontColor(AppTokens.Colors.onSurface)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .height(180)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#00000024', offsetY: 2 })
  }
}