@Entry
@Component
struct SupplyHubPage {
  @State activeFilter: string = 'All'

  private readonly cards: CargoCard[] = [
    { title: 'Copper stack', id: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', id: 'SH-022', fill: '64%' },
    { title: 'Agro crates', id: 'SH-031', fill: '92%' },
    { title: 'Glass kits', id: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', id: 'SH-057', fill: '88%' },
    { title: 'Raw silica', id: 'SH-063', fill: '43%' }
  ]

  private readonly manifest: ManifestEntry[] = [
    { origin: 'Santiago', destination: 'Lima', status: 'Boarding' },
    { origin: 'Mecca', destination: 'Algiers', status: 'At dock' },
    { origin: 'Reykjavík', destination: 'Oslo', status: 'Delayed' },
    { origin: 'Perth', destination: 'Jakarta', status: 'In flight' }
  ]

  private readonly filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' }
  ]

  build() {
    Column() {
      // Top bar
      Row() {
        Circle({ width: 40, height: 40 })
          .fill('#2A1C14')
        Column() {
          Text('SupplyHub')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
          Text('Logistics grid')
            .fontSize(16)
            .fontColor('#FBEFE0')
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
        Circle({ width: 40, height: 40 })
          .fill('#2A1C14')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#19110D')
      .opacity(0.95)

      // Main content
      Scroll() {
        Column() {
          // Filter chips
          Row() {
            ForEach(this.filters, (filter: HubFilter) => {
              Text(filter.label)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.activeFilter === filter.label ? '#100C08' : '#FBEFE0')
                .padding({ left: 20, right: 20, top: 12, bottom: 12 })
                .borderRadius(14)
                .backgroundColor(this.activeFilter === filter.label ? '#C27D38' : '#2A1C14')
                .onClick(() => {
                  this.activeFilter = filter.label
                })
            })
          }
          .width('100%')
          .margin({ top: 18, bottom: 18 })

          // Cargo grid heading
          Text('Cargo grid')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FBEFE0')
            .width('100%')
            .margin({ bottom: 18 })

          // Cargo grid
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column() {
                  // Image placeholder
                  Row() {
                    Circle({ width: 72, height: 72 })
                      .fill('#8B6B4C')
                      .opacity(0.6)
                  }
                  .width('100%')
                  .height(96)
                  .justifyContent(FlexAlign.Center)
                  .backgroundColor('#100C08')
                  .borderRadius(14)

                  Column() {
                    Text(card.title)
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FBEFE0')
                    Text(card.id)
                      .fontSize(16)
                      .fontColor('#FBEFE0')
                      .opacity(0.7)
                      .margin({ top: 4 })
                    Text(`Fill ${card.fill}`)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#6ECE89')
                      .margin({ top: 4 })
                  }
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                  .margin({ top: 14 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#2A1C14')
                .borderRadius(22)
                .opacity(0.92)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(14)
          .columnsGap(14)
          .height(340)

          // Route manifest heading
          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
            .width('100%')
            .margin({ top: 26, bottom: 14 })

          // Manifest list
          Column() {
            ForEach(this.manifest, (entry: ManifestEntry) => {
              Row() {
                Column() {
                  Text(`${entry.origin} → ${entry.destination}`)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FBEFE0')
                  Text(entry.status)
                    .fontSize(14)
                    .fontColor(this.getStatusColor(entry.status))
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text('Details')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#100C08')
                  .padding({ left: 18, right: 18, top: 10, bottom: 10 })
                  .backgroundColor('#C27D38')
                  .borderRadius(10)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#2A1C14')
              .borderRadius(18)
              .opacity(0.85)
              .margin({ bottom: 10 })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      }
      .layoutWeight(1)
      .backgroundColor('#100C08')
      .scrollBar(BarState.Off)

      // Bottom bar
      Row() {
        Column() {
          Text('Manifest filter')
            .fontSize(14)
            .fontColor('#FBEFE0')
            .fontWeight(FontWeight.Medium)
          Text(this.activeFilter)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Text('Dispatch')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#100C08')
          .padding({ left: 48, right: 48, top: 14, bottom: 14 })
          .backgroundColor('#8B6B4C')
          .borderRadius(28)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .backgroundColor('#19110D')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#100C08')
  }

  getStatusColor(status: string): ResourceColor {
    if (status === 'Delayed') {
      return '#E19F41'
    }
    if (status === 'In flight') {
      return '#6ECE89'
    }
    return '#FBEFE0'
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
