import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppTokensColors {
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

interface AppTokensSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokensElevation {
  level2: number;
  level3: number;
}

interface AppTokensConfig {
  Colors: AppTokensColors;
  Spacing: AppTokensSpacing;
  Elevation: AppTokensElevation;
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
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Elevation: {
    level2: 2, // Simplified elevation mapping for ArkTS shadow
    level3: 3
  }
}

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
struct RootScreen {
  @State selectedRange: string = '7 Days';
  @State flags: string[] = [];
  @State darkSwitch: boolean = false;
  @State notifCount: number = 2;

  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom'];

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppTokens.Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppTokens.Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppTokens.Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppTokens.Colors.tertiary }
  ];

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          this.IconBox(AppTokens.Colors.primary)
        
          Text('Analytics')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      
      // Main Content Area
      Scroll() {
        Column() {
          // Filter Chips (Ranges)
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            ForEach(this.ranges, (range: string) => {
              this.FilterChipItem(range, range === this.selectedRange)
            }, (item: string) => item)
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xs })
          .gap(AppTokens.Spacing.sm)
          
          Blank().height(AppTokens.Spacing.md)

          // Controls Row
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Text('Compare')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            
            this.AssistChipItem('Prev Period', this.flags.includes('Prev Period'))
            this.AssistChipItem('Goal', this.flags.includes('Goal'))
            
            Row({ space: AppTokens.Spacing.xs }) {
              Text('Dark')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              
              Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
                .onChange((isOn: boolean) => {
                  this.darkSwitch = isOn;
                })
                .selectedColor(AppTokens.Colors.primary)
            }
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xs })
          .gap(AppTokens.Spacing.sm)

          Blank().height(AppTokens.Spacing.lg)

          // Grid Layout for KPIs and Charts
          GridContainer() {
            ForEach(this.kpis, (metric: MetricCardUi) => {
              GridItem() {
                this.KpiCard(metric)
              }
            }, (item: MetricCardUi) => item.id.toString())

            ForEach(this.charts, (chart: ChartCardUi) => {
              GridItem() {
                this.ChartCard(chart)
              }
            }, (item: ChartCardUi) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto auto')
          .gap(AppTokens.Spacing.lg)
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xxxl })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  IconBox(color: string) {
    Rectangle()
      .width(20)
      .height(20)
      .fill(color)
      .borderRadius(6)
  }

  @Builder
  FilterChipItem(label: string, active: boolean) {
    Button() {
      Text(label)
        .fontSize(active ? 14 : 12)
        .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(active ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .type(ButtonType.Capsule)
    .backgroundColor(active ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
    .borderRadius(8)
    .onClick(() => {
      this.selectedRange = label;
    })
  }

  @Builder
  AssistChipItem(label: string, active: boolean) {
    Button() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .type(ButtonType.Capsule)
    .backgroundColor(active ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
    .borderRadius(6)
    .onClick(() => {
      if (this.flags.includes(label)) {
        const index = this.flags.indexOf(label);
        if (index > -1) {
          this.flags.splice(index, 1);
        }
      } else {
        this.flags.push(label);
      }
    })
  }

  @Builder
  KpiCard(metric: MetricCardUi) {
    Column() {
      Row() {
        Text(metric.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        this.IconBox(metric.color)
      }
      .width('100%')
      
      Blank().height(AppTokens.Spacing.sm)
      
      Text(metric.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank().height(AppTokens.Spacing.sm)
      
      Row({ space: AppTokens.Spacing.xs }) {
        this.IconBox(metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
        
        Text(metric.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({ radius: 10, color: '#00000014', offsetY: 2 }) // Approximation of Level 2 shadow
    .border({ width: 1, color: AppTokens.Colors.outline })
    .height(120)
  }

  @Builder
  ChartCard(chart: ChartCardUi) {
    Column() {
      Text(chart.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank().height(AppTokens.Spacing.md)
      
      // Mock Chart Visualization
      Row({ space: AppTokens.Spacing.sm }) {
        this.BarChartItem(AppTokens.Colors.primary, 40)
        this.BarChartItem(AppTokens.Colors.secondary, 30)
        this.BarChartItem(AppTokens.Colors.tertiary, 48)
        this.BarChartItem(AppTokens.Colors.outline, 22)
        this.BarChartItem(AppTokens.Colors.primary, 32)
        this.BarChartItem(AppTokens.Colors.secondary, 42)
      }
      .width('100%')
      .aspectRatio(1.6)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(chart.color)
      .borderRadius(8)
      
      Blank().height(AppTokens.Spacing.md)
      
      Row({ space: AppTokens.Spacing.sm }) {
        this.DotLegend(AppTokens.Colors.primary)
        Text('Series A').fontSize(10).fontWeight(FontWeight.Medium).fontColor(AppTokens.Colors.onSurface)
        
        this.DotLegend(AppTokens.Colors.secondary)
        Text('Series B').fontSize(10).fontWeight(FontWeight.Medium).fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({ radius: 10, color: '#00000014', offsetY: 2 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .height(180)
  }

  @Builder
  BarChartItem(color: string, height: number) {
    Rectangle()
      .width(6)
      .height(height)
      .fill(color)
      .borderRadius(6)
  }

  @Builder
  DotLegend(color: string) {
    Rectangle()
      .width(8)
      .height(8)
      .fill(color)
      .borderRadius(6)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(`${this.notifCount} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Button() {
        Text('Mark All Read')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .type(ButtonType.Capsule)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(12)
      .height(44)
      .width(140)
      .onClick(() => {
        this.notifCount = 0;
      })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 15, color: '#00000029', offsetY: 3 }) // Approximation of Level 3 shadow
  }
}