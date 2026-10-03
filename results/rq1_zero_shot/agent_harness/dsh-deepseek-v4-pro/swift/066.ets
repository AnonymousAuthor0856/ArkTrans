// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 26, weight: FontWeight.Semibold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  },
  Shadow: {
    level1: { radius: 3, dy: 1, color: '#1A000000' },
    level2: { radius: 6, dy: 3, color: '#24000000' }
  }
};

const colorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  tertiary: AppTokens.Colors.tertiary,
  onTertiary: AppTokens.Colors.onTertiary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error,
  success: AppTokens.Colors.success,
  warning: AppTokens.Colors.warning
};

const typography = {
  displayLarge: AppTokens.Typography.display,
  headlineMedium: AppTokens.Typography.headline,
  titleMedium: AppTokens.Typography.title,
  bodyMedium: AppTokens.Typography.body,
  labelMedium: AppTokens.Typography.label
};

const shapes = {
  small: AppTokens.Shapes.small,
  medium: AppTokens.Shapes.medium,
  large: AppTokens.Shapes.large
};

// MARK: - Data Models
class DayTab {
  id: number;
  label: string;
  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

class StockRow {
  id: number;
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
  constructor(id: number, code: string, name: string, price: string, change: string, positive: boolean) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.price = price;
    this.change = change;
    this.positive = positive;
  }
}

// MARK: - CustomFilterChip
@Component
struct CustomFilterChip {
  @Prop selected: boolean = false;
  @Prop label: string = '';
  action: () => void = () => {};

  build() {
    Button() {
      Text(this.label)
        .fontSize(typography.labelMedium.size)
        .fontWeight(typography.labelMedium.weight)
        .fontColor(this.selected ? colorScheme.onPrimary : colorScheme.onSurface)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.selected ? colorScheme.secondary : colorScheme.surface)
        .borderRadius(shapes.small)
        .border({ width: 1, color: colorScheme.outline })
    }
    .onClick(() => {
      this.action();
    })
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ];
  @State selectedDayId: number = 1;

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];
  @State currentSector: string = 'All';

  private items: StockRow[] = [
    new StockRow(1, '600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow(2, '000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow(3, '300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow(4, '601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow(5, '600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow(6, '688981', 'SMIC', '56.4', '-0.48%', false)
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        // 顶部应用栏
        Row() {
          Blank()
          Text('Stock Calendar')
            .fontSize(typography.displayLarge.size)
            .fontWeight(typography.displayLarge.weight)
            .fontColor(colorScheme.onSurface)
          Blank()
        }
        .width('100%')
        .padding({ top: 40, bottom: 40 })
        .backgroundColor(colorScheme.background)

        // 主要内容区域
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // 日期选择和行业筛选卡片
            Column({ space: AppTokens.Spacing.md }) {
              Row({ space: AppTokens.Spacing.md }) {
                ForEach(this.days, (d: DayTab) => {
                  Button() {
                    Text(d.label)
                      .fontSize(d.id === this.selectedDayId ? typography.titleMedium.size : typography.bodyMedium.size)
                      .fontWeight(d.id === this.selectedDayId ? typography.titleMedium.weight : typography.bodyMedium.weight)
                      .fontColor(d.id === this.selectedDayId ? colorScheme.onPrimary : colorScheme.onSurface)
                      .width('100%')
                      .height(36)
                      .backgroundColor(d.id === this.selectedDayId ? colorScheme.primary : colorScheme.surfaceVariant)
                      .borderRadius(shapes.small)
                  }
                  .layoutWeight(1)
                  .onClick(() => {
                    this.selectedDayId = d.id;
                  })
                }, (d: DayTab) => d.id.toString())
              }

              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.sectors, (s: string) => {
                  CustomFilterChip({
                    selected: this.currentSector === s,
                    label: s,
                    action: () => {
                      this.currentSector = s;
                    }
                  })
                }, (s: string) => s)
                Blank()
              }
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(colorScheme.surface)
            .borderRadius(shapes.large)
            .border({ width: 1, color: colorScheme.outline })
            .shadow({ radius: AppTokens.Shadow.level2.radius, color: AppTokens.Shadow.level2.color, offsetX: 0, offsetY: AppTokens.Shadow.level2.dy })

            // 股票列表
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                Row() {
                  Row({ space: AppTokens.Spacing.md }) {
                    Row()
                      .width(28)
                      .height(28)
                      .backgroundColor(colorScheme.surfaceVariant)
                      .borderRadius(shapes.small)

                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(item.name)
                        .fontSize(typography.titleMedium.size)
                        .fontWeight(typography.titleMedium.weight)
                        .fontColor(colorScheme.onSurface)
                      Text(item.code)
                        .fontSize(typography.labelMedium.size)
                        .fontWeight(typography.labelMedium.weight)
                        .fontColor(colorScheme.onSurface)
                    }
                    .alignItems(HorizontalAlign.Start)
                  }

                  Blank()

                  Row({ space: AppTokens.Spacing.lg }) {
                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(item.price)
                        .fontSize(typography.titleMedium.size)
                        .fontWeight(typography.titleMedium.weight)
                        .fontColor(colorScheme.onSurface)
                      Row({ space: AppTokens.Spacing.xs }) {
                        Row()
                          .width(8)
                          .height(8)
                          .backgroundColor(item.positive ? colorScheme.success : colorScheme.error)
                          .borderRadius(4)
                        Text(item.change)
                          .fontSize(typography.labelMedium.size)
                          .fontWeight(typography.labelMedium.weight)
                          .fontColor(item.positive ? colorScheme.success : colorScheme.error)
                      }
                    }
                    .alignItems(HorizontalAlign.End)

                    Button() {
                      Text('Detail')
                        .fontSize(typography.labelMedium.size)
                        .fontWeight(typography.labelMedium.weight)
                        .fontColor(colorScheme.onPrimary)
                        .width(76)
                        .height(36)
                        .backgroundColor(colorScheme.primary)
                        .borderRadius(shapes.small)
                    }
                    .onClick(() => {})
                  }
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .constraintSize({ minHeight: 72 })
                .backgroundColor(colorScheme.surface)
                .borderRadius(shapes.medium)
                .border({ width: 1, color: colorScheme.outline })
                .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
              }, (item: StockRow) => item.id.toString())
            }
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorScheme.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - StockCalendarApp
@Entry
@Component
struct StockCalendarApp {
  build() {
    RootScreen()
  }
}
