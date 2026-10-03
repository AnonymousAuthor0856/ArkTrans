const NAME: string = '111StockListen'
const UI_TYPE: string = 'Calendar'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#214E34'
  static readonly secondary: string = '#2D6A4F'
  static readonly tertiary: string = '#6C757D'
  static readonly background: string = '#F8F1E5'
  static readonly surface: string = '#FFFBF0'
  static readonly surfaceVariant: string = '#E9DFC7'
  static readonly outline: string = '#D2C6AA'
  static readonly success: string = '#2B9348'
  static readonly warning: string = '#F4A261'
  static readonly error: string = '#D62828'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#1B1F22'
  static readonly onBackground: string = '#1B1F22'
  static readonly onSurface: string = '#1B1F22'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 20
  static readonly xxl: number = 28
  static readonly xxxl: number = 40
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
struct DayPill {
  @Prop label: string
  @Prop active: boolean

  build() {
    Text(this.label)
      .width('100%')
      .height(36)
      .textAlign(TextAlign.Center)
      .fontSize(this.active ? 16 : 13)
      .fontWeight(this.active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.active ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.active ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(6)
  }
}

@Component
struct StockItem {
  @Prop code: string
  @Prop name: string
  @Prop price: string
  @Prop change: string
  @Prop positive: boolean

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Stack()
          .width(28)
          .height(28)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)

        Column({ space: AppSpacing.xs }) {
          Text(this.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(20)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .lineHeight(14)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Row({ space: AppSpacing.lg }) {
        Column({ space: 2 }) {
          Text(this.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(20)
            .fontColor(AppColors.onSurface)

          Row({ space: AppSpacing.xs }) {
            Circle()
              .width(8)
              .height(8)
              .fill(this.positive ? AppColors.success : AppColors.error)

            Text(this.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .lineHeight(14)
              .fontColor(this.positive ? AppColors.success : AppColors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail', { type: ButtonType.Normal, stateEffect: true })
          .width(76)
          .height(36)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

@Entry
@Component
struct Index {
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

  @State selected: number = 1
  @State current: string = 'All'

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .lineHeight(32)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Column({ space: AppSpacing.md }) {
        Column({ space: AppSpacing.sm }) {
          Row({ space: AppSpacing.sm }) {
            ForEach(this.days, (day: DayTab) => {
              DayPill({
                label: day.label,
                active: day.id === this.selected
              })
                .layoutWeight(1)
                .onClick(() => {
                  this.selected = day.id
                })
            }, (day: DayTab) => day.id.toString())
          }
          .width('100%')

          Row({ space: AppSpacing.sm }) {
            ForEach(this.sectors, (sector: string) => {
              Text(sector)
                .height(34)
                .constraintSize({ minWidth: 80 })
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
                .textAlign(TextAlign.Center)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.current === sector ? AppColors.onPrimary : AppColors.onSurface)
                .backgroundColor(this.current === sector ? AppColors.secondary : AppColors.surface)
                .borderRadius(6)
                .border({ width: 1, color: AppColors.outline })
                .onClick(() => {
                  this.current = sector
                })
            }, (sector: string) => sector)
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(14)
        .border({ width: 1, color: AppColors.outline })
        .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 })

        List({ space: AppSpacing.sm }) {
          ForEach(this.items, (item: StockRow) => {
            ListItem() {
              StockItem({
                code: item.code,
                name: item.name,
                price: item.price,
                change: item.change,
                positive: item.positive
              })
            }
          }, (item: StockRow) => item.code)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ bottom: AppSpacing.xxxl })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}