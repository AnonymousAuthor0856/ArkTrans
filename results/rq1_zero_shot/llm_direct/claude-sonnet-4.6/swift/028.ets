import { router } from '@kit.ArkUI';

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, Elevation)

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
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 16;
  static readonly labelSize: number = 14;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

// MARK: - Data Models

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
  label: string;
  value: number;

  constructor(label: string, value: number) {
    this.label = label;
    this.value = value;
  }
}

// MARK: - FilterChip Component

@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Text(this.title)
      .fontSize(AppTypography.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
      .borderRadius(AppShapes.smallCornerRadius)
      .border({ width: 1, color: AppColors.outline, radius: AppShapes.smallCornerRadius })
      .onClick(() => {
        this.action();
      })
  }
}

// MARK: - CustomLinearProgressIndicator Component

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0;
  color: string = '#000000';
  trackColor: string = '#EEEEEE';
  barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      Row()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .backgroundColor(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// MARK: - ProductivityItemCard Component

@Component
struct ProductivityItemCard {
  item: ProductivityItem = new ProductivityItem(0, '', '', 0, '');

  build() {
    Column({ space: 0 }) {
      Row() {
        Text(this.item.title)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)

        Row({ space: AppSpacing.sm }) {
          Circle({ width: 10, height: 10 })
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.md })

      Row({ space: AppSpacing.sm }) {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: AppColors.surfaceVariant,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.mediumCornerRadius)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.mediumCornerRadius })
  }
}

// MARK: - BarChart Component

@Component
struct BarChart {
  chartData: ChartData[] = [];

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Column() {
            Blank()
              .layoutWeight(1)
            Column()
              .width('60%')
              .height(`${data.value * 100}%`)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.smallCornerRadius)
          }
          .layoutWeight(1)
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
      .height(150)
      .alignItems(VerticalAlign.Bottom)

      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Text(data.label)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
    }
    .width('100%')
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ];
  private chartData: ChartData[] = [
    new ChartData('Mon', 0.6),
    new ChartData('Tue', 0.8),
    new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0),
    new ChartData('Fri', 0.7),
    new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ];

  private topBarHeight: number = 56;
  private bottomBarButtonHeight: number = 56;
  private bottomBarPadding: number = AppSpacing.md;

  build() {
    Column() {
      // MARK: - Top Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Circle({ width: 24, height: 24 })
            .fill(AppColors.outline)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.Transparent)
        .margin({ left: AppSpacing.md })

        Blank()

        Text('Productivity Check')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Blank()

        Button({ type: ButtonType.Circle }) {
          Circle({ width: 24, height: 24 })
            .fill(AppColors.outline)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.Transparent)
        .margin({ right: AppSpacing.md })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({
        radius: 10,
        color: '#1A000000',
        offsetX: 0,
        offsetY: 4
      })
      .zIndex(1)

      // MARK: - Scrollable Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Filter Chips Row
          Row({ space: AppSpacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                action: () => {
                  this.selectedFilter = filter;
                }
              })
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({ left: AppSpacing.md, right: AppSpacing.md })

          // Weekly Throughput Card
          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .margin({ bottom: AppSpacing.md })
              .alignSelf(ItemAlign.Start)

            BarChart({ chartData: this.chartData })
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeCornerRadius)
          .shadow({
            radius: 3,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 1
          })
          .margin({ left: AppSpacing.md, right: AppSpacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            ProductivityItemCard({ item: item })
              .margin({ left: AppSpacing.md, right: AppSpacing.md })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({
          top: AppSpacing.md,
          bottom: this.bottomBarButtonHeight + this.bottomBarPadding * 2 + AppSpacing.md
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      // MARK: - Bottom Bar
      Column() {
        Button() {
          Text('Submit New Form')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width('100%')
        .height(this.bottomBarButtonHeight)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.mediumCornerRadius)
        .margin(AppSpacing.md)
        .onClick(() => {})
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 10,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -4
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}