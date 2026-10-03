// MARK: - AppTokens (Design System)

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

  export namespace Typography {
    export const displaySize: number = 26
    export const displayWeight: FontWeight = FontWeight.SemiBold
    export const headlineSize: number = 20
    export const headlineWeight: FontWeight = FontWeight.Medium
    export const titleSize: number = 16
    export const titleWeight: FontWeight = FontWeight.Medium
    export const bodySize: number = 13
    export const bodyWeight: FontWeight = FontWeight.Regular
    export const labelSize: number = 11
    export const labelWeight: FontWeight = FontWeight.Medium
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

  export interface ShadowSpec {
    radius: number
    dy: number
    color: string
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { radius: 3, dy: 1, color: '#1A000000' }
    export const level2: ShadowSpec = { radius: 6, dy: 3, color: '#24000000' }
    export const level3: ShadowSpec = { radius: 10, dy: 5, color: '#29000000' }
    export const level4: ShadowSpec = { radius: 14, dy: 7, color: '#2E000000' }
    export const level5: ShadowSpec = { radius: 18, dy: 9, color: '#33000000' }
  }
}

// MARK: - AppTheme

class AppColorScheme {
  readonly primary: string = AppTokens.Colors.primary
  readonly onPrimary: string = AppTokens.Colors.onPrimary
  readonly secondary: string = AppTokens.Colors.secondary
  readonly onSecondary: string = AppTokens.Colors.onSecondary
  readonly tertiary: string = AppTokens.Colors.tertiary
  readonly onTertiary: string = AppTokens.Colors.onTertiary
  readonly background: string = AppTokens.Colors.background
  readonly onBackground: string = AppTokens.Colors.onBackground
  readonly surface: string = AppTokens.Colors.surface
  readonly onSurface: string = AppTokens.Colors.onSurface
  readonly surfaceVariant: string = AppTokens.Colors.surfaceVariant
  readonly outline: string = AppTokens.Colors.outline
  readonly error: string = AppTokens.Colors.error
  readonly success: string = AppTokens.Colors.success
  readonly warning: string = AppTokens.Colors.warning
}

class AppTypography {
  readonly displayLargeSize: number = AppTokens.Typography.displaySize
  readonly displayLargeWeight: FontWeight = AppTokens.Typography.displayWeight
  readonly headlineMediumSize: number = AppTokens.Typography.headlineSize
  readonly headlineMediumWeight: FontWeight = AppTokens.Typography.headlineWeight
  readonly titleMediumSize: number = AppTokens.Typography.titleSize
  readonly titleMediumWeight: FontWeight = AppTokens.Typography.titleWeight
  readonly bodyMediumSize: number = AppTokens.Typography.bodySize
  readonly bodyMediumWeight: FontWeight = AppTokens.Typography.bodyWeight
  readonly labelMediumSize: number = AppTokens.Typography.labelSize
  readonly labelMediumWeight: FontWeight = AppTokens.Typography.labelWeight
}

class AppShapes {
  readonly small: number = AppTokens.Shapes.small
  readonly medium: number = AppTokens.Shapes.medium
  readonly large: number = AppTokens.Shapes.large
}

const colorScheme: AppColorScheme = new AppColorScheme()
const typography: AppTypography = new AppTypography()
const shapes: AppShapes = new AppShapes()

// MARK: - Data Models

interface DayTab {
  id: number
  label: string
}

interface StockRow {
  id: string
  code: string
  name: string
  price: string
  change: string
  positive: boolean
}

// MARK: - Custom Components

@Component
struct CustomFilterChip {
  @Prop selected: boolean = false
  @Prop label: string = ''
  onSelect: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? colorScheme.onPrimary : colorScheme.onSurface)
      .backgroundColor(this.selected ? colorScheme.secondary : colorScheme.surface)
      .borderRadius(shapes.small)
      .border({ width: 1, color: colorScheme.outline })
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .height(32)
      .onClick((): void => {
        this.onSelect()
      })
  }
}

// MARK: - Stock Item Row

@Component
struct StockItemRow {
  @Prop itemId: string = ''
  @Prop itemCode: string = ''
  @Prop itemName: string = ''
  @Prop itemPrice: string = ''
  @Prop itemChange: string = ''
  @Prop itemPositive: boolean = false

  build() {
    Stack() {
      Row() {
        Row() {
          Row()
            .width(28)
            .height(28)
            .backgroundColor(colorScheme.surfaceVariant)
            .borderRadius(shapes.small)

          Column() {
            Text(this.itemName)
              .fontSize(typography.titleMediumSize)
              .fontWeight(typography.titleMediumWeight)
              .fontColor(colorScheme.onSurface)
            Text(this.itemCode)
              .fontSize(typography.labelMediumSize)
              .fontWeight(typography.labelMediumWeight)
              .fontColor(colorScheme.onSurface)
              .margin({ top: AppTokens.Spacing.xs })
          }
          .alignItems(HorizontalAlign.Start)
        }

        Blank()

        Row() {
          Column() {
            Text(this.itemPrice)
              .fontSize(typography.titleMediumSize)
              .fontWeight(typography.titleMediumWeight)
              .fontColor(colorScheme.onSurface)
            Row() {
              Row()
                .width(8)
                .height(8)
                .backgroundColor(this.itemPositive ? colorScheme.success : colorScheme.error)
                .borderRadius(4)
              Text(this.itemChange)
                .fontSize(typography.labelMediumSize)
                .fontWeight(typography.labelMediumWeight)
                .fontColor(this.itemPositive ? colorScheme.success : colorScheme.error)
                .margin({ left: AppTokens.Spacing.xs })
            }
            .margin({ top: AppTokens.Spacing.xs })
          }
          .alignItems(HorizontalAlign.End)

          Button('Detail')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorScheme.onPrimary)
            .backgroundColor(colorScheme.primary)
            .borderRadius(shapes.small)
            .width(76)
            .height(36)
            .margin({ left: AppTokens.Spacing.lg })
        }
      }
      .padding(AppTokens.Spacing.md)
      .height(72)
      .alignItems(VerticalAlign.Center)
    }
    .backgroundColor(colorScheme.surface)
    .borderRadius(shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: AppTokens.ElevationMapping.level1.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
    .border({ width: 1, color: colorScheme.outline })
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  private items: StockRow[] = [
    { id: '1', code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { id: '2', code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { id: '3', code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { id: '4', code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { id: '5', code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { id: '6', code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Stock Calendar')
            .fontSize(typography.displayLargeSize)
            .fontWeight(typography.displayLargeWeight)
            .fontColor(colorScheme.onSurface)
        }
        .width('100%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(colorScheme.background)

        Scroll() {
          Column() {
            Stack() {
              Column() {
                Row() {
                  ForEach(this.days, (d: DayTab): void => {
                    Button(d.label)
                      .fontSize(this.selectedDayId === d.id ? typography.titleMediumSize : typography.bodyMediumSize)
                      .fontWeight(this.selectedDayId === d.id ? typography.titleMediumWeight : typography.bodyMediumWeight)
                      .fontColor(this.selectedDayId === d.id ? colorScheme.onPrimary : colorScheme.onSurface)
                      .backgroundColor(this.selectedDayId === d.id ? colorScheme.primary : colorScheme.surfaceVariant)
                      .borderRadius(shapes.small)
                      .height(36)
                      .flexGrow(1)
                      .onClick((): void => {
                        this.selectedDayId = d.id
                      })
                  }, (d: DayTab): string => d.id.toString())
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)

                Row() {
                  ForEach(this.sectors, (s: string): void => {
                    CustomFilterChip({
                      selected: this.currentSector === s,
                      label: s,
                      onSelect: (): void => {
                        this.currentSector = s
                      }
                    })
                  }, (s: string): string => s)
                  Blank()
                }
                .width('100%')
                .margin({ top: AppTokens.Spacing.md })
              }
              .padding(AppTokens.Spacing.md)
            }
            .backgroundColor(colorScheme.surface)
            .borderRadius(shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: AppTokens.ElevationMapping.level2.color,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
            .border({ width: 1, color: colorScheme.outline })

            Column() {
              ForEach(this.items, (item: StockRow): void => {
                StockItemRow({
                  itemId: item.id,
                  itemCode: item.code,
                  itemName: item.name,
                  itemPrice: item.price,
                  itemChange: item.change,
                  itemPositive: item.positive
                })
              }, (item: StockRow): string => item.id)
            }
            .width('100%')
            .margin({ top: AppTokens.Spacing.md })
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.xxxl
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorScheme.background)
  }
}
