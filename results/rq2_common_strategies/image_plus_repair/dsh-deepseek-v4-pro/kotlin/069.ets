interface CargoCard {
  title: string;
  id: string;
  fill: string;
}

interface ManifestEntry {
  origin: string;
  destination: string;
  status: string;
}

interface HubFilter {
  label: string;
}

const C_PRIMARY: string = '#8B6B4C';
const C_SECONDARY: string = '#C27D38';
const C_TERTIARY: string = '#F2C57C';
const C_BACKGROUND: string = '#100C08';
const C_SURFACE: string = '#19110D';
const C_SURFACE_VARIANT: string = '#2A1C14';
const C_OUTLINE: string = '#4F3A2C';
const C_SUCCESS: string = '#6ECE89';
const C_WARNING: string = '#E19F41';
const C_ERROR: string = '#D96666';
const C_ON_PRIMARY: string = '#100C08';
const C_ON_SECONDARY: string = '#100C08';
const C_ON_TERTIARY: string = '#120E04';
const C_ON_BACKGROUND: string = '#F7EAD8';
const C_ON_SURFACE: string = '#FBEFE0';

const C_SURFACE_95: string = 'rgba(25,17,13,0.95)';
const C_ON_SURFACE_70: string = 'rgba(251,239,224,0.7)';
const C_ON_SURFACE_80: string = 'rgba(251,239,224,0.8)';
const C_SURFACE_VARIANT_92: string = 'rgba(42,28,20,0.92)';
const C_SURFACE_VARIANT_85: string = 'rgba(42,28,20,0.85)';
const C_TERTIARY_40: string = 'rgba(242,197,124,0.4)';

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    { title: 'Copper stack', id: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', id: 'SH-022', fill: '64%' },
    { title: 'Agro crates', id: 'SH-031', fill: '92%' },
    { title: 'Glass kits', id: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', id: 'SH-057', fill: '88%' },
    { title: 'Raw silica', id: 'SH-063', fill: '43%' }
  ];

  private manifest: ManifestEntry[] = [
    { origin: 'Santiago', destination: 'Lima', status: 'Boarding' },
    { origin: 'Mecca', destination: 'Algiers', status: 'At dock' },
    { origin: 'Reykjavík', destination: 'Oslo', status: 'Delayed' },
    { origin: 'Perth', destination: 'Jakarta', status: 'In flight' }
  ];

  private filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' }
  ];

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return C_WARNING;
    }
    if (status === 'In flight') {
      return C_SUCCESS;
    }
    return C_ON_SURFACE_80;
  }

  build() {
    Column() {
      Row() {
        Stack() {
        }
        .width(26)
        .height(26)
        .borderRadius(13)
        .backgroundColor(C_SURFACE_VARIANT)

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .lineHeight(22)
            .fontWeight(500)
            .fontColor(C_ON_SURFACE)
          Text('Logistics grid')
            .fontSize(12)
            .lineHeight(16)
            .fontWeight(500)
            .fontColor(C_ON_SURFACE_70)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Stack() {
        }
        .width(26)
        .height(26)
        .borderRadius(13)
        .backgroundColor(C_SURFACE_VARIANT)
      }
      .width('100%')
      .height(64)
      .padding({ left: 14, right: 14 })
      .backgroundColor(C_SURFACE_95)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: 26 }) {
          Row({ space: 10 }) {
            ForEach(this.filters, (filter: HubFilter) => {
              Button() {
                Text(filter.label)
                  .fontSize(12)
                  .lineHeight(16)
                  .fontWeight(500)
                  .fontColor(filter.label === this.activeFilter ? C_ON_SECONDARY : C_ON_SURFACE)
              }
              .backgroundColor(filter.label === this.activeFilter ? C_SECONDARY : C_SURFACE_VARIANT)
              .borderRadius(10)
              .padding({ left: 14, right: 14, top: 6, bottom: 6 })
              .onClick(() => {
                this.activeFilter = filter.label;
              })
            }, (filter: HubFilter) => filter.label)
          }
          .width('100%')

          Text('Cargo grid')
            .fontSize(22)
            .lineHeight(28)
            .fontWeight(600)
            .fontColor(C_ON_SURFACE)
            .width('100%')

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column({ space: 14 }) {
                  Stack() {
                    Stack() {
                    }
                    .width(60)
                    .height(60)
                    .borderRadius(30)
                    .backgroundColor(C_TERTIARY_40)
                  }
                  .width('100%')
                  .height(90)
                  .borderRadius(10)
                  .backgroundColor(C_SURFACE)
                  .alignContent(Alignment.Center)

                  Column({ space: 6 }) {
                    Text(card.title)
                      .fontSize(16)
                      .lineHeight(22)
                      .fontWeight(500)
                      .fontColor(C_ON_SURFACE)
                    Text(card.id)
                      .fontSize(14)
                      .lineHeight(20)
                      .fontWeight(400)
                      .fontColor(C_ON_SURFACE_70)
                    Text('Fill ' + card.fill)
                      .fontSize(12)
                      .lineHeight(16)
                      .fontWeight(500)
                      .fontColor(C_SUCCESS)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding(18)
                .borderRadius(18)
                .backgroundColor(C_SURFACE_VARIANT_92)
                .alignItems(HorizontalAlign.Start)
              }
            }, (card: CargoCard) => card.id)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(14)
          .rowsGap(14)
          .height(320)
          .width('100%')

          Text('Route manifest')
            .fontSize(22)
            .lineHeight(28)
            .fontWeight(600)
            .fontColor(C_ON_SURFACE)
            .width('100%')

          ForEach(this.manifest, (entry: ManifestEntry) => {
            Row() {
              Column({ space: 6 }) {
                Text(entry.origin + ' → ' + entry.destination)
                  .fontSize(16)
                  .lineHeight(22)
                  .fontWeight(500)
                  .fontColor(C_ON_SURFACE)
                Text(entry.status)
                  .fontSize(14)
                  .lineHeight(20)
                  .fontWeight(400)
                  .fontColor(this.statusColor(entry.status))
              }
              .alignItems(HorizontalAlign.Start)

              Button() {
                Text('Details')
                  .fontSize(12)
                  .lineHeight(16)
                  .fontWeight(500)
                  .fontColor(C_ON_SECONDARY)
              }
              .backgroundColor(C_SECONDARY)
              .borderRadius(10)
              .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              .onClick(() => {
              })
            }
            .width('100%')
            .padding(18)
            .borderRadius(18)
            .backgroundColor(C_SURFACE_VARIANT_85)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (entry: ManifestEntry) => entry.origin + entry.destination)
        }
        .width('100%')
        .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(C_BACKGROUND)
      .scrollBar(BarState.Off)

      Row() {
        Column({ space: 6 }) {
          Text('Manifest filter')
            .fontSize(12)
            .lineHeight(16)
            .fontWeight(500)
            .fontColor(C_ON_SURFACE)
          Text(this.activeFilter)
            .fontSize(16)
            .lineHeight(22)
            .fontWeight(500)
            .fontColor(C_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button() {
          Text('Dispatch')
            .fontSize(16)
            .lineHeight(22)
            .fontWeight(500)
            .fontColor(C_ON_PRIMARY)
        }
        .backgroundColor(C_PRIMARY)
        .borderRadius(18)
        .padding({ left: 36, right: 36, top: 10, bottom: 10 })
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .backgroundColor(C_SURFACE)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}
