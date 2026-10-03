// ArkTS translation of 028.kt (OCRCheckProductivityForm_en dashboard)

const C_PRIMARY = '#0F172A';
const C_SECONDARY = '#475569';
const C_TERTIARY = '#94A3B8';
const C_BACKGROUND = '#F8FAFC';
const C_SURFACE = '#FFFFFF';
const C_SURFACE_VARIANT = '#F1F5F9';
const C_OUTLINE = '#E2E8F0';
const C_SUCCESS = '#22C55E';
const C_WARNING = '#F59E0B';
const C_ERROR = '#EF4444';
const C_ON_PRIMARY = '#FFFFFF';
const C_ON_SECONDARY = '#FFFFFF';
const C_ON_TERTIARY = '#0F172A';
const C_ON_BACKGROUND = '#0F172A';
const C_ON_SURFACE = '#0F172A';

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
struct ProductivityDashboard {
  @State selectedFilter: string = 'Weekly';
  filters: string[] = ['Daily', 'Weekly', 'Monthly'];

  productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, C_SUCCESS),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, C_WARNING),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, C_SECONDARY),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, C_SUCCESS),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, C_ERROR)
  ];

  chartData: ChartData[] = [
    new ChartData('Mon', 0.6), new ChartData('Tue', 0.8), new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0), new ChartData('Fri', 0.7), new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ];

  private isSelected(filter: string): boolean {
    return this.selectedFilter === filter;
  }

  private barHeight(value: number): number {
    return Math.round(value * 120);
  }

  private percentText(progress: number): string {
    return Math.round(progress * 100).toString() + '%';
  }

  @Builder
  ProductivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)
        Row({ space: 8 }) {
          Column()
            .width(10)
            .height(10)
            .backgroundColor(item.statusColor)
            .borderRadius(5)
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      Row({ space: 8 }) {
        Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
          .height(8)
          .color(item.statusColor)
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(4)
          .layoutWeight(1)
        Text(this.percentText(item.progress))
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_SECONDARY)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(C_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: C_OUTLINE })
  }

  build() {
    Column() {
      Stack() {
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_ON_SURFACE)
        Row() {
          Column()
            .width(24)
            .height(24)
            .backgroundColor(C_OUTLINE)
            .borderRadius(12)
          Column()
            .width(24)
            .height(24)
            .backgroundColor(C_OUTLINE)
            .borderRadius(12)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(C_SURFACE)

      Scroll() {
        Column({ space: 24 }) {
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isSelected(filter) ? C_ON_PRIMARY : C_ON_SURFACE)
                .backgroundColor(this.isSelected(filter) ? C_PRIMARY : C_SURFACE)
                .border({ width: 1, color: C_OUTLINE })
                .borderRadius(8)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .onClick(() => {
                  this.selectedFilter = filter;
                })
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
            Blank().height(16)
            Column() {
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Column()
                      .width('60%')
                      .height(this.barHeight(data.value))
                      .backgroundColor(C_PRIMARY)
                      .borderRadius(8)
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.End)
                  .alignItems(HorizontalAlign.Center)
                }, (data: ChartData) => data.label)
              }
              .width('100%')
              .layoutWeight(1)
              .alignItems(VerticalAlign.Bottom)
              Blank().height(8)
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(C_SECONDARY)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                }, (data: ChartData) => data.label)
              }
              .width('100%')
            }
            .width('100%')
            .height(150)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(C_SURFACE)
          .borderRadius(16)

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.ProductivityCard(item)
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)

      Column() {
        Button() {
          Text('Submit New Form')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_PRIMARY)
        }
        .width('100%')
        .height(56)
        .backgroundColor(C_PRIMARY)
        .borderRadius(12)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(C_SURFACE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}
