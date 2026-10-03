import { LengthMetrics } from '@kit.ArkUI'

// ── Design Tokens ──────────────────────────────────────────────────────────────
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF214E34'
    export const secondary = '#FF2D6A4F'
    export const tertiary = '#FF6C757D'
    export const background = '#FFF8F1E5'
    export const surface = '#FFFFFBF0'
    export const surfaceVariant = '#FFE9DFC7'
    export const outline = '#FFD2C6AA'
    export const success = '#FF2B9348'
    export const warning = '#FFF4A261'
    export const error = '#FFD62828'
    export const onPrimary = '#FFFFFFFF'
    export const onSecondary = '#FFFFFFFF'
    export const onTertiary = '#FF1B1F22'
    export const onBackground = '#FF1B1F22'
    export const onSurface = '#FF1B1F22'
  }

  export namespace Spacing {
    export const xs = 4
    export const sm = 8
    export const md = 12
    export const lg = 16
    export const xl = 20
    export const xxl = 28
    export const xxxl = 40
  }

  export namespace Radius {
    export const small = 6
    export const medium = 10
    export const large = 14
  }

  export namespace FontSize {
    export const display = 26
    export const headline = 20
    export const title = 16
    export const body = 13
    export const label = 11
  }
}

// ── Data Models ────────────────────────────────────────────────────────────────
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

// ── Day Selector Row ───────────────────────────────────────────────────────────
@Component
struct DaySelectorRow {
  @Prop days: DayTab[] = []
  @Link selectedId: number

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      ForEach(this.days, (d: DayTab) => {
        Text(d.label)
          .fontSize(AppTokens.FontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedId === d.id
            ? AppTokens.Colors.onPrimary
            : AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .height(36)
          .layoutWeight(1)
          .backgroundColor(this.selectedId === d.id
            ? AppTokens.Colors.primary
            : AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)
          .onClick(() => {
            this.selectedId = d.id
          })
      }, (d: DayTab) => d.id.toString())
    }
    .width('100%')
  }
}

// ── Sector Filter Chips ────────────────────────────────────────────────────────
@Component
struct SectorChips {
  @Prop sectors: string[] = []
  @Link current: string

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      ForEach(this.sectors, (s: string) => {
        Text(s)
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.current === s
            ? AppTokens.Colors.onPrimary
            : AppTokens.Colors.onSurface)
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
          .backgroundColor(this.current === s
            ? AppTokens.Colors.secondary
            : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.current = s
          })
      }, (s: string) => s)
    }
    .width('100%')
  }
}

// ── Stock List Item ────────────────────────────────────────────────────────────
@Component
struct StockItem {
  @Prop item: StockRow = { code: '', name: '', price: '', change: '', positive: true }

  build() {
    Row() {
      // Left: icon placeholder + name/code
      Row({ space: AppTokens.Spacing.md }) {
        // Icon placeholder
        Row()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.item.name)
            .fontSize(AppTokens.FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.item.code)
            .fontSize(AppTokens.FontSize.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      // Right: price/change + detail button
      Row({ space: AppTokens.Spacing.lg }) {
        Column() {
          Text(this.item.price)
            .fontSize(AppTokens.FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.End)

          Row({ space: AppTokens.Spacing.xs }) {
            Row()
              .width(8)
              .height(8)
              .backgroundColor(this.item.positive
                ? AppTokens.Colors.success
                : AppTokens.Colors.error)
              .borderRadius(AppTokens.Radius.small)

            Text(this.item.change)
              .fontSize(AppTokens.FontSize.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.item.positive
                ? AppTokens.Colors.success
                : AppTokens.Colors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Text('Detail')
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .textAlign(TextAlign.Center)
          .width(76)
          .height(36)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.small)
          .onClick(() => {})
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: 3 })
  }
}

// ── Root Screen ────────────────────────────────────────────────────────────────
@Component
struct RootScreen {
  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]
  @State selectedDay: number = 1
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  @State currentSector: string = 'All'
  private stockItems: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  build() {
    Column() {
      // ── Top App Bar ──────────────────────────────────────────────────────────
      Row() {
        Text('Stock Calendar')
          .fontSize(AppTokens.FontSize.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // ── Body ─────────────────────────────────────────────────────────────────
      Column({ space: AppTokens.Spacing.md }) {
        // Calendar + Filter Card
        Column({ space: AppTokens.Spacing.sm }) {
          DaySelectorRow({ days: this.days, selectedId: $selectedDay })
          SectorChips({ sectors: this.sectors, current: $currentSector })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.large)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 6, color: '#23000000', offsetX: 0, offsetY: 3 })

        // Stock List
        List({ space: AppTokens.Spacing.sm }) {
          ForEach(this.stockItems, (itx: StockRow) => {
            ListItem() {
              StockItem({ item: itx })
            }
          }, (itx: StockRow) => itx.code)

          // Bottom padding item
          ListItem() {
            Row().height(AppTokens.Spacing.xxxl)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: 0
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ── Entry Point ────────────────────────────────────────────────────────────────
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}