class AppTokens {
  static readonly Colors = {
    primary: '#FF214E34',
    secondary: '#FF2D6A4F',
    tertiary: '#FF6C757D',
    background: '#FFF8F1E5',
    surface: '#FFFFFBF0',
    surfaceVariant: '#FFE9DFC7',
    outline: '#FFD2C6AA',
    success: '#FF2B9348',
    warning: '#FFF4A261',
    error: '#FFD62828',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF1B1F22',
    onBackground: '#FF1B1F22',
    onSurface: '#FF1B1F22',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40,
  }
}

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

@Component
struct StockCard {
  @Prop code: string
  @Prop name: string
  @Prop price: string
  @Prop change: string
  @Prop positive: boolean

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Column()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.code)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)

      Row({ space: AppTokens.Spacing.lg }) {
        Column() {
          Text(this.price)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Row({ space: AppTokens.Spacing.xs }) {
            Column()
              .width(8)
              .height(8)
              .backgroundColor(this.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
              .borderRadius(AppTokens.Shapes.small)
            Text(this.change)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          }
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(76)
          .height(36)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1
  @State currentSector: string = 'All'
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri'),
  ]
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Stock Calendar')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: 12, bottom: 12 })
        .backgroundColor(AppTokens.Colors.background)
        .justifyContent(FlexAlign.Center)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            Column({ space: AppTokens.Spacing.md }) {
              Row({ space: AppTokens.Spacing.md }) {
                ForEach(this.days, (d: DayTab) => {
                  Text(d.label)
                    .fontSize(this.selectedDayId === d.id ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
                    .fontWeight(this.selectedDayId === d.id ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
                    .fontColor(this.selectedDayId === d.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .layoutWeight(1)
                    .height(36)
                    .backgroundColor(this.selectedDayId === d.id ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.small)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.selectedDayId = d.id
                    })
                })
              }
              .width('100%')

              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.sectors, (s: string) => {
                  Text(s)
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(this.currentSector === s ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                    .backgroundColor(this.currentSector === s ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.small)
                    .border({ width: 1, color: AppTokens.Colors.outline })
                    .onClick(() => {
                      this.currentSector = s
                    })
                })
              }
              .width('100%')
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: 6, color: '#24000000', offsetY: 3 })

            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                StockCard({ code: item.code, name: item.name, price: item.price, change: item.change, positive: item.positive })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}