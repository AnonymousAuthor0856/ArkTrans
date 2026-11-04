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

class StockColors {
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

@Entry
@Component
struct Index {
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
  CalendarPanel() {
    Column() {
      Row() {
        ForEach(this.days, (day: DayTab) => {
          Button(day.label)
            .height(36)
            .fontSize(day.id === this.selectedDay ? 16 : 13)
            .fontWeight(day.id === this.selectedDay ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(day.id === this.selectedDay ? StockColors.onPrimary : StockColors.onSurface)
            .backgroundColor(day.id === this.selectedDay ? StockColors.primary : StockColors.surfaceVariant)
            .borderRadius(6)
            .layoutWeight(1)
            .margin({ right: day.id === 5 ? 0 : 8 })
            .onClick(() => {
              this.selectedDay = day.id;
            })
        }, (day: DayTab) => day.id.toString())
      }
      .width('100%')

      Row() {
        ForEach(this.sectors, (sector: string) => {
          Button(sector)
            .height(34)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.currentSector === sector ? StockColors.onPrimary : StockColors.onSurface)
            .backgroundColor(this.currentSector === sector ? StockColors.secondary : StockColors.surface)
            .borderRadius(6)
            .border({ width: 1, color: StockColors.outline })
            .margin({ right: sector === 'Finance' ? 0 : 8 })
            .onClick(() => {
              this.currentSector = sector;
            })
        }, (sector: string) => sector)
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(StockColors.surface)
    .borderRadius(14)
    .border({ width: 1, color: StockColors.outline })
    .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })
  }

  @Builder
  StockItem(item: StockRow) {
    Row() {
      Row() {
        Text('')
          .width(28)
          .height(28)
          .backgroundColor(StockColors.surfaceVariant)
          .borderRadius(6)

        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(StockColors.onSurface)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(StockColors.onSurface)
            .margin({ top: 4 })
        }
        .margin({ left: 12 })
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Row() {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(StockColors.onSurface)
            .textAlign(TextAlign.End)
          Row() {
            Text('')
              .width(8)
              .height(8)
              .backgroundColor(item.positive ? StockColors.success : StockColors.error)
              .borderRadius(4)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? StockColors.success : StockColors.error)
              .margin({ left: 4 })
          }
          .margin({ top: 4 })
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .width(76)
          .height(36)
          .fontSize(11)
          .fontColor(StockColors.onPrimary)
          .backgroundColor(StockColors.primary)
          .borderRadius(6)
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(StockColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: StockColors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor(StockColors.onSurface)
        .width('100%')
        .height(58)
        .textAlign(TextAlign.Center)

      this.CalendarPanel()

      Scroll() {
        Column() {
          ForEach(this.items, (item: StockRow) => {
            Column() {
              this.StockItem(item)
            }
            .margin({ bottom: 8 })
          }, (item: StockRow) => item.code)
        }
        .width('100%')
        .padding({ top: 12, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 12 })
    .backgroundColor(StockColors.background)
  }
}
