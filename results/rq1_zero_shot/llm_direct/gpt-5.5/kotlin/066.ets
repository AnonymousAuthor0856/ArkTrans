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

class AppTypography {
  static readonly displaySize: number = 26
  static readonly displayLineHeight: number = 32
  static readonly headlineSize: number = 20
  static readonly headlineLineHeight: number = 26
  static readonly titleSize: number = 16
  static readonly titleLineHeight: number = 20
  static readonly bodySize: number = 13
  static readonly bodyLineHeight: number = 18
  static readonly labelSize: number = 11
  static readonly labelLineHeight: number = 14
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
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

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 3, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 5, 0.16)
  static readonly level4: ShadowSpec = new ShadowSpec(10, 14, 7, 0.18)
  static readonly level5: ShadowSpec = new ShadowSpec(14, 18, 9, 0.20)
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
struct DayTabItem {
  day: DayTab = new DayTab(0, '')
  selectedId: number = 1

  build() {
    Box() {
      Text(this.day.label)
        .fontSize(this.day.id === this.selectedId ? AppTypography.titleSize : AppTypography.bodySize)
        .fontWeight(this.day.id === this.selectedId ? FontWeight.Medium : FontWeight.Regular)
        .lineHeight(this.day.id === this.selectedId ? AppTypography.titleLineHeight : AppTypography.bodyLineHeight)
        .fontColor(this.day.id === this.selectedId ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(36)
    .layoutWeight(1)
    .borderRadius(AppShapes.small)
    .backgroundColor(this.day.id === this.selectedId ? AppColors.primary : AppColors.surfaceVariant)
    .alignContent(Alignment.Center)
  }
}

@Component
struct SectorChip {
  label: string = ''
  active: boolean = false
  onTap: () => void = () => {}

  build() {
    Row() {
      Text(this.label)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .lineHeight(AppTypography.labelLineHeight)
        .fontColor(this.active ? AppColors.onPrimary : AppColors.onSurface)
    }
    .height(32)
    .padding({ left: 12, right: 12 })
    .borderRadius(AppShapes.small)
    .border({ width: 1, color: AppColors.outline })
    .backgroundColor(this.active ? AppColors.secondary : AppColors.surface)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .onClick(this.onTap)
  }
}

@Component
struct StockListItem {
  item: StockRow = new StockRow('', '', '', '', true)

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Box()
          .width(28)
          .height(28)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.surfaceVariant)

        Column({ space: AppSpacing.xs }) {
          Text(this.item.name)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppTypography.titleLineHeight)
            .fontColor(AppColors.onSurface)

          Text(this.item.code)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppTypography.labelLineHeight)
            .fontColor(AppColors.onSurface)
        }
      }
      .alignItems(VerticalAlign.Center)

      Row({ space: AppSpacing.lg }) {
        Column() {
          Text(this.item.price)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppTypography.titleLineHeight)
            .fontColor(AppColors.onSurface)

          Row({ space: AppSpacing.xs }) {
            Box()
              .width(8)
              .height(8)
              .borderRadius(AppShapes.small)
              .backgroundColor(this.item.positive ? AppColors.success : AppColors.error)

            Text(this.item.change)
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(AppTypography.labelLineHeight)
              .fontColor(this.item.positive ? AppColors.success : AppColors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .width(76)
          .height(36)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.md)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevation.level1.radius,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State selected: number = 1
  @State current: string = 'All'

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

  build() {
    Column() {
      Row() {
        Text('Stock Calendar')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(AppTypography.displayLineHeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        Column({ space: AppSpacing.sm }) {
          Row({ space: AppSpacing.sm }) {
            ForEach(this.days, (day: DayTab) => {
              DayTabItem({
                day: day,
                selectedId: this.selected
              })
                .onClick(() => {
                  this.selected = day.id
                })
            }, (day: DayTab) => day.id.toString())
          }
          .width('100%')

          Row({ space: AppSpacing.sm }) {
            ForEach(this.sectors, (sector: string) => {
              SectorChip({
                label: sector,
                active: this.current === sector,
                onTap: () => {
                  this.current = sector
                }
              })
            }, (sector: string) => sector)
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppSpacing.md)
        .borderRadius(AppShapes.large)
        .border({ width: 1, color: AppColors.outline })
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevation.level2.radius,
          color: 'rgba(0, 0, 0, 0.14)',
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })

        List({ space: AppSpacing.sm }) {
          ForEach(this.items, (stock: StockRow) => {
            ListItem() {
              StockListItem({ item: stock })
            }
          }, (stock: StockRow) => stock.code)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: AppSpacing.xxxl })
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}