interface DayItem {
  id: number
  label: string
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
  readonly colorPrimary: string = '#214E34'
  readonly colorSecondary: string = '#2D6A4F'
  readonly colorTertiary: string = '#6C757D'
  readonly colorBackground: string = '#F8F1E5'
  readonly colorSurface: string = '#FFFBF0'
  readonly colorSurfaceVariant: string = '#E9DFC7'
  readonly colorOutline: string = '#D2C6AA'
  readonly colorSuccess: string = '#2B9348'
  readonly colorWarning: string = '#F4A261'
  readonly colorError: string = '#D62828'
  readonly colorOnPrimary: string = '#FFFFFF'
  readonly colorOnSurface: string = '#1B1F22'

  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  readonly days: DayItem[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  readonly sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  readonly items: StockItem[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  @Builder
  DayButton(day: DayItem) {
    Button(day.label)
      .fontSize(day.id === this.selectedDayId ? 16 : 13)
      .fontWeight(day.id === this.selectedDayId ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(day.id === this.selectedDayId ? this.colorOnPrimary : this.colorOnSurface)
      .backgroundColor(day.id === this.selectedDayId ? this.colorPrimary : this.colorSurfaceVariant)
      .borderRadius(6)
      .height(36)
      .layoutWeight(1)
      .onClick(() => {
        this.selectedDayId = day.id
      })
  }

  @Builder
  FilterChip(sector: string) {
    Button(sector)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentSector === sector ? this.colorOnPrimary : this.colorOnSurface)
      .backgroundColor(this.currentSector === sector ? this.colorSecondary : this.colorSurface)
      .borderRadius(6)
      .border({ width: 1, color: this.colorOutline })
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .onClick(() => {
        this.currentSector = sector
      })
  }

  @Builder
  StockCard(item: StockItem) {
    Row() {
      Row() {
        Column()
          .width(28)
          .height(28)
          .borderRadius(6)
          .backgroundColor(this.colorSurfaceVariant)

        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .constraintSize({ maxWidth: 140 })
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Row() {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .textAlign(TextAlign.End)

          Row() {
            Column()
              .width(8)
              .height(8)
              .borderRadius(4)
              .backgroundColor(item.positive ? this.colorSuccess : this.colorError)
              .margin({ right: 4 })
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? this.colorSuccess : this.colorError)
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 4 })
          .justifyContent(FlexAlign.End)
        }
        .alignItems(HorizontalAlign.End)
        .margin({ right: 16 })

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnPrimary)
          .backgroundColor(this.colorPrimary)
          .borderRadius(6)
          .width(76)
          .height(36)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .constraintSize({ minHeight: 72 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.colorSurface)
    .borderRadius(10)
    .border({ width: 1, color: this.colorOutline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .margin({ bottom: 8 })
  }

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 40, bottom: 40 })
      .backgroundColor(this.colorBackground)

      Scroll() {
        Column() {
          Column() {
            Row() {
              ForEach(this.days, (day: DayItem) => {
                this.DayButton(day)
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              ForEach(this.sectors, (sector: string) => {
                this.FilterChip(sector)
              })
            }
            .width('100%')
            .margin({ top: 12 })
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.colorSurface)
          .borderRadius(14)
          .border({ width: 1, color: this.colorOutline })
          .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })
          .margin({ bottom: 12 })

          ForEach(this.items, (item: StockItem) => {
            this.StockCard(item)
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 40 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}