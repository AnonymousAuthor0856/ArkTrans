import window from '@ohos.window';

class AppColors {
  static readonly primary: ResourceColor = '#214E34';
  static readonly secondary: ResourceColor = '#2D6A4F';
  static readonly tertiary: ResourceColor = '#6C757D';
  static readonly background: ResourceColor = '#F8F1E5';
  static readonly surface: ResourceColor = '#FFFBF0';
  static readonly surfaceVariant: ResourceColor = '#E9DFC7';
  static readonly outline: ResourceColor = '#D2C6AA';
  static readonly success: ResourceColor = '#2B9348';
  static readonly warning: ResourceColor = '#F4A261';
  static readonly error: ResourceColor = '#D62828';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#1B1F22';
  static readonly onBackground: ResourceColor = '#1B1F22';
  static readonly onSurface: ResourceColor = '#1B1F22';
}

class TextStyleToken {
  size: number;
  weight: FontWeight | string | number;

  constructor(size: number, weight: FontWeight | string | number) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypography {
  static readonly displayLarge: TextStyleToken = new TextStyleToken(26, '600');
  static readonly headlineMedium: TextStyleToken = new TextStyleToken(20, FontWeight.Medium);
  static readonly titleMedium: TextStyleToken = new TextStyleToken(16, FontWeight.Medium);
  static readonly bodyMedium: TextStyleToken = new TextStyleToken(13, FontWeight.Regular);
  static readonly labelMedium: TextStyleToken = new TextStyleToken(11, FontWeight.Medium);
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 3, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 5, 0.16);
  static readonly level4: ShadowSpec = new ShadowSpec(10, 14, 7, 0.18);
  static readonly level5: ShadowSpec = new ShadowSpec(14, 18, 9, 0.20);
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

@Builder
function DefaultBuilder() {
}

@Component
struct CustomCard {
  radius: number = AppShapes.medium;
  containerColor: ResourceColor = AppColors.surface;
  elevation: ShadowSpec = ElevationMapping.level1;
  borderWidth: number = 0;
  borderColor: ResourceColor = Color.Transparent;

  @BuilderParam content: () => void = DefaultBuilder;

  build() {
    Column() {
      this.content();
    }
    .width('100%')
    .backgroundColor(this.containerColor)
    .borderRadius(this.radius)
    .shadow({
      radius: this.elevation.radius,
      color: `rgba(0, 0, 0, ${this.elevation.opacity})`,
      offsetX: 0,
      offsetY: this.elevation.dy
    })
    .border({
      width: this.borderWidth,
      color: this.borderColor
    })
  }
}

@Component
struct CustomFilterChip {
  selected: boolean = false;
  label: string = '';
  action: () => void = () => {
  };

  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(this.label)
        .fontSize(AppTypography.labelMedium.size)
        .fontWeight(AppTypography.labelMedium.weight)
        .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(this.selected ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.action();
    })
  }
}

@Entry
@Component
struct RootScreen {
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ];

  @State private selectedDayId: number = 1;

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  @State private currentSector: string = 'All';

  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Blank();

          Text('Stock Calendar')
            .fontSize(AppTypography.displayLarge.size)
            .fontWeight(AppTypography.displayLarge.weight)
            .fontColor(AppColors.onSurface)

          Blank();
        }
        .width('100%')
        .padding({
          top: 40,
          bottom: 40
        })
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            CustomCard({
              radius: AppShapes.large,
              containerColor: AppColors.surface,
              elevation: ElevationMapping.level2,
              borderWidth: 1,
              borderColor: AppColors.outline
            }) {
              Column({ space: AppSpacing.md }) {
                Row({ space: AppSpacing.md }) {
                  ForEach(this.days, (d: DayTab) => {
                    Button({ type: ButtonType.Normal, stateEffect: true }) {
                      Text(d.label)
                        .fontSize(d.id === this.selectedDayId ? AppTypography.titleMedium.size : AppTypography.bodyMedium.size)
                        .fontWeight(d.id === this.selectedDayId ? AppTypography.titleMedium.weight : AppTypography.bodyMedium.weight)
                        .fontColor(d.id === this.selectedDayId ? AppColors.onPrimary : AppColors.onSurface)
                    }
                    .height(36)
                    .layoutWeight(1)
                    .padding(0)
                    .backgroundColor(d.id === this.selectedDayId ? AppColors.primary : AppColors.surfaceVariant)
                    .borderRadius(AppShapes.small)
                    .onClick(() => {
                      this.selectedDayId = d.id;
                    })
                  }, (d: DayTab) => d.id.toString())
                }
                .width('100%')

                Row({ space: AppSpacing.sm }) {
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
                    .layoutWeight(1)
                }
                .width('100%')
              }
              .padding(AppSpacing.md)
            }

            Column({ space: AppSpacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                CustomCard({
                  radius: AppShapes.medium,
                  containerColor: AppColors.surface,
                  elevation: ElevationMapping.level1,
                  borderWidth: 1,
                  borderColor: AppColors.outline
                }) {
                  Row() {
                    Row({ space: AppSpacing.md }) {
                      Stack()
                        .width(28)
                        .height(28)
                        .backgroundColor(AppColors.surfaceVariant)
                        .borderRadius(AppShapes.small)

                      Column({ space: AppSpacing.xs }) {
                        Text(item.name)
                          .fontSize(AppTypography.titleMedium.size)
                          .fontWeight(AppTypography.titleMedium.weight)
                          .fontColor(AppColors.onSurface)
                          .maxLines(1)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })

                        Text(item.code)
                          .fontSize(AppTypography.labelMedium.size)
                          .fontWeight(AppTypography.labelMedium.weight)
                          .fontColor(AppColors.onSurface)
                      }
                      .alignItems(HorizontalAlign.Start)
                    }
                    .alignItems(VerticalAlign.Center)

                    Blank()
                      .layoutWeight(1)

                    Row({ space: AppSpacing.lg }) {
                      Column() {
                        Text(item.price)
                          .fontSize(AppTypography.titleMedium.size)
                          .fontWeight(AppTypography.titleMedium.weight)
                          .fontColor(AppColors.onSurface)

                        Row({ space: AppSpacing.xs }) {
                          Stack()
                            .width(8)
                            .height(8)
                            .backgroundColor(item.positive ? AppColors.success : AppColors.error)
                            .borderRadius(AppShapes.small)

                          Text(item.change)
                            .fontSize(AppTypography.labelMedium.size)
                            .fontWeight(AppTypography.labelMedium.weight)
                            .fontColor(item.positive ? AppColors.success : AppColors.error)
                        }
                        .alignItems(VerticalAlign.Center)
                      }
                      .alignItems(HorizontalAlign.End)

                      Button({ type: ButtonType.Normal, stateEffect: true }) {
                        Text('Detail')
                          .fontSize(AppTypography.labelMedium.size)
                          .fontWeight(AppTypography.labelMedium.weight)
                          .fontColor(AppColors.onPrimary)
                      }
                      .width(76)
                      .height(36)
                      .padding(0)
                      .backgroundColor(AppColors.primary)
                      .borderRadius(AppShapes.small)
                      .onClick(() => {
                      })
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('100%')
                  .constraintSize({ minHeight: 72 })
                  .padding(AppSpacing.md)
                  .alignItems(VerticalAlign.Center)
                }
              }, (item: StockRow) => item.code)
            }
            .width('100%')
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.xxxl + AppSpacing.md
          })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}