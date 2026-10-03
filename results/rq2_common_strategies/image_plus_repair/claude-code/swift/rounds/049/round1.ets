// MARK: - AppTokens

class AppColors {
  static readonly primary: ResourceColor = '#FFFF7043';
  static readonly secondary: ResourceColor = '#FFFFB74D';
  static readonly tertiary: ResourceColor = '#FFFFD180';
  static readonly background: ResourceColor = '#FFFFF8F2';
  static readonly surface: ResourceColor = '#FFFFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFFFE0B2';
  static readonly outline: ResourceColor = '#FFD7CCC8';
  static readonly success: ResourceColor = '#FF43A047';
  static readonly warning: ResourceColor = '#FFFFB300';
  static readonly error: ResourceColor = '#FFE53935';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FF3E2723';
  static readonly onTertiary: ResourceColor = '#FF3E2723';
  static readonly onBackground: ResourceColor = '#FF3E2723';
  static readonly onSurface: ResourceColor = '#FF3E2723';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: Length = 8;
  static readonly medium: Length = 14;
  static readonly large: Length = 20;
}

class AppSpacing {
  static readonly sm: Length = 6;
  static readonly md: Length = 10;
  static readonly lg: Length = 16;
  static readonly xl: Length = 24;
  static readonly xxl: Length = 36;
}

class AppElevation {
  static readonly level2Radius: number = 8;
  static readonly level2Y: number = 4;
  static readonly level2Opacity: number = 0.15;
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
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium);

      Text(this.trip.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm });

      Text(`${this.trip.days} days`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
        .margin({ top: AppSpacing.sm });

      Row() {
        Text(this.trip.price)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary);

        Blank();

        Button('Details')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(36)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .onClick(() => {
            console.info(`Details for ${this.trip.title}`);
          });
      }
      .width('100%')
      .margin({ top: AppSpacing.sm });
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2Radius,
      color: `rgba(0, 0, 0, ${AppElevation.level2Opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level2Y
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
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.primary)
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .margin({ top: AppSpacing.xl, bottom: AppSpacing.md });

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip });
            }
          }, (trip: TripCard) => trip.id.toString());
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.lg)
        .rowsGap(AppSpacing.lg)
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.xxl
        });
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [
        ['#FFE8C7', 0.0],
        ['#FFFFF8F2', 0.5],
        ['#FFE4D1', 1.0]
      ],
      direction: GradientDirection.Bottom
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
