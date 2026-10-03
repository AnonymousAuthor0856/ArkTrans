import { LengthMetrics } from '@kit.ArkUI'

// Design Tokens
namespace DesignTokens {
  export namespace Colors {
    export const primary = '#FF8B6B4C'
    export const secondary = '#FFC27D38'
    export const tertiary = '#FFF2C57C'
    export const background = '#FF100C08'
    export const surface = '#FF19110D'
    export const surfaceVariant = '#FF2A1C14'
    export const outline = '#FF4F3A2C'
    export const success = '#FF6ECE89'
    export const warning = '#FFE19F41'
    export const error = '#FFD96666'
    export const onPrimary = '#FF100C08'
    export const onSecondary = '#FF100C08'
    export const onTertiary = '#FF120E04'
    export const onBackground = '#FFF7EAD8'
    export const onSurface = '#FFFBEFE0'
  }

  export namespace Spacing {
    export const xxs = 6
    export const xs = 10
    export const sm = 14
    export const md = 18
    export const lg = 26
    export const xl = 36
    export const xxl = 48
    export const xxxl = 62
  }

  export namespace Radius {
    export const small = 10
    export const medium = 18
    export const large = 26
  }
}

interface CargoCard {
  title: string
  id: string
  fill: string
}

interface ManifestEntry {
  origin: string
  destination: string
  status: string
}

interface HubFilter {
  label: string
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    { title: 'Copper stack', id: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', id: 'SH-022', fill: '64%' },
    { title: 'Agro crates', id: 'SH-031', fill: '92%' },
    { title: 'Glass kits', id: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', id: 'SH-057', fill: '88%' },
    { title: 'Raw silica', id: 'SH-063', fill: '43%' },
  ]

  private manifest: ManifestEntry[] = [
    { origin: 'Santiago', destination: 'Lima', status: 'Boarding' },
    { origin: 'Mecca', destination: 'Algiers', status: 'At dock' },
    { origin: 'Reykjavík', destination: 'Oslo', status: 'Delayed' },
    { origin: 'Perth', destination: 'Jakarta', status: 'In flight' },
  ]

  private filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' },
  ]

  getStatusColor(status: string): string {
    if (status === 'Delayed') return DesignTokens.Colors.warning
    if (status === 'In flight') return DesignTokens.Colors.success
    return '#CCF7EAD8'
  }

  @Builder
  TopBar() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Stack() {}
        .width(26)
        .height(26)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(13)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)

      Column() {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .letterSpacing(0.2)

        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3FBEFE0')
          .letterSpacing(0.3)
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      Button({ type: ButtonType.Circle }) {
        Stack() {}
        .width(26)
        .height(26)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(13)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ horizontal: DesignTokens.Spacing.md, vertical: DesignTokens.Spacing.sm })
    .backgroundColor(DesignTokens.Colors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .letterSpacing(0.3)

        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .letterSpacing(0.2)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Dispatch')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onPrimary)
        .backgroundColor(DesignTokens.Colors.primary)
        .borderRadius(DesignTokens.Radius.medium)
        .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
    }
    .width('100%')
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    .backgroundColor(DesignTokens.Colors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 12, color: '#42000000', offsetY: 6 })
  }

  @Builder
  FilterRow() {
    Row({ space: DesignTokens.Spacing.xs }) {
      ForEach(this.filters, (filter: HubFilter) => {
        Button(filter.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
          .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.Radius.small)
          .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          .onClick(() => {
            this.activeFilter = filter.label
          })
      })
    }
    .width('100%')
  }

  @Builder
  CargoGrid() {
    Grid() {
      ForEach(this.cards, (card: CargoCard) => {
        GridItem() {
          Column({ space: DesignTokens.Spacing.sm }) {
            Stack({ alignContent: Alignment.Center }) {
              Stack() {}
              .width('100%')
              .height(90)
              .backgroundColor(DesignTokens.Colors.surface)
              .borderRadius(DesignTokens.Radius.small)

              Stack() {}
              .width(60)
              .height(60)
              .backgroundColor('#66F2C57C')
              .borderRadius(30)
            }
            .width('100%')
            .height(90)

            Column({ space: DesignTokens.Spacing.xxs }) {
              Text(card.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface)
                .letterSpacing(0.2)

              Text(card.id)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#B3FBEFE0')
                .letterSpacing(0.2)

              Text(`Fill ${card.fill}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.success)
                .letterSpacing(0.3)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .padding(DesignTokens.Spacing.md)
          .backgroundColor('#EB2A1C14')
          .borderRadius(DesignTokens.Radius.medium)
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(DesignTokens.Spacing.sm)
    .rowsGap(DesignTokens.Spacing.sm)
    .width('100%')
    .height(320)
  }

  @Builder
  ManifestList() {
    ForEach(this.manifest, (entry: ManifestEntry) => {
      Row() {
        Column({ space: DesignTokens.Spacing.xxs }) {
          Text(`${entry.origin} → ${entry.destination}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .letterSpacing(0.2)

          Text(entry.status)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.getStatusColor(entry.status))
            .letterSpacing(0.2)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(DesignTokens.Radius.small)
          .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
      }
      .width('100%')
      .padding(DesignTokens.Spacing.md)
      .backgroundColor('#D92A1C14')
      .borderRadius(DesignTokens.Radius.medium)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: DesignTokens.Spacing.lg }) {
          this.FilterRow()

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.Colors.onSurface)
            .letterSpacing(0.1)
            .width('100%')

          this.CargoGrid()

          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.Colors.onSurface)
            .letterSpacing(0.1)
            .width('100%')

          this.ManifestList()
        }
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(DesignTokens.Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}