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

class Palette {
  static readonly primary: string = '#8B6B4C'
  static readonly secondary: string = '#C27D38'
  static readonly tertiary: string = '#F2C57C'
  static readonly background: string = '#100C08'
  static readonly surface: string = '#19110D'
  static readonly surfaceVariant: string = '#2A1C14'
  static readonly success: string = '#6ECE89'
  static readonly warning: string = '#E19F41'
  static readonly onPrimary: string = '#100C08'
  static readonly onSurface: string = '#FBEFE0'
  static readonly mutedText: string = '#BDAEA2'
}

@Entry
@Component
struct SupplyHubPage {
  @State activeFilter: string = 'All'
  private readonly filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']
  private readonly cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]
  private readonly manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavik', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ]

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return Palette.warning
    }
    if (status === 'In flight') {
      return Palette.success
    }
    return Palette.mutedText
  }

  @Builder
  TopBar() {
    Stack() {
      Row() {
        Circle()
          .width(52)
          .height(52)
          .fill(Palette.surfaceVariant)
          .opacity(0.76)
        Blank()
        Circle()
          .width(52)
          .height(52)
          .fill(Palette.surfaceVariant)
          .opacity(0.76)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 30, right: 30, top: 38 })
      .alignItems(VerticalAlign.Top)

      Column() {
        Text('SupplyHub')
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.onSurface)
          .lineHeight(38)
        Text('Logistics grid')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.mutedText)
          .lineHeight(29)
          .opacity(0.9)
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 32 })
    }
    .width('100%')
    .height(132)
    .backgroundColor(Palette.surface)
  }

  @Builder
  FilterButton(label: string) {
    Button(label)
      .type(ButtonType.Normal)
      .fontSize(25)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.activeFilter === label ? Palette.onPrimary : Palette.onSurface)
      .backgroundColor(this.activeFilter === label ? Palette.secondary : Palette.surfaceVariant)
      .borderRadius(18)
      .height(80)
      .padding({ left: 28, right: 28 })
      .stateEffect(false)
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  CargoCell(card: CargoCard) {
    Column() {
      Stack() {
        Circle()
          .width(120)
          .height(120)
          .fill(Palette.tertiary)
          .opacity(0.47)
      }
      .width('100%')
      .height(180)
      .backgroundColor(Palette.surface)
      .borderRadius(18)

      Column() {
        Text(card.title)
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.onSurface)
          .lineHeight(38)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(card.id)
          .fontSize(28)
          .fontColor(Palette.mutedText)
          .lineHeight(36)
          .margin({ top: 10 })
        Text('Fill ' + card.fill)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.success)
          .lineHeight(31)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .margin({ top: 28 })
    }
    .width('100%')
    .height(404)
    .padding({ left: 36, right: 36, top: 36, bottom: 34 })
    .backgroundColor(Palette.surfaceVariant)
    .borderRadius(34)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column() {
        Text(entry.origin + ' -> ' + entry.destination)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.onSurface)
          .lineHeight(28)
        Text(entry.status)
          .fontSize(18)
          .fontColor(this.statusColor(entry.status))
          .lineHeight(24)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Details')
        .type(ButtonType.Normal)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onPrimary)
        .backgroundColor(Palette.secondary)
        .borderRadius(14)
        .height(46)
        .padding({ left: 22, right: 22 })
        .stateEffect(false)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 20, bottom: 20 })
    .backgroundColor(Palette.surfaceVariant)
    .borderRadius(26)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Manifest filter')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.onSurface)
          .lineHeight(31)
        Text(this.activeFilter)
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor(Palette.onSurface)
          .lineHeight(38)
          .margin({ top: 14 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Dispatch')
        .type(ButtonType.Normal)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.onPrimary)
        .backgroundColor(Palette.primary)
        .borderRadius(40)
        .width(276)
        .height(80)
        .stateEffect(false)
    }
    .width('100%')
    .height(168)
    .padding({ left: 52, right: 52, top: 42, bottom: 32 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Palette.surfaceVariant)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            Row() {
              ForEach(this.filters, (filter: string) => {
                this.FilterButton(filter)
              }, (filter: string) => filter)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 40 })

            Text('Cargo grid')
              .width('100%')
              .fontSize(43)
              .fontWeight(FontWeight.Bold)
              .fontColor(Palette.onSurface)
              .lineHeight(54)
              .margin({ top: 62 })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  this.CargoCell(card)
                }
              }, (card: CargoCard) => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(28)
            .rowsGap(28)
            .width('100%')
            .height(836)
            .margin({ top: 50 })

            Text('Route manifest')
              .width('100%')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Palette.onSurface)
              .lineHeight(36)
              .margin({ top: 34, bottom: 18 })

            ForEach(this.manifest, (entry: ManifestEntry) => {
              this.ManifestRow(entry)
            }, (entry: ManifestEntry) => entry.origin + entry.destination)
          }
          .width('100%')
          .padding({ left: 52, right: 52, bottom: 198 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Palette.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Palette.background)
  }
}
