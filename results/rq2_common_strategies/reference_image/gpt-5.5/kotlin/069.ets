const COLOR_PRIMARY: string = '#8B6B4C'
const COLOR_SECONDARY: string = '#C27D38'
const COLOR_TERTIARY: string = '#F2C57C'
const COLOR_BACKGROUND: string = '#100C08'
const COLOR_SURFACE: string = '#19110D'
const COLOR_SURFACE_VARIANT: string = '#2A1C14'
const COLOR_OUTLINE: string = '#4F3A2C'
const COLOR_SUCCESS: string = '#6ECE89'
const COLOR_WARNING: string = '#E19F41'
const COLOR_ERROR: string = '#D96666'
const COLOR_ON_PRIMARY: string = '#100C08'
const COLOR_ON_SECONDARY: string = '#100C08'
const COLOR_ON_TERTIARY: string = '#120E04'
const COLOR_ON_BACKGROUND: string = '#F7EAD8'
const COLOR_ON_SURFACE: string = '#FBEFE0'
const COLOR_ON_SURFACE_MUTED: string = '#BFB0A1'
const COLOR_CARD_IMAGE: string = '#160E0B'
const COLOR_PLACEHOLDER: string = '#806844'

const RADIUS_SMALL: number = 10
const RADIUS_MEDIUM: number = 18
const RADIUS_LARGE: number = 26

const SPACE_XXS: number = 6
const SPACE_XS: number = 10
const SPACE_SM: number = 14
const SPACE_MD: number = 18
const SPACE_LG: number = 26
const SPACE_XL: number = 36

class CargoCard {
  title: string
  id: string
  fill: string

  constructor(title: string, id: string, fill: string) {
    this.title = title
    this.id = id
    this.fill = fill
  }
}

class ManifestEntry {
  origin: string
  destination: string
  status: string

  constructor(origin: string, destination: string, status: string) {
    this.origin = origin
    this.destination = destination
    this.status = status
  }
}

class HubFilter {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

@Entry
@Component
struct SupplyHubIndex {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]

  private manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ]

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ]

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return COLOR_WARNING
    }
    if (status === 'In flight') {
      return COLOR_SUCCESS
    }
    return COLOR_ON_SURFACE_MUTED
  }

  @Builder
  TopBar() {
    Row() {
      Stack()
        .width(52)
        .height(52)
        .borderRadius(26)
        .backgroundColor(COLOR_SURFACE_VARIANT)

      Column() {
        Text('SupplyHub')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(36)

        Text('Logistics grid')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE_MUTED)
          .lineHeight(26)
      }
      .alignItems(HorizontalAlign.Center)

      Stack()
        .width(52)
        .height(52)
        .borderRadius(26)
        .backgroundColor(COLOR_SURFACE_VARIANT)
    }
    .width('100%')
    .height(128)
    .padding({ left: 30, right: 30, top: 18, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  FilterButton(filter: HubFilter) {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(filter.label)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeFilter === filter.label ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
    }
    .height(80)
    .width(filter.label === 'All' ? 116 : 146)
    .borderRadius(RADIUS_MEDIUM)
    .backgroundColor(this.activeFilter === filter.label ? COLOR_SECONDARY : COLOR_SURFACE_VARIANT)
    .onClick(() => {
      this.activeFilter = filter.label
    })
  }

  @Builder
  CargoTile(card: CargoCard) {
    Column({ space: SPACE_SM }) {
      Stack({ alignContent: Alignment.Center }) {
        Stack()
          .width(120)
          .height(120)
          .borderRadius(60)
          .backgroundColor(COLOR_PLACEHOLDER)
      }
      .width('100%')
      .height(180)
      .borderRadius(RADIUS_SMALL)
      .backgroundColor(COLOR_CARD_IMAGE)

      Column({ space: SPACE_XXS }) {
        Text(card.title)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(34)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(card.id)
          .fontSize(26)
          .fontWeight(FontWeight.Regular)
          .fontColor(COLOR_ON_SURFACE_MUTED)
          .lineHeight(32)

        Text('Fill ' + card.fill)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SUCCESS)
          .lineHeight(30)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(404)
    .padding(SPACE_XL)
    .borderRadius(RADIUS_LARGE)
    .backgroundColor(COLOR_SURFACE_VARIANT)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text(entry.origin + ' → ' + entry.destination)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(26)

        Text(entry.status)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.statusColor(entry.status))
          .lineHeight(22)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Details')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
      }
      .height(44)
      .padding({ left: SPACE_SM, right: SPACE_SM })
      .borderRadius(RADIUS_SMALL)
      .backgroundColor(COLOR_SECONDARY)
    }
    .width('100%')
    .padding(SPACE_MD)
    .borderRadius(RADIUS_MEDIUM)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text('Manifest filter')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(30)

        Text(this.activeFilter)
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .lineHeight(36)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Dispatch')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
      }
      .width(276)
      .height(80)
      .borderRadius(40)
      .backgroundColor(COLOR_PRIMARY)
    }
    .width('100%')
    .height(168)
    .padding({ left: 52, right: 52, top: SPACE_MD, bottom: SPACE_MD })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .shadow({
      radius: 18,
      color: '#66000000',
      offsetX: 0,
      offsetY: -4
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: SPACE_LG }) {
          Row({ space: SPACE_MD }) {
            ForEach(this.filters, (filter: HubFilter) => {
              this.FilterButton(filter)
            }, (filter: HubFilter) => filter.label)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          Text('Cargo grid')
            .width('100%')
            .fontSize(42)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .lineHeight(52)
            .margin({ top: SPACE_XL })

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoTile(card)
              }
            }, (card: CargoCard) => card.id)
          }
          .width('100%')
          .height(836)
          .columnsTemplate('1fr 1fr')
          .columnsGap(28)
          .rowsGap(28)
          .scrollBar(BarState.Off)

          Text('Route manifest')
            .width('100%')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .lineHeight(30)
            .margin({ top: SPACE_XS })

          Column({ space: SPACE_SM }) {
            ForEach(this.manifest, (entry: ManifestEntry) => {
              this.ManifestRow(entry)
            }, (entry: ManifestEntry) => entry.origin + entry.destination)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 52, right: 52, top: 44, bottom: SPACE_LG })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}