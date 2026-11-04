class AppColors {
  static primary: string = '#214E34'
  static secondary: string = '#2D6A4F'
  static tertiary: string = '#6C757D'
  static background: string = '#F8F1E5'
  static surface: string = '#FFFBF0'
  static surfaceVariant: string = '#E9DFC7'
  static outline: string = '#D2C6AA'
  static success: string = '#2B9348'
  static warning: string = '#F4A261'
  static error: string = '#D62828'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#1B1F22'
  static onBackground: string = '#1B1F22'
  static onSurface: string = '#1B1F22'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 20
  static xxl: number = 28
  static xxxl: number = 40
}

class AppShape {
  static small: number = 6
  static medium: number = 10
  static large: number = 14
}

class DayTab {
  id: number
  label: string

  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

class StockRowData {
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

@Entry
@Component
struct Index {
  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ]
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  private items: StockRowData[] = [
    new StockRowData('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRowData('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRowData('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRowData('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRowData('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRowData('688981', 'SMIC', '56.4', '-0.48%', false)
  ]

  @Builder
  DayButton(day: DayTab) {
    Text(day.label)
      .fontSize(this.selectedDayId === day.id ? 16 : 13)
      .fontWeight(this.selectedDayId === day.id ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedDayId === day.id ? AppColors.onPrimary : AppColors.onSurface)
      .height(36)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.selectedDayId === day.id ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppShape.small)
      .onClick(() => {
        this.selectedDayId = day.id
      })
  }

  @Builder
  SectorChip(sector: string) {
    Text(sector)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentSector === sector ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.currentSector === sector ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
      .onClick(() => {
        this.currentSector = sector
      })
  }

  @Builder
  FilterCard() {
    Column({ space: AppSpacing.md }) {
      Row({ space: AppSpacing.md }) {
        ForEach(this.days, (day: DayTab) => {
          this.DayButton(day)
        })
      }
      .width('100%')

      Row({ space: AppSpacing.sm }) {
        ForEach(this.sectors, (sector: string) => {
          this.SectorChip(sector)
        })
        Blank()
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
    .shadow({ radius: 6, color: '#24000000', offsetY: 3 })
  }

  @Builder
  StockRow(item: StockRowData) {
    Row() {
      Row({ space: AppSpacing.md }) {
        Rect()
          .width(28)
          .height(28)
          .fill(AppColors.surfaceVariant)
          .radius(AppShape.small)

        Column({ space: AppSpacing.xs }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()
        .layoutWeight(1)

      Row({ space: AppSpacing.lg }) {
        Column() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row({ space: AppSpacing.xs }) {
            Rect()
              .width(8)
              .height(8)
              .fill(item.positive ? AppColors.success : AppColors.error)
              .radius(AppShape.small)
            Text(item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(item.positive ? AppColors.success : AppColors.error)
          }
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width(76)
          .height(36)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShape.small)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(72)
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.medium })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Stock Calendar')
            .fontSize(26)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({ top: 40, bottom: 40 })
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            this.FilterCard()

            Column({ space: AppSpacing.sm }) {
              ForEach(this.items, (item: StockRowData) => {
                this.StockRow(item)
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
