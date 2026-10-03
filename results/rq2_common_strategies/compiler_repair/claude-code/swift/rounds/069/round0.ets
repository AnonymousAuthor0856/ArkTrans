// SupplyHub - Cargo Logistics Grid
// Converted from SwiftUI to ArkTS

import { Font, FontWeight, ResourceColor } from '@kit.ArkUI';

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

// MARK: - Design Tokens

class DesignTokens {
  static Colors = class {
    static primary: ResourceColor = '#8B6B4C';
    static secondary: ResourceColor = '#C27D38';
    static tertiary: ResourceColor = '#F2C57C';
    static background: ResourceColor = '#100C08';
    static surface: ResourceColor = '#19110D';
    static surfaceVariant: ResourceColor = '#2A1C14';
    static outline: ResourceColor = '#4F3A2C';
    static success: ResourceColor = '#6ECE89';
    static warning: ResourceColor = '#E19F41';
    static error: ResourceColor = '#D96666';
    static onPrimary: ResourceColor = '#100C08';
    static onSecondary: ResourceColor = '#100C08';
    static onTertiary: ResourceColor = '#120E04';
    static onBackground: ResourceColor = '#F7EAD8';
    static onSurface: ResourceColor = '#FBF0E0';
  };

  static Typography = class {
    static display = { size: 28, weight: FontWeight.Bold };
    static headline = { size: 22, weight: FontWeight.SemiBold };
    static title = { size: 16, weight: FontWeight.Medium };
    static body = { size: 14, weight: FontWeight.Regular };
    static label = { size: 12, weight: FontWeight.Medium };
  };

  static Spacing = class {
    static xxs: number = 6;
    static xs: number = 10;
    static sm: number = 14;
    static md: number = 18;
    static lg: number = 26;
    static xl: number = 36;
    static xxl: number = 48;
    static xxxl: number = 62;
  };

  static CornerRadius = class {
    static small: number = 10;
    static medium: number = 18;
    static large: number = 26;
  };
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
        .space(2)
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
      .space(DesignTokens.Spacing.xs)
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
        RoundRect({ width: '100%', height: 90, radius: DesignTokens.CornerRadius.small })
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
      .space(DesignTokens.Spacing.xxs)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .space(DesignTokens.Spacing.sm)
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
            .space(DesignTokens.Spacing.xs)
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
          .space(DesignTokens.Spacing.lg)
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
          .width('100%')
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
