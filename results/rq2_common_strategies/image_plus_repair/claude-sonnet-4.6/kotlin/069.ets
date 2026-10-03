// Color constants
const COLOR_PRIMARY: string = '#8B6B4C'
const COLOR_SECONDARY: string = '#C27D38'
const COLOR_TERTIARY: string = '#F2C57C'
const COLOR_BACKGROUND: string = '#100C08'
const COLOR_SURFACE: string = '#19110D'
const COLOR_SURFACE_VARIANT: string = '#2A1C14'
const COLOR_OUTLINE: string = '#4F3A2C'
const COLOR_SUCCESS: string = '#6ECE89'
const COLOR_WARNING: string = '#E19F41'
const COLOR_ON_SURFACE: string = '#FBEFE0'
const COLOR_ON_SECONDARY: string = '#100C08'
const COLOR_ON_PRIMARY: string = '#100C08'

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

function makeCargoCard(title: string, id: string, fill: string): CargoCard {
  let c = new CargoCard()
  c.title = title
  c.id = id
  c.fill = fill
  return c
}

function makeManifestEntry(origin: string, destination: string, status: string): ManifestEntry {
  let e = new ManifestEntry()
  e.origin = origin
  e.destination = destination
  e.status = status
  return e
}

function makeHubFilter(label: string): HubFilter {
  let f = new HubFilter()
  f.label = label
  return f
}

function statusColor(status: string): string {
  if (status === 'Delayed') {
    return COLOR_WARNING
  } else if (status === 'In flight') {
    return COLOR_SUCCESS
  } else {
    return COLOR_ON_SURFACE
  }
}

@Component
struct FilterButton {
  label: string = ''
  active: boolean = false
  onTap: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
      .backgroundColor(this.active ? COLOR_SECONDARY : COLOR_SURFACE_VARIANT)
      .borderRadius(10)
      .padding({ left: 14, right: 14, top: 6, bottom: 6 })
      .onClick(() => {
        this.onTap()
      })
  }
}

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard()

  build() {
    Column({ space: 14 }) {
      Stack({ alignContent: Alignment.Center }) {
        Row()
          .width('100%')
          .height(90)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(10)
        Row()
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor('#66F2C57C')
      }
      .width('100%')
      .height(90)

      Column({ space: 6 }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text(this.card.id)
          .fontSize(14)
          .fontColor(COLOR_ON_SURFACE)
          .opacity(0.7)
        Text('Fill ' + this.card.fill)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SUCCESS)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(18)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(18)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ManifestRow {
  entry: ManifestEntry = new ManifestEntry()

  build() {
    Row() {
      Column({ space: 6 }) {
        Text(this.entry.origin + ' → ' + this.entry.destination)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text(this.entry.status)
          .fontSize(14)
          .fontColor(statusColor(this.entry.status))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Details')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SECONDARY)
        .backgroundColor(COLOR_SECONDARY)
        .borderRadius(10)
        .padding({ left: 14, right: 14, top: 10, bottom: 10 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(18)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(18)
  }
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    makeCargoCard('Copper stack', 'SH-014', '78%'),
    makeCargoCard('Fiber reels', 'SH-022', '64%'),
    makeCargoCard('Agro crates', 'SH-031', '92%'),
    makeCargoCard('Glass kits', 'SH-045', '51%'),
    makeCargoCard('Steel mesh', 'SH-057', '88%'),
    makeCargoCard('Raw silica', 'SH-063', '43%'),
  ]

  private manifest: ManifestEntry[] = [
    makeManifestEntry('Santiago', 'Lima', 'Boarding'),
    makeManifestEntry('Mecca', 'Algiers', 'At dock'),
    makeManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    makeManifestEntry('Perth', 'Jakarta', 'In flight'),
  ]

  private filters: HubFilter[] = [
    makeHubFilter('All'),
    makeHubFilter('Atlantic'),
    makeHubFilter('Pacific'),
    makeHubFilter('Inland'),
  ]

  build() {
    Column() {
      // Top bar
      Row() {
        Row()
          .width(26)
          .height(26)
          .borderRadius(13)
          .backgroundColor(COLOR_SURFACE_VARIANT)

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)

        Row()
          .width(26)
          .height(26)
          .borderRadius(13)
          .backgroundColor(COLOR_SURFACE_VARIANT)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 26, right: 26, top: 16, bottom: 16 })
      .backgroundColor(COLOR_SURFACE)

      // Scrollable content
      Scroll() {
        Column({ space: 26 }) {
          // Filter row
          Row({ space: 10 }) {
            ForEach(this.filters, (filter: HubFilter) => {
              FilterButton({
                label: filter.label,
                active: this.activeFilter === filter.label,
                onTap: () => {
                  this.activeFilter = filter.label
                }
              })
            })
          }
          .width('100%')

          // Cargo grid heading
          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')

          // 2-column cargo grid
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                CargoCardView({ card: card })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(14)
          .rowsGap(14)
          .width('100%')
          .height(480)

          // Manifest heading
          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')

          // Manifest list
          Column({ space: 14 }) {
            ForEach(this.manifest, (entry: ManifestEntry) => {
              ManifestRow({ entry: entry })
            })
          }
          .width('100%')
        }
        .padding({ left: 26, right: 26, top: 18, bottom: 18 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      Row() {
        Column({ space: 6 }) {
          Text('Manifest filter')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Dispatch')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(18)
          .padding({ left: 36, right: 36, top: 10, bottom: 10 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .backgroundColor(COLOR_SURFACE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}