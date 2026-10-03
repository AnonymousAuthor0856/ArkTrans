// Data Models
class CargoCard {
  id: number;
  title: string;
  itemId: string;
  fill: string;

  constructor(id: number, title: string, itemId: string, fill: string) {
    this.id = id;
    this.title = title;
    this.itemId = itemId;
    this.fill = fill;
  }
}

class HubFilter {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

// Design Tokens - Colors as constants
const COLOR_PRIMARY: string = '#8B6B4C';
const COLOR_SECONDARY: string = '#C27D38';
const COLOR_TERTIARY: string = '#F2C57C';
const COLOR_BACKGROUND: string = '#10080C';
const COLOR_SURFACE: string = '#19110D';
const COLOR_SURFACE_VARIANT: string = '#2A1C14';
const COLOR_OUTLINE: string = '#4F3A2C';
const COLOR_SUCCESS: string = '#6ECE89';
const COLOR_WARNING: string = '#E19F41';
const COLOR_ERROR: string = '#D96666';
const COLOR_ON_PRIMARY: string = '#100C08';
const COLOR_ON_SECONDARY: string = '#100C08';
const COLOR_ON_TERTIARY: string = '#120E04';
const COLOR_ON_BACKGROUND: string = '#F7EAD8';
const COLOR_ON_SURFACE: string = '#FBEFE0';

const cards: CargoCard[] = [
  new CargoCard(1, 'Copper stack', 'SH-014', '78%'),
  new CargoCard(2, 'Fiber reels', 'SH-022', '64%'),
  new CargoCard(3, 'Agro crates', 'SH-031', '92%'),
  new CargoCard(4, 'Glass kits', 'SH-045', '51%'),
  new CargoCard(5, 'Steel mesh', 'SH-057', '88%'),
  new CargoCard(6, 'Raw silica', 'SH-063', '43%'),
];

const filters: HubFilter[] = [
  new HubFilter(1, 'All'),
  new HubFilter(2, 'Atlantic'),
  new HubFilter(3, 'Pacific'),
  new HubFilter(4, 'Inland'),
];

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All';

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: 26 }) {
          FilterButtons({
            activeFilter: $activeFilter,
            filters: filters
          })

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')
            .padding({ left: 26, right: 26 })

          Grid() {
            ForEach(cards, (card: CargoCard) => {
              GridItem() {
                CargoCardView({ card: card })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(14)
          .rowsGap(14)
          .padding({ left: 26, right: 26 })
          .width('100%')

          Column({ space: 10 }) {
            Text('Manifest filter')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#B3FBEFE0')

            Text(this.activeFilter)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 26, right: 26, top: 18, bottom: 18 })
          .backgroundColor('#D92A1C14')
          .borderRadius(18)
          .margin({ left: 26, right: 26 })
        }
        .padding({ top: 18, bottom: 18 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}

@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .width(26)
        .height(26)
        .fill(COLOR_SURFACE_VARIANT)

      Blank()

      Column({ space: 2 }) {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3FBEFE0')
      }

      Blank()

      Circle()
        .width(26)
        .height(26)
        .fill(COLOR_SURFACE_VARIANT)
    }
    .width('100%')
    .height(64)
    .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    .backgroundColor('#F219110D')
  }
}

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Text(filter.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter.label ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
            .backgroundColor(this.activeFilter === filter.label ? COLOR_SECONDARY : COLOR_SURFACE_VARIANT)
            .borderRadius(10)
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        })
      }
      .padding({ left: 26, right: 26 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard(0, '', '', '');

  build() {
    Column({ space: 14 }) {
      Stack() {
        Column()
          .width('100%')
          .height(90)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(10)

        Circle()
          .width(60)
          .height(60)
          .fill('#66F2C57C')
      }
      .width('100%')
      .height(90)

      Column({ space: 6 }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .width('100%')

        Text(this.card.itemId)
          .fontSize(14)
          .fontColor('#B3FBEFE0')
          .width('100%')

        Text(`Fill ${this.card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SUCCESS)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(18)
    .backgroundColor('#EB2A1C14')
    .borderRadius(18)
    .width('100%')
  }
}