import { router } from '@kit.ArkUI'

// ============ Design Tokens ============
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0EA5E9'
    export const secondary: string = '#22C55E'
    export const tertiary: string = '#F59E0B'
    export const background: string = '#F7FAFC'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#EFF3F7'
    export const outline: string = '#D4D9E1'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#0F172A'
    export const onTertiary: string = '#111827'
    export const onBackground: string = '#0B1220'
    export const onSurface: string = '#0B1220'
  }

  export namespace Spacing {
    export const xs: number = 2
    export const sm: number = 4
    export const md: number = 6
    export const lg: number = 8
    export const xl: number = 12
    export const xxl: number = 16
    export const xxxl: number = 24
  }
}

// ============ Data Models ============
interface MetricCardUi {
  id: number
  title: string
  value: string
  delta: string
  color: string
}

interface ChartCardUi {
  id: number
  title: string
  color: string
}

// ============ KPI Card Component ============
@Component
struct MetricCard {
  item: MetricCardUi = { id: 0, title: '', value: '', delta: '', color: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Text(this.item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Column()
          .width(16)
          .height(16)
          .backgroundColor(this.item.color)
          .borderRadius(6)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.item.value)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.xs }) {
        Column()
          .width(6)
          .height(6)
          .borderRadius(6)
          .backgroundColor(this.item.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
        Text(this.item.delta)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.item.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

// ============ Chart Card Component ============
@Component
struct ChartCard {
  item: ChartCardUi = { id: 0, title: '', color: '' }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      // Chart placeholder with bar visualization
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .aspectRatio(1.6)
          .backgroundColor(this.item.color)
          .borderRadius(8)

        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(6)
            .height(40)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(6)
          Column()
            .width(6)
            .height(30)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(6)
          Column()
            .width(6)
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(6)
          Column()
            .width(6)
            .height(22)
            .backgroundColor(AppTokens.Colors.outline)
            .borderRadius(6)
          Column()
            .width(6)
            .height(32)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(6)
          Column()
            .width(6)
            .height(42)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(6)
        }
        .alignItems(VerticalAlign.Bottom)
      }

      // Legend
      Row({ space: AppTokens.Spacing.sm }) {
        Column()
          .width(8)
          .height(8)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.primary)
        Text('Series A')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Column()
          .width(8)
          .height(8)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.secondary)
        Text('Series B')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

// ============ Root Screen ============
@Entry
@Component
struct RootScreen {
  private ranges: string[] = ['Today', '7 Days', '30 Days', '90 Days', 'YTD', 'Custom']
  @State selectedRange: string = '7 Days'
  @State prevPeriodActive: boolean = false
  @State goalActive: boolean = false
  @State darkSwitch: boolean = false
  @State notifCount: number = 2

  private kpis: MetricCardUi[] = [
    { id: 1, title: 'Revenue', value: '$24,560', delta: '+8.2%', color: AppTokens.Colors.secondary },
    { id: 2, title: 'Orders', value: '1,284', delta: '+3.1%', color: AppTokens.Colors.primary },
    { id: 3, title: 'Refunds', value: '42', delta: '-1.4%', color: AppTokens.Colors.error },
    { id: 4, title: 'Active Users', value: '8,921', delta: '+5.6%', color: AppTokens.Colors.tertiary }
  ]

  private charts: ChartCardUi[] = [
    { id: 1, title: 'Sales Trend', color: '#E0F2FE' },
    { id: 2, title: 'Conversion Funnel', color: '#EFF6FF' },
    { id: 3, title: 'Geo Distribution', color: '#ECFDF5' },
    { id: 4, title: 'Device Breakdown', color: '#FFFBEB' }
  ]

  @Builder
  TopBar() {
    Row({ space: AppTokens.Spacing.sm }) {
      Column()
        .width(20)
        .height(20)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(6)
      Text('Analytics')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: { bottom: 1 }, color: AppTokens.Colors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text('Notifications')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(`${this.notifCount} pending`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Mark All Read')
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .onClick(() => {
          this.notifCount = 0
        })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: '#28000000', offsetY: -1 })
  }

  @Builder
  RangeChips() {
    Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(AppTokens.Spacing.sm), cross: LengthMetrics.vp(AppTokens.Spacing.xs) } }) {
      ForEach(this.ranges, (r: string) => {
        Text(r)
          .fontSize(this.selectedRange === r ? 14 : 12)
          .fontWeight(this.selectedRange === r ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selectedRange === r ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor(this.selectedRange === r ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.selectedRange = r
          })
      })
    }
    .width('100%')
  }

  @Builder
  CompareRow() {
    Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center, space: { main: LengthMetrics.vp(AppTokens.Spacing.sm), cross: LengthMetrics.vp(AppTokens.Spacing.xs) } }) {
      Text('Compare')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text('Prev Period')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.prevPeriodActive ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .backgroundColor(this.prevPeriodActive ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
        .borderRadius(6)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {
          this.prevPeriodActive = !this.prevPeriodActive
        })

      Text('Goal')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.goalActive ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .backgroundColor(this.goalActive ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
        .borderRadius(6)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {
          this.goalActive = !this.goalActive
        })

      Row({ space: AppTokens.Spacing.xs }) {
        Text('Dark')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
          .selectedColor(AppTokens.Colors.primary)
          .onChange((isOn: boolean) => {
            this.darkSwitch = isOn
          })
          .width(40)
          .height(22)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  @Builder
  GridContent() {
    Grid() {
      ForEach(this.kpis, (m: MetricCardUi) => {
        GridItem() {
          MetricCard({ item: m })
        }
      })
      ForEach(this.charts, (c: ChartCardUi) => {
        GridItem() {
          ChartCard({ item: c })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg)
    .width('100%')
    .layoutWeight(1)
    .padding({ bottom: AppTokens.Spacing.xxxl })
  }

  build() {
    Column() {
      // Top Bar
      this.TopBar()

      // Scrollable content
      Scroll() {
        Column({ space: 0 }) {
          // Range chips
          Column() {
            this.RangeChips()
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: 0 })

          // Spacer
          Column().height(AppTokens.Spacing.md)

          // Compare row
          Column() {
            this.CompareRow()
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Spacer
          Column().height(AppTokens.Spacing.lg)

          // Grid
          Column() {
            Grid() {
              ForEach(this.kpis, (m: MetricCardUi) => {
                GridItem() {
                  MetricCard({ item: m })
                }
              })
              ForEach(this.charts, (c: ChartCardUi) => {
                GridItem() {
                  ChartCard({ item: c })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppTokens.Spacing.lg)
            .rowsGap(AppTokens.Spacing.lg)
            .width('100%')
            .padding({ bottom: AppTokens.Spacing.xxxl })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}