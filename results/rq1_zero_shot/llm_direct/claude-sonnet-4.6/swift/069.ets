import { router } from '@kit.ArkUI';

// MARK: - Data Models

interface CargoCard {
  id: number;
  title: string;
  itemId: string;
  fill: string;
}

interface HubFilter {
  id: number;
  label: string;
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
    onSurface: '#FBEFE0',
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  },
  Spacing: {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62,
  },
  CornerRadius: {
    small: 10,
    medium: 18,
    large: 26,
  },
};

// MARK: - Top App Bar Component

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26)

        Blank()

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(DesignTokens.Typography.title.size)
            .fontWeight(DesignTokens.Typography.title.weight)
            .fontColor(DesignTokens.Colors.onSurface)

          Text('Logistics grid')
            .fontSize(DesignTokens.Typography.label.size)
            .fontWeight(DesignTokens.Typography.label.weight)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
        }

        Blank()

        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26)
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md,
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(DesignTokens.Colors.surface)
    .opacity(0.95)
  }
}

// MARK: - Filter Buttons Component

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Text(filter.label)
            .fontSize(DesignTokens.Typography.label.size)
            .fontWeight(DesignTokens.Typography.label.weight)
            .fontColor(
              this.activeFilter === filter.label
                ? DesignTokens.Colors.onSecondary
                : DesignTokens.Colors.onSurface
            )
            .padding({
              left: DesignTokens.Spacing.sm,
              right: DesignTokens.Spacing.sm,
              top: DesignTokens.Spacing.xxs,
              bottom: DesignTokens.Spacing.xxs,
            })
            .backgroundColor(
              this.activeFilter === filter.label
                ? DesignTokens.Colors.secondary
                : DesignTokens.Colors.surfaceVariant
            )
            .borderRadius(DesignTokens.CornerRadius.small)
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        }, (filter: HubFilter) => filter.id.toString())
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

// MARK: - Cargo Card View Component

@Component
struct CargoCardView {
  card: CargoCard = { id: 0, title: '', itemId: '', fill: '' };

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      Stack() {
        RoundedRect()
          .radiusWidth(DesignTokens.CornerRadius.small)
          .radiusHeight(DesignTokens.CornerRadius.small)
          .fill(DesignTokens.Colors.surface)
          .width('100%')
          .height(90)

        Circle()
          .fill(DesignTokens.Colors.tertiary)
          .opacity(0.4)
          .width(60)
          .height(60)
      }
      .width('100%')
      .height(90)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.card.title)
          .fontSize(DesignTokens.Typography.title.size)
          .fontWeight(DesignTokens.Typography.title.weight)
          .fontColor(DesignTokens.Colors.onSurface)
          .width('100%')

        Text(this.card.itemId)
          .fontSize(DesignTokens.Typography.body.size)
          .fontWeight(DesignTokens.Typography.body.weight)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .width('100%')

        Text(`Fill ${this.card.fill}`)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.success)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.92)
    .borderRadius(DesignTokens.CornerRadius.medium)
    .width('100%')
  }
}

// MARK: - Main Content View

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    { id: 1, title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { id: 2, title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { id: 3, title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { id: 4, title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { id: 5, title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { id: 6, title: 'Raw silica', itemId: 'SH-063', fill: '43%' },
  ];

  private filters: HubFilter[] = [
    { id: 1, label: 'All' },
    { id: 2, label: 'Atlantic' },
    { id: 3, label: 'Pacific' },
    { id: 4, label: 'Inland' },
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        TopAppBar()

        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            FilterButtons({
              activeFilter: $activeFilter,
              filters: this.filters,
            })

            Text('Cargo grid')
              .fontSize(DesignTokens.Typography.headline.size)
              .fontWeight(DesignTokens.Typography.headline.weight)
              .fontColor(DesignTokens.Colors.onSurface)
              .width('100%')
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
            .width('100%')

            Column({ space: DesignTokens.Spacing.xs }) {
              Text('Manifest filter')
                .fontSize(DesignTokens.Typography.label.size)
                .fontWeight(DesignTokens.Typography.label.weight)
                .fontColor(DesignTokens.Colors.onSurface)
                .opacity(0.7)
                .width('100%')

              Text(this.activeFilter)
                .fontSize(DesignTokens.Typography.title.size)
                .fontWeight(DesignTokens.Typography.title.weight)
                .fontColor(DesignTokens.Colors.onSurface)
                .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg,
              top: DesignTokens.Spacing.md,
              bottom: DesignTokens.Spacing.md,
            })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .opacity(0.85)
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
          }
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}