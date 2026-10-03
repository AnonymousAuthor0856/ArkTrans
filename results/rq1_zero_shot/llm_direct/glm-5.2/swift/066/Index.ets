// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#214E34',
    secondary: '#2D6A4F',
    tertiary: '#6C757D',
    background: '#F8F1E5',
    surface: '#FFFBF0',
    surfaceVariant: '#E9DFC7',
    outline: '#D2C6AA',
    success: '#2B9348',
    warning: '#F4A261',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#1B1F22',
    onBackground: '#1B1F22',
    onSurface: '#1B1F22'
  };

  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  };

  static readonly Elevation = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 3, opacity: 0.14 },
    level3: { radius: 10, dy: 5, opacity: 0.16 },
    level4: { radius: 14, dy: 7, opacity: 0.18 },
    level5: { radius: 18, dy: 9, opacity: 0.20 }
  };
}

// Data Models
class DayTab {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

class StockRow {
  id: string;
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;

  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.id = code;
    this.code = code;
    this.name = name;
    this.price = price;
    this.change = change;
    this.positive = positive;
  }
}

// Custom Components
@Component
export struct CustomCard {
  @Prop shape: number;
  @Prop containerColor: string;
  @Prop elevation: any;
  @Prop borderColor: string;
  @Prop borderWidth: number;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(this.containerColor)
    .borderRadius(this.shape)
    .shadow({
      radius: this.elevation.radius,
      color: `rgba(0,0,0,${this.elevation.opacity})`,
      offsetX: 0,
      offsetY: this.elevation.dy
    })
    .border({ width: this.borderWidth, color: this.borderColor, radius: this.shape })
    .padding(0);
  }
}

@Component
export struct CustomFilterChip {
  @Prop selected: boolean;
  @Prop label: string;
  onSelect: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.selected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onSelect());
  }
}

@Entry
@Component
struct RootScreen {
  private days: DayTab[] = [
    new DayTab(1, "Mon"),
    new DayTab(2, "Tue"),
    new DayTab(3, "Wed"),
    new DayTab(4, "Thu"),
    new DayTab(5, "Fri")
  ];
  @State private selectedDayId: number = 1;

  private sectors: string[] = ["All", "Tech", "Energy", "Finance"];
  @State private currentSector: string = "All";

  private items: StockRow[] = [
    new StockRow("600519", "Kweichow Moutai", "1687.3", "+1.24%", true),
    new StockRow("000001", "Ping An Bank", "12.54", "-0.62%", false),
    new StockRow("300750", "CATL", "192.8", "+0.87%", true),
    new StockRow("601318", "Ping An Ins.", "44.2", "-1.12%", false),
    new StockRow("600036", "CMBC", "36.9", "+0.15%", true),
    new StockRow("688981", "SMIC", "56.4", "-0.48%", false)
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top App Bar
        Text("Stock Calendar")
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 40, bottom: 40 })
          .backgroundColor(AppTokens.Colors.background)

        // Main Content
        Scroll() {
          Column() {
            // Date and Sector Card
            CustomCard({
              shape: AppTokens.Shapes.large,
              containerColor: AppTokens.Colors.surface,
              elevation: AppTokens.Elevation.level2,
              borderColor: AppTokens.Colors.outline,
              borderWidth: 1,
              content: () => {
                Column() {
                  // Days Row
                  Row() {
                    ForEach(this.days, (d: DayTab) => {
                      Button(d.label)
                        .fontSize(d.id === this.selectedDayId ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                        .fontWeight(d.id === this.selectedDayId ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                        .fontColor(d.id === this.selectedDayId ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .layoutWeight(1)
                        .height(36)
                        .backgroundColor(d.id === this.selectedDayId ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                        .borderRadius(AppTokens.Shapes.small)
                        .onClick(() => this.selectedDayId = d.id)
                    })
                  }.width('100%')

                  // Sectors Row
                  Row() {
                    ForEach(this.sectors, (s: string) => {
                      CustomFilterChip({
                        selected: this.currentSector === s,
                        label: s,
                        onSelect: () => this.currentSector = s
                      })
                    })
                    Blank().layoutWeight(1)
                  }.width('100%').margin({ top: AppTokens.Spacing.md })
                }
                .padding(AppTokens.Spacing.md)
                .alignItems(HorizontalAlign.Start)
              }
            })

            // Stock List
            Column() {
              ForEach(this.items, (item: StockRow) => {
                CustomCard({
                  shape: AppTokens.Shapes.medium,
                  containerColor: AppTokens.Colors.surface,
                  elevation: AppTokens.Elevation.level1,
                  borderColor: AppTokens.Colors.outline,
                  borderWidth: 1,
                  content: () => {
                    Row() {
                      // Left Section
                      Row() {
                        Column() {
                          Text('')
                        }
                        .backgroundColor(AppTokens.Colors.surfaceVariant)
                        .width(28)
                        .height(28)
                        .borderRadius(AppTokens.Shapes.small)

                        Column() {
                          Text(item.name)
                            .fontSize(AppTokens.Typography.title.size)
                            .fontWeight(AppTokens.Typography.title.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Text(item.code)
                            .fontSize(AppTokens.Typography.label.size)
                            .fontWeight(AppTokens.Typography.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                            .margin({ top: AppTokens.Spacing.xs })
                        }.alignItems(HorizontalAlign.Start)
                      }

                      // Spacer
                      Blank().layoutWeight(1)

                      // Right Section
                      Row() {
                        Column() {
                          Text(item.price)
                            .fontSize(AppTokens.Typography.title.size)
                            .fontWeight(AppTokens.Typography.title.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Row() {
                            Text('')
                              .backgroundColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                              .width(8)
                              .height(8)
                              .borderRadius(4)
                              .margin({ right: AppTokens.Spacing.xs })
                            Text(item.change)
                              .fontSize(AppTokens.Typography.label.size)
                              .fontWeight(AppTokens.Typography.label.weight)
                              .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                          }.margin({ top: AppTokens.Spacing.xs })
                        }.alignItems(HorizontalAlign.End)

                        Button("Detail")
                          .fontSize(AppTokens.Typography.label.size)
                          .fontWeight(AppTokens.Typography.label.weight)
                          .fontColor(AppTokens.Colors.onPrimary)
                          .width(76)
                          .height(36)
                          .backgroundColor(AppTokens.Colors.primary)
                          .borderRadius(AppTokens.Shapes.small)
                          .margin({ left: AppTokens.Spacing.lg })
                      }
                    }
                    .padding(AppTokens.Spacing.md)
                    .width('100%')
                    .height(72)
                  }
                }).margin({ top: AppTokens.Spacing.sm })
              })
            }.margin({ top: AppTokens.Spacing.md })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}