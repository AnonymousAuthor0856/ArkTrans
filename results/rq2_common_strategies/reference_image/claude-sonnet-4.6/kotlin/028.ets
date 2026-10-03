// Index.ets — 029_OCRCheckProductivityForm_en / Dashboard / Monochrome Comfortable / 720x1280

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
}

class Space {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
}

class Radius {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
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

class ChartBar {
  label: string;
  value: number;

  constructor(label: string, value: number) {
    this.label = label;
    this.value = value;
  }
}

@Entry
@Component
struct ProductivityCheck {
  @State selectedFilter: string = 'Weekly';
  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  private barAreaHeight: number = 122;

  private chartData: ChartBar[] = [
    new ChartBar('Mon', 0.6),
    new ChartBar('Tue', 0.8),
    new ChartBar('Wed', 0.5),
    new ChartBar('Thu', 1.0),
    new ChartBar('Fri', 0.7),
    new ChartBar('Sat', 0.4),
    new ChartBar('Sun', 0.2)
  ];

  private items: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ];

  @Builder
  TopBar() {
    Row() {
      Row() {
      }
      .width(24)
      .height(24)
      .backgroundColor(AppColors.outline)
      .borderRadius(12)
      .onClick(() => {
      })

      Text('Productivity Check')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
      }
      .width(24)
      .height(24)
      .backgroundColor(AppColors.outline)
      .borderRadius(12)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(56)
    .padding({ left: Space.md, right: Space.md })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ChipView(label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === label ? AppColors.onPrimary : AppColors.primary)
      .textAlign(TextAlign.Center)
      .padding({ left: Space.md, right: Space.md, top: Space.sm, bottom: Space.sm })
      .backgroundColor(this.selectedFilter === label ? AppColors.primary : AppColors.surface)
      .borderRadius(Radius.small)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.selectedFilter = label;
      })
  }

  @Builder
  FilterRow() {
    Row() {
      ForEach(this.filters, (filter: string) => {
        this.ChipView(filter)
      }, (filter: string) => filter)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')

      Column() {
        Row() {
          ForEach(this.chartData, (bar: ChartBar) => {
            Column() {
              Column() {
              }
              .width('60%')
              .height(bar.value * this.barAreaHeight)
              .backgroundColor(AppColors.primary)
              .borderRadius(Radius.small)
            }
            .layoutWeight(1)
            .height(this.barAreaHeight)
            .justifyContent(FlexAlign.End)
            .alignItems(HorizontalAlign.Center)
          }, (bar: ChartBar) => bar.label + '_bar')
        }
        .width('100%')
        .height(this.barAreaHeight)
        .alignItems(VerticalAlign.Bottom)

        Row() {
          ForEach(this.chartData, (bar: ChartBar) => {
            Text(bar.label)
              .fontSize(14)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .maxLines(1)
          }, (bar: ChartBar) => bar.label + '_label')
        }
        .width('100%')
        .margin({ top: Space.sm })
      }
      .width('100%')
      .margin({ top: Space.md })
    }
    .width('100%')
    .padding(Space.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(Radius.large)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ItemCard(item: ProductivityItem) {
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
          Row() {
          }
          .width(10)
          .height(10)
          .backgroundColor(item.statusColor)
          .borderRadius(5)

          Text(item.status)
            .fontSize(14)
            .fontColor(item.statusColor)
            .margin({ left: Space.sm })
            .maxLines(1)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Row() {
          }
          .width('100%')
          .height(8)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(4)

          Row() {
          }
          .width((item.progress * 100).toFixed(0) + '%')
          .height(8)
          .backgroundColor(item.statusColor)
          .borderRadius(4)
        }
        .layoutWeight(1)
        .height(8)

        Text((item.progress * 100).toFixed(0) + '%')
          .fontSize(14)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: Space.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: Space.md })
    }
    .width('100%')
    .padding(Space.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(Radius.medium)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  BottomBar() {
    Column() {
      Button('Submit New Form')
        .width('100%')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(Radius.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(Space.md)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 10, color: '#14000000', offsetX: 0, offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.FilterRow()

          Column() {
            this.ChartCard()
          }
          .width('100%')
          .margin({ top: Space.lg, bottom: Space.lg })

          ForEach(this.items, (item: ProductivityItem) => {
            this.ItemCard(item)
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding(Space.md)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}