// AppTokens.ets - Design System
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
    displayLarge: { fontSize: 26, fontWeight: FontWeight.Medium },
    headlineMedium: { fontSize: 20, fontWeight: FontWeight.Medium },
    titleMedium: { fontSize: 16, fontWeight: FontWeight.Medium },
    bodyMedium: { fontSize: 13, fontWeight: FontWeight.Regular },
    labelMedium: { fontSize: 11, fontWeight: FontWeight.Medium }
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
export class DayTab {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

export class StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;

  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
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
  @Prop shapeRadius: number;
  @Prop containerColor: string;
  @Prop elevationRadius: number;
  @Prop elevationDy: number;
  @Prop elevationOpacity: number;
  @Prop borderWidth: number;
  @Prop borderColor: string;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .backgroundColor(this.containerColor)
    .borderRadius(this.shapeRadius)
    .shadow({
      radius: this.elevationRadius,
      color: `rgba(0, 0, 0, ${this.elevationOpacity})`,
      offsetY: this.elevationDy
    })
    .border({
      width: this.borderWidth,
      color: this.borderColor
    })
  }
}

@Component
export struct CustomFilterChip {
  @Prop selected: boolean;
  @Prop label: string;
  onChipClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(AppTokens.Typography.labelMedium.fontSize)
      .fontWeight(AppTokens.Typography.labelMedium.fontWeight)
      .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.selected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
      .onClick(() => {
        this.onChipClick();
      })
  }
}

// RootScreen Component
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

  @Builder
  DayButton(day: DayTab) {
    Text(day.label)
      .fontSize(day.id === this.selectedDayId ?
        AppTokens.Typography.titleMedium.fontSize :
        AppTokens.Typography.bodyMedium.fontSize)
      .fontWeight(day.id === this.selectedDayId ?
        AppTokens.Typography.titleMedium.fontWeight :
        AppTokens.Typography.bodyMedium.fontWeight)
      .fontColor(day.id === this.selectedDayId ?
        AppTokens.Colors.onPrimary :
        AppTokens.Colors.onSurface)
      .width('100%')
      .height(36)
      .textAlign(TextAlign.Center)
      .backgroundColor(day.id === this.selectedDayId ?
        AppTokens.Colors.primary :
        AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.selectedDayId = day.id;
      })
  }

  @Builder
  StockListItem(item: StockRow) {
    CustomCard({
      shapeRadius: AppTokens.Shapes.medium,
      containerColor: AppTokens.Colors.surface,
      elevationRadius: AppTokens.Elevation.level1.radius,
      elevationDy: AppTokens.Elevation.level1.dy,
      elevationOpacity: AppTokens.Elevation.level1.opacity,
      borderWidth: 1,
      borderColor: AppTokens.Colors.outline,
      content: () => {
        this.StockItemContent(item);
      }
    })
  }

  @Builder
  StockItemContent(item: StockRow) {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        // Icon placeholder
        Row()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(item.name)
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(item.code)
            .fontSize(AppTokens.Typography.labelMedium.fontSize)
            .fontWeight(AppTokens.Typography.labelMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Row({ space: AppTokens.Spacing.lg }) {
        Column() {
          Text(item.price)
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Row({ space: AppTokens.Spacing.xs }) {
            Row()
              .width(8)
              .height(8)
              .backgroundColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
              .borderRadius(AppTokens.Shapes.small)
            Text(item.change)
              .fontSize(AppTokens.Typography.labelMedium.fontSize)
              .fontWeight(AppTokens.Typography.labelMedium.fontWeight)
              .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          }
        }
        .alignItems(HorizontalAlign.End)

        Text('Detail')
          .fontSize(AppTokens.Typography.labelMedium.fontSize)
          .fontWeight(AppTokens.Typography.labelMedium.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(76)
          .height(36)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .constraintSize({ minHeight: 72 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Blank()
        Text('Stock Calendar')
          .fontSize(AppTokens.Typography.displayLarge.fontSize)
          .fontWeight(AppTokens.Typography.displayLarge.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
      }
      .width('100%')
      .padding({
        top: 40,
        bottom: 40
      })
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Date selection and sector filter card
          CustomCard({
            shapeRadius: AppTokens.Shapes.large,
            containerColor: AppTokens.Colors.surface,
            elevationRadius: AppTokens.Elevation.level2.radius,
            elevationDy: AppTokens.Elevation.level2.dy,
            elevationOpacity: AppTokens.Elevation.level2.opacity,
            borderWidth: 1,
            borderColor: AppTokens.Colors.outline,
            content: () => {
              this.FilterCardContent();
            }
          })

          // Stock list
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              this.StockListItem(item);
            }, (item: StockRow) => item.code)
          }
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.xxxl
        })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  FilterCardContent() {
    Column({ space: AppTokens.Spacing.md }) {
      // Day tabs
      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.days, (day: DayTab) => {
          this.DayButton(day);
        }, (day: DayTab) => day.id.toString())
      }
      .width('100%')

      // Sector filter chips
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.sectors, (sector: string) => {
          CustomFilterChip({
            selected: this.currentSector === sector,
            label: sector,
            onChipClick: () => {
              this.currentSector = sector;
            }
          })
        }, (sector: string) => sector)
        Blank()
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
  }
}