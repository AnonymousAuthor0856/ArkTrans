interface ColorTokens {
  primary: string
  secondary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  error: string
  text: string
  white: string
}

const COLORS: ColorTokens = {
  primary: '#214E34',
  secondary: '#2D6A4F',
  background: '#F8F1E5',
  surface: '#FFFBF0',
  surfaceVariant: '#E9DFC7',
  outline: '#D2C6AA',
  success: '#2B9348',
  error: '#D62828',
  text: '#1B1F22',
  white: '#FFFFFF'
}

interface StockItem {
  code: string
  name: string
  price: string
  change: string
  positive: boolean
}

@Entry
@Component
struct StockCalendarApp {
  @State selectedDay: string = 'Mon'
  @State selectedSector: string = 'All'

  private readonly days: string[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
  private readonly sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  private readonly stocks: StockItem[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  build() {
    Column() {
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 40, bottom: 40 })

      Scroll() {
        Column({ space: 12 }) {
          this.filterPanel()

          Column({ space: 8 }) {
            ForEach(this.stocks, (item: StockItem) => {
              this.stockCard(item)
            }, (item: StockItem) => item.code)
          }
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 40 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  filterPanel() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        ForEach(this.days, (day: string) => {
          Button(day)
            .fontSize(day === this.selectedDay ? 20 : 18)
            .fontColor(day === this.selectedDay ? COLORS.white : COLORS.text)
            .fontWeight(day === this.selectedDay ? FontWeight.Medium : FontWeight.Regular)
            .backgroundColor(day === this.selectedDay ? COLORS.primary : COLORS.surfaceVariant)
            .borderRadius(6)
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.selectedDay = day
            })
        }, (day: string) => day)
      }
      .width('100%')

      Row({ space: 8 }) {
        ForEach(this.sectors, (sector: string) => {
          Button(sector)
            .fontSize(16)
            .fontColor(this.selectedSector === sector
              ? COLORS.white
              : COLORS.text)
            .backgroundColor(this.selectedSector === sector
              ? COLORS.secondary
              : COLORS.surface)
            .border({
              width: 1,
              color: COLORS.outline,
              radius: 6
            })
            .height(30)
            .padding({ left: 12, right: 12 })
            .onClick(() => {
              this.selectedSector = sector
            })
        }, (sector: string) => sector)
        Blank()
      }
      .width('100%')
    }
    .padding(12)
    .width('100%')
    .backgroundColor(COLORS.surface)
    .border({
      width: 1,
      color: COLORS.outline,
      radius: 14
    })
    .shadow({
      radius: 6,
      color: '#24000000',
      offsetY: 3
    })
  }

  @Builder
  stockCard(item: StockItem) {
    Row({ space: 12 }) {
      Row() {
        Blank()
      }
      .width(28)
      .height(28)
      .borderRadius(6)
      .backgroundColor(COLORS.surfaceVariant)

      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(item.code)
          .fontSize(13)
          .fontColor(COLORS.text)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 4 }) {
        Text(item.price)
          .fontSize(16)
          .fontColor(COLORS.text)
        Row({ space: 4 }) {
          Row()
            .width(8)
            .height(8)
            .borderRadius(4)
            .backgroundColor(item.positive ? COLORS.success : COLORS.error)
          Text(item.change)
            .fontSize(13)
            .fontColor(item.positive ? COLORS.success : COLORS.error)
        }
      }
      .alignItems(HorizontalAlign.End)

      Button('Detail')
        .fontSize(13)
        .fontColor(COLORS.white)
        .backgroundColor(COLORS.primary)
        .borderRadius(6)
        .width(76)
        .height(36)
    }
    .padding(12)
    .width('100%')
    .height(80)
    .backgroundColor(COLORS.surface)
    .border({
      width: 1,
      color: COLORS.outline,
      radius: 10
    })
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetY: 1
    })
  }
}
