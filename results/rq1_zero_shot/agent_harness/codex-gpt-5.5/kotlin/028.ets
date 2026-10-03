const NAME: string = '029_OCRCheckProductivityForm_en';
const UI_TYPE: string = 'Dashboard';
const STYLE_THEME: string = 'Monochrome Comfortable';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
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
  label: string;
  value: number;

  constructor(label: string, value: number) {
    this.label = label;
    this.value = value;
  }
}

@Entry
@Component
struct MainActivity {
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
    new ChartData('Mon', 0.6), new ChartData('Tue', 0.8), new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0), new ChartData('Fri', 0.7), new ChartData('Sat', 0.4), new ChartData('Sun', 0.2)
  ];

  @Builder
  TopBar(): void {
    Row() {
      Circle().width(24).height(24).fill(AppColors.outline);
      Blank();
      Text('Productivity Check')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Blank();
      Circle().width(24).height(24).fill(AppColors.outline);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  FilterRow(): void {
    Row() {
      ForEach(this.filters, (filter: string) => {
        Button(filter)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedFilter === filter ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(this.selectedFilter === filter ? AppColors.primary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(8)
          .onClick(() => {
            this.selectedFilter = filter;
          });
        Blank().width(AppSpacing.sm);
      }, (filter: string) => filter)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center);
  }

  @Builder
  ChartCard(): void {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank().height(AppSpacing.md);
      Column() {
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Stack() {
              Rect()
                .width('60%')
                .height(`${data.value * 100}%`)
                .fill(AppColors.primary)
                .radius(8);
            }
            .layoutWeight(1)
            .height('100%')
            .alignContent(Alignment.Bottom);
          }, (data: ChartData) => data.label)
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(VerticalAlign.Bottom);
        Blank().height(AppSpacing.sm);
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1);
          }, (data: ChartData) => data.label)
        }
        .width('100%');
      }
      .width('100%')
      .height(150);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ProductivityCard(item: ProductivityItem): void {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Blank();
        Row({ space: AppSpacing.sm }) {
          Circle().width(10).height(10).fill(item.statusColor);
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor);
        }
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      Blank().height(AppSpacing.md);
      Row({ space: AppSpacing.sm }) {
        Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
          .layoutWeight(1)
          .height(8)
          .color(item.statusColor)
          .backgroundColor(AppColors.surfaceVariant);
        Text(`${Math.floor(item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
          .width(40);
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  BottomBar(): void {
    Button('Submit New Form')
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onPrimary)
      .backgroundColor(AppColors.primary)
      .borderRadius(12)
      .width('100%')
      .height(56)
      .margin(AppSpacing.md);
  }

  build() {
    Column() {
      this.TopBar();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.FilterRow();
          this.ChartCard();
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.ProductivityCard(item);
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding(AppSpacing.md);
      }
      .layoutWeight(1);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
