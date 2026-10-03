// Design Tokens - using plain constants instead of object literals
const COLOR_PRIMARY: number = 0xFF0F172A;
const COLOR_SECONDARY: number = 0xFF475569;
const COLOR_TERTIARY: number = 0xFF94A3B8;
const COLOR_BACKGROUND: number = 0xFFF8FAFC;
const COLOR_SURFACE: number = 0xFFFFFFFF;
const COLOR_SURFACE_VARIANT: number = 0xFFF1F5F9;
const COLOR_OUTLINE: number = 0xFFE2E8F0;
const COLOR_SUCCESS: number = 0xFF22C55E;
const COLOR_WARNING: number = 0xFFF59E0B;
const COLOR_ERROR: number = 0xFFEF4444;
const COLOR_ON_PRIMARY: number = 0xFFFFFFFF;
const COLOR_ON_SECONDARY: number = 0xFFFFFFFF;
const COLOR_ON_TERTIARY: number = 0xFF0F172A;
const COLOR_ON_BACKGROUND: number = 0xFF0F172A;
const COLOR_ON_SURFACE: number = 0xFF0F172A;

const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 16;
const SPACING_LG: number = 24;
const SPACING_XL: number = 32;
const SPACING_XXL: number = 48;

const SHAPE_SMALL: number = 8;
const SHAPE_MEDIUM: number = 12;
const SHAPE_LARGE: number = 16;

class ProductivityItem {
  id: number = 0;
  title: string = '';
  status: string = '';
  progress: number = 0;
  statusColor: number = COLOR_PRIMARY;
}

class ChartDataItem {
  label: string = '';
  value: number = 0;
}

function makeProductivityItem(id: number, title: string, status: string, progress: number, statusColor: number): ProductivityItem {
  const item = new ProductivityItem();
  item.id = id;
  item.title = title;
  item.status = status;
  item.progress = progress;
  item.statusColor = statusColor;
  return item;
}

function makeChartDataItem(label: string, value: number): ChartDataItem {
  const item = new ChartDataItem();
  item.label = label;
  item.value = value;
  return item;
}

const productivityItems: ProductivityItem[] = [
  makeProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, COLOR_SUCCESS),
  makeProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, COLOR_WARNING),
  makeProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, COLOR_SECONDARY),
  makeProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, COLOR_SUCCESS),
  makeProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, COLOR_ERROR),
];

const chartData: ChartDataItem[] = [
  makeChartDataItem('Mon', 0.6),
  makeChartDataItem('Tue', 0.8),
  makeChartDataItem('Wed', 0.5),
  makeChartDataItem('Thu', 1.0),
  makeChartDataItem('Fri', 0.7),
  makeChartDataItem('Sat', 0.4),
  makeChartDataItem('Sun', 0.2),
];

@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Text(this.title)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
      .padding({
        left: SPACING_MD,
        right: SPACING_MD,
        top: SPACING_SM,
        bottom: SPACING_SM
      })
      .backgroundColor(this.isSelected ? COLOR_PRIMARY : COLOR_SURFACE)
      .borderRadius(SHAPE_SMALL)
      .border({ width: 1, color: COLOR_OUTLINE, radius: SHAPE_SMALL })
      .onClick(() => {
        this.action();
      })
  }
}

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0;
  color: number = COLOR_PRIMARY;
  trackColor: number = COLOR_SURFACE_VARIANT;
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

@Component
struct ProductivityCard {
  item: ProductivityItem = new ProductivityItem();

  build() {
    Column({ space: 0 }) {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)

        Row({ space: SPACING_SM }) {
          Circle({ width: 10, height: 10 })
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: SPACING_MD })

      Row({ space: SPACING_SM }) {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: COLOR_SURFACE_VARIANT,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SECONDARY)
          .width(40)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .padding(SPACING_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_MEDIUM)
    .border({ width: 1, color: COLOR_OUTLINE, radius: SHAPE_MEDIUM })
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';
  filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  chartHeight: number = 150;

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Row() {
        Circle({ width: 24, height: 24 })
          .fill(COLOR_OUTLINE)
          .margin({ left: SPACING_MD })

        Blank()

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)

        Blank()

        Circle({ width: 24, height: 24 })
          .fill(COLOR_OUTLINE)
          .margin({ right: SPACING_MD })
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 4 })
      .zIndex(1)

      // Scrollable Content
      Scroll() {
        Column({ space: SPACING_LG }) {
          // Filter Chips Row
          Row({ space: SPACING_SM }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                action: () => {
                  this.selectedFilter = filter;
                }
              })
            })
          }
          .width('100%')
          .padding({ left: SPACING_MD, right: SPACING_MD })
          .justifyContent(FlexAlign.Start)

          // Weekly Throughput Card
          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)
              .margin({ bottom: SPACING_MD })
              .alignSelf(ItemAlign.Start)

            // Chart bars
            Row() {
              ForEach(chartData, (data: ChartDataItem) => {
                Column() {
                  Blank()
                  Column()
                    .width('60%')
                    .height(this.chartHeight * data.value)
                    .backgroundColor(COLOR_PRIMARY)
                    .borderRadius(SHAPE_SMALL)
                }
                .layoutWeight(1)
                .height(this.chartHeight)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.End)
              })
            }
            .width('100%')
            .height(this.chartHeight)
            .alignItems(VerticalAlign.Bottom)

            // Chart Labels
            Row() {
              ForEach(chartData, (data: ChartDataItem) => {
                Text(data.label)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_SECONDARY)
                  .textAlign(TextAlign.Center)
                  .layoutWeight(1)
              })
            }
            .width('100%')
            .margin({ top: SPACING_SM })
          }
          .padding(SPACING_MD)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(SHAPE_LARGE)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .margin({ left: SPACING_MD, right: SPACING_MD })
          .width(`calc(100% - ${SPACING_MD * 2}vp)`)

          // Productivity Items
          ForEach(productivityItems, (item: ProductivityItem) => {
            ProductivityCard({ item: item })
              .margin({ left: SPACING_MD, right: SPACING_MD })
              .width(`calc(100% - ${SPACING_MD * 2}vp)`)
          })

          // Bottom padding to avoid overlap with bottom bar
          Row()
            .height(88)
        }
        .padding({ top: SPACING_MD, bottom: SPACING_MD })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Column() {
        Button('Submit New Form')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .width('100%')
          .height(56)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(SHAPE_MEDIUM)
          .padding({ left: 0, right: 0 })
      }
      .padding(SPACING_MD)
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: -4 })
      .width('100%')
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}