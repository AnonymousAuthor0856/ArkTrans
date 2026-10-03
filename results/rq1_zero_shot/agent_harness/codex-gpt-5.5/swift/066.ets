class AppColors {
  static primary: string = '#214E34';
  static secondary: string = '#2D6A4F';
  static tertiary: string = '#6C757D';
  static background: string = '#F8F1E5';
  static surface: string = '#FFFBF0';
  static surfaceVariant: string = '#E9DFC7';
  static outline: string = '#D2C6AA';
  static success: string = '#2B9348';
  static warning: string = '#F4A261';
  static error: string = '#D62828';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#1B1F22';
  static onBackground: string = '#1B1F22';
  static onSurface: string = '#1B1F22';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 20;
  static xxl: number = 28;
  static xxxl: number = 40;
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
  @State private selectedDayId: number = 1;
  @State private currentSector: string = 'All';
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
  private FilterChip(label: string) {
    Text(label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentSector === label ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.currentSector === label ? AppColors.secondary : AppColors.surface)
      .borderRadius(6)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.currentSector = label;
      })
  }

  @Builder
  private DayButton(day: DayTab) {
    Text(day.label)
      .fontSize(this.selectedDayId === day.id ? 16 : 13)
      .fontWeight(this.selectedDayId === day.id ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedDayId === day.id ? AppColors.onPrimary : AppColors.onSurface)
      .height(36)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.selectedDayId === day.id ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(6)
      .onClick(() => {
        this.selectedDayId = day.id;
      })
  }

  @Builder
  private StockCard(item: StockRow) {
    Row() {
      Row({ space: AppSpacing.md }) {
        Rect()
          .width(28)
          .height(28)
          .fill(AppColors.surfaceVariant)
          .radius(6)
        Column({ space: AppSpacing.xs }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Row({ space: AppSpacing.lg }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row({ space: AppSpacing.xs }) {
            Rect()
              .width(8)
              .height(8)
              .fill(item.positive ? AppColors.success : AppColors.error)
              .radius(4)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? AppColors.success : AppColors.error)
          }
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .width(76)
          .height(36)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
      }
    }
    .padding(AppSpacing.md)
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })
  }

  @Builder
  private SelectorCard() {
    Column({ space: AppSpacing.md }) {
      Row({ space: AppSpacing.md }) {
        ForEach(this.days, (day: DayTab) => {
          this.DayButton(day)
        })
      }
      .width('100%')

      Row({ space: AppSpacing.sm }) {
        ForEach(this.sectors, (sector: string) => {
          this.FilterChip(sector)
        })
        Blank()
      }
      .width('100%')
    }
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 6, color: '#00000024', offsetX: 0, offsetY: 3 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Blank()
          Text('Stock Calendar')
            .fontSize(26)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
          Blank()
        }
        .padding({ top: 40, bottom: 40 })
        .width('100%')
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            this.SelectorCard()

            Column({ space: AppSpacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                this.StockCard(item)
              })
            }
            .width('100%')
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
