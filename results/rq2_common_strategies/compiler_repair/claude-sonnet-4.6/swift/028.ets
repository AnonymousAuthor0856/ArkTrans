import { router } from '@kit.ArkUI';

// ============================================================
// Design Tokens
// ============================================================
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0F172A';
    export const secondary: string = '#475569';
    export const tertiary: string = '#94A3B8';
    export const background: string = '#F8FAFC';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F1F5F9';
    export const outline: string = '#E2E8F0';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#0F172A';
    export const onBackground: string = '#0F172A';
    export const onSurface: string = '#0F172A';
  }

  export namespace Typography {
    export const displaySize: number = 32;
    export const headlineSize: number = 24;
    export const titleSize: number = 18;
    export const bodySize: number = 16;
    export const labelSize: number = 14;
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 8;
    export const mediumCornerRadius: number = 12;
    export const largeCornerRadius: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 16;
    export const lg: number = 24;
    export const xl: number = 32;
    export const xxl: number = 48;
  }
}

// ============================================================
// Data Models
// ============================================================
interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: string;
}

interface ChartDataItem {
  label: string;
  value: number;
}

// ============================================================
// Filter Chip Component
// ============================================================
@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Text(this.title)
      .fontSize(AppTokens.Typography.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.smallCornerRadius)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.smallCornerRadius })
      .onClick(() => {
        this.onSelect();
      })
  }
}

// ============================================================
// Custom Linear Progress Indicator
// ============================================================
@Component
struct CustomLinearProgressIndicator {
  progress: number = 0;
  color: string = '#000000';
  trackColor: string = '#E2E8F0';
  barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      // Progress
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

// ============================================================
// Productivity Item Card
// ============================================================
@Component
struct ProductivityItemCard {
  item: ProductivityItem = {
    id: 0,
    title: '',
    status: '',
    progress: 0,
    statusColor: '#000000'
  };

  build() {
    Column({ space: 0 }) {
      // Title Row
      Row() {
        Text(this.item.title)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        Row({ space: AppTokens.Spacing.sm }) {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: AppTokens.Spacing.md })

      // Progress Row
      Row({ space: AppTokens.Spacing.sm }) {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: AppTokens.Colors.surfaceVariant,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
  }
}

// ============================================================
// Bar Chart Component
// ============================================================
@Component
struct BarChart {
  chartData: ChartDataItem[] = [];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Bars
      Row() {
        ForEach(this.chartData, (data: ChartDataItem) => {
          Column() {
            Blank()
              .layoutWeight(1)
            Column()
              .width('60%')
              .height(`${data.value * 100}%`)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
          }
          .layoutWeight(1)
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
        })
      }
      .width('100%')
      .height(150)
      .alignItems(VerticalAlign.Bottom)

      // Labels
      Row() {
        ForEach(this.chartData, (data: ChartDataItem) => {
          Text(data.label)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        })
      }
      .width('100%')
    }
    .width('100%')
  }
}

// ============================================================
// Main Screen
// ============================================================
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

  private chartData: ChartDataItem[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ];

  build() {
    Column() {
      // ── Top Bar ──────────────────────────────────────────
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.outline)
          .margin({ left: AppTokens.Spacing.md })

        Blank().layoutWeight(1)

        Text('Productivity Check')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Blank().layoutWeight(1)

        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.outline)
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 4 })
      .zIndex(1)

      // ── Scrollable Content ───────────────────────────────
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onSelect: () => {
                  this.selectedFilter = filter;
                }
              })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Weekly Throughput Card
          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })
              .alignSelf(ItemAlign.Start)

            BarChart({ chartData: this.chartData })
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            ProductivityItemCard({ item: item })
              .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })

          // Bottom padding so content isn't hidden behind bottom bar
          Row().height(88)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // ── Bottom Bar ───────────────────────────────────────
      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .onClick(() => {})
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: -4 })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}