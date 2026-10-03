import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#214E34'
const COLOR_SECONDARY = '#2D6A4F'
const COLOR_TERTIARY = '#6C757D'
const COLOR_BACKGROUND = '#F8F1E5'
const COLOR_SURFACE = '#FFFBF0'
const COLOR_SURFACE_VARIANT = '#E9DFC7'
const COLOR_OUTLINE = '#D2C6AA'
const COLOR_SUCCESS = '#2B9348'
const COLOR_WARNING = '#F4A261'
const COLOR_ERROR = '#D62828'
const COLOR_ON_PRIMARY = '#FFFFFF'
const COLOR_ON_SECONDARY = '#FFFFFF'
const COLOR_ON_TERTIARY = '#1B1F22'
const COLOR_ON_BACKGROUND = '#1B1F22'
const COLOR_ON_SURFACE = '#1B1F22'

// Spacing tokens
const SPACING_XS = 4
const SPACING_SM = 8
const SPACING_MD = 12
const SPACING_LG = 16
const SPACING_XL = 20
const SPACING_XXL = 28
const SPACING_XXXL = 40

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

@Entry
@Component
struct RootScreen {
  @State selectedDay: number = 1
  @State currentSector: string = 'All'

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  private stockItems: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  @Builder
  DayTabRow() {
    Row({ space: SPACING_SM }) {
      ForEach(this.days, (d: DayTab) => {
        Text(d.label)
          .fontSize(d.id === this.selectedDay ? 16 : 13)
          .fontWeight(d.id === this.selectedDay ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(d.id === this.selectedDay ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
          .backgroundColor(d.id === this.selectedDay ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
          .borderRadius(6)
          .height(36)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.selectedDay = d.id
          })
      })
    }
    .width('100%')
  }

  @Builder
  SectorChips() {
    Row({ space: SPACING_SM }) {
      ForEach(this.sectors, (s: string) => {
        Text(s)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentSector === s ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
          .backgroundColor(this.currentSector === s ? COLOR_SECONDARY : COLOR_SURFACE)
          .borderRadius(6)
          .border({ width: 1, color: COLOR_OUTLINE })
          .padding({ left: SPACING_SM, right: SPACING_SM, top: SPACING_XS, bottom: SPACING_XS })
          .onClick(() => {
            this.currentSector = s
          })
      })
    }
    .width('100%')
  }

  @Builder
  StockCard(item: StockRow) {
    Row() {
      Row({ space: SPACING_MD }) {
        // Icon placeholder
        Column()
          .width(28)
          .height(28)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(6)

        Column({ space: SPACING_XS }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Row({ space: SPACING_LG }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Row({ space: SPACING_XS }) {
            Column()
              .width(8)
              .height(8)
              .backgroundColor(item.positive ? COLOR_SUCCESS : COLOR_ERROR)
              .borderRadius(2)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? COLOR_SUCCESS : COLOR_ERROR)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(6)
          .height(36)
          .width(76)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(SPACING_MD)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(10)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: 3 })
    .constraintSize({ minHeight: 72 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      // Main content
      Column({ space: SPACING_MD }) {
        // Calendar card
        Column({ space: SPACING_SM }) {
          this.DayTabRow()
          this.SectorChips()
        }
        .width('100%')
        .padding(SPACING_MD)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(14)
        .border({ width: 1, color: COLOR_OUTLINE })
        .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })

        // Stock list
        List({ space: SPACING_SM }) {
          ForEach(this.stockItems, (item: StockRow) => {
            ListItem() {
              this.StockCard(item)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}