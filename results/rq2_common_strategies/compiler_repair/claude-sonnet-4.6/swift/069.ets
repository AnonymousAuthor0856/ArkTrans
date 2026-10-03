class ColorTokens {
  primary: string = '#8B6B4C';
  secondary: string = '#C27D38';
  tertiary: string = '#F2C57C';
  background: string = '#10080C';
  surface: string = '#19110D';
  surfaceVariant: string = '#2A1C14';
  outline: string = '#4F3A2C';
  success: string = '#6ECE89';
  warning: string = '#E19F41';
  error: string = '#D96666';
  onPrimary: string = '#100C08';
  onSecondary: string = '#100C08';
  onTertiary: string = '#120E04';
  onBackground: string = '#F7EAD8';
  onSurface: string = '#FBEFE0';
}

const Colors: ColorTokens = new ColorTokens();

class CargoCard {
  id: number = 0;
  title: string = '';
  itemId: string = '';
  fill: string = '';

  constructor(id: number, title: string, itemId: string, fill: string) {
    this.id = id;
    this.title = title;
    this.itemId = itemId;
    this.fill = fill;
  }
}

class HubFilter {
  id: number = 0;
  label: string = '';

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

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

@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .fill(Colors.surfaceVariant)
        .width(26)
        .height(26)

      Blank()

      Column({ space: 2 }) {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#CCFBEFE0')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Circle()
        .fill(Colors.surfaceVariant)
        .width(26)
        .height(26)
    }
    .width('100%')
    .height(64)
    .padding({ left: 26, right: 26, top: 18, bottom: 18 })
    .backgroundColor(Colors.surface)
  }
}

@Component
struct FilterButtonsRow {
  @Link activeFilter: string;

  build() {
    Scroll() {
      Row({ space: 10 }) {
        ForEach(filters, (filter: HubFilter) => {
          Text(filter.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter.label ? Colors.onSecondary : Colors.onSurface)
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
            .backgroundColor(this.activeFilter === filter.label ? Colors.secondary : Colors.surfaceVariant)
            .borderRadius(10)
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        }, (filter: HubFilter) => filter.id.toString())
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
          .backgroundColor(Colors.surface)
          .borderRadius(10)

        Circle()
          .fill('#66F2C57C')
          .width(60)
          .height(60)
      }
      .width('100%')
      .height(90)
      .borderRadius(10)
      .alignContent(Alignment.Center)

      Column({ space: 6 }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .width('100%')

        Text(this.card.itemId)
          .fontSize(14)
          .fontColor('#B3FBEFE0')
          .width('100%')

        Text('Fill ' + this.card.fill)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.success)
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

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All';

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: 26 }) {
          FilterButtonsRow({ activeFilter: $activeFilter })

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
            .width('100%')
            .padding({ left: 26, right: 26 })

          Grid() {
            ForEach(cards, (card: CargoCard) => {
              GridItem() {
                CargoCardView({ card: card })
              }
            }, (card: CargoCard) => card.id.toString())
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
              .width('100%')

            Text(this.activeFilter)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')
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
    .backgroundColor(Colors.background)
  }
}