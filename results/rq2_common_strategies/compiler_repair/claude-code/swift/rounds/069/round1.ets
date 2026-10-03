// SupplyHub - Cargo Logistics Grid
// Converted from SwiftUI to ArkTS

// MARK: - Data Models

interface CargoCard {
  id: string;
  title: string;
  itemId: string;
  fill: string;
}

interface HubFilter {
  id: string;
  label: string;
}

interface FontStyle {
  size: number;
  weight: number;
}

// MARK: - Design Tokens

namespace DesignTokens {
  export namespace Colors {
    export const primary = '#8B6B4C';
    export const secondary = '#C27D38';
    export const tertiary = '#F2C57C';
    export const background = '#100C08';
    export const surface = '#19110D';
    export const surfaceVariant = '#2A1C14';
    export const outline = '#4F3A2C';
    export const success = '#6ECE89';
    export const warning = '#E19F41';
    export const error = '#D96666';
    export const onPrimary = '#100C08';
    export const onSecondary = '#100C08';
    export const onTertiary = '#120E04';
    export const onBackground = '#F7EAD8';
    export const onSurface = '#FBF0E0';
  }

  export namespace Typography {
    export const display: FontStyle = { size: 28, weight: 700 };
    export const headline: FontStyle = { size: 22, weight: 600 };
    export const title: FontStyle = { size: 16, weight: 500 };
    export const body: FontStyle = { size: 14, weight: 400 };
    export const label: FontStyle = { size: 12, weight: 500 };
  }

  export namespace Spacing {
    export const xxs = 6;
    export const xs = 10;
    export const sm = 14;
    export const md = 18;
    export const lg = 26;
    export const xl = 36;
    export const xxl = 48;
    export const xxxl = 62;
  }

  export namespace CornerRadius {
    export const small = 10;
    export const medium = 18;
    export const large = 26;
  }
}

// MARK: - Top App Bar Component

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle({ width: 26, height: 26 })
          .fill(DesignTokens.Colors.surfaceVariant)

        Blank()

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
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Blank()

        Circle({ width: 26, height: 26 })
          .fill(DesignTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
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
  @State filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row() {
        ForEach(this.filters, (filter: HubFilter) => {
          Button(filter.label) {
            this.activeFilter = filter.label;
          }
          .type(ButtonType.Normal)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(this.activeFilter === filter.label
            ? DesignTokens.Colors.onSecondary
            : DesignTokens.Colors.onSurface)
          .backgroundColor(this.activeFilter === filter.label
            ? DesignTokens.Colors.secondary
            : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.CornerRadius.small)
          .padding({
            left: DesignTokens.Spacing.sm,
            right: DesignTokens.Spacing.sm,
            top: DesignTokens.Spacing.xxs,
            bottom: DesignTokens.Spacing.xxs
          })
        }, (filter: HubFilter) => filter.id)
      }
      .width('100%')
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
  card: CargoCard = { id: '', title: '', itemId: '', fill: '' };

  build() {
    Column() {
      Stack() {
        RoundedRect({
          width: '100%',
          height: 90,
          radius: [
            DesignTokens.CornerRadius.small,
            DesignTokens.CornerRadius.small,
            DesignTokens.CornerRadius.small,
            DesignTokens.CornerRadius.small
          ]
        })
          .fill(DesignTokens.Colors.surface)

        Circle({ width: 60, height: 60 })
          .fill(DesignTokens.Colors.tertiary)
          .opacity(0.4)
      }
      .width('100%')
      .height(90)

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

        Text('Fill ' + this.card.fill)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.92)
    .borderRadius(DesignTokens.CornerRadius.medium)
  }
}

// MARK: - Main Content View

@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    { id: '1', title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { id: '2', title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { id: '3', title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { id: '4', title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { id: '5', title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { id: '6', title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ];

  private filters: HubFilter[] = [
    { id: '1', label: 'All' },
    { id: '2', label: 'Atlantic' },
    { id: '3', label: 'Pacific' },
    { id: '4', label: 'Inland' }
  ];

  build() {
    Stack() {
      Column() {
        TopAppBar()

        Scroll() {
          Column() {
            FilterButtons({ activeFilter: $activeFilter, filters: this.filters })

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
              }, (card: CargoCard) => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignTokens.Spacing.sm)
            .rowsGap(DesignTokens.Spacing.sm)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

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
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .width('100%')
            .padding({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg,
              top: DesignTokens.Spacing.md,
              bottom: DesignTokens.Spacing.md
            })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .opacity(0.85)
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
          .width('100%')
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
        }
        .scrollable(ScrollDirection.Vertical)
        .width('100%')
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}
