// Index.ets

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, Elevation)

interface AppColors {
  primary: ResourceStr;
  secondary: ResourceStr;
  tertiary: ResourceStr;
  background: ResourceStr;
  surface: ResourceStr;
  surfaceVariant: ResourceStr;
  outline: ResourceStr;
  success: ResourceStr;
  warning: ResourceStr;
  error: ResourceStr;
  onPrimary: ResourceStr;
  onSecondary: ResourceStr;
  onTertiary: ResourceStr;
  onBackground: ResourceStr;
  onSurface: ResourceStr;
}

interface AppTypographyStyle {
  font: string;
  weight: FontWeight;
  lineHeight: number;
  letterSpacing: number;
}

interface AppTypography {
  display: AppTypographyStyle;
  headline: AppTypographyStyle;
  title: AppTypographyStyle;
  body: AppTypographyStyle;
  label: AppTypographyStyle;
}

interface AppShapes {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

interface AppElevation {
  level1: AppShadowSpec;
  level2: AppShadowSpec;
  level3: AppShadowSpec;
}

class AppTokens {
  static Colors: AppColors = {
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
    onSurface: '#FF0F172A'
  };

  static Typography: AppTypography = {
    display: { font: '32fp', weight: FontWeight.Bold, lineHeight: 40, letterSpacing: 0 },
    headline: { font: '24fp', weight: FontWeight.Medium, lineHeight: 32, letterSpacing: 0 },
    title: { font: '18fp', weight: FontWeight.Medium, lineHeight: 24, letterSpacing: 0.15 },
    body: { font: '16fp', weight: FontWeight.Normal, lineHeight: 22, letterSpacing: 0.5 },
    label: { font: '14fp', weight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0.5 }
  };

  static Shapes: AppShapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16
  };

  static Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  static Elevation: AppElevation = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 2, opacity: 0.10 },
    level3: { radius: 10, dy: 4, opacity: 0.10 }
  };
}

// MARK: - Data Models

interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: ResourceStr;
}

interface ChartData {
  label: string;
  value: number;
}

// MARK: - Custom Views / Components

@Component
export struct FilterChip {
  @Prop title: string;
  @Prop isSelected: boolean;
  onTap: () => void = () => {};

  build() {
    Button(this.title, { type: ButtonType.Normal })
      .onClick(() => this.onTap())
      .fontSize(AppTokens.Typography.label.font)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.smallCornerRadius)
      .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
export struct CustomLinearProgressIndicator {
  @Prop progress: number;
  @Prop color: ResourceStr;
  @Prop trackColor: ResourceStr;
  @Prop barHeight: number;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      // Progress
      Column()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .backgroundColor(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// MARK: - RootScreen (Main UI)

@Entry
@Component
struct RootScreen {
  @State private selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  
  private productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: AppTokens.Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: AppTokens.Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: AppTokens.Colors.error }
  ];

  private chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 }, { label: 'Tue', value: 0.8 }, { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 }, { label: 'Fri', value: 0.7 }, { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
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
          .fontSize(AppTokens.Typography.headline.font)
          .fontWeight(AppTokens.Typography.headline.weight)
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
        color: `rgba(0,0,0,${AppTokens.Elevation.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level3.dy
      })
      .zIndex(1)

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onTap: () => {
                  this.selectedFilter = filter;
                }
              })
              if (filter !== this.filters[this.filters.length - 1]) {
                Blank().width(AppTokens.Spacing.sm)
              }
            })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md
          })

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(AppTokens.Typography.title.font)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart
            Column({ space: AppTokens.Spacing.sm }) {
              // Chart Bars
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Blank() // Pushes content to bottom
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
                    .fontSize(AppTokens.Typography.label.font)
                    .fontWeight(AppTokens.Typography.label.weight)
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
            color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          })
          .margin({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md
          })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(AppTokens.Typography.title.font)
                  .fontWeight(AppTokens.Typography.title.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .layoutWeight(1)

                Row({ space: AppTokens.Spacing.sm }) {
                  Circle({ width: 10, height: 10 }).fill(item.statusColor)
                  Text(item.status)
                    .fontSize(AppTokens.Typography.label.font)
                    .fontWeight(AppTokens.Typography.label.weight)
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
                  barHeight: 8
                })
                .layoutWeight(1)

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(AppTokens.Typography.label.font)
                  .fontWeight(AppTokens.Typography.label.weight)
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
            .margin({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md
            })
          })
        }
        .width('100%')
        .padding({
          top: AppTokens.Spacing.md,
          bottom: this.bottomBarTotalHeight + AppTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // MARK: - Bottom Bar
      Column() {
        Button('Submit New Form', { type: ButtonType.Normal })
          .fontSize(AppTokens.Typography.title.font)
          .fontWeight(AppTokens.Typography.title.weight)
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
        color: `rgba(0,0,0,${AppTokens.Elevation.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level3.dy
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}