import { router } from '@kit.ArkUI'

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

const primaryColor: string = '#FF214E34'
const secondaryColor: string = '#FF2D6A4F'
const backgroundColor: string = '#FFF8F1E5'
const surfaceColor: string = '#FFFFFBF0'
const surfaceVariantColor: string = '#FFE9DFC7'
const outlineColor: string = '#FFD2C6AA'
const successColor: string = '#FF2B9348'
const errorColor: string = '#FFD62828'
const onPrimaryColor: string = '#FFFFFFFF'
const onSurfaceColor: string = '#FF1B1F22'

@Entry
@Component
struct Index {
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

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(surfaceColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column({ space: 12 }) {
        // Calendar Card
        Column({ space: 8 }) {
          // Day Tabs Row
          Row({ space: 8 }) {
            ForEach(this.days, (d: DayTab) => {
              Text(d.label)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedDay === d.id ? onPrimaryColor : onSurfaceColor)
                .textAlign(TextAlign.Center)
                .height(36)
                .layoutWeight(1)
                .backgroundColor(this.selectedDay === d.id ? primaryColor : surfaceVariantColor)
                .borderRadius(6)
                .onClick(() => {
                  this.selectedDay = d.id
                })
            })
          }
          .width('100%')

          // Sector Filter Row
          Row({ space: 8 }) {
            ForEach(this.sectors, (s: string) => {
              Text(s)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.currentSector === s ? onPrimaryColor : onSurfaceColor)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor(this.currentSector === s ? secondaryColor : surfaceColor)
                .borderRadius(6)
                .border({ width: 1, color: outlineColor })
                .onClick(() => {
                  this.currentSector = s
                })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding(12)
        .backgroundColor(surfaceColor)
        .borderRadius(14)
        .border({ width: 1, color: outlineColor })
        .shadow({ radius: 6, color: '#22000000', offsetX: 0, offsetY: 3 })

        // Stock List
        List({ space: 8 }) {
          ForEach(this.stockItems, (item: StockRow) => {
            ListItem() {
              Row() {
                // Left side
                Row({ space: 12 }) {
                  // Icon placeholder
                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor(surfaceVariantColor)
                    .borderRadius(6)

                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(onSurfaceColor)

                    Text(item.code)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(onSurfaceColor)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .alignItems(VerticalAlign.Center)

                // Right side
                Row({ space: 16 }) {
                  Column({ space: 4 }) {
                    Text(item.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(onSurfaceColor)
                      .textAlign(TextAlign.End)

                    Row({ space: 4 }) {
                      Column()
                        .width(8)
                        .height(8)
                        .backgroundColor(item.positive ? successColor : errorColor)
                        .borderRadius(2)

                      Text(item.change)
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(item.positive ? successColor : errorColor)
                    }
                    .alignItems(VerticalAlign.Center)
                    .justifyContent(FlexAlign.End)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(onPrimaryColor)
                    .backgroundColor(primaryColor)
                    .borderRadius(6)
                    .height(36)
                    .width(76)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(surfaceColor)
              .borderRadius(10)
              .border({ width: 1, color: outlineColor })
              .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
              .constraintSize({ minHeight: 72 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}