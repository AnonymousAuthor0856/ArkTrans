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

class ProductivityColors {
  static primary: string = '#0F172A';
  static secondary: string = '#475569';
  static tertiary: string = '#94A3B8';
  static background: string = '#F8FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F1F5F9';
  static outline: string = '#E2E8F0';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  private chartData: ChartData[] = [
    new ChartData('Mon', 60),
    new ChartData('Tue', 80),
    new ChartData('Wed', 50),
    new ChartData('Thu', 100),
    new ChartData('Fri', 70),
    new ChartData('Sat', 40),
    new ChartData('Sun', 20)
  ];
  private items: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 100, ProductivityColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 75, ProductivityColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 10, ProductivityColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 100, ProductivityColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 40, ProductivityColors.error)
  ];

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === label ? ProductivityColors.onPrimary : ProductivityColors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.selectedFilter === label ? ProductivityColors.primary : ProductivityColors.surface)
      .border({ width: 1, color: ProductivityColors.outline, radius: 8 })
      .borderRadius(8)
      .onClick(() => {
        this.selectedFilter = label;
      })
  }

  @Builder
  ChartBar(data: ChartData) {
    Column() {
      Blank()
        .width('60%')
        .height(data.value * 1.2)
        .backgroundColor(ProductivityColors.primary)
        .borderRadius(8)
      Text(data.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductivityColors.secondary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .height(150)
    .justifyContent(FlexAlign.End)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductivityColors.onSurface)
        .lineHeight(24)
        .width('100%')
      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          this.ChartBar(data)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
      .height(170)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ProductivityColors.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  StatusCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ProductivityColors.onSurface)
          .layoutWeight(1)
        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Progress({ value: item.progress, total: 100, type: ProgressType.Linear })
          .layoutWeight(1)
          .height(8)
          .color(item.statusColor)
          .backgroundColor(ProductivityColors.surfaceVariant)
        Text(item.progress.toString() + '%')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ProductivityColors.secondary)
          .width(40)
          .textAlign(TextAlign.End)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ProductivityColors.surface)
    .border({ width: 1, color: ProductivityColors.outline, radius: 12 })
    .borderRadius(12)
  }

  build() {
    Column() {
      Row() {
        Circle().width(24).height(24).fill(ProductivityColors.outline)
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ProductivityColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle().width(24).height(24).fill(ProductivityColors.outline)
      }
      .width('100%')
      .padding(16)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(ProductivityColors.surface)

      Scroll() {
        Column() {
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              this.FilterChip(filter)
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          Column() {
            this.ChartCard()
          }
          .width('100%')
          .margin({ top: 24 })

          ForEach(this.items, (item: ProductivityItem) => {
            Column() {
              this.StatusCard(item)
            }
            .width('100%')
            .margin({ top: 24 })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .width('100%')

      Button('Submit New Form')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductivityColors.onPrimary)
        .width('100%')
        .height(56)
        .margin(16)
        .backgroundColor(ProductivityColors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ProductivityColors.background)
  }
}
