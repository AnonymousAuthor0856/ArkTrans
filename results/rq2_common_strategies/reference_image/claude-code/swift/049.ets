import { common } from '@kit.AbilityKit';

// MARK: - AppTokens

class AppTokens {
  static class Colors {
    static readonly primary: Color = Color('#FFFF7043');
    static readonly secondary: Color = Color('#FFFFB74D');
    static readonly tertiary: Color = Color('#FFFFD180');
    static readonly background: Color = Color('#FFFFF8F2');
    static readonly surface: Color = Color('#FFFFFFFF');
    static readonly surfaceVariant: Color = Color('#FFFFE0B2');
    static readonly outline: Color = Color('#FFD7CCC8');
    static readonly success: Color = Color('#FF43A047');
    static readonly warning: Color = Color('#FFFFB300');
    static readonly error: Color = Color('#FFE53935');
    static readonly onPrimary: Color = Color('#FFFFFFFF');
    static readonly onSecondary: Color = Color('#FF3E2723');
    static readonly onTertiary: Color = Color('#FF3E2723');
    static readonly onBackground: Color = Color('#FF3E2723');
    static readonly onSurface: Color = Color('#FF3E2723');
  }

  static class TypographyTokens {
    static readonly displaySize: number = 28;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly titleSize: number = 18;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Normal;
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  }

  static class Shapes {
    static readonly small: Length = 8;
    static readonly medium: Length = 14;
    static readonly large: Length = 20;
  }

  static class Spacing {
    static readonly sm: Length = 6;
    static readonly md: Length = 10;
    static readonly lg: Length = 16;
    static readonly xl: Length = 24;
    static readonly xxl: Length = 36;
  }

  static class ElevationMapping {
    static readonly level2Radius: number = 8;
    static readonly level2Y: number = 4;
    static readonly level2Opacity: number = 0.15;
  }

  static readonly gridItemMinSize: number = 160;
}

// MARK: - Data Model

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

// MARK: - TripCardView

@Component
struct TripCardView {
  @Link trip: TripCard;

  build() {
    Column() {
      // Image placeholder
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium);

      Text(this.trip.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm });

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.sm });

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary);

        Blank();

        Button('Details')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .onClick(() => {
            console.info(`Details for ${this.trip.title}`);
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
      radius: AppTokens.ElevationMapping.level2Radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2Y
    });
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State trips: TripCard[] = [
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
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.md });

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip });
            }
          }, (trip: TripCard) => trip.id.toString());
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxl
        });
      }
      .width('100%')
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [
        [AppTokens.Colors.secondary, 0.0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 1.0]
      ],
      direction: GradientDirection.Bottom,
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
