// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ProductivityApp {
  @State selectedFilter: string = "Weekly";

  // Data Models
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

  // Tokens & Constants
  private readonly COLORS = {
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

  private readonly SPACING = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32
  };

  private readonly SHAPES = {
    small: 8,
    medium: 12,
    large: 16
  };

  private readonly filters: string[] = ["Daily", "Weekly", "Monthly"];

  private readonly productivityItems: ProductivityItem[] = [
    { id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: Color(this.COLORS.success) },
    { id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: Color(this.COLORS.warning) },
    { id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: Color(this.COLORS.secondary) },
    { id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: Color(this.COLORS.success) },
    { id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: Color(this.COLORS.error) }
  ];

  private readonly chartData: ChartData[] = [
    { label: "Mon", value: 0.6 }, { label: "Tue", value: 0.8 }, { label: "Wed", value: 0.5 },
    { label: "Thu", value: 1.0 }, { label: "Fri", value: 0.7 }, { label: "Sat", value: 0.4 },
    { label: "Sun", value: 0.2 }
  ];

  build() {
    Column() {
      // Top Bar
      this.buildTopBar();

      // Scrollable Content
      Scroll() {
        Column({ space: this.SPACING.lg }) {
          // Filter Chips
          this.buildFilterChips();

          // Weekly Throughput Card
          this.buildChartCard();

          // Productivity Items List
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.buildProductivityItem(item);
          });

          // Bottom padding to prevent content hiding behind fixed button
          Blank().height(80); 
        }
        .padding({ left: this.SPACING.md, right: this.SPACING.md, top: this.SPACING.md })
      }
      .layoutWeight(1)
      .backgroundColor(Color(this.COLORS.background))
      .scrollBar(BarState.Off)

      // Bottom Fixed Button
      this.buildBottomButton();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(this.COLORS.background))
    .statusBarHeight(StatusBarHeight.Auto) // Ensure safe area handling
  }

  @Builder
  buildTopBar() {
    Row() {
      // Placeholder for Menu Icon
      Circle().width(24).height(24).fill(Color(this.COLORS.outline)).opacity(0.5)
      
      Spacer()

      Text("Productivity Check")
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color(this.COLORS.onSurface))

      Spacer()

      // Placeholder for Notification/Settings Icon
      Circle().width(24).height(24).fill(Color(this.COLORS.outline)).opacity(0.5)
    }
    .width('100%')
    .height(56)
    .padding({ left: this.SPACING.md, right: this.SPACING.md })
    .backgroundColor(Color(this.COLORS.surface))
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
  }

  @Builder
  buildFilterChips() {
    Row() {
      ForEach(this.filters, (filter: string) => {
        Button(filter) {
          this.selectedFilter = filter;
        }
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedFilter === filter ? Color(this.COLORS.onPrimary) : Color(this.COLORS.onSurface))
        .backgroundColor(this.selectedFilter === filter ? Color(this.COLORS.primary) : Color(this.COLORS.surface))
        .borderWidth(1)
        .borderColor(Color(this.COLORS.outline))
        .borderRadius(this.SHAPES.small)
        .padding({ left: this.SPACING.md, right: this.SPACING.md, top: this.SPACING.sm, bottom: this.SPACING.sm })
        
        if (filter !== this.filters[this.filters.length - 1]) {
          Blank().width(this.SPACING.sm);
        }
      })
    }
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildChartCard() {
    Column() {
      Text("Weekly Throughput")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color(this.COLORS.onSurface))
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: this.SPACING.md })

      // Chart Area
      Column() {
        // Bars
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Column() {
              // The bar itself
              // Height is relative to the container height. 
              // We use a fixed height container below and percentage logic or calculated height.
              // Here we simulate the visual by using a fixed max height and scaling.
              // In ArkTS, GeometryReader is complex, so we calculate height based on a known max height (e.g., 150vp)
              // However, to keep it simple and responsive without complex geometry readers:
              // We will assume a max height of 150vp for the chart area.
              
              // Note: Using 'vp' for height calculation inside a flex row can be tricky. 
              // A better approach in ArkTS for charts is often Canvas or precise constraints.
              // For this UI replication, we will use a fixed height constraint on the parent.
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.End)
            .child((_) => {
               // This is a workaround to access parent height if needed, but simpler:
               // Just set height directly based on value * maxHeight
               // Since we can't easily get parent height in builder without GeometryReader,
               // we'll define a constant max height for the chart bars visually.
               // Let's say max height is 120vp.
               return Column()
                 .width('60%') // fillMaxWidth(0.6f) equivalent
                 .height(`${data.value * 120}vp`) // Assuming max height 120vp
                 .backgroundColor(Color(this.COLORS.primary))
                 .borderRadius(this.SHAPES.small)
            })
          })
        }
        .height(120) // Fixed height for the chart visualization area
        .margin({ bottom: this.SPACING.sm })

        // Labels
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color(this.COLORS.secondary))
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          })
        }
      }
    }
    .padding(this.SPACING.md)
    .backgroundColor(Color(this.COLORS.surface))
    .borderRadius(this.SHAPES.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
  }

  @Builder
  buildProductivityItem(item: ProductivityItem) {
    Column() {
      // Header: Title and Status
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color(this.COLORS.onSurface))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          
        Spacer()

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)
          
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
            .margin({ left: this.SPACING.sm })
        }
      }
      .width('100%')
      .margin({ bottom: this.SPACING.md })

      // Footer: Progress Bar and Percentage
      Row() {
        // Custom Linear Progress Indicator
        Row() {
          // Track
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(Color(this.COLORS.surfaceVariant))
            .borderRadius(4)
            
          // Fill
          Row()
            .width(`${item.progress * 100}%`)
            .height(8)
            .backgroundColor(item.statusColor)
            .borderRadius(4)
        }
        .clip(true) // Ensures the fill doesn't overflow track corners
        .layoutWeight(1)

        Text(`${Math.round(item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color(this.COLORS.secondary))
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: this.SPACING.sm })
      }
    }
    .padding(this.SPACING.md)
    .backgroundColor(Color(this.COLORS.surface))
    .borderRadius(this.SHAPES.medium)
    .border({ width: 1, color: Color(this.COLORS.outline) })
  }

  @Builder
  buildBottomButton() {
    Column() {
      Button("Submit New Form") {
        // Action
      }
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(Color(this.COLORS.onPrimary))
      .backgroundColor(Color(this.COLORS.primary))
      .borderRadius(this.SHAPES.medium)
      .width('100%')
      .height(56)
    }
    .padding(this.SPACING.md)
    .backgroundColor(Color(this.COLORS.surface))
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -4 }) // Shadow upwards
  }
}