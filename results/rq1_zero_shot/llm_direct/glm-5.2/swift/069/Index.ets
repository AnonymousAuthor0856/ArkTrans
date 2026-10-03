// Code converted to ArkTS
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

// MARK: - Data Models

class CargoCard {
  id: string = generateId();
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
  id: string = generateId();
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

function generateId(): string {
  return Math.random().toString(36).substring(2) + Date.now().toString(36);
}

// MARK: - Design Tokens

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
    onSurface: '#FBEFE0'
  };

  static Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Spacing = {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62
  };

  static CornerRadius = {
    small: 10,
    medium: 18,
    large: 26
  };
}

// MARK: - Main Content View

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

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background)

      Column() {
        // Top App Bar
        TopAppBar()

        // Main Content
        Scroll() {
          Column() {
            // Filter Buttons
            FilterButtons({ activeFilter: this.activeFilter, filters: this.filters })

            // Cargo Grid Section
            Text('Cargo grid')
              .fontSize(DesignTokens.Typography.headline.size)
              .fontWeight(DesignTokens.Typography.headline.weight)
              .fontColor(DesignTokens.Colors.onSurface)
              .margin({ top: DesignTokens.Spacing.lg, bottom: DesignTokens.Spacing.sm })
              .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

            // Cargo Grid
            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  CargoCardView({ card: card })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignTokens.Spacing.sm)
            .rowsGap(DesignTokens.Spacing.sm)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

            // Manifest Filter Section
            Column() {
              Text('Manifest filter')
                .fontSize(DesignTokens.Typography.label.size)
                .fontWeight(DesignTokens.Typography.label.weight)
                .fontColor(DesignTokens.Colors.onSurface)
                .opacity(0.7)

              Text(this.activeFilter)
                .fontSize(DesignTokens.Typography.title.size)
                .fontWeight(DesignTokens.Typography.title.weight)
                .fontColor(DesignTokens.Colors.onSurface)
                .margin({ top: DesignTokens.Spacing.xxs })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .opacity(0.85)
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ top: DesignTokens.Spacing.lg, left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, bottom: DesignTokens.Spacing.lg })
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Subviews

@Component
struct TopAppBar {
  build() {
    Row() {
      // Navigation Icon
      Circle({ width: 26, height: 26 })
        .fillColor(DesignTokens.Colors.surfaceVariant)

      Blank()

      // Title
      Column() {
        Text('SupplyHub')
          .fontSize(DesignTokens.Typography.title.size)
          .fontWeight(DesignTokens.Typography.title.weight)
          .fontColor(DesignTokens.Colors.onSurface)

        Text('Logistics grid')
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .margin({ top: 2 })
      }

      Blank()

      // Action Icon
      Circle({ width: 26, height: 26 })
        .fillColor(DesignTokens.Colors.surfaceVariant)
    }
    .width('100%')
    .height(64)
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    .backgroundColor(DesignTokens.Colors.surface)
    .opacity(0.95)
  }
}

@Component
struct FilterButtons {
  @Prop activeFilter: string;
  private filters: HubFilter[];

  build() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button({ type: ButtonType.Normal }) {
            Text(filter.label)
              .fontSize(DesignTokens.Typography.label.size)
              .fontWeight(DesignTokens.Typography.label.weight)
              .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
              .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          }
          .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.CornerRadius.small)
          .onClick(() => {
            this.activeFilter = filter.label;
          })
        })
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CargoCardView {
  private card: CargoCard;

  build() {
    Column() {
      // Image placeholder
      Stack() {
        Circle({ width: 60, height: 60 })
          .fillColor(DesignTokens.Colors.tertiary)
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      .backgroundColor(DesignTokens.Colors.surface)
      .borderRadius(DesignTokens.CornerRadius.small)

      // Text Content
      Column() {
        Text(this.card.title)
          .fontSize(DesignTokens.Typography.title.size)
          .fontWeight(DesignTokens.Typography.title.weight)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.card.itemId)
          .fontSize(DesignTokens.Typography.body.size)
          .fontWeight(DesignTokens.Typography.body.weight)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .margin({ top: DesignTokens.Spacing.xxs })

        Text(`Fill ${this.card.fill}`)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.success)
          .margin({ top: DesignTokens.Spacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: DesignTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.92)
    .borderRadius(DesignTokens.CornerRadius.medium)
  }
}