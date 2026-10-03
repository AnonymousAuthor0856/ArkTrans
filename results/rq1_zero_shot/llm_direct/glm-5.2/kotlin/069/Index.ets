// 131*SupplyHub*en
// Grid
// Muted Earth
// en
// 720x1280
// primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0
// Medium
// Grid,Image,LazyList
// Muted earth cargo grid with image placeholders

class DesignTokens {
  static Colors = {
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
  };
  static Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold, lineHeight: 34 },
    headline: { fontSize: 22, fontWeight: FontWeight.SemiBold, lineHeight: 28 },
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 },
  };
  static Shapes = {
    small: 10,
    medium: 18,
    large: 26,
  };
  static Spacing = {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62,
  };
}

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

@Entry
@Component
struct SupplyHub {
  private cards: CargoCard[] = [
    { title: 'Copper stack', id: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', id: 'SH-022', fill: '64%' },
    { title: 'Agro crates', id: 'SH-031', fill: '92%' },
    { title: 'Glass kits', id: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', id: 'SH-057', fill: '88%' },
    { title: 'Raw silica', id: 'SH-063', fill: '43%' },
  ];

  private manifest: ManifestEntry[] = [
    { origin: 'Santiago', destination: 'Lima', status: 'Boarding' },
    { origin: 'Mecca', destination: 'Algiers', status: 'At dock' },
    { origin: 'Reykjavík', destination: 'Oslo', status: 'Delayed' },
    { origin: 'Perth', destination: 'Jakarta', status: 'In flight' },
  ];

  private filters: HubFilter[] = [
    { label: 'All' },
    { label: 'Atlantic' },
    { label: 'Pacific' },
    { label: 'Inland' },
  ];

  @State activeFilter: string = 'All';

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(26)
          .height(26)
          .borderRadius(13)
          .backgroundColor(DesignTokens.Colors.surfaceVariant);

        Column() {
          Text('SupplyHub')
            .fontSize(DesignTokens.Typography.title.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium);

          Text('Logistics grid')
            .fontSize(DesignTokens.Typography.label.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
            .fontWeight(FontWeight.Medium);
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 12, right: 12 });

        Row()
          .width(26)
          .height(26)
          .borderRadius(13)
          .backgroundColor(DesignTokens.Colors.surfaceVariant);
      }
      .width('100%')
      .height(60)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(DesignTokens.Colors.surface);

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Row
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.filters, (filter: HubFilter) => {
              Button(filter.label)
                .fontSize(DesignTokens.Typography.label.fontSize)
                .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
                .borderRadius(DesignTokens.Shapes.small)
                .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
                .margin({ right: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
                .onClick(() => {
                  this.activeFilter = filter.label;
                });
            });
          }
          .width('100%')
          .margin({ bottom: DesignTokens.Spacing.lg });

          // Cargo Grid Header
          Text('Cargo grid')
            .fontSize(DesignTokens.Typography.headline.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .fontWeight(FontWeight.SemiBold)
            .margin({ bottom: DesignTokens.Spacing.md });

          // Cargo Grid
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column() {
                  Box() {
                    Box()
                      .width(60)
                      .height(60)
                      .borderRadius(30)
                      .backgroundColor(DesignTokens.Colors.tertiary)
                      .opacity(0.4);
                  }
                  .width('100%')
                  .height(90)
                  .borderRadius(DesignTokens.Shapes.small)
                  .backgroundColor(DesignTokens.Colors.surface)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(VerticalAlign.Center)
                  .margin({ bottom: DesignTokens.Spacing.sm });

                  Text(card.title)
                    .fontSize(DesignTokens.Typography.title.fontSize)
                    .fontColor(DesignTokens.Colors.onSurface)
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: DesignTokens.Spacing.xxs });

                  Text(card.id)
                    .fontSize(DesignTokens.Typography.body.fontSize)
                    .fontColor(DesignTokens.Colors.onSurface)
                    .opacity(0.7)
                    .margin({ bottom: DesignTokens.Spacing.xxs });

                  Text(`Fill ${card.fill}`)
                    .fontSize(DesignTokens.Typography.label.fontSize)
                    .fontColor(DesignTokens.Colors.success)
                    .fontWeight(FontWeight.Medium);
                }
                .padding(DesignTokens.Spacing.md)
                .borderRadius(DesignTokens.Shapes.medium)
                .backgroundColor(DesignTokens.Colors.surfaceVariant)
                .opacity(0.92);
              }
            });
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(DesignTokens.Spacing.sm)
          .columnsGap(DesignTokens.Spacing.sm)
          .width('100%')
          .height(320)
          .margin({ bottom: DesignTokens.Spacing.lg });

          // Route Manifest Header
          Text('Route manifest')
            .fontSize(DesignTokens.Typography.headline.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .fontWeight(FontWeight.SemiBold)
            .margin({ bottom: DesignTokens.Spacing.md });

          // Manifest List
          ForEach(this.manifest, (entry: ManifestEntry) => {
            Row() {
              Column() {
                Text(`${entry.origin} → ${entry.destination}`)
                  .fontSize(DesignTokens.Typography.title.fontSize)
                  .fontColor(DesignTokens.Colors.onSurface)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: DesignTokens.Spacing.xxs });

                Text(entry.status)
                  .fontSize(DesignTokens.Typography.body.fontSize)
                  .fontColor(entry.status === 'Delayed' ? DesignTokens.Colors.warning : (entry.status === 'In flight' ? DesignTokens.Colors.success : DesignTokens.Colors.onSurface))
                  .opacity(entry.status === 'Delayed' || entry.status === 'In flight' ? 1 : 0.8);
              }
              .alignItems(HorizontalAlign.Start);

              Button('Details')
                .fontSize(DesignTokens.Typography.label.fontSize)
                .fontColor(DesignTokens.Colors.onSecondary)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(DesignTokens.Colors.secondary)
                .borderRadius(DesignTokens.Shapes.small)
                .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs });
            }
            .width('100%')
            .padding(DesignTokens.Spacing.md)
            .borderRadius(DesignTokens.Shapes.medium)
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .opacity(0.85)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: DesignTokens.Spacing.sm });
          });
        }
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md });
      }
      .layoutWeight(1)
      .backgroundColor(DesignTokens.Colors.background);

      // Bottom Bar
      Row() {
        Column() {
          Text('Manifest filter')
            .fontSize(DesignTokens.Typography.label.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: DesignTokens.Spacing.xxs });

          Text(this.activeFilter)
            .fontSize(DesignTokens.Typography.title.fontSize)
            .fontColor(DesignTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium);
        }
        .alignItems(HorizontalAlign.Start);

        Button('Dispatch')
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontColor(DesignTokens.Colors.onPrimary)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(DesignTokens.Colors.primary)
          .borderRadius(DesignTokens.Shapes.medium)
          .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs });
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(DesignTokens.Colors.surface);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background);
  }
}