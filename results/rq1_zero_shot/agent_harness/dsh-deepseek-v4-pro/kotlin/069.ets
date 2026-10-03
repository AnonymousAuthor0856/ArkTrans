const Colors = {
  primary: '#8B6B4C',
  secondary: '#C27D38',
  tertiary: '#F2C57C',
  background: '#100C08',
  surface: '#19110D',
  surfaceVariant: '#2A1C14',
  outline: '#4F3A2C',
  success: '#6ECE89',
  warning: '#E19F41',
  error: '#D96666',
  onPrimary: '#100C08',
  onSecondary: '#100C08',
  onTertiary: '#120E04',
  onBackground: '#F7EAD8',
  onSurface: '#FBEFE0',
}

const Spacing = {
  xxs: 6,
  xs: 10,
  sm: 14,
  md: 18,
  lg: 26,
  xl: 36,
  xxl: 48,
  xxxl: 62,
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
struct Index {
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

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return Colors.warning
    }
    if (status === 'In flight') {
      return Colors.success
    }
    return Colors.onSurface
  }

  build() {
    Column() {
      Row() {
        Blank()
          .width(26)
          .height(26)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(13)
        Column({ space: Spacing.xxs }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        Blank()
          .width(26)
          .height(26)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(13)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Scroll() {
            Row({ space: Spacing.xs }) {
              ForEach(this.filters, (filter: HubFilter) => {
                Button() {
                  Text(filter.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.activeFilter === filter.label ? Colors.onSecondary : Colors.onSurface)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilter === filter.label ? Colors.secondary : Colors.surfaceVariant)
                .borderRadius(10)
                .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xxs, bottom: Spacing.xxs })
                .onClick(() => {
                  this.activeFilter = filter.label
                })
              }, (filter: HubFilter) => filter.label)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column({ space: Spacing.sm }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Blank()
                      .width(60)
                      .height(60)
                      .backgroundColor(Colors.tertiary)
                      .borderRadius(30)
                      .opacity(0.4)
                  }
                  .width('100%')
                  .height(90)
                  .backgroundColor(Colors.surface)
                  .borderRadius(10)

                  Column({ space: Spacing.xxs }) {
                    Text(card.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                    Text(card.id)
                      .fontSize(14)
                      .fontColor(Colors.onSurface)
                    Text('Fill ' + card.fill)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.success)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .padding(Spacing.md)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(18)
              }
            }, (card: CargoCard) => card.id)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(Spacing.sm)
          .rowsGap(Spacing.sm)
          .height(320)
          .width('100%')

          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          ForEach(this.manifest, (entry: ManifestEntry) => {
            Row() {
              Column({ space: Spacing.xxs }) {
                Text(entry.origin + ' → ' + entry.destination)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(entry.status)
                  .fontSize(14)
                  .fontColor(this.statusColor(entry.status))
              }
              .alignItems(HorizontalAlign.Start)

              Button('Details')
                .type(ButtonType.Normal)
                .fontSize(12)
                .fontColor(Colors.onSecondary)
                .backgroundColor(Colors.secondary)
                .borderRadius(10)
                .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
                .onClick(() => {})
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(18)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (entry: ManifestEntry) => entry.origin + entry.destination)
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: Spacing.xxs }) {
          Text('Manifest filter')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Button('Dispatch')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(18)
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.xs, bottom: Spacing.xs })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
