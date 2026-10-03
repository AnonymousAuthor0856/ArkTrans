// AppTokens.ets

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, Elevation)

export class AppTokens {
  // MARK: Colors
  static readonly Colors = {
    primary: '#FF0F172A',
    secondary: '#FF475569',
    tertiary: '#FF94A3B8',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  };

  // MARK: Typography
  static readonly Typography = {
    display: { size: 32, weight: FontWeight.Bold, lineHeight: 40, letterSpacing: 0 },
    headline: { size: 24, weight: FontWeight.Medium, lineHeight: 32, letterSpacing: 0 },
    title: { size: 18, weight: FontWeight.Medium, lineHeight: 24, letterSpacing: 0.15 },
    body: { size: 16, weight: FontWeight.Normal, lineHeight: 22, letterSpacing: 0.5 },
    label: { size: 14, weight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0.5 },
  };

  // MARK: Shapes
  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16,
  };

  // MARK: Spacing
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };

  // MARK: Elevation
  static readonly Elevation = {
    level1: { radius: 3, dy: 1, opacity: 0.10, color: '#000000' },
    level2: { radius: 6, dy: 2, opacity: 0.10, color: '#000000' },
    level3: { radius: 10, dy: 4, opacity: 0.10, color: '#000000' },
  };
}

// Helper to apply typography styles to Text components
@Extend(Text)
function appStyle(style: typeof AppTokens.Typography.title) {
  .fontSize(style.size)
  .fontWeight(style.weight)
  .lineHeight(style.lineHeight)
  .letterSpacing(style.letterSpacing)
}

// MARK: - Data Models

interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: ResourceColor;
}

interface ChartData {
  label: string;
  value: number;
}

// MARK: - Custom Views / Components

// Custom Linear Progress Indicator Component
@Component
export struct CustomLinearProgressIndicator {
  private progress: number = 0;
  private color: ResourceColor = '';
  private trackColor: ResourceColor = '';
  private height: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.height / 2)

      // Progress
      Column()
        .width(`${this.progress * 100}%`)
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.height / 2)
    }
    .width('100%')
    .height(this.height)
  }
}

// MARK: - RootScreen (Main UI)

@Entry
@Component
export struct RootScreen {
  @State private selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  
  private productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: AppTokens.Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: AppTokens.Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: AppTokens.Colors.error },
  ];

  private chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 }, { label: 'Tue', value: 0.8 }, { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 }, { label: 'Fri', value: 0.7 }, { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 },
  ];

  private topBarHeight: number = 56;
  private bottomBarButtonHeight: number = 56;
  private bottomBarPadding: number = AppTokens.Spacing.md;
  private bottomBarTotalHeight: number = this.bottomBarButtonHeight + this.bottomBarPadding * 2;

  build() {
    Column() {
      // MARK: - Top Bar
      Row() {
        Button() {
          Circle({ width: 24, height: 24 }).fill(AppTokens.Colors.outline)
        }
        .backgroundColor(Color.Transparent)
        .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('Productivity Check')
          .appStyle(AppTokens.Typography.headline)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Circle({ width: 24, height: 24 }).fill(AppTokens.Colors.outline)
        }
        .backgroundColor(Color.Transparent)
        .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.Elevation.level3.radius,
        color: AppTokens.Elevation.level3.color,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level3.dy,
        fill: AppTokens.Elevation.level3.color
      })
      .zIndex(1)

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row() {
            ForEach(this.filters, (filter: string) => {
              Button(filter)
                .appStyle(AppTokens.Typography.label)
                .fontColor(this.selectedFilter === filter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedFilter === filter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.smallCornerRadius)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.selectedFilter = filter;
                })
              
              if (filter !== this.filters[this.filters.length - 1]) {
                Blank().width(AppTokens.Spacing.sm)
              }
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .appStyle(AppTokens.Typography.title)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart
            Column({ space: AppTokens.Spacing.sm }) {
              // Chart Bars
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Blank() // Push to bottom

                    Column()
                      .width('60%')
                      .height(`${data.value * 100}%`)
                      .backgroundColor(AppTokens.Colors.primary)
                      .borderRadius(AppTokens.Shapes.smallCornerRadius)
                  }
                  .layoutWeight(1)
                  .height('100%')
                  .justifyContent(FlexAlign.End)
                })
              }
              .width('100%')
              .height(150)

              // Chart Labels
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .appStyle(AppTokens.Typography.label)
                    .fontColor(AppTokens.Colors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
            }
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: AppTokens.Elevation.level1.color,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy,
            fill: AppTokens.Elevation.level1.color
          })
          .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .appStyle(AppTokens.Typography.title)
                  .fontColor(AppTokens.Colors.onSurface)

                Blank()

                Row({ space: AppTokens.Spacing.sm }) {
                  Circle({ width: 10, height: 10 }).fill(item.statusColor)
                  Text(item.status)
                    .appStyle(AppTokens.Typography.label)
                    .fontColor(item.statusColor)
                }
              }
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md })

              Row({ space: AppTokens.Spacing.sm }) {
                CustomLinearProgressIndicator({
                  progress: item.progress,
                  color: item.statusColor,
                  trackColor: AppTokens.Colors.surfaceVariant,
                  height: 8
                })
                .layoutWeight(1)

                Text(`${Math.floor(item.progress * 100)}%`)
                  .appStyle(AppTokens.Typography.label)
                  .fontColor(AppTokens.Colors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: this.bottomBarTotalHeight + AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      // MARK: - Bottom Bar
      Column() {
        Button('Submit New Form')
          .appStyle(AppTokens.Typography.title)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(this.bottomBarButtonHeight)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.Elevation.level3.radius,
        color: AppTokens.Elevation.level3.color,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level3.dy,
        fill: AppTokens.Elevation.level3.color
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
  }
}