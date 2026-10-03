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

// Design System Tokens
class AppTokens {
  static readonly Colors: Record<string, string> = {
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
  }

  static readonly Typography: Record<string, Object> = {
    display: { size: 26, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  }

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  }

  static readonly Elevation: Record<string, Object> = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 3, opacity: 0.14 },
    level3: { radius: 10, dy: 5, opacity: 0.16 },
    level4: { radius: 14, dy: 7, opacity: 0.18 },
    level5: { radius: 18, dy: 9, opacity: 0.20 }
  }
}

// Custom Components
@Component
struct CustomCard {
  @Prop shape: number = 0;
  @Prop containerColor: ResourceColor = Color.Transparent;
  @Prop elevationRadius: number = 0;
  @Prop elevationDy: number = 0;
  @Prop elevationOpacity: number = 0;
  @Prop cardBorderWidth: number = 0;
  @Prop cardBorderColor: ResourceColor = Color.Transparent;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(this.containerColor)
    .borderRadius(this.shape)
    .border({ width: this.cardBorderWidth, color: this.cardBorderColor })
    .shadow({
      radius: this.elevationRadius,
      color: `rgba(0,0,0,${this.elevationOpacity})`,
      offsetX: 0,
      offsetY: this.elevationDy
    })
  }
}

@Component
struct CustomFilterChip {
  @Prop selected: boolean = false;
  @Prop label: string = '';
  onSelect: () => void = () => {};

  build() {
    Button(this.label, { type: ButtonType.Normal })
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.selected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onSelect())
  }
}

// Main UI
@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1;
  @State currentSector: string = 'All';

  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ];

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top App Bar
        Row() {
          Blank()
          Text('Stock Calendar')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
        }
        .width('100%')
        .padding({ top: 40, bottom: 40 })
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Date & Sector Selection Card
            CustomCard({
              shape: AppTokens.Shapes.large,
              containerColor: AppTokens.Colors.surface,
              elevationRadius: AppTokens.Elevation.level2.radius,
              elevationDy: AppTokens.Elevation.level2.dy,
              elevationOpacity: AppTokens.Elevation.level2.opacity,
              cardBorderWidth: 1,
              cardBorderColor: AppTokens.Colors.outline,
              content: () => {
                Column({ space: AppTokens.Spacing.md }) {
                  // Day Tabs
                  Row({ space: AppTokens.Spacing.md }) {
                    ForEach(this.days, (d: DayTab) => {
                      Button(d.label, { type: ButtonType.Normal })
                        .fontSize(d.id === this.selectedDayId ?
                          AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                        .fontWeight(d.id === this.selectedDayId ?
                          AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                        .fontColor(d.id === this.selectedDayId ?
                          AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                        .layoutWeight(1)
                        .height(36)
                        .backgroundColor(d.id === this.selectedDayId ?
                          AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                        .borderRadius(AppTokens.Shapes.small)
                        .onClick(() => {
                          this.selectedDayId = d.id;
                        })
                    })
                  }
                  .width('100%')

                  // Sector Filter Chips
                  Row({ space: AppTokens.Spacing.sm }) {
                    ForEach(this.sectors, (s: string) => {
                      CustomFilterChip({
                        selected: this.currentSector === s,
                        label: s,
                        onSelect: () => {
                          this.currentSector = s;
                        }
                      })
                    })
                    Blank()
                  }
                  .width('100%')
                }
                .padding(AppTokens.Spacing.md)
              }
            })

            // Stock List
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                CustomCard({
                  shape: AppTokens.Shapes.medium,
                  containerColor: AppTokens.Colors.surface,
                  elevationRadius: AppTokens.Elevation.level1.radius,
                  elevationDy: AppTokens.Elevation.level1.dy,
                  elevationOpacity: AppTokens.Elevation.level1.opacity,
                  cardBorderWidth: 1,
                  cardBorderColor: AppTokens.Colors.outline,
                  content: () => {
                    Row() {
                      // Left Section
                      Row({ space: AppTokens.Spacing.md }) {
                        Column()
                          .width(28)
                          .height(28)
                          .backgroundColor(AppTokens.Colors.surfaceVariant)
                          .borderRadius(AppTokens.Shapes.small)

                        Column({ space: AppTokens.Spacing.xs }) {
                          Text(item.name)
                            .fontSize(AppTokens.Typography.title.size)
                            .fontWeight(AppTokens.Typography.title.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Text(item.code)
                            .fontSize(AppTokens.Typography.label.size)
                            .fontWeight(AppTokens.Typography.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                        }
                        .alignItems(HorizontalAlign.Start)
                      }

                      Blank()

                      // Right Section
                      Row({ space: AppTokens.Spacing.lg }) {
                        Column() {
                          Text(item.price)
                            .fontSize(AppTokens.Typography.title.size)
                            .fontWeight(AppTokens.Typography.title.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Row({ space: AppTokens.Spacing.xs }) {
                            Column()
                              .width(8)
                              .height(8)
                              .backgroundColor(item.positive ?
                                AppTokens.Colors.success : AppTokens.Colors.error)
                              .borderRadius(AppTokens.Shapes.small)
                            Text(item.change)
                              .fontSize(AppTokens.Typography.label.size)
                              .fontWeight(AppTokens.Typography.label.weight)
                              .fontColor(item.positive ?
                                AppTokens.Colors.success : AppTokens.Colors.error)
                          }
                        }
                        .alignItems(HorizontalAlign.End)

                        Button('Detail', { type: ButtonType.Normal })
                          .fontSize(AppTokens.Typography.label.size)
                          .fontWeight(AppTokens.Typography.label.weight)
                          .fontColor(AppTokens.Colors.onPrimary)
                          .width(76)
                          .height(36)
                          .backgroundColor(AppTokens.Colors.primary)
                          .borderRadius(AppTokens.Shapes.small)
                      }
                    }
                    .width('100%')
                    .padding(AppTokens.Spacing.md)
                    .constraintSize({ minHeight: 72 })
                  }
                })
              })
            }
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.xxxl
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
  }
}