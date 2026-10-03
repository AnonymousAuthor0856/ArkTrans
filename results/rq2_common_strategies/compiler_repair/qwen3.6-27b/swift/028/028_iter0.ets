import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, Elevation)

/**
 * 应用程序的统一设计令牌，包括颜色、字体、形状、间距和阴影。
 */
class AppTokens {
  /**
   * 颜色令牌
   */
  static Colors = {
    primary: '#0F172A',
    secondary: '#475569',
    tertiary: '#94A3B8',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  /**
   * 字体排版令牌
   */
  static TypographyTokens = {
    display: {
      fontSize: 32,
      fontWeight: FontWeight.Bold,
      lineHeight: 40,
      letterSpacing: 0
    },
    headline: {
      fontSize: 24,
      fontWeight: FontWeight.SemiBold,
      lineHeight: 32,
      letterSpacing: 0
    },
    title: {
      fontSize: 18,
      fontWeight: FontWeight.Medium,
      lineHeight: 24,
      letterSpacing: 0.15
    },
    body: {
      fontSize: 16,
      fontWeight: FontWeight.Regular,
      lineHeight: 22,
      letterSpacing: 0.5
    },
    label: {
      fontSize: 14,
      fontWeight: FontWeight.Medium,
      lineHeight: 18,
      letterSpacing: 0.5
    }
  };

  /**
   * 形状令牌，主要用于圆角半径。
   */
  static Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16
  };

  /**
   * 间距令牌
   */
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  /**
   * 阴影层级映射
   */
  static ElevationMapping = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 2, opacity: 0.10 },
    level3: { radius: 10, dy: 4, opacity: 0.10 }
  };
}

// MARK: - Data Models

/**
 * 生产力项目数据模型
 */
interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: string;
}

/**
 * 图表数据模型
 */
interface ChartData {
  label: string;
  value: number;
}

// MARK: - Custom Views / Components

/**
 * 自定义筛选芯片，模仿 Compose 的 `FilterChip`。
 */
@Component
struct FilterChip {
  @Prop title: string;
  @Prop isSelected: boolean;
  action: () => void;

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.title)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
        .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.smallCornerRadius)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.smallCornerRadius })
    }
    .onClick(() => {
      this.action();
    })
  }
}

/**
 * 自定义线性进度指示器，模仿 Compose 的 `LinearProgressIndicator`。
 */
@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number;
  @Prop color: string;
  @Prop trackColor: string;
  @Prop height: number;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rect()
        .fill(this.trackColor)
        .height(this.height)
        .width('100%')
        .borderRadius(this.height / 2);

      // Progress
      Rect()
        .fill(this.color)
        .height(this.height)
        .width(`${this.progress * 100}%`)
        .borderRadius(this.height / 2);
    }
    .height(this.height)
    .width('100%')
  }
}

// MARK: - RootScreen (Main UI)

/**
 * 应用程序的主屏幕视图。
 */
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';
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
  private get bottomBarTotalHeight(): number {
    return this.bottomBarButtonHeight + this.bottomBarPadding * 2;
  }

  build() {
    Column() {
      // MARK: - Top Bar
      Row() {
        // Left Icon Placeholder
        Button({ type: ButtonType.Circle }) {
          Circle()
            .fill(AppTokens.Colors.outline)
            .width(24)
            .height(24)
        }
        .margin({ left: AppTokens.Spacing.md })

        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Text('Productivity Check')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .letterSpacing(AppTokens.TypographyTokens.headline.letterSpacing)
            .lineHeight(AppTokens.TypographyTokens.headline.lineHeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .layoutWeight(1)

        // Right Icon Placeholder
        Button({ type: ButtonType.Circle }) {
          Circle()
            .fill(AppTokens.Colors.outline)
            .width(24)
            .height(24)
        }
        .margin({ right: AppTokens.Spacing.md })
      }
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level3.dy
      })
      .zIndex(1)

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row() {
            ForEach(this.filters, (filter: string) => {
              Column() {
                FilterChip({
                  title: filter,
                  isSelected: this.selectedFilter === filter,
                  action: () => {
                    this.selectedFilter = filter;
                  }
                })
              }
              if (filter !== this.filters[this.filters.length - 1]) {
                Blank().width(AppTokens.Spacing.sm)
              }
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .letterSpacing(AppTokens.TypographyTokens.title.letterSpacing)
              .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart
            Column({ space: AppTokens.Spacing.sm }) {
              // Bar Chart Area
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Flex({ justifyContent: FlexAlign.End }) {
                      Rect()
                        .fill(AppTokens.Colors.primary)
                        .width(`${(100 / this.chartData.length) * 0.6}%`)
                        .height(`${data.value * 100}%`)
                        .borderRadius(AppTokens.Shapes.smallCornerRadius)
                    }
                    .height('100%')
                    .layoutWeight(1)
                  }
                  .layoutWeight(1)
                })
              }
              .height(150)
              .width('100%')

              // Chart Labels
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
                    .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
                    .fontColor(AppTokens.Colors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
            }
          }
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .letterSpacing(AppTokens.TypographyTokens.title.letterSpacing)
                  .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
                  .fontColor(AppTokens.Colors.onSurface)

                Blank().layoutWeight(1)

                Row({ space: AppTokens.Spacing.sm }) {
                  Circle()
                    .fill(item.statusColor)
                    .width(10)
                    .height(10)

                  Text(item.status)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
                    .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
                    .fontColor(item.statusColor)
                }
              }
              .margin({ bottom: AppTokens.Spacing.md })

              Row({ space: AppTokens.Spacing.sm }) {
                CustomLinearProgressIndicator({
                  progress: item.progress,
                  color: item.statusColor,
                  trackColor: AppTokens.Colors.surfaceVariant,
                  height: 8
                })
                .layoutWeight(1)

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
                  .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
                  .fontColor(AppTokens.Colors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
            }
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
            .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })
        }
        .padding({ top: AppTokens.Spacing.md, bottom: this.bottomBarTotalHeight })
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      // MARK: - Bottom Bar
      Column() {
        Button({ type: ButtonType.Capsule }) {
          Text('Submit New Form')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .letterSpacing(AppTokens.TypographyTokens.title.letterSpacing)
            .lineHeight(AppTokens.TypographyTokens.title.lineHeight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('100%')
        .height(this.bottomBarButtonHeight)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.mediumCornerRadius)
      }
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level3.dy
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .systemBarProperties({ safeArea: SafeArea.NONE })
  }
}