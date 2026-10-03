@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    { title: 'Copper stack', id: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', id: 'SH-022', fill: '64%' },
    { title: 'Agro crates', id: 'SH-031', fill: '92%' },
    { title: 'Glass kits', id: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', id: 'SH-057', fill: '88%' },
    { title: 'Raw silica', id: 'SH-063', fill: '43%' }
  ]

  private manifest: ManifestEntry[] = [
    { origin: 'Santiago', destination: 'Lima', status: 'Boarding' },
    { origin: 'Mecca', destination: 'Algiers', status: 'At dock' },
    { origin: 'Reykjavík', destination: 'Oslo', status: 'Delayed' },
    { origin: 'Perth', destination: 'Jakarta', status: 'In flight' }
  ]

  private filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' }
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          // Filter row
          Row() {
            ForEach(this.filters, (filter: HubFilter) => {
              Button(filter.label)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.activeFilter === filter.label ? Tokens.onSecondary : Tokens.onSurface)
                .backgroundColor(this.activeFilter === filter.label ? Tokens.secondary : Tokens.surfaceVariant)
                .borderRadius(Tokens.shapeSmall)
                .padding({ left: Tokens.spSm, right: Tokens.spSm, top: Tokens.spXxs, bottom: Tokens.spXxs })
                .margin({ right: Tokens.spXs })
                .onClick(() => {
                  this.activeFilter = filter.label
                })
            }, (item: HubFilter) => item.label)
          }
          .width('100%')
          .margin({ bottom: Tokens.spLg })

          // Cargo grid section
          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Tokens.onSurface)
            .margin({ bottom: Tokens.spMd })

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoCardItem(card)
              }
            }, (item: CargoCard) => item.id)
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(Tokens.spSm)
          .columnsGap(Tokens.spSm)
          .height(320)
          .margin({ bottom: Tokens.spLg })

          // Route manifest section
          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Tokens.onSurface)
            .margin({ bottom: Tokens.spMd })

          Column() {
            ForEach(this.manifest, (entry: ManifestEntry) => {
              this.ManifestRow(entry)
            }, (item: ManifestEntry) => item.origin + item.destination)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: Tokens.spLg, right: Tokens.spLg, top: Tokens.spMd, bottom: Tokens.spMd })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Tokens.background)
  }

  @Builder
  TopBar() {
    Row() {
      // Navigation icon placeholder
      Circle()
        .width(26)
        .height(26)
        .fill(Tokens.surfaceVariant)

      Column() {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      // Action icon placeholder
      Circle()
        .width(26)
        .height(26)
        .fill(Tokens.surfaceVariant)
    }
    .width('100%')
    .padding({ left: Tokens.spLg, right: Tokens.spLg, top: Tokens.spMd, bottom: Tokens.spMd })
    .backgroundColor(Tokens.surface)
  }

  @Builder
  CargoCardItem(card: CargoCard) {
    Column() {
      // Image placeholder
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(60)
          .height(60)
          .fill(Tokens.tertiary)
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      .backgroundColor(Tokens.surface)
      .borderRadius(Tokens.shapeSmall)
      .margin({ bottom: Tokens.spSm })

      Column() {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
        Text(card.id)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(Tokens.onSurface)
          .opacity(0.7)
          .margin({ top: Tokens.spXxs })
        Text('Fill ' + card.fill)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.success)
          .margin({ top: Tokens.spXxs })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(Tokens.spMd)
    .backgroundColor(Tokens.surfaceVariant)
    .borderRadius(Tokens.shapeMedium)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column() {
        Text(entry.origin + ' → ' + entry.destination)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
        Text(entry.status)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.statusColor(entry.status))
          .margin({ top: Tokens.spXxs })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Details')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Tokens.onSecondary)
        .backgroundColor(Tokens.secondary)
        .borderRadius(Tokens.shapeSmall)
        .padding({ left: Tokens.spSm, right: Tokens.spSm, top: Tokens.spXxs, bottom: Tokens.spXxs })
    }
    .width('100%')
    .padding(Tokens.spMd)
    .backgroundColor(Tokens.surfaceVariant)
    .borderRadius(Tokens.shapeMedium)
    .margin({ bottom: Tokens.spSm })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
          .margin({ top: Tokens.spXxs })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Dispatch')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Tokens.onPrimary)
        .backgroundColor(Tokens.primary)
        .borderRadius(Tokens.shapeMedium)
        .padding({ left: Tokens.spXl, right: Tokens.spXl, top: Tokens.spXs, bottom: Tokens.spXs })
    }
    .width('100%')
    .padding({ left: Tokens.spLg, right: Tokens.spLg, top: Tokens.spMd, bottom: Tokens.spMd })
    .backgroundColor(Tokens.surface)
  }

  private statusColor(status: string): ResourceColor {
    if (status === 'Delayed') {
      return Tokens.warning
    } else if (status === 'In flight') {
      return Tokens.success
    }
    return Tokens.onSurface
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

namespace Tokens {
  export const primary: string = '#8B6B4C'
  export const secondary: string = '#C27D38'
  export const tertiary: string = '#F2C57C'
  export const background: string = '#100C08'
  export const surface: string = '#19110D'
  export const surfaceVariant: string = '#2A1C14'
  export const outline: string = '#4F3A2C'
  export const success: string = '#6ECE89'
  export const warning: string = '#E19F41'
  export const error: string = '#D96666'
  export const onPrimary: string = '#100C08'
  export const onSecondary: string = '#100C08'
  export const onTertiary: string = '#120E04'
  export const onBackground: string = '#F7EAD8'
  export const onSurface: string = '#FBEFE0'

  export const shapeSmall: number = 10
  export const shapeMedium: number = 18
  export const shapeLarge: number = 26

  export const spXxs: number = 6
  export const spXs: number = 10
  export const spSm: number = 14
  export const spMd: number = 18
  export const spLg: number = 26
  export const spXl: number = 36
  export const spXxl: number = 48
  export const spXxxl: number = 62
}
