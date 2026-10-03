@Entry
@Component
struct StockCalendarApp {
  @State selectedDay: number = 1
  @State currentSector: string = 'All'
  @State stockItems: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  // AppTokens Colors
  private primaryColor: string = '#214E34'
  private secondaryColor: string = '#2D6A4F'
  private tertiaryColor: string = '#6C757D'
  private backgroundColor: string = '#F8F1E5'
  private surfaceColor: string = '#FFFBF0'
  private surfaceVariantColor: string = '#E9DFC7'
  private outlineColor: string = '#D2C6AA'
  private successColor: string = '#2B9348'
  private warningColor: string = '#F4A261'
  private errorColor: string = '#D62828'
  private onPrimaryColor: string = '#FFFFFF'
  private onSecondaryColor: string = '#FFFFFF'
  private onTertiaryColor: string = '#1B1F22'
  private onBackgroundColor: string = '#1B1F22'
  private onSurfaceColor: string = '#1B1F22'

  @Builder
  TopBar() {
    Row() {
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor(this.surfaceColor)
  }

  @Builder
  DayTabItem(day: DayTab) {
    Column() {
      Text(day.label)
        .fontSize(day.id === this.selectedDay ? 16 : 13)
        .fontWeight(day.id === this.selectedDay ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(day.id === this.selectedDay ? this.onPrimaryColor : this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(36)
        .backgroundColor(day.id === this.selectedDay ? this.primaryColor : this.surfaceVariantColor)
        .borderRadius(6)
        .justifyContent(FlexAlign.Center)
    }
    .layoutWeight(1)
    .onClick(() => {
      this.selectedDay = day.id
    })
  }

  @Builder
  SectorChip(sector: string) {
    Text(sector)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(sector === this.currentSector ? this.onPrimaryColor : this.onSurfaceColor)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor(sector === this.currentSector ? this.secondaryColor : this.surfaceColor)
      .borderRadius(6)
      .border({ width: 1, color: this.outlineColor })
      .onClick(() => {
        this.currentSector = sector
      })
  }

  @Builder
  StockRowItem(item: StockRow) {
    Row() {
      Row({ space: 12 }) {
        // Icon placeholder
        Row()
          .width(28)
          .height(28)
          .backgroundColor(this.surfaceVariantColor)
          .borderRadius(6)

        Column({ space: 4 }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
        }
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .layoutWeight(1)

      Row({ space: 16 }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .textAlign(TextAlign.End)
          Row({ space: 4 }) {
            Row()
              .width(8)
              .height(8)
              .backgroundColor(item.positive ? this.successColor : this.errorColor)
              .borderRadius(6)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? this.successColor : this.errorColor)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimaryColor)
          .backgroundColor(this.primaryColor)
          .borderRadius(6)
          .height(36)
          .width(76)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.surfaceColor)
    .borderRadius(10)
    .border({ width: 1, color: this.outlineColor })
    .constraintSize({ minHeight: 72 })
  }

  build() {
    Column() {
      // Top Bar
      this.TopBar()

      // Main content
      Column({ space: 12 }) {
        // Calendar Card
        Column({ space: 8 }) {
          // Day tabs
          Row({ space: 8 }) {
            ForEach(this.days, (day: DayTab) => {
              this.DayTabItem(day)
            })
          }
          .width('100%')

          // Sector chips
          Row({ space: 8 }) {
            ForEach(this.sectors, (sector: string) => {
              this.SectorChip(sector)
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding(12)
        .backgroundColor(this.surfaceColor)
        .borderRadius(14)
        .border({ width: 1, color: this.outlineColor })

        // Stock list
        List({ space: 8 }) {
          ForEach(this.stockItems, (item: StockRow) => {
            ListItem() {
              this.StockRowItem(item)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

interface DayTab {
  id: number
  label: string
}

interface StockRow {
  code: string
  name: string
  price: string
  change: string
  positive: boolean
}