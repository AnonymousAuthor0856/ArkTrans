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

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class ShadowSpec {
  radius: number
  dy: number
  color: string

  constructor(radius: number, dy: number, color: string) {
    this.radius = radius
    this.dy = dy
    this.color = color
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(3, 1, '#1A000000')
  static readonly level2: ShadowSpec = new ShadowSpec(6, 3, '#24000000')
  static readonly level3: ShadowSpec = new ShadowSpec(10, 5, '#29000000')
  static readonly level4: ShadowSpec = new ShadowSpec(14, 7, '#2E000000')
  static readonly level5: ShadowSpec = new ShadowSpec(18, 9, '#33000000')
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

@Builder
function EmptyBuilder() {
}

@Component
struct CustomCard {
  radius: number = AppShapes.medium
  containerColor: string = AppColors.surface
  elevation: ShadowSpec = AppElevation.level1
  borderWidth: number = 0
  borderColor: string = '#00000000'
  @BuilderParam content: () => void = EmptyBuilder

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(this.containerColor)
    .borderRadius(this.radius)
    .border({
      width: this.borderWidth,
      color: this.borderColor
    })
    .shadow({
      radius: this.elevation.radius,
      color: this.elevation.color,
      offsetX: 0,
      offsetY: this.elevation.dy
    })
  }
}

@Component
struct CustomFilterChip {
  selected: boolean = false
  label: string = ''
  action: () => void = () => {
  }

  build() {
    Text(this.label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
      .height(36)
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md
      })
      .textAlign(TextAlign.Center)
      .backgroundColor(this.selected ? AppColors.secondary : AppColors.surface)
      .borderRadius(AppShapes.small)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.action()
      })
  }
}

@Entry
@Component
struct RootScreen {
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

  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Stock Calendar')
            .fontSize(26)
            .fontWeight(600)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(192)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            CustomCard({
              radius: AppShapes.large,
              containerColor: AppColors.surface,
              elevation: AppElevation.level2,
              borderWidth: 1,
              borderColor: AppColors.outline
            }) {
              Column({ space: AppSpacing.md }) {
                Row({ space: AppSpacing.md }) {
                  ForEach(this.days, (day: DayTab) => {
                    Text(day.label)
                      .fontSize(this.selectedDayId === day.id ? 16 : 13)
                      .fontWeight(this.selectedDayId === day.id ? FontWeight.Medium : FontWeight.Normal)
                      .fontColor(this.selectedDayId === day.id ? AppColors.onPrimary : AppColors.onSurface)
                      .height(36)
                      .layoutWeight(1)
                      .textAlign(TextAlign.Center)
                      .backgroundColor(this.selectedDayId === day.id ? AppColors.primary : AppColors.surfaceVariant)
                      .borderRadius(AppShapes.small)
                      .onClick(() => {
                        this.selectedDayId = day.id
                      })
                  }, (day: DayTab) => day.id.toString())
                }
                .width('100%')

                Row({ space: AppSpacing.sm }) {
                  ForEach(this.sectors, (sector: string) => {
                    CustomFilterChip({
                      selected: this.currentSector === sector,
                      label: sector,
                      action: () => {
                        this.currentSector = sector
                      }
                    })
                  }, (sector: string) => sector)
                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
              }
              .width('100%')
              .padding(AppSpacing.md)
            }

            Column({ space: AppSpacing.sm }) {
              ForEach(this.items, (item: StockRow, index: number) => {
                CustomCard({
                  radius: AppShapes.medium,
                  containerColor: AppColors.surface,
                  elevation: AppElevation.level1,
                  borderWidth: 1,
                  borderColor: AppColors.outline
                }) {
                  Row() {
                    Row({ space: AppSpacing.md }) {
                      Stack()
                        .width(28)
                        .height(28)
                        .backgroundColor(AppColors.surfaceVariant)
                        .borderRadius(AppShapes.small)

                      Column({ space: AppSpacing.xs }) {
                        Text(item.name)
                          .fontSize(16)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(AppColors.onSurface)
                          .maxLines(2)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })

                        Text(item.code)
                          .fontSize(11)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(AppColors.onSurface)
                      }
                      .layoutWeight(1)
                      .alignItems(HorizontalAlign.Start)
                    }
                    .layoutWeight(1)
                    .alignItems(VerticalAlign.Center)

                    Row({ space: AppSpacing.lg }) {
                      Column({ space: AppSpacing.xs }) {
                        Text(item.price)
                          .fontSize(16)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(AppColors.onSurface)
                          .textAlign(TextAlign.End)
                          .width('100%')

                        Row({ space: AppSpacing.xs }) {
                          Stack()
                            .width(8)
                            .height(8)
                            .borderRadius(4)
                            .backgroundColor(item.positive ? AppColors.success : AppColors.error)

                          Text(item.change)
                            .fontSize(11)
                            .fontWeight(FontWeight.Medium)
                            .fontColor(item.positive ? AppColors.success : AppColors.error)
                        }
                        .width('100%')
                        .justifyContent(FlexAlign.End)
                        .alignItems(VerticalAlign.Center)
                      }
                      .width(80)
                      .alignItems(HorizontalAlign.End)

                      Text('Detail')
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.onPrimary)
                        .width(76)
                        .height(36)
                        .textAlign(TextAlign.Center)
                        .backgroundColor(AppColors.primary)
                        .borderRadius(AppShapes.small)
                        .onClick(() => {
                        })
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('100%')
                  .constraintSize({ minHeight: 72 })
                  .padding(AppSpacing.md)
                  .alignItems(VerticalAlign.Center)
                }
              }, (item: StockRow, index: number) => `${item.code}_${index}`)
            }
            .width('100%')
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.xxxl
          })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}