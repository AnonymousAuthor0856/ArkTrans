class DesignColors {
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

class DesignSpacing {
  static xxs: number = 6;
  static xs: number = 10;
  static sm: number = 14;
  static md: number = 18;
  static lg: number = 26;
  static xl: number = 36;
  static xxl: number = 48;
  static xxxl: number = 62;
}

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

@Entry
@Component
struct ContentView {
  @State private activeFilter: string = 'All';
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

  @Builder
  private TopAppBar() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#19110DF2')
      Row() {
        Circle()
          .width(26)
          .height(26)
          .fill(DesignColors.surfaceVariant)
        Blank()
        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSurface)
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0B3')
        }
        Blank()
        Circle()
          .width(26)
          .height(26)
          .fill(DesignColors.surfaceVariant)
      }
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
      .width('100%')
    }
    .height(64)
    .width('100%')
  }

  @Builder
  private FilterButton(filter: HubFilter) {
    Text(filter.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === filter.label ? DesignColors.onSecondary : DesignColors.onSurface)
      .padding({ left: DesignSpacing.sm, right: DesignSpacing.sm, top: DesignSpacing.xxs, bottom: DesignSpacing.xxs })
      .backgroundColor(this.activeFilter === filter.label ? DesignColors.secondary : DesignColors.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.activeFilter = filter.label;
      })
  }

  @Builder
  private FilterButtons() {
    Scroll() {
      Row({ space: DesignSpacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          this.FilterButton(filter)
        })
      }
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  private CargoCardView(card: CargoCard) {
    Column({ space: DesignSpacing.sm }) {
      Stack() {
        Rect()
          .width('100%')
          .height(90)
          .fill(DesignColors.surface)
          .radius(10)
        Circle()
          .width(60)
          .height(60)
          .fill('#F2C57C66')
      }
      .width('100%')
      .height(90)

      Column({ space: DesignSpacing.xxs }) {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSurface)
        Text(card.itemId)
          .fontSize(14)
          .fontColor('#FBEFE0B3')
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DesignSpacing.md)
    .width('100%')
    .backgroundColor('#2A1C14EB')
    .borderRadius(18)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopAppBar()

        Scroll() {
          Column({ space: DesignSpacing.lg }) {
            this.FilterButtons()

            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(DesignColors.onSurface)
              .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
              .width('100%')
              .textAlign(TextAlign.Start)

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  this.CargoCardView(card)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignSpacing.sm)
            .rowsGap(DesignSpacing.sm)
            .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
            .width('100%')

            Column({ space: DesignSpacing.xs }) {
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FBEFE0B3')
              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignColors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
            .width('100%')
            .backgroundColor('#2A1C14D9')
            .borderRadius(18)
            .margin({ left: DesignSpacing.lg, right: DesignSpacing.lg })
          }
          .padding({ top: DesignSpacing.md, bottom: DesignSpacing.md })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}
