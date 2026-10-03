// Index.ets

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

class DesignTokens {
  static primary: string = '#8B6B4C';
  static secondary: string = '#C27D38';
  static tertiary: string = '#F2C57C';
  static background: string = '#100C08';
  static surface: string = '#19110D';
  static surfaceVariant: string = '#2A1C14';
  static outline: string = '#4F3A2C';
  static success: string = '#6ECE89';
  static warning: string = '#E19F41';
  static error: string = '#D96666';
  static onPrimary: string = '#100C08';
  static onSecondary: string = '#100C08';
  static onTertiary: string = '#120E04';
  static onBackground: string = '#F7EAD8';
  static onSurface: string = '#FBEFE0';
}

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

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 26, height: 26 }).fill(DesignTokens.surfaceVariant);

        Column() {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface);
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface)
            .opacity(0.7);
        }
        .alignItems(HorizontalAlign.Center);

        Circle({ width: 26, height: 26 }).fill(DesignTokens.surfaceVariant);
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(DesignTokens.surface)
      .opacity(0.95);

      // Content List
      Scroll() {
        Column() {
          // Filters
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.filters, (filter: HubFilter) => {
              Button(filter.label)
                .height(32)
                .borderRadius(10)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.activeFilter === filter.label ? DesignTokens.secondary : DesignTokens.surfaceVariant)
                .fontColor(this.activeFilter === filter.label ? DesignTokens.onSecondary : DesignTokens.onSurface)
                .margin({ right: 10, bottom: 10 })
                .onClick(() => {
                  this.activeFilter = filter.label;
                });
            });
          }
          .width('100%');

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.onSurface)
            .margin({ top: 16, bottom: 14 });

          // Cargo Grid
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column() {
                  Row() {
                    Circle({ width: 60, height: 60 })
                      .fill(DesignTokens.tertiary)
                      .opacity(0.4);
                  }
                  .width('100%')
                  .height(90)
                  .borderRadius(10)
                  .backgroundColor(DesignTokens.surface)
                  .justifyContent(FlexAlign.Center);

                  Text(card.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.onSurface)
                    .margin({ top: 14 });

                  Text(card.id)
                    .fontSize(14)
                    .fontColor(DesignTokens.onSurface)
                    .opacity(0.7)
                    .margin({ top: 6 });

                  Text(`Fill ${card.fill}`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.success)
                    .margin({ top: 6 });
                }
                .padding(18)
                .borderRadius(18)
                .backgroundColor(DesignTokens.surfaceVariant)
                .opacity(0.92)
                .alignItems(HorizontalAlign.Start);
              }
            });
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(14)
          .columnsGap(14)
          .height(320);

          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.onSurface)
            .margin({ top: 26, bottom: 14 });

          // Manifest List
          ForEach(this.manifest, (entry: ManifestEntry) => {
            Row() {
              Column() {
                Text(`${entry.origin} → ${entry.destination}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(DesignTokens.onSurface);
                Text(entry.status)
                  .fontSize(14)
                  .fontColor(entry.status === 'Delayed' ? DesignTokens.warning : (entry.status === 'In flight' ? DesignTokens.success : DesignTokens.onSurface))
                  .opacity(entry.status === 'Delayed' || entry.status === 'In flight' ? 1 : 0.8)
                  .margin({ top: 6 });
              }
              .alignItems(HorizontalAlign.Start);

              Button('Details')
                .height(32)
                .borderRadius(10)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(DesignTokens.secondary)
                .fontColor(DesignTokens.onSecondary);
            }
            .width('100%')
            .padding(18)
            .borderRadius(18)
            .backgroundColor(DesignTokens.surfaceVariant)
            .opacity(0.85)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 14 });
          });
        }
        .padding({ left: 26, right: 26, top: 18, bottom: 18 });
      }
      .layoutWeight(1)
      .backgroundColor(DesignTokens.background);

      // Bottom Bar
      Row() {
        Column() {
          Text('Manifest filter')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface);
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface)
            .margin({ top: 6 });
        }
        .alignItems(HorizontalAlign.Start);

        Button('Dispatch')
          .height(40)
          .borderRadius(18)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(DesignTokens.primary)
          .fontColor(DesignTokens.onPrimary)
          .padding({ left: 36, right: 36 });
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(DesignTokens.surface);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.background);
  }
}