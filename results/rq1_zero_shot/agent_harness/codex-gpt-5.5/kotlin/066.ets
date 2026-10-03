const NAME: string = "111StockListen";
const UI_TYPE: string = "Calendar";
const STYLE_THEME: string = "Retro Flat";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#214E34';
  static readonly secondary: string = '#2D6A4F';
  static readonly background: string = '#F8F1E5';
  static readonly surface: string = '#FFFBF0';
  static readonly surfaceVariant: string = '#E9DFC7';
  static readonly outline: string = '#D2C6AA';
  static readonly success: string = '#2B9348';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#1B1F22';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xxxl: number = 40;
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
struct MainActivity {
  @State selectedDay: number = 1;
  @State currentSector: string = 'All';

  private days: DayTab[] = [
    new DayTab(1, 'Mon'), new DayTab(2, 'Tue'), new DayTab(3, 'Wed'), new DayTab(4, 'Thu'), new DayTab(5, 'Fri')
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
  CalendarCard() {
    Column({ space: AppSpacing.sm }) {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.days, (day: DayTab) => {
          Text(day.label)
            .fontSize(day.id === this.selectedDay ? 16 : 13)
            .fontWeight(day.id === this.selectedDay ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(day.id === this.selectedDay ? AppColors.onPrimary : AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .height(36)
            .lineHeight(36)
            .backgroundColor(day.id === this.selectedDay ? AppColors.primary : AppColors.surfaceVariant)
            .borderRadius(6)
            .onClick(() => {
              this.selectedDay = day.id;
            })
        })
      }
      .width('100%')

      Row({ space: AppSpacing.sm }) {
        ForEach(this.sectors, (sector: string) => {
          Text(sector)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.currentSector === sector ? AppColors.onPrimary : AppColors.onSurface)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
            .backgroundColor(this.currentSector === sector ? AppColors.secondary : AppColors.surface)
            .borderRadius(6)
            .border({ width: 1, color: AppColors.outline })
            .onClick(() => {
              this.currentSector = sector;
            })
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 6, color: '#24000000', offsetY: 3 })
  }

  @Builder
  StockItem(item: StockRow) {
    Row() {
      Row({ space: AppSpacing.md }) {
        Blank()
          .width(28)
          .height(28)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)
        Column({ space: AppSpacing.xs }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.78)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Row({ space: AppSpacing.lg }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row({ space: AppSpacing.xs }) {
            Blank()
              .width(8)
              .height(8)
              .backgroundColor(item.positive ? AppColors.success : AppColors.error)
              .borderRadius(4)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? AppColors.success : AppColors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width(76)
          .height(36)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(66)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        this.CalendarCard()

        Scroll() {
          Column({ space: AppSpacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              this.StockItem(item)
            })
            Blank().height(AppSpacing.xxxl)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
