// SupplyHub — ArkTS (HarmonyOS) port of the SwiftUI source.
// Entry page: ContentView(). Place in pages/ContentView.ets and register in main_pages.json.

// ---------------------------------------------------------------------------
// MARK: - Data Models
// ---------------------------------------------------------------------------

class CargoCard {
  title: string;
  itemId: string;
  fill: string;

  constructor(title: string, itemId: string, fill: string) {
    this.title = title;
    this.itemId = itemId;
    this.fill = fill;
  }
}

class HubFilter {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

// ---------------------------------------------------------------------------
// MARK: - Design Tokens
// ---------------------------------------------------------------------------

class Tokens {
  // Colors (opaque)
  static readonly PRIMARY: string = '#8B6B4C';
  static readonly SECONDARY: string = '#C27D38';
  static readonly TERTIARY: string = '#F2C57C';
  static readonly BACKGROUND: string = '#100C08';
  static readonly SURFACE: string = '#19110D';
  static readonly SURFACE_VARIANT: string = '#2A1C14';
  static readonly OUTLINE: string = '#4F3A2C';
  static readonly SUCCESS: string = '#6ECE89';
  static readonly WARNING: string = '#E19F41';
  static readonly ERROR: string = '#D96666';
  static readonly ON_PRIMARY: string = '#100C08';
  static readonly ON_SECONDARY: string = '#100C08';
  static readonly ON_TERTIARY: string = '#120E04';
  static readonly ON_BACKGROUND: string = '#F7EAD8';
  static readonly ON_SURFACE: string = '#FBEFE0';

  // Colors with alpha baked in (#AARRGGBB)
  static readonly SURFACE_95: string = '#F219110D';          // surface.opacity(0.95)
  static readonly SURFACE_VARIANT_92: string = '#EB2A1C14';  // surfaceVariant.opacity(0.92)
  static readonly SURFACE_VARIANT_85: string = '#D92A1C14';  // surfaceVariant.opacity(0.85)
  static readonly ON_SURFACE_70: string = '#B3FBEFE0';       // onSurface.opacity(0.70)
  static readonly TERTIARY_40: string = '#66F2C57C';         // tertiary.opacity(0.40)

  // Spacing
  static readonly XXS: number = 6;
  static readonly XS: number = 10;
  static readonly SM: number = 14;
  static readonly MD: number = 18;
  static readonly LG: number = 26;
  static readonly XL: number = 36;
  static readonly XXL: number = 48;
  static readonly XXXL: number = 62;

  // Corner radius
  static readonly RADIUS_SMALL: number = 10;
  static readonly RADIUS_MEDIUM: number = 18;
  static readonly RADIUS_LARGE: number = 26;
}

// ---------------------------------------------------------------------------
// MARK: - Top App Bar
// ---------------------------------------------------------------------------

@Component
struct TopAppBar {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Tokens.SURFACE_95)

      Row() {
        Circle({ width: 26, height: 26 })
          .fill(Tokens.SURFACE_VARIANT)

        Blank()

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Tokens.ON_SURFACE)

          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Tokens.ON_SURFACE_70)
        }

        Blank()

        Circle({ width: 26, height: 26 })
          .fill(Tokens.SURFACE_VARIANT)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({
        left: Tokens.LG,
        right: Tokens.LG,
        top: Tokens.MD,
        bottom: Tokens.MD
      })
    }
    .width('100%')
    .height(64)
  }
}

// ---------------------------------------------------------------------------
// MARK: - Filter Buttons
// ---------------------------------------------------------------------------

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row({ space: Tokens.XS }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Text(filter.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter.label
              ? Tokens.ON_SECONDARY
              : Tokens.ON_SURFACE)
            .padding({
              left: Tokens.SM,
              right: Tokens.SM,
              top: Tokens.XXS,
              bottom: Tokens.XXS
            })
            .backgroundColor(this.activeFilter === filter.label
              ? Tokens.SECONDARY
              : Tokens.SURFACE_VARIANT)
            .borderRadius(Tokens.RADIUS_SMALL)
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        }, (filter: HubFilter) => filter.label)
      }
      .padding({ left: Tokens.LG, right: Tokens.LG })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .align(Alignment.Start)
  }
}

// ---------------------------------------------------------------------------
// MARK: - Cargo Card
// ---------------------------------------------------------------------------

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard('', '', '');

  build() {
    Column({ space: Tokens.SM }) {
      // Image placeholder
      Stack() {
        Column()
          .width('100%')
          .height(90)
          .borderRadius(Tokens.RADIUS_SMALL)
          .backgroundColor(Tokens.SURFACE)

        Circle({ width: 60, height: 60 })
          .fill(Tokens.TERTIARY_40)
      }
      .width('100%')
      .height(90)

      Column({ space: Tokens.XXS }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.ON_SURFACE)

        Text(this.card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(Tokens.ON_SURFACE_70)

        Text(`Fill ${this.card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.SUCCESS)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Tokens.MD)
    .backgroundColor(Tokens.SURFACE_VARIANT_92)
    .borderRadius(Tokens.RADIUS_MEDIUM)
  }
}

// ---------------------------------------------------------------------------
// MARK: - Main Content View
// ---------------------------------------------------------------------------

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ];

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ];

  // Two cards per grid row; last row may hold a single card.
  private buildRows(): CargoCard[][] {
    const rows: CargoCard[][] = [];
    for (let i = 0; i < this.cards.length; i += 2) {
      const row: CargoCard[] = [];
      row.push(this.cards[i]);
      if (i + 1 < this.cards.length) {
        row.push(this.cards[i + 1]);
      }
      rows.push(row);
    }
    return rows;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        TopAppBar()

        Scroll() {
          Column({ space: Tokens.LG }) {
            // Filter buttons
            FilterButtons({
              activeFilter: $activeFilter,
              filters: this.filters
            })

            // Cargo grid section
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Tokens.ON_SURFACE)
              .padding({ left: Tokens.LG, right: Tokens.LG })

            Column({ space: Tokens.SM }) {
              ForEach(this.buildRows(), (row: CargoCard[]) => {
                Row({ space: Tokens.SM }) {
                  ForEach(row, (card: CargoCard) => {
                    CargoCardView({ card: card })
                      .layoutWeight(1)
                  }, (card: CargoCard) => card.itemId)

                  if (row.length < 2) {
                    Column()
                      .layoutWeight(1)
                  }
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
                .padding({ left: Tokens.LG, right: Tokens.LG })
              }, (row: CargoCard[]) => row[0].itemId)
            }
            .width('100%')

            // Manifest filter section
            Row() {
              Column({ space: Tokens.XS }) {
                Text('Manifest filter')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Tokens.ON_SURFACE_70)

                Text(this.activeFilter)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Tokens.ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .padding({
                left: Tokens.LG,
                right: Tokens.LG,
                top: Tokens.MD,
                bottom: Tokens.MD
              })
              .backgroundColor(Tokens.SURFACE_VARIANT_85)
              .borderRadius(Tokens.RADIUS_MEDIUM)
            }
            .width('100%')
            .padding({ left: Tokens.LG, right: Tokens.LG })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ top: Tokens.MD, bottom: Tokens.MD })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Tokens.BACKGROUND)
  }
}