import { promptAction } from '@kit.ArkUI';

// MARK: - AppTokens
// Centralized design tokens for colors, typography, shapes, spacing and shadows.

namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF7043';
    export const secondary = '#FFB74D';
    export const tertiary = '#FFD180';
    export const background = '#FFF8F2';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#FFE0B2';
    export const outline = '#D7CCC8';
    export const success = '#43A047';
    export const warning = '#FFB300';
    export const error = '#E53935';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#3E2723';
    export const onTertiary = '#3E2723';
    export const onBackground = '#3E2723';
    export const onSurface = '#3E2723';
  }

  export namespace TypographyTokens {
    export const display: Font = { size: 28, weight: FontWeight.Bold };
    export const title: Font = { size: 18, weight: FontWeight.Medium };
    export const body: Font = { size: 14, weight: FontWeight.Regular };
    export const label: Font = { size: 12, weight: FontWeight.Medium };
  }

  export namespace Shapes {
    export const small = 8;
    export const medium = 14;
    export const large = 20;
  }

  export namespace Spacing {
    export const sm = 6;
    export const md = 10;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 36;
  }

  export class ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;

    constructor(elevation: number, radius: number, dy: number, opacity: number) {
      this.elevation = elevation;
      this.radius = radius;
      this.dy = dy;
      this.opacity = opacity;
    }
  }

  export namespace ElevationMapping {
    export const level1 = new ShadowSpec(2, 4, 2, 0.1);
    export const level2 = new ShadowSpec(6, 8, 4, 0.15);
    export const level3 = new ShadowSpec(10, 12, 6, 0.18);
  }

  export const gridItemMinSize = 160;
}

// MARK: - Data Model

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

// MARK: - TripCardView
// Component for rendering a single trip card.

@Component
struct TripCardView {
  @Prop trip: TripCard;

  build() {
    Column() {
      // Image placeholder
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium);

      Text(this.trip.title)
        .font(AppTokens.TypographyTokens.title)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm });

      Text(`${this.trip.days} days`)
        .font(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.sm });

      Row() {
        Text(this.trip.price)
          .font(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.primary);

        Blank();

        Button('Details')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .onClick(() => {
            promptAction.showToast({ message: `Details for ${this.trip.title}` });
          });
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm });
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    });
  }
}

// MARK: - RootScreen
// Main UI layout with a grid of trip cards.

@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ];

  build() {
    Column() {
      Text('Itinerary Planner')
        .font(AppTokens.TypographyTokens.display)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ top: AppTokens.Spacing.md });

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip });
            }
          }, (trip: TripCard) => trip.id.toString());
        }
        .columnsTemplate('repeat(auto-fill, minmax(160px, 1fr))')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl });
      }
      .width('100%')
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.secondary, 0.0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 1.0]
      ],
      repeating: false
    });
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct ItineraryPlannerApp {
  build() {
    RootScreen();
  }
}
