// Stock Calendar - ArkTS conversion
// Kotlin Compose -> ArkTS (HarmonyOS ArkUI declarative)

@Entry
@Component
struct StockCalendarPage {
  @State selectedDay: number = 1
  @State currentSector: string = "All"

  private days: DayTab[] = [
    new DayTab(1, "Mon"),
    new DayTab(2, "Tue"),
    new DayTab(3, "Wed"),
    new DayTab(4, "Thu"),
    new DayTab(5, "Fri")
  ]
  private sectors: string[] = ["All", "Tech", "Energy", "Finance"]
  private stocks: StockRow[] = [
    new StockRow("600519", "Kweichow Moutai", "1687.3", "+1.24%", true),
    new StockRow("000001", "Ping An Bank", "12.54", "-0.62%", false),
    new StockRow("300750", "CATL", "192.8", "+0.87%", true),
    new StockRow("601318", "Ping An Ins.", "44.2", "-1.12%", false),
    new StockRow("600036", "CMBC", "36.9", "+0.15%", true),
    new StockRow("688981", "SMIC", "56.4", "-0.48%", false)
  ]

  build() {
    Column() {
      Column() {
        Text("Stock Calendar")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Column() {
          Row() {
            ForEach(this.days, (d: DayTab) => {
              Text(d.label)
                .fontSize(this.selectedDay === d.id
                  ? AppTokens.TypographyTokens.title.fontSize
                  : AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(this.selectedDay === d.id
                  ? AppTokens.TypographyTokens.title.fontWeight
                  : AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(this.selectedDay === d.id
                  ? AppTokens.Colors.onPrimary
                  : AppTokens.Colors.onSurface)
                .layoutWeight(1)
                .height(36)
                .textAlign(TextAlign.Center)
                .borderRadius(AppTokens.Shapes.small)
                .backgroundColor(this.selectedDay === d.id
                  ? AppTokens.Colors.primary
                  : AppTokens.Colors.surfaceVariant)
                .onClick(() => {
                  this.selectedDay = d.id
                })
            }, (d: DayTab) => d.id.toString())
          }
          .width('100%')

          Row() {
            ForEach(this.sectors, (s: string) => {
              Text(s)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(this.currentSector === s
                  ? AppTokens.Colors.onPrimary
                  : AppTokens.Colors.onSurface)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .borderRadius(AppTokens.Shapes.small)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .backgroundColor(this.currentSector === s
                  ? AppTokens.Colors.secondary
                  : AppTokens.Colors.surface)
                .onClick(() => {
                  this.currentSector = s
                })
            }, (s: string) => s)
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm })
          .justifyContent(FlexAlign.Start)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .border({
          width: 1,
          color: AppTokens.Colors.outline
        })
        .shadow({
          radius: 6,
          color: 'rgba(0,0,0,0.14)',
          offsetY: 3
        })

        List() {
          ForEach(this.stocks, (item: StockRow) => {
            ListItem() {
              this.StockItemCard(item)
            }
          }, (item: StockRow) => item.code)
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.md })
        .divider({ strokeWidth: 0, color: Color.Transparent })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  StockItemCard(item: StockRow) {
    Row() {
      Row() {
        Row()
          .width(28)
          .height(28)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Column() {
          Text(item.name)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(item.code)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .margin({ left: AppTokens.Spacing.md })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Row() {
        Column() {
          Text(item.price)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Row() {
            Row()
              .width(8)
              .height(8)
              .borderRadius(AppTokens.Shapes.small)
              .backgroundColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
            Text(item.change)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
              .margin({ left: AppTokens.Spacing.xs })
          }
          .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.End)

        Text("Detail")
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(76)
          .height(36)
          .textAlign(TextAlign.Center)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.lg })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .borderRadius(AppTokens.Shapes.medium)
    .backgroundColor(AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .shadow({
      radius: 3,
      color: 'rgba(0,0,0,0.10)',
      offsetY: 1
    })
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

class TextStyle {
  fontSize: number
  fontWeight: number
  lineHeight: number
  letterSpacing: number
  constructor(fontSize: number, fontWeight: number, lineHeight: number, letterSpacing: number) {
    this.fontSize = fontSize
    this.fontWeight = fontWeight
    this.lineHeight = lineHeight
    this.letterSpacing = letterSpacing
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#214E34'
    export const secondary: string = '#2D6A4F'
    export const tertiary: string = '#6C757D'
    export const background: string = '#F8F1E5'
    export const surface: string = '#FFFBF0'
    export const surfaceVariant: string = '#E9DFC7'
    export const outline: string = '#D2C6AA'
    export const success: string = '#2B9348'
    export const warning: string = '#F4A261'
    export const error: string = '#D62828'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#FFFFFF'
    export const onTertiary: string = '#1B1F22'
    export const onBackground: string = '#1B1F22'
    export const onSurface: string = '#1B1F22'
  }
  export namespace TypographyTokens {
    export const display: TextStyle = new TextStyle(26, 600, 32, 0)
    export const headline: TextStyle = new TextStyle(20, 500, 26, 0)
    export const title: TextStyle = new TextStyle(16, 500, 20, 0)
    export const body: TextStyle = new TextStyle(13, 400, 18, 0)
    export const label: TextStyle = new TextStyle(11, 500, 14, 0)
  }
  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 14
  }
  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 20
    export const xxl: number = 28
    export const xxxl: number = 40
  }
}
