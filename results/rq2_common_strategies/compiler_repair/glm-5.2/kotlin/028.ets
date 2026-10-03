// Index.ets
const NAME: string = "029_OCRCheckProductivityForm_en";
const UI_TYPE: string = "Dashboard";
const STYLE_THEME: string = "Monochrome Comfortable";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppTokensColors {
  primary: string = "#FF0F172A";
  secondary: string = "#FF475569";
  tertiary: string = "#FF94A3B8";
  background: string = "#FFF8FAFC";
  surface: string = "#FFFFFFFF";
  surfaceVariant: string = "#FFF1F5F9";
  outline: string = "#FFE2E8F0";
  success: string = "#FF22C55E";
  warning: string = "#FFF59E0B";
  error: string = "#FFEF4444";
  onPrimary: string = "#FFFFFFFF";
  onSecondary: string = "#FFFFFFFF";
  onTertiary: string = "#FF0F172A";
  onBackground: string = "#FF0F172A";
  onSurface: string = "#FF0F172A";
}

class AppTokensSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 16;
  lg: number = 24;
  xl: number = 32;
  xxl: number = 48;
}

class AppTokens {
  static Colors: AppTokensColors = new AppTokensColors();
  static Spacing: AppTokensSpacing = new AppTokensSpacing();
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
struct RootScreen {
  @State selectedFilter: string = "Weekly";
  @State productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, "Form Batch #A-102", "Completed", 1.0, AppTokens.Colors.success),
    new ProductivityItem(2, "Invoice Set #B-231", "In Progress", 0.75, AppTokens.Colors.warning),
    new ProductivityItem(3, "Document Scan #C-456", "Pending", 0.1, AppTokens.Colors.secondary),
    new ProductivityItem(4, "Form Batch #A-103", "Completed", 1.0, AppTokens.Colors.success),
    new ProductivityItem(5, "Data Entry #D-789", "Failed", 0.4, AppTokens.Colors.error)
  ];
  @State chartData: ChartData[] = [
    new ChartData("Mon", 0.6),
    new ChartData("Tue", 0.8),
    new ChartData("Wed", 0.5),
    new ChartData("Thu", 1.0),
    new ChartData("Fri", 0.7),
    new ChartData("Sat", 0.4),
    new ChartData("Sun", 0.2)
  ];

  private filters: string[] = ["Daily", "Weekly", "Monthly"];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 24, height: 24 })
          .fill(AppTokens.Colors.outline)
          .margin({ left: AppTokens.Spacing.md });

        Text("Productivity Check")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Circle({ width: 24, height: 24 })
          .fill(AppTokens.Colors.outline)
          .margin({ right: AppTokens.Spacing.md });
      }
      .width("100%")
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Content List
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedFilter === filter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                .margin({ right: 8 })
                .onClick(() => {
                  this.selectedFilter = filter;
                });
            });
          }
          .width("100%")
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg });

          // Weekly Throughput Card
          Column() {
            Text("Weekly Throughput")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md });

            // Chart Bars
            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Column() {
                  Column() {
                    Column()
                      .width("60%")
                      .height(`${data.value * 100}%`)
                      .backgroundColor(AppTokens.Colors.primary)
                      .borderRadius(8);
                  }
                  .layoutWeight(1)
                  .width("100%")
                  .justifyContent(FlexAlign.End)
                  .alignItems(HorizontalAlign.Center);
                }
                .layoutWeight(1)
                .height(150)
                .justifyContent(FlexAlign.End)
              });
            }
            .width("100%")
            .height(150)
            .alignItems(VerticalAlign.Bottom);

            // Chart Labels
            Row() {
              ForEach(this.chartData, (data: ChartData) => {
                Text(data.label)
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.secondary)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center);
              });
            }
            .width("100%")
            .margin({ top: AppTokens.Spacing.sm });
          }
          .width("100%")
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(16)
          .margin({ bottom: AppTokens.Spacing.lg });

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .layoutWeight(1);

                Row() {
                  Circle({ width: 10, height: 10 })
                    .fill(item.statusColor)
                    .margin({ right: AppTokens.Spacing.sm });

                  Text(item.status)
                    .fontSize(14)
                    .fontColor(item.statusColor);
                }
                .alignItems(VerticalAlign.Center);
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);

              Row() {
                Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
                  .layoutWeight(1)
                  .height(8)
                  .color(item.statusColor)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)
                  .margin({ right: AppTokens.Spacing.sm });

                Text(`${Math.floor(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.secondary)
                  .width(40)
                  .textAlign(TextAlign.End);
              }
              .width("100%")
              .margin({ top: AppTokens.Spacing.md })
              .alignItems(VerticalAlign.Center);
            }
            .width("100%")
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ bottom: AppTokens.Spacing.lg });
          });
        }
        .width("100%")
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: 80 });
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Bar
      Row() {
        Button("Submit New Form")
          .width("100%")
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(12);
      }
      .width("100%")
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: "#1A000000", offsetX: 0, offsetY: -4 });
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background);
  }
}