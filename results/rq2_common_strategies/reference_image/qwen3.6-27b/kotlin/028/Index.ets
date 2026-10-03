import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "029_OCRCheckProductivityForm_en";
const UI_TYPE = "Dashboard";
const STYLE_THEME = "Monochrome Comfortable";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ColorTokens {
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

const AppColors: ColorTokens = {
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

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const AppSpacing: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48
};

// --- Data Models ---

interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number; // 0.0 to 1.0
  statusColor: string;
}

interface ChartData {
  label: string;
  value: number; // 0.0 to 1.0
}

// --- Main Entry ---

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';
  
  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];

  private productivityItems: ProductivityItem[] = [
    { id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: AppColors.success },
    { id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: AppColors.warning },
    { id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: AppColors.secondary },
    { id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: AppColors.success },
    { id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: AppColors.error }
  ];

  private chartData: ChartData[] = [
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
      this.buildTopBar();

      // Scrollable Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Filter Chips
          this.buildFilterChips();

          // Weekly Throughput Chart
          this.buildChartCard();

          // Productivity List
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.buildListItem(item);
          })
          
          // Bottom padding for the fixed button
          Blank().height(80) 
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })

      // Bottom Action Button
      this.buildBottomButton();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  buildTopBar() {
    Row() {
      // Left Icon Placeholder
      Circle({ width: 24, height: 24 })
        .fill(AppColors.outline)
      
      Text("Productivity Check")
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      // Right Icon Placeholder
      Circle({ width: 24, height: 24 })
        .fill(AppColors.outline)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  buildFilterChips() {
    Row() {
      ForEach(this.filters, (filter: string) => {
        Button(filter)
          .type(ButtonType.Normal)
          .backgroundColor(this.selectedFilter === filter ? AppColors.primary : AppColors.surface)
          .fontColor(this.selectedFilter === filter ? AppColors.onPrimary : AppColors.onSurface)
          .borderWidth(1)
          .borderColor(AppColors.outline)
          .borderRadius(8)
          .height(36)
          .margin({ right: AppSpacing.sm })
          .onClick(() => {
            this.selectedFilter = filter;
          })
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
        .fontColor(AppColors.primary)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: AppSpacing.md })

      Column() {
        // Bars
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Column() {
              // The bar itself
              Column()
                .width('60%')
                .height(`${data.value * 100}%`)
                .backgroundColor(AppColors.primary)
                .borderRadius({ topLeft: 8, topRight: 8 })
                .alignSelf(ItemAlign.End)
            }
            .layoutWeight(1)
            .height(150)
            .justifyContent(FlexAlign.End)
          })
        }
        
        // Labels
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          })
        }
        .margin({ top: AppSpacing.sm })
      }
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
  }

  @Builder
  buildListItem(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Circle({ width: 10, height: 10 })
            .fill(item.statusColor)
            .margin({ right: AppSpacing.xs })
          
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      
      Row() {
        // Progress Bar Track
        Row()
          .width('100%')
          .height(8)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(4)
          .clip(true)
          .layoutWeight(1)
          .contentAlignment(HorizontalAlign.Start)
          .margin({ right: AppSpacing.sm })
          .childAlign(VerticalAlign.Center)
          .childLayout((child: any) => {
             child.width(`${item.progress * 100}%`);
          })
          .child(
            Row()
              .height(8)
              .backgroundColor(item.statusColor)
              .borderRadius(4)
          )

        Text(`${Math.round(item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width(40)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  buildBottomButton() {
    Button("Submit New Form")
      .type(ButtonType.Normal)
      .backgroundColor(AppColors.primary)
      .fontColor(AppColors.onPrimary)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .height(56)
      .borderRadius(12)
      .margin({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.md })
      .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
  }
}