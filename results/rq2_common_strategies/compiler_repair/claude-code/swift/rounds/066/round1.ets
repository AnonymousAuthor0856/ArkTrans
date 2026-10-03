// AppTokens - Design System
class AppColors {
  static readonly primary: Color = { r: 33, g: 78, b: 52, a: 1 };
  static readonly secondary: Color = { r: 45, g: 106, b: 79, a: 1 };
  static readonly tertiary: Color = { r: 108, g: 117, b: 125, a: 1 };
  static readonly background: Color = { r: 248, g: 241, b: 229, a: 1 };
  static readonly surface: Color = { r: 255, g: 251, b: 240, a: 1 };
  static readonly surfaceVariant: Color = { r: 233, g: 223, b: 199, a: 1 };
  static readonly outline: Color = { r: 210, g: 198, b: 170, a: 1 };
  static readonly success: Color = { r: 43, g: 147, b: 72, a: 1 };
  static readonly warning: Color = { r: 244, g: 162, b: 97, a: 1 };
  static readonly error: Color = { r: 214, g: 40, b: 40, a: 1 };
  static readonly onPrimary: Color = { r: 255, g: 255, b: 255, a: 1 };
  static readonly onSecondary: Color = { r: 255, g: 255, b: 255, a: 1 };
  static readonly onTertiary: Color = { r: 27, g: 31, b: 34, a: 1 };
  static readonly onBackground: Color = { r: 27, g: 31, b: 34, a: 1 };
  static readonly onSurface: Color = { r: 27, g: 31, b: 34, a: 1 };
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

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppElevation {
  static readonly level1: ShadowSpec = { radius: 3, dy: 1, opacity: 0.10 };
  static readonly level2: ShadowSpec = { radius: 6, dy: 3, opacity: 0.14 };
  static readonly level3: ShadowSpec = { radius: 10, dy: 5, opacity: 0.16 };
  static readonly level4: ShadowSpec = { radius: 14, dy: 7, opacity: 0.18 };
  static readonly level5: ShadowSpec = { radius: 18, dy: 9, opacity: 0.20 };
}

// Data Models
interface DayTab {
  id: number;
  label: string;
}

interface StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

// Filter Chip Component
@Component
struct CustomFilterChip {
  @Prop selected: boolean = false;
  @Prop label: string = '';
  onSelect?: () => void;

  build() {
    Text(this.label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.selected ? AppColors.secondary : AppColors.surface)
      .borderRadius(AppRadius.small)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        if (this.onSelect) {
          this.onSelect();
        }
      })
  }
}

// Day Tab Button
@Component
struct DayTabButton {
  @Prop day: DayTab = { id: 0, label: '' };
  @Prop active: boolean = false;
  onClick?: () => void;

  build() {
    Text(this.day.label)
      .fontSize(this.active ? 16 : 13)
      .fontWeight(this.active ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.active ? AppColors.onPrimary : AppColors.onSurface)
      .height(36)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.active ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppRadius.small)
      .onClick(() => {
        if (this.onClick) {
          this.onClick();
        }
      })
  }
}

// Stock Row Item Component
@Component
struct StockItem {
  @Prop item: StockRow = { code: '', name: '', price: '', change: '', positive: false };

  build() {
    Row() {
      Row() {
        // Icon placeholder
        Row() { }
          .width(28)
          .height(28)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.small)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .space(AppSpacing.md)

      Blank()

      Row() {
        Column() {
          Text(this.item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row() {
            Row() { }
              .width(8)
              .height(8)
              .backgroundColor(this.item.positive ? AppColors.success : AppColors.error)
              .borderRadius(AppRadius.small)
            Text(this.item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.item.positive ? AppColors.success : AppColors.error)
          }
          .space(AppSpacing.xs)
        }
        .alignItems(HorizontalAlign.End)

        Text('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width(76)
          .height(36)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.small)
          .onClick(() => { })
      }
      .space(AppSpacing.lg)
    }
    .padding(AppSpacing.md)
    .height(72)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: AppElevation.level1.radius,
      color: { r: 0, g: 0, b: 0, a: AppElevation.level1.opacity },
      offsetY: AppElevation.level1.dy
    })
  }
}

// Main Entry
@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1;
  @State currentSector: string = 'All';

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ];

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  private items: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 40, bottom: 40 })
      .backgroundColor(AppColors.background)

      Scroll() {
        Column() {
          // Filter Card
          Column() {
            // Day Tabs
            Row() {
              ForEach(this.days, (d: DayTab) => {
                DayTabButton({
                  day: d,
                  active: d.id === this.selectedDayId,
                  onClick: () => {
                    this.selectedDayId = d.id;
                  }
                })
              }, (d: DayTab) => d.id.toString())
            }
            .width('100%')
            .space(AppSpacing.md)

            // Sector Filter Chips
            Row() {
              ForEach(this.sectors, (s: string) => {
                CustomFilterChip({
                  selected: this.currentSector === s,
                  label: s,
                  onSelect: () => {
                    this.currentSector = s;
                  }
                })
              }, (s: string) => s)
              Blank()
            }
            .width('100%')
            .space(AppSpacing.sm)
          }
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppRadius.large)
          .border({ width: 1, color: AppColors.outline })
          .shadow({
            radius: AppElevation.level2.radius,
            color: { r: 0, g: 0, b: 0, a: AppElevation.level2.opacity },
            offsetY: AppElevation.level2.dy
          })

          // Stock List
          Column() {
            ForEach(this.items, (item: StockRow) => {
              StockItem({ item: item })
            }, (item: StockRow) => item.code)
          }
          .width('100%')
          .space(AppSpacing.sm)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.xxxl
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
