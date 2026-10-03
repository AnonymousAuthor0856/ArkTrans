// AppTokens
class AppColors {
  static readonly primary: string = '#0F172A';
  static readonly secondary: string = '#475569';
  static readonly tertiary: string = '#94A3B8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0F172A';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class AppTypography {
  static readonly displaySize: number = 32;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 24;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 16;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 14;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class AppShadows {
  static readonly level1Color: string = '#1A000000';
  static readonly level1Radius: number = 3;
  static readonly level1Dy: number = 1;
  static readonly level2Color: string = '#1A000000';
  static readonly level2Radius: number = 6;
  static readonly level2Dy: number = 2;
  static readonly level3Color: string = '#1A000000';
  static readonly level3Radius: number = 10;
  static readonly level3Dy: number = 4;
}

class ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: string;
  constructor(id: number, title: string, status: string, progress: number, statusColor: string) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.progress = progress;
    this.statusColor = statusColor;
  }
}

class ChartData {
  id: number;
  label: string;
  value: number;
  constructor(id: number, label: string, value: number) {
    this.id = id;
    this.label = label;
    this.value = value;
  }
}

// 自定义筛选芯片
@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.title)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .letterSpacing(0.5)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })
    }
    .onClick(() => {
      this.action();
    })
  }
}

// 自定义线性进度指示器
@Component
struct LinearProgress {
  progress: number = 0;
  color: string = '#000000';
  trackColor: string = '#CCCCCC';
  height: number = 8;
  radius: number = 4;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.radius)
      Row()
        .width(Math.round(this.progress * 100) + '%')
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.radius)
    }
    .width('100%')
    .height(this.height)
  }
}

@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';

  filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ];
  chartData: ChartData[] = [
    new ChartData(1, 'Mon', 0.6), new ChartData(2, 'Tue', 0.8), new ChartData(3, 'Wed', 0.5),
    new ChartData(4, 'Thu', 1.0), new ChartData(5, 'Fri', 0.7), new ChartData(6, 'Sat', 0.4),
    new ChartData(7, 'Sun', 0.2)
  ];

  topBarHeight: number = 56;
  bottomBarButtonHeight: number = 56;
  bottomBarPadding: number = AppSpacing.md;
  bottomBarTotalHeight: number = 56 + AppSpacing.md * 2;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button({ type: ButtonType.Normal }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .padding({ left: AppSpacing.md })

        Blank()

        Text('Productivity Check')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.onSurface)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .padding({ right: AppSpacing.md })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: AppShadows.level3Radius, color: AppShadows.level3Color, offsetX: 0, offsetY: AppShadows.level3Dy })
      .zIndex(1)

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips Row
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChip({ title: filter, isSelected: this.selectedFilter === filter, action: () => { this.selectedFilter = filter; } })
              if (filter !== this.filters[this.filters.length - 1]) {
                Blank().width(AppSpacing.sm)
              }
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({ left: AppSpacing.md, right: AppSpacing.md })

          // Weekly Throughput Card
          Column() {
            Text('Weekly Throughput')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .letterSpacing(0.15)
              .fontColor(AppColors.onSurface)
              .padding({ bottom: AppSpacing.md })

            // Chart
            Column() {
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Blank()
                    Row()
                      .width('60%')
                      .height(150 * data.value)
                      .backgroundColor(AppColors.primary)
                      .borderRadius(AppShapes.small)
                  }
                  .height(150)
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.End)
                  .alignItems(HorizontalAlign.Center)
                }, (data: ChartData) => '' + data.id)
              }
              .width('100%')
              .height(150)
              .alignItems(VerticalAlign.Bottom)

              // Chart Labels
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(AppTypography.labelWeight)
                    .letterSpacing(0.5)
                    .fontColor(AppColors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                }, (data: ChartData) => '' + data.id)
              }
              .width('100%')
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
          .padding({ left: AppSpacing.md, right: AppSpacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(AppTypography.titleSize)
                  .fontWeight(AppTypography.titleWeight)
                  .letterSpacing(0.15)
                  .fontColor(AppColors.onSurface)

                Blank()

                Row() {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.statusColor)

                  Text(item.status)
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(AppTypography.labelWeight)
                    .letterSpacing(0.5)
                    .fontColor(item.statusColor)
                }
                .space(AppSpacing.sm)
              }
              .width('100%')
              .padding({ bottom: AppSpacing.md })

              Row() {
                LinearProgress({ progress: item.progress, color: item.statusColor, trackColor: AppColors.surfaceVariant, height: 8, radius: 4 })
                  .layoutWeight(1)

                Text('' + Math.round(item.progress * 100) + '%')
                  .fontSize(AppTypography.labelSize)
                  .fontWeight(AppTypography.labelWeight)
                  .letterSpacing(0.5)
                  .fontColor(AppColors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .space(AppSpacing.sm)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .border({ width: 1, color: AppColors.outline })
            .padding({ left: AppSpacing.md, right: AppSpacing.md })
          }, (item: ProductivityItem) => '' + item.id)
        }
        .width('100%')
        .space(AppSpacing.lg)
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md + this.bottomBarTotalHeight })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Button({ type: ButtonType.Normal }) {
          Text('Submit New Form')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(this.bottomBarButtonHeight)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding(AppSpacing.md)
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: AppShadows.level3Radius, color: AppShadows.level3Color, offsetX: 0, offsetY: AppShadows.level3Dy })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
