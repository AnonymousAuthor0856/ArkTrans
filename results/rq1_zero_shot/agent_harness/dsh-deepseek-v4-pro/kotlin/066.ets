const Colors = {
  primary: '#214E34',
  secondary: '#2D6A4F',
  tertiary: '#6C757D',
  background: '#F8F1E5',
  surface: '#FFFBF0',
  surfaceVariant: '#E9DFC7',
  outline: '#D2C6AA',
  success: '#2B9348',
  warning: '#F4A261',
  error: '#D62828',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#1B1F22',
  onBackground: '#1B1F22',
  onSurface: '#1B1F22',
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  xxl: 28,
  xxxl: 40,
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

@Entry
@Component
struct Index {
  @State selected: number = 1
  @State sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  @State current: string = 'All'
  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' },
  ]
  private items: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false },
  ]

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Column({ space: Spacing.md }) {
        Column({ space: Spacing.sm }) {
          Row({ space: Spacing.sm }) {
            ForEach(this.days, (d: DayTab) => {
              Stack({ alignContent: Alignment.Center }) {
                Text(d.label)
                  .fontSize(d.id === this.selected ? 16 : 13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(d.id === this.selected ? Colors.onPrimary : Colors.onSurface)
              }
              .layoutWeight(1)
              .height(36)
              .backgroundColor(d.id === this.selected ? Colors.primary : Colors.surfaceVariant)
              .borderRadius(6)
            }, (d: DayTab) => d.id.toString())
          }

          Scroll() {
            Row({ space: Spacing.sm }) {
              ForEach(this.sectors, (s: string) => {
                Button() {
                  Text(s)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.current === s ? Colors.onPrimary : Colors.onSurface)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.current === s ? Colors.secondary : Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: Colors.outline })
                .onClick(() => {
                  this.current = s
                })
              }, (s: string) => s)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
        }
        .width('100%')
        .padding(Spacing.md)
        .backgroundColor(Colors.surface)
        .borderRadius(14)
        .border({ width: 1, color: Colors.outline })

        Scroll() {
          Column({ space: Spacing.sm }) {
            ForEach(this.items, (itx: StockRow) => {
              Row() {
                Row({ space: Spacing.md }) {
                  Blank()
                    .width(28)
                    .height(28)
                    .backgroundColor(Colors.surfaceVariant)
                    .borderRadius(6)
                  Column({ space: Spacing.xs }) {
                    Text(itx.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                    Text(itx.code)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .alignItems(VerticalAlign.Center)

                Row({ space: Spacing.lg }) {
                  Column({ space: Spacing.xs }) {
                    Text(itx.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                    Row({ space: Spacing.xs }) {
                      Blank()
                        .width(8)
                        .height(8)
                        .backgroundColor(itx.positive ? Colors.success : Colors.error)
                        .borderRadius(6)
                      Text(itx.change)
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(itx.positive ? Colors.success : Colors.error)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .type(ButtonType.Normal)
                    .fontSize(11)
                    .fontColor(Colors.onPrimary)
                    .backgroundColor(Colors.primary)
                    .borderRadius(6)
                    .height(36)
                    .width(76)
                    .onClick(() => {})
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(Spacing.md)
              .constraintSize({ minHeight: 72 })
              .backgroundColor(Colors.surface)
              .borderRadius(10)
              .border({ width: 1, color: Colors.outline })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (itx: StockRow) => itx.code)
          }
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
