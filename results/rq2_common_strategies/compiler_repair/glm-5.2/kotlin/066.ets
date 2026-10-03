// 111StockListen
// Calendar
// Retro Flat
// en
// 720x1280

interface AppColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface AppTypographyType {
  display: TextStyle;
  headline: TextStyle;
  title: TextStyle;
  body: TextStyle;
  label: TextStyle;
}

interface AppShapesType {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacingType {
  xs: Length;
  sm: Length;
  md: Length;
  lg: Length;
  xl: Length;
  xxl: Length;
  xxxl: Length;
}

interface AppElevationMappingType {
  level1: number;
  level2: number;
  level3: number;
  level4: number;
  level5: number;
}

class AppTokens {
  static Colors: AppColorsType = {
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
    onSurface: '#1B1F22',
  };

  static TypographyTokens: AppTypographyType = {
    display: { fontSize: 26, fontWeight: FontWeight.Medium, lineHeight: 32 } as TextStyle,
    headline: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 26 } as TextStyle,
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 20 } as TextStyle,
    body: { fontSize: 13, fontWeight: FontWeight.Normal, lineHeight: 18 } as TextStyle,
    label: { fontSize: 11, fontWeight: FontWeight.Medium, lineHeight: 14 } as TextStyle,
  };

  static Shapes: AppShapesType = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static Spacing: AppSpacingType = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40,
  };

  static ElevationMapping: AppElevationMappingType = {
    level1: 1,
    level2: 3,
    level3: 6,
    level4: 10,
    level5: 14,
  };
}

class DayTab {
  id: number;
  label: string;
  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

class StockRow {
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

@Entry
@Component
struct RootScreen {
  @State selected: number = 1;
  @State current: string = 'All';
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri'),
  ];
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];
  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false),
  ];

  build() {
    Column() {
      // TopAppBar
      Text('Stock Calendar')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      // Content
      Column() {
        // Filter Card
        Column() {
          // Days Row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.days, (d: DayTab) => {
              Column() {
                Text(d.label)
                  .fontSize(d.id === this.selected ? AppTokens.TypographyTokens.title.fontSize : AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(d.id === this.selected ? AppTokens.TypographyTokens.title.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(d.id === this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .layoutWeight(1)
              .height(36)
              .backgroundColor(d.id === this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.small)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.sm })

          // Sectors Row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.sectors, (s: string) => {
              Text(s)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(this.current === s ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.current === s ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.current = s;
                })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: AppTokens.ElevationMapping.level2, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 3 })

        // List
        Scroll() {
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.items, (itx: StockRow) => {
              Row() {
                Row({ space: AppTokens.Spacing.md }) {
                  Column() {}
                  .width(28)
                  .height(28)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small)

                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(itx.name)
                      .fontSize(AppTokens.TypographyTokens.title.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(itx.code)
                      .fontSize(AppTokens.TypographyTokens.label.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .alignItems(VerticalAlign.Center)

                Row({ space: AppTokens.Spacing.lg }) {
                  Column() {
                    Text(itx.price)
                      .fontSize(AppTokens.TypographyTokens.title.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                    Row({ space: AppTokens.Spacing.xs }) {
                      Column() {}
                      .width(8)
                      .height(8)
                      .backgroundColor(itx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                      .borderRadius(AppTokens.Shapes.small)
                      Text(itx.change)
                        .fontSize(AppTokens.TypographyTokens.label.fontSize)
                        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                        .fontColor(itx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.small)
                    .height(36)
                    .width(76)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 1 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xxxl })
        }
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.md })
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}