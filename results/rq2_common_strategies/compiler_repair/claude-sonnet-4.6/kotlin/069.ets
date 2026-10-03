import { LengthMetrics } from '@kit.ArkUI'

// Design Tokens
const Colors = {
  primary: '#FF8B6B4C',
  secondary: '#FFC27D38',
  tertiary: '#FFF2C57C',
  background: '#FF100C08',
  surface: '#FF19110D',
  surfaceVariant: '#FF2A1C14',
  outline: '#FF4F3A2C',
  success: '#FF6ECE89',
  warning: '#FFE19F41',
  error: '#FFD96666',
  onPrimary: '#FF100C08',
  onSecondary: '#FF100C08',
  onTertiary: '#FF120E04',
  onBackground: '#FFF7EAD8',
  onSurface: '#FFFBEFE0',
}

class CargoCard {
  title: string = ''
  id: string = ''
  fill: string = ''
}

class ManifestEntry {
  origin: string = ''
  destination: string = ''
  status: string = ''
}

class HubFilter {
  label: string = ''
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
    if (status === 'Delayed') return Colors.warning
    if (status === 'In flight') return Colors.success
    return '#CCfbefe0'
  }

  @Builder
  TopBar() {
    Row() {
      // Navigation icon
      Stack() {
        Circle({ width: 26, height: 26 })
          .fill(Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .alignContent(Alignment.Center)

      // Title
      Column() {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3fbefe0')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      // Action icon
      Stack() {
        Circle({ width: 26, height: 26 })
          .fill(Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Colors.surface)
    .padding({ left: 4, right: 4 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Dispatch')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(18)
        .padding({ left: 36, right: 36, top: 10, bottom: 10 })
    }
    .width('100%')
    .backgroundColor(Colors.surface)
    .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterRow() {
    Row({ space: 10 }) {
      ForEach(this.filters, (filter: HubFilter) => {
        Button(filter.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.activeFilter === filter.label ? Colors.onSecondary : Colors.onSurface)
          .backgroundColor(this.activeFilter === filter.label ? Colors.secondary : Colors.surfaceVariant)
          .borderRadius(10)
          .padding({ left: 14, right: 14, top: 6, bottom: 6 })
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
          Column({ space: 14 }) {
            Stack() {
              Row()
                .width('100%')
                .height(90)
                .backgroundColor(Colors.surface)
                .borderRadius(10)
              Circle({ width: 60, height: 60 })
                .fill('#66F2C57C')
            }
            .width('100%')
            .height(90)
            .alignContent(Alignment.Center)

            Column({ space: 6 }) {
              Text(card.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(card.id)
                .fontSize(14)
                .fontColor('#B3fbefe0')
              Text('Fill ' + card.fill)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.success)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .padding(18)
          .backgroundColor('#EB2A1C14')
          .borderRadius(18)
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(14)
    .rowsGap(14)
    .width('100%')
    .height(320)
  }

  @Builder
  ManifestList() {
    ForEach(this.manifest, (entry: ManifestEntry) => {
      Row() {
        Column({ space: 6 }) {
          Text(entry.origin + ' → ' + entry.destination)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(entry.status)
            .fontSize(14)
            .fontColor(this.getStatusColor(entry.status))
        }
        .alignItems(HorizontalAlign.Start)

        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(10)
          .padding({ left: 14, right: 14, top: 10, bottom: 10 })
      }
      .width('100%')
      .backgroundColor('#D92A1C14')
      .borderRadius(18)
      .padding(18)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 26 }) {
          this.FilterRow()

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
            .width('100%')

          this.CargoGrid()

          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
            .width('100%')

          this.ManifestList()
        }
        .padding({ left: 26, right: 26, top: 18, bottom: 18 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}