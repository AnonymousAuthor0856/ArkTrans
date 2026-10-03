import { BusinessError } from '@kit.BasicServicesKit';

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
    onSurface: '#FBEFE0'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.SemiBold },
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
    { id: 6, title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ];

  private filters: HubFilter[] = [
    { id: 1, label: 'All' },
    { id: 2, label: 'Atlantic' },
    { id: 3, label: 'Pacific' },
    { id: 4, label: 'Inland' }
  ];

  build() {
    Stack() {
      Column() {
        // Top App Bar
        TopAppBar();

        // Main Content
        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            // Filter Buttons
            FilterButtons({
              activeFilter: this.activeFilter,
              filters: this.filters,
              onFilterChange: (label: string) => {
                this.activeFilter = label;
              }
            });

            // Cargo Grid Section
            Text('Cargo grid')
              .font({ size: DesignTokens.Typography.headline.size, weight: DesignTokens.Typography.headline.weight })
              .fontColor(DesignTokens.Colors.onSurface)
              .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg });

            LazyForEach(this.cards, (card: CargoCard) => {
              return CargoCardView({ card: card });
            }, (card: CargoCard) => {
              return card.id.toString();
            }).gridTemplateColumns('1fr 1fr')
              .gridTemplateRows('auto')
              .columnsGap(DesignTokens.Spacing.sm)
              .rowsGap(DesignTokens.Spacing.sm)
              .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg });

            // Manifest Filter Section
            Column({ space: DesignTokens.Spacing.xs }) {
              Text('Manifest filter')
                .font({ size: DesignTokens.Typography.label.size, weight: DesignTokens.Typography.label.weight })
                .fontColor(Color(DesignTokens.Colors.onSurface).opacity(0.7));

              Text(this.activeFilter)
                .font({ size: DesignTokens.Typography.title.size, weight: DesignTokens.Typography.title.weight })
                .fontColor(DesignTokens.Colors.onSurface);
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
            .backgroundColor(Color(DesignTokens.Colors.surfaceVariant).opacity(0.85))
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg });
          }
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md });
        }
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%');
    }
    .backgroundColor(DesignTokens.Colors.background)
    .systemBarProperties({ statusBarContentColor: Color.White })
  }
}

// MARK: - Subviews

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        // Navigation Icon
        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26);

        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Column({ space: 2 }) {
            Text('SupplyHub')
              .font({ size: DesignTokens.Typography.title.size, weight: DesignTokens.Typography.title.weight })
              .fontColor(DesignTokens.Colors.onSurface);

            Text('Logistics grid')
              .font({ size: DesignTokens.Typography.label.size, weight: DesignTokens.Typography.label.weight })
              .fontColor(Color(DesignTokens.Colors.onSurface).opacity(0.7));
          }
        }
        .layoutWeight(1);

        // Action Icon
        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26);
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .width('100%');
    }
    .height(64)
    .backgroundColor(Color(DesignTokens.Colors.surface).opacity(0.95));
  }
}

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[];
  onFilterChange: (label: string) => void;

  build() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button(filter.label) {
            this.activeFilter = filter.label;
            this.onFilterChange(filter.label);
          }
          .font({ size: DesignTokens.Typography.label.size, weight: DesignTokens.Typography.label.weight })
          .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
          .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.CornerRadius.small)
          .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          .borderWidth(0);
        });
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg });
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%');
  }
}

@Component
struct CargoCardView {
  card: CargoCard;

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      // Image placeholder
      Stack() {
        RoundedRectangle({ width: '100%', height: '100%' })
          .fill(DesignTokens.Colors.surface)
          .borderRadius(DesignTokens.CornerRadius.small);

        Circle()
          .fill(Color(DesignTokens.Colors.tertiary).opacity(0.4))
          .width(60)
          .height(60);
      }
      .height(90)
      .width('100%');

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.card.title)
          .font({ size: DesignTokens.Typography.title.size, weight: DesignTokens.Typography.title.weight })
          .fontColor(DesignTokens.Colors.onSurface);

        Text(this.card.itemId)
          .font({ size: DesignTokens.Typography.body.size, weight: DesignTokens.Typography.body.weight })
          .fontColor(Color(DesignTokens.Colors.onSurface).opacity(0.7));

        Text(`Fill ${this.card.fill}`)
          .font({ size: DesignTokens.Typography.label.size, weight: DesignTokens.Typography.label.weight })
          .fontColor(DesignTokens.Colors.success);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(Color(DesignTokens.Colors.surfaceVariant).opacity(0.92))
    .borderRadius(DesignTokens.CornerRadius.medium)
    .width('100%');
  }
}