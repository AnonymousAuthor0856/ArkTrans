// SupplyHub - Logistics grid (ArkTS conversion from SwiftUI)

@Entry
@Component
struct SupplyHubPage {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    { title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ];

  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland'];

  build() {
    Column() {
      // Top App Bar
      this.TopAppBar()

      // Main Scroll Content
      Scroll() {
        Column({ space: DT.Spacing.lg }) {
          // Filter Buttons
          Scroll() {
            Row({ space: DT.Spacing.xs }) {
              ForEach(this.filters, (filter: string) => {
                Text(filter)
                  .font({ size: 12, weight: DT.FontWeightMedium })
                  .fontColor(this.activeFilter === filter
                    ? DT.Colors.onSecondary
                    : DT.Colors.onSurface)
                  .padding({
                    left: DT.Spacing.sm,
                    right: DT.Spacing.sm,
                    top: DT.Spacing.xxs,
                    bottom: DT.Spacing.xxs
                  })
                  .backgroundColor(this.activeFilter === filter
                    ? DT.Colors.secondary
                    : DT.Colors.surfaceVariant)
                  .borderRadius(DT.CornerRadius.small)
                  .onClick(() => {
                    this.activeFilter = filter;
                  })
              }, (filter: string) => filter)
            }
            .padding({ left: DT.Spacing.lg, right: DT.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // Cargo Grid Section
          Text('Cargo grid')
            .font({ size: 22, weight: DT.FontWeightSemibold })
            .fontColor(DT.Colors.onSurface)
            .padding({ left: DT.Spacing.lg, right: DT.Spacing.lg })

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoCardView(card)
              }
            }, (card: CargoCard) => card.itemId)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(DT.Spacing.sm)
          .rowsGap(DT.Spacing.sm)
          .padding({ left: DT.Spacing.lg, right: DT.Spacing.lg })

          // Manifest Filter Section
          Column({ space: DT.Spacing.xs }) {
            Text('Manifest filter')
              .font({ size: 12, weight: DT.FontWeightMedium })
              .fontColor(DT.Colors.onSurface)
              .opacity(0.7)

            Text(this.activeFilter)
              .font({ size: 16, weight: DT.FontWeightMedium })
              .fontColor(DT.Colors.onSurface)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: DT.Spacing.lg,
            right: DT.Spacing.lg,
            top: DT.Spacing.md,
            bottom: DT.Spacing.md
          })
          .backgroundColor(DT.Colors.surfaceVariant)
          .opacity(0.85)
          .borderRadius(DT.CornerRadius.medium)
          .margin({ left: DT.Spacing.lg, right: DT.Spacing.lg })
        }
        .padding({ top: DT.Spacing.md, bottom: DT.Spacing.md })
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DT.Colors.background)
  }

  @Builder
  TopAppBar() {
    Row() {
      Circle({ width: 26, height: 26 })
        .fill(DT.Colors.surfaceVariant)

      Column({ space: 2 }) {
        Text('SupplyHub')
          .font({ size: 16, weight: DT.FontWeightMedium })
          .fontColor(DT.Colors.onSurface)

        Text('Logistics grid')
          .font({ size: 12, weight: DT.FontWeightMedium })
          .fontColor(DT.Colors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle({ width: 26, height: 26 })
        .fill(DT.Colors.surfaceVariant)
    }
    .width('100%')
    .height(64)
    .padding({ left: DT.Spacing.lg, right: DT.Spacing.lg })
    .backgroundColor(DT.Colors.surface)
    .opacity(0.95)
  }

  @Builder
  CargoCardView(card: CargoCard) {
    Column({ space: DT.Spacing.sm }) {
      // Image placeholder with circle overlay
      Stack() {
        RoundedRect({
          width: '100%',
          height: 90,
          radius: DT.CornerRadius.small
        })
          .fill(DT.Colors.surface)

        Circle({ width: 60, height: 60 })
          .fill(DT.Colors.tertiary)
          .opacity(0.4)
      }
      .width('100%')

      Column({ space: DT.Spacing.xxs }) {
        Text(card.title)
          .font({ size: 16, weight: DT.FontWeightMedium })
          .fontColor(DT.Colors.onSurface)

        Text(card.itemId)
          .font({ size: 14, weight: FontWeight.Regular })
          .fontColor(DT.Colors.onSurface)
          .opacity(0.7)

        Text(`Fill ${card.fill}`)
          .font({ size: 12, weight: DT.FontWeightMedium })
          .fontColor(DT.Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DT.Spacing.md)
    .width('100%')
    .backgroundColor(DT.Colors.surfaceVariant)
    .opacity(0.92)
    .borderRadius(DT.CornerRadius.medium)
  }
}

// Data Models
interface CargoCard {
  title: string;
  itemId: string;
  fill: string;
}

// Design Tokens
namespace DT {
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
    export const onSurface = '#FBEFE0';
  }

  export namespace Spacing {
    export const xxs: number = 6;
    export const xs: number = 10;
    export const sm: number = 14;
    export const md: number = 18;
    export const lg: number = 26;
    export const xl: number = 36;
    export const xxl: number = 48;
    export const xxxl: number = 62;
  }

  export namespace CornerRadius {
    export const small: number = 10;
    export const medium: number = 18;
    export const large: number = 26;
  }

  export const FontWeightMedium: number = 500;
  export const FontWeightSemibold: number = 600;
  export const FontWeightBold: number = 700;
}
