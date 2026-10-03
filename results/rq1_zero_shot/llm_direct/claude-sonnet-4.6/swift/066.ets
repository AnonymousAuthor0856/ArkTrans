import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens (Design System)

class AppColors {
  static readonly primary: ResourceColor = '#21_4E_34' // rgb(33,78,52)
  static readonly secondary: ResourceColor = '#2D_6A_4F' // rgb(45,106,79)
  static readonly tertiary: ResourceColor = '#6C_75_7D' // rgb(108,117,125)
  static readonly background: ResourceColor = '#F8_F1_E5' // rgb(248,241,229)
  static readonly surface: ResourceColor = '#FF_FB_F0' // rgb(255,251,240)
  static readonly surfaceVariant: ResourceColor = '#E9_DF_C7' // rgb(233,223,199)
  static readonly outline: ResourceColor = '#D2_C6_AA' // rgb(210,198,170)
  static readonly success: ResourceColor = '#2B_93_48' // rgb(43,147,72)
  static readonly warning: ResourceColor = '#F4_A2_61' // rgb(244,162,97)
  static readonly error: ResourceColor = '#D6_28_28' // rgb(214,40,40)
  static readonly onPrimary: ResourceColor = '#FF_FF_FF'
  static readonly onSecondary: ResourceColor = '#FF_FF_FF'
  static readonly onTertiary: ResourceColor = '#1B_1F_22' // rgb(27,31,34)
  static readonly onBackground: ResourceColor = '#1B_1F_22'
  static readonly onSurface: ResourceColor = '#1B_1F_22'
}

class AppTypographyTokens {
  static readonly displaySize: number = 26
  static readonly displayWeight: FontWeight = FontWeight.Medium
  static readonly headlineSize: number = 20
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 16
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 13
  static readonly bodyWeight: FontWeight = FontWeight.Normal
  static readonly labelSize: number = 11
  static readonly labelWeight: FontWeight = FontWeight.Medium
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

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

interface ShadowSpec {
  radius: number
  dy: number
  opacity: number
}

class AppElevation {
  static readonly level1: ShadowSpec = { radius: 3, dy: 1, opacity: 0.10 }
  static readonly level2: ShadowSpec = { radius: 6, dy: 3, opacity: 0.14 }
  static readonly level3: ShadowSpec = { radius: 10, dy: 5, opacity: 0.16 }
  static readonly level4: ShadowSpec = { radius: 14, dy: 7, opacity: 0.18 }
  static readonly level5: ShadowSpec = { radius: 18, dy: 9, opacity: 0.20 }
}

// MARK: - Data Models

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

// MARK: - Custom Components

@Component
struct CustomFilterChip {
  @Prop selected: boolean = false
  @Prop label: string = ''
  action: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(AppTypographyTokens.labelSize)
      .fontWeight(AppTypographyTokens.labelWeight)
      .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.selected ? AppColors.secondary : AppColors.surface)
      .borderRadius(AppRadius.small)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.action()
      })
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]
  @State private selectedDayId: number = 1

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  @State private currentSector: string = 'All'

  private items: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column({ space: 0 }) {
        // Top App Bar
        Row() {
          Text('Stock Calendar')
            .fontSize(AppTypographyTokens.displaySize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 40, bottom: 40 })
        .backgroundColor(AppColors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.md }) {

            // Date & Sector Filter Card
            Column({ space: AppSpacing.md }) {
              // Day Tabs Row
              Row({ space: AppSpacing.md }) {
                ForEach(this.days, (d: DayTab) => {
                  Text(d.label)
                    .fontSize(d.id === this.selectedDayId
                      ? AppTypographyTokens.titleSize
                      : AppTypographyTokens.bodySize)
                    .fontWeight(d.id === this.selectedDayId
                      ? AppTypographyTokens.titleWeight
                      : AppTypographyTokens.bodyWeight)
                    .fontColor(d.id === this.selectedDayId
                      ? AppColors.onPrimary
                      : AppColors.onSurface)
                    .textAlign(TextAlign.Center)
                    .height(36)
                    .layoutWeight(1)
                    .backgroundColor(d.id === this.selectedDayId
                      ? AppColors.primary
                      : AppColors.surfaceVariant)
                    .borderRadius(AppRadius.small)
                    .onClick(() => {
                      this.selectedDayId = d.id
                    })
                }, (d: DayTab) => d.id.toString())
              }
              .width('100%')

              // Sector Filter Chips Row
              Row({ space: AppSpacing.sm }) {
                ForEach(this.sectors, (s: string) => {
                  CustomFilterChip({
                    selected: this.currentSector === s,
                    label: s,
                    action: () => {
                      this.currentSector = s
                    }
                  })
                }, (s: string) => s)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
            }
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppRadius.large)
            .border({ width: 1, color: AppColors.outline })
            .shadow({
              radius: AppElevation.level2.radius,
              color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
              offsetX: 0,
              offsetY: AppElevation.level2.dy
            })
            .alignItems(HorizontalAlign.Start)

            // Stock List
            Column({ space: AppSpacing.sm }) {
              ForEach(this.items, (item: StockRow) => {
                // Stock Row Card
                Row() {
                  // Left: Icon + Name/Code
                  Row({ space: AppSpacing.md }) {
                    // Icon placeholder
                    Column() {}
                    .width(28)
                    .height(28)
                    .backgroundColor(AppColors.surfaceVariant)
                    .borderRadius(AppRadius.small)

                    // Name and Code
                    Column({ space: AppSpacing.xs }) {
                      Text(item.name)
                        .fontSize(AppTypographyTokens.titleSize)
                        .fontWeight(AppTypographyTokens.titleWeight)
                        .fontColor(AppColors.onSurface)
                      Text(item.code)
                        .fontSize(AppTypographyTokens.labelSize)
                        .fontWeight(AppTypographyTokens.labelWeight)
                        .fontColor(AppColors.onSurface)
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .alignItems(VerticalAlign.Center)

                  Blank()

                  // Right: Price/Change + Detail Button
                  Row({ space: AppSpacing.lg }) {
                    // Price and Change
                    Column() {
                      Text(item.price)
                        .fontSize(AppTypographyTokens.titleSize)
                        .fontWeight(AppTypographyTokens.titleWeight)
                        .fontColor(AppColors.onSurface)
                      Row({ space: AppSpacing.xs }) {
                        // Change indicator dot
                        Column() {}
                        .width(8)
                        .height(8)
                        .backgroundColor(item.positive ? AppColors.success : AppColors.error)
                        .borderRadius(AppRadius.small)

                        Text(item.change)
                          .fontSize(AppTypographyTokens.labelSize)
                          .fontWeight(AppTypographyTokens.labelWeight)
                          .fontColor(item.positive ? AppColors.success : AppColors.error)
                      }
                      .alignItems(VerticalAlign.Center)
                    }
                    .alignItems(HorizontalAlign.End)

                    // Detail Button
                    Text('Detail')
                      .fontSize(AppTypographyTokens.labelSize)
                      .fontWeight(AppTypographyTokens.labelWeight)
                      .fontColor(AppColors.onPrimary)
                      .textAlign(TextAlign.Center)
                      .width(76)
                      .height(36)
                      .backgroundColor(AppColors.primary)
                      .borderRadius(AppRadius.small)
                      .onClick(() => {})
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .constraintSize({ minHeight: 72 })
                .padding(AppSpacing.md)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                .backgroundColor(AppColors.surface)
                .borderRadius(AppRadius.medium)
                .border({ width: 1, color: AppColors.outline })
                .shadow({
                  radius: AppElevation.level1.radius,
                  color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
                  offsetX: 0,
                  offsetY: AppElevation.level1.dy
                })
              }, (item: StockRow) => item.code)
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
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}