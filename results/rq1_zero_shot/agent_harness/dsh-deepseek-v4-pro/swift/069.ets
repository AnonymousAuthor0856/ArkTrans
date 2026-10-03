// MARK: - Data Models
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

// MARK: - Design Tokens
const DesignTokens = {
  Colors: {
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
    onSurface: '#FBEFE0'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Spacing: {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62
  },
  CornerRadius: {
    small: 10,
    medium: 18,
    large: 26
  }
};

// MARK: - ContentView
@Component
struct ContentView {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    new CargoCard(1, 'Copper stack', 'SH-014', '78%'),
    new CargoCard(2, 'Fiber reels', 'SH-022', '64%'),
    new CargoCard(3, 'Agro crates', 'SH-031', '92%'),
    new CargoCard(4, 'Glass kits', 'SH-045', '51%'),
    new CargoCard(5, 'Steel mesh', 'SH-057', '88%'),
    new CargoCard(6, 'Raw silica', 'SH-063', '43%')
  ];

  private filters: HubFilter[] = [
    new HubFilter(1, 'All'),
    new HubFilter(2, 'Atlantic'),
    new HubFilter(3, 'Pacific'),
    new HubFilter(4, 'Inland')
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        TopAppBar()

        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            // Filter Buttons
            FilterButtons({ activeFilter: $activeFilter, filters: this.filters })

            // Cargo Grid Section
            Text('Cargo grid')
              .fontSize(DesignTokens.Typography.headline.size)
              .fontWeight(DesignTokens.Typography.headline.weight)
              .fontColor(DesignTokens.Colors.onSurface)
              .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  CargoCardView({ card: card })
                }
              }, (card: CargoCard) => card.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignTokens.Spacing.sm)
            .rowsGap(DesignTokens.Spacing.sm)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

            // Manifest Filter Section
            Column({ space: DesignTokens.Spacing.xs }) {
              Text('Manifest filter')
                .fontSize(DesignTokens.Typography.label.size)
                .fontWeight(DesignTokens.Typography.label.weight)
                .fontColor('#B3FBEFE0')
              Text(this.activeFilter)
                .fontSize(DesignTokens.Typography.title.size)
                .fontWeight(DesignTokens.Typography.title.weight)
                .fontColor(DesignTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
            .backgroundColor('#D92A1C14')
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
          }
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Row()
          .width(26)
          .height(26)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(13)

        Blank()

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(DesignTokens.Typography.title.size)
            .fontWeight(DesignTokens.Typography.title.weight)
            .fontColor(DesignTokens.Colors.onSurface)
          Text('Logistics grid')
            .fontSize(DesignTokens.Typography.label.size)
            .fontWeight(DesignTokens.Typography.label.weight)
            .fontColor('#B3FBEFE0')
        }

        Blank()

        Row()
          .width(26)
          .height(26)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(13)
      }
      .alignItems(VerticalAlign.Center)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#F219110D')
  }
}

// MARK: - Filter Buttons
@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button() {
            Text(filter.label)
              .fontSize(DesignTokens.Typography.label.size)
              .fontWeight(DesignTokens.Typography.label.weight)
              .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
              .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
              .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
              .borderRadius(DesignTokens.CornerRadius.small)
          }
          .onClick(() => {
            this.activeFilter = filter.label;
          })
        }, (filter: HubFilter) => filter.id.toString())
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

// MARK: - Cargo Card View
@Component
struct CargoCardView {
  @Prop card: CargoCard = new CargoCard(0, '', '', '');

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      // Image placeholder
      Stack() {
        Row()
          .width('100%')
          .height(90)
          .backgroundColor(DesignTokens.Colors.surface)
          .borderRadius(DesignTokens.CornerRadius.small)

        Row()
          .width(60)
          .height(60)
          .backgroundColor('#66F2C57C')
          .borderRadius(30)
      }

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.card.title)
          .fontSize(DesignTokens.Typography.title.size)
          .fontWeight(DesignTokens.Typography.title.weight)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.card.itemId)
          .fontSize(DesignTokens.Typography.body.size)
          .fontWeight(DesignTokens.Typography.body.weight)
          .fontColor('#B3FBEFE0')
        Text('Fill ' + this.card.fill)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor('#EB2A1C14')
    .borderRadius(DesignTokens.CornerRadius.medium)
  }
}

// MARK: - SupplyHubApp
@Entry
@Component
struct SupplyHubApp {
  build() {
    ContentView()
  }
}
