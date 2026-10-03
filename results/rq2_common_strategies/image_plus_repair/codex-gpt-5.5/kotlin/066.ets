class DayTab {
  id: number
  label: string

  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

class StockRow {
  code: string
  name: string
  price: string
  change: string
  positive: boolean

  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.code = code
    this.name = name
    this.price = price
    this.change = change
    this.positive = positive
  }
}

class AppColors {
  static readonly primary: ResourceColor = '#214E34'
  static readonly secondary: ResourceColor = '#2D6A4F'
  static readonly background: ResourceColor = '#F8F1E5'
  static readonly surface: ResourceColor = '#FFFBF0'
  static readonly surfaceVariant: ResourceColor = '#E9DFC7'
  static readonly outline: ResourceColor = '#D2C6AA'
  static readonly success: ResourceColor = '#2B9348'
  static readonly error: ResourceColor = '#D62828'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSurface: ResourceColor = '#1B1F22'
}

@Entry
@Component
struct StockCalendarPage {
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ]
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ]

  @State selectedDay: number = 1
  @State currentSector: string = 'All'

  @Builder
  DayButton(day: DayTab) {
    Text(day.label)
      .fontSize(day.id === this.selectedDay ? 16 : 13)
      .fontWeight(day.id === this.selectedDay ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(day.id === this.selectedDay ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(36)
      .borderRadius(6)
      .backgroundColor(day.id === this.selectedDay ? AppColors.primary : AppColors.surfaceVariant)
      .onClick(() => {
        this.selectedDay = day.id
      })
  }

  @Builder
  SectorChip(label: string) {
    Text(label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(label === this.currentSector ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .height(32)
      .padding({ left: 18, right: 18 })
      .borderRadius(6)
      .border({ width: 1, color: AppColors.outline })
      .backgroundColor(label === this.currentSector ? AppColors.secondary : AppColors.surface)
      .onClick(() => {
        this.currentSector = label
      })
  }

  @Builder
  DirectionDot(item: StockRow) {
    Circle()
      .width(8)
      .height(8)
      .fill(item.positive ? AppColors.success : AppColors.error)
  }

  @Builder
  StockItem(item: StockRow) {
    Row() {
      Row() {
        Blank()
          .width(28)
          .height(28)
          .borderRadius(6)
          .backgroundColor(AppColors.surfaceVariant)

        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .lineHeight(20)

          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(14)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)
      .constraintSize({ minWidth: 0 })

      Row() {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(20)
            .textAlign(TextAlign.End)

          Row() {
            this.DirectionDot(item)

            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? AppColors.success : AppColors.error)
              .lineHeight(14)
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.End)
          .margin({ top: 1 })
        }
        .alignItems(HorizontalAlign.End)
        .width(76)

        Button() {
          Text('Deta\nil')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .lineHeight(14)
            .textAlign(TextAlign.Center)
        }
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
          .width(76)
          .height(36)
          .padding(0)
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(72)
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 3, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(32)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Column() {
        Column() {
          Row({ space: 8 }) {
            ForEach(this.days, (day: DayTab) => {
              Row() {
                this.DayButton(day)
              }
              .layoutWeight(1)
            }, (day: DayTab) => day.id.toString())
          }
          .width('100%')
          .height(36)

          Row({ space: 8 }) {
            ForEach(this.sectors, (sector: string) => {
              this.SectorChip(sector)
            }, (sector: string) => sector)
          }
          .width('100%')
          .height(32)
          .margin({ top: 8 })
        }
        .width('100%')
        .padding(12)
        .borderRadius(14)
        .border({ width: 1, color: AppColors.outline })
        .backgroundColor(AppColors.surface)
        .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })

        List({ space: 8 }) {
          ForEach(this.items, (item: StockRow) => {
            ListItem() {
              this.StockItem(item)
            }
          }, (item: StockRow) => item.code)
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 12 })
        .padding({ bottom: 40 })
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12 })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
