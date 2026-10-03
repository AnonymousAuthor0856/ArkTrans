// App.ets
import { router } from '@kit.ArkUI';

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

interface ShadowConfig {
  radius: number;
  dy: number;
  opacity: number;
}

interface ColorMap {
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
  onSurface: string;
}

interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShadowMap {
  level1: ShadowConfig;
  level3: ShadowConfig;
}

@Entry
@Component
struct ProductivityApp {
  @State selectedFilter: string = "Weekly";

  // Tokens & Constants
  private readonly COLORS: ColorMap = {
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
    onSurface: '#0F172A'
  };

  private readonly SPACING: SpacingMap = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32
  };

  private readonly SHADOWS: ShadowMap = {
    level1: { radius: 3, dy: 1, opacity: 0.1 },
    level3: { radius: 10, dy: 4, opacity: 0.1 }
  };

  private readonly filters: string[] = ["Daily", "Weekly", "Monthly"];

  private readonly productivityItems: ProductivityItem[] = [
    { id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: Color.Green },
    { id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: Color.Orange },
    { id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: Color.Gray },
    { id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: Color.Green },
    { id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: Color.Red }
  ];

  private readonly chartData: ChartData[] = [
    { label: "Mon", value: 0.6 },
    { label: "Tue", value: 0.8 },
    { label: "Wed", value: 0.5 },
    { label: "Thu", value: 1.0 },
    { label: "Fri", value: 0.7 },
    { label: "Sat", value: 0.4 },
    { label: "Sun", value: 0.2 }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle().width(24).height(24).fill(this.COLORS.outline)
        Text("Productivity Check")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor(this.COLORS.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle().width(24).height(24).fill(this.COLORS.outline)
      }
      .width('100%')
      .height(56)
      .padding({ left: this.SPACING.md, right: this.SPACING.md })
      .backgroundColor(this.COLORS.surface)
      .shadow({
        radius: this.SHADOWS.level3.radius,
        color: 'rgba(0, 0, 0, ' + this.SHADOWS.level3.opacity + ')',
        offsetX: 0,
        offsetY: this.SHADOWS.level3.dy
      })
      .zIndex(1)

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.filters, (filter: string) => {
              Button(filter)
                .onClick(() => {
                  this.selectedFilter = filter;
                })
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedFilter === filter ? this.COLORS.primary : this.COLORS.surface)
                .fontColor(this.selectedFilter === filter ? this.COLORS.onPrimary : this.COLORS.onSurface)
                .borderRadius(8)
                .border({ width: 1, color: this.COLORS.outline })
                .margin({ right: filter !== this.filters[this.filters.length - 1] ? this.SPACING.sm : 0 })
                .height(36)
                .padding({ left: this.SPACING.md, right: this.SPACING.md })
                .fontWeight(FontWeight.Medium)
                .fontSize(14)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: this.SPACING.lg, bottom: this.SPACING.lg })

          // Weekly Throughput Card
          Column() {
            Text("Weekly Throughput")
              .fontWeight(FontWeight.Medium)
              .fontSize(18)
              .fontColor(this.COLORS.onSurface)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: this.SPACING.md })

            // Chart Area
            Column() {
              // Bars
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Blank().layoutWeight(1)
                    Rect()
                      .fill(Color.Primary)
                      .borderRadius(8)
                      .width('60%')
                      .height(`${data.value * 100}%`)
                  }
                  .layoutWeight(1)
                  .height(150)
                })
              }
              .width('100%')
              .margin({ bottom: this.SPACING.sm })

              // Labels
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontColor(this.COLORS.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
            }
          }
          .width('100%')
          .padding(this.SPACING.md)
          .backgroundColor(this.COLORS.surface)
          .borderRadius(16)
          .shadow({
            radius: this.SHADOWS.level1.radius,
            color: 'rgba(0, 0, 0, ' + this.SHADOWS.level1.opacity + ')',
            offsetX: 0,
            offsetY: this.SHADOWS.level1.dy
          })
          .margin({ bottom: this.SPACING.lg })

          // Productivity Items List
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(18)
                  .fontColor(this.COLORS.onSurface)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Start)

                Row() {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.statusColor)
                    .margin({ right: this.SPACING.sm })

                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.statusColor)
                }
              }
              .width('100%')
              .margin({ bottom: this.SPACING.md })

              Row() {
                // Custom Linear Progress Indicator
                Stack({ alignContent: Alignment.Start }) {
                  // Track
                  Capsule()
                    .fill(this.COLORS.surfaceVariant)
                    .height(8)
                    .width('100%')

                  // Progress
                  Capsule()
                    .fill(item.statusColor)
                    .height(8)
                    .width(`${item.progress * 100}%`)
                }
                .layoutWeight(1)
                .margin({ right: this.SPACING.sm })

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontColor(this.COLORS.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
            }
            .width('100%')
            .padding(this.SPACING.md)
            .backgroundColor(this.COLORS.surface)
            .borderRadius(12)
            .border({ width: 1, color: this.COLORS.outline })
            .margin({ bottom: this.SPACING.md })
          })

          // Bottom padding to prevent content being hidden behind fixed button
          Column().height(100)
        }
        .padding({ left: this.SPACING.md, right: this.SPACING.md })
      }
      .layoutWeight(1)
      .backgroundColor(this.COLORS.background)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Button("Submit New Form")
        .onClick(() => {
          // Action
        })
        .type(ButtonType.Normal)
        .backgroundColor(this.COLORS.primary)
        .fontColor(this.COLORS.onPrimary)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .height(56)
        .width('100%')
        .margin({
          left: this.SPACING.md,
          right: this.SPACING.md,
          top: this.SPACING.md,
          bottom: this.SPACING.md
        })
        .shadow({
          radius: this.SHADOWS.level3.radius,
          color: 'rgba(0, 0, 0, ' + this.SHADOWS.level3.opacity + ')',
          offsetX: 0,
          offsetY: this.SHADOWS.level3.dy
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLORS.background)
    .statusBarConfig({ mode: StatusBarColorMode.Light })
  }
}