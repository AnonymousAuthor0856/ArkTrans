// Design Tokens
class ColorsClass {
  primary: string = '#214E34';
  secondary: string = '#2D6A4F';
  tertiary: string = '#6C757D';
  background: string = '#F8F1E5';
  surface: string = '#FFFBF0';
  surfaceVariant: string = '#E9DFC7';
  outline: string = '#D2C6AA';
  success: string = '#2B9348';
  warning: string = '#F4A261';
  error: string = '#D62828';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#1B1F22';
  onBackground: string = '#1B1F22';
  onSurface: string = '#1B1F22';
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 20;
  xxl: number = 28;
  xxxl: number = 40;
}

const Colors: ColorsClass = new ColorsClass();
const Spacing: SpacingClass = new SpacingClass();

interface DayTab {
  id: number;
  label: string;
}

interface StockRow {
  id: string;
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

@Entry
@Component
struct RootScreen {
  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' },
  ];

  @State selectedDayId: number = 1;

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];
  @State currentSector: string = 'All';

  private items: StockRow[] = [
    { id: '1', code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { id: '2', code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { id: '3', code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { id: '4', code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { id: '5', code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { id: '6', code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false },
  ];

  @Builder
  DayButton(day: DayTab) {
    Button(day.label)
      .fontSize(day.id === this.selectedDayId ? 16 : 13)
      .fontWeight(day.id === this.selectedDayId ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(day.id === this.selectedDayId ? Colors.onPrimary : Colors.onSurface)
      .backgroundColor(day.id === this.selectedDayId ? Colors.primary : Colors.surfaceVariant)
      .borderRadius(6)
      .height(36)
      .layoutWeight(1)
      .onClick(() => {
        this.selectedDayId = day.id;
      })
  }

  @Builder
  FilterChip(sector: string) {
    Button(sector)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentSector === sector ? Colors.onPrimary : Colors.onSurface)
      .backgroundColor(this.currentSector === sector ? Colors.secondary : Colors.surface)
      .borderRadius(6)
      .border({ width: 1, color: Colors.outline })
      .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
      .onClick(() => {
        this.currentSector = sector;
      })
  }

  @Builder
  StockCard(item: StockRow) {
    Row() {
      Row({ space: Spacing.md }) {
        Column()
          .width(28)
          .height(28)
          .borderRadius(6)
          .backgroundColor(Colors.surfaceVariant)

        Column({ space: Spacing.xs }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Row({ space: Spacing.lg }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Row({ space: Spacing.xs }) {
            Column()
              .width(8)
              .height(8)
              .borderRadius(2)
              .backgroundColor(item.positive ? Colors.success : Colors.error)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? Colors.success : Colors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(6)
          .width(76)
          .height(36)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(Spacing.md)
    .constraintSize({ minHeight: 72 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Colors.surface)
    .borderRadius(10)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 40, bottom: 40 })
      .backgroundColor(Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.md }) {
          // Day + Sector Filter Card
          Column({ space: Spacing.md }) {
            // Day Tabs
            Row({ space: Spacing.md }) {
              ForEach(this.days, (day: DayTab) => {
                this.DayButton(day)
              }, (day: DayTab) => day.id.toString())
            }
            .width('100%')

            // Sector Filter Chips
            Row({ space: Spacing.sm }) {
              ForEach(this.sectors, (sector: string) => {
                this.FilterChip(sector)
              }, (sector: string) => sector)
            }
            .width('100%')
          }
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(14)
          .border({ width: 1, color: Colors.outline })
          .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })
          .alignItems(HorizontalAlign.Start)

          // Stock List
          Column({ space: Spacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              this.StockCard(item)
            }, (item: StockRow) => item.id)
          }
          .width('100%')
        }
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.md,
          bottom: Spacing.xxxl
        })
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}