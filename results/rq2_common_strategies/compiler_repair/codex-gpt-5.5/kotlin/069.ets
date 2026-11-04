class CargoCard {
  title: string;
  id: string;
  fill: string;

  constructor(title: string, id: string, fill: string) {
    this.title = title;
    this.id = id;
    this.fill = fill;
  }
}

class ManifestEntry {
  origin: string;
  destination: string;
  status: string;

  constructor(origin: string, destination: string, status: string) {
    this.origin = origin;
    this.destination = destination;
    this.status = status;
  }
}

class HubColors {
  static readonly primary: string = '#8B6B4C';
  static readonly secondary: string = '#C27D38';
  static readonly tertiary: string = '#F2C57C';
  static readonly background: string = '#100C08';
  static readonly surface: string = '#19110D';
  static readonly surfaceVariant: string = '#2A1C14';
  static readonly success: string = '#6ECE89';
  static readonly warning: string = '#E19F41';
  static readonly onPrimary: string = '#100C08';
  static readonly onSecondary: string = '#100C08';
  static readonly onSurface: string = '#FBEFE0';
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'All';
  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland'];
  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ];
  private manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavik', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ];

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return HubColors.warning;
    }
    if (status === 'In flight') {
      return HubColors.success;
    }
    return '#CCFBEFE0';
  }

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(26)
        .height(26)
        .fill(HubColors.surfaceVariant)

      Column() {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HubColors.onSurface)
        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3FBEFE0')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(26)
        .height(26)
        .fill(HubColors.surfaceVariant)
    }
    .width('100%')
    .height(68)
    .padding({ left: 18, right: 18 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F219110D')
  }

  @Builder
  FilterRow() {
    Row() {
      ForEach(this.filters, (filter: string) => {
        Button(filter)
          .height(34)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.activeFilter === filter ? HubColors.onSecondary : HubColors.onSurface)
          .backgroundColor(this.activeFilter === filter ? HubColors.secondary : HubColors.surfaceVariant)
          .borderRadius(10)
          .margin({ right: filter === 'Inland' ? 0 : 10 })
          .onClick(() => {
            this.activeFilter = filter;
          })
      }, (filter: string) => filter)
    }
    .width('100%')
  }

  @Builder
  CargoTile(card: CargoCard) {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(60)
          .height(60)
          .fill('#66F2C57C')
      }
      .width('100%')
      .height(90)
      .backgroundColor(HubColors.surface)
      .borderRadius(10)

      Text(card.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HubColors.onSurface)
        .width('100%')
        .margin({ top: 14 })
      Text(card.id)
        .fontSize(14)
        .fontColor('#B3FBEFE0')
        .width('100%')
        .margin({ top: 6 })
      Text('Fill ' + card.fill)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(HubColors.success)
        .width('100%')
        .margin({ top: 6 })
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#EB2A1C14')
    .borderRadius(18)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column() {
        Text(entry.origin + ' -> ' + entry.destination)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HubColors.onSurface)
        Text(entry.status)
          .fontSize(14)
          .fontColor(this.statusColor(entry.status))
          .margin({ top: 6 })
      }
      .layoutWeight(1)

      Button('Details')
        .height(36)
        .fontSize(12)
        .fontColor(HubColors.onSecondary)
        .backgroundColor(HubColors.secondary)
        .borderRadius(10)
    }
    .width('100%')
    .padding(18)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D92A1C14')
    .borderRadius(18)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(HubColors.onSurface)
        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HubColors.onSurface)
          .margin({ top: 6 })
      }
      .layoutWeight(1)

      Button('Dispatch')
        .height(42)
        .fontSize(16)
        .fontColor(HubColors.onPrimary)
        .backgroundColor(HubColors.primary)
        .borderRadius(18)
    }
    .width('100%')
    .height(80)
    .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(HubColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.FilterRow()

            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(HubColors.onSurface)
              .width('100%')
              .margin({ top: 26, bottom: 14 })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  this.CargoTile(card)
                }
              }, (card: CargoCard) => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(14)
            .rowsGap(14)
            .width('100%')
            .height(640)

            Text('Route manifest')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(HubColors.onSurface)
              .width('100%')
              .margin({ top: 26, bottom: 14 })

            ForEach(this.manifest, (entry: ManifestEntry) => {
              Column() {
                this.ManifestRow(entry)
              }
              .margin({ bottom: 14 })
            }, (entry: ManifestEntry) => entry.origin + entry.destination)
          }
          .width('100%')
          .padding({ left: 26, right: 26, top: 18, bottom: 104 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(HubColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HubColors.background)
  }
}
