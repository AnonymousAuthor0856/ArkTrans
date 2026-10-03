class AppColors {
  public static readonly primary: ResourceColor = 0xFFFF7043;
  public static readonly secondary: ResourceColor = 0xFFFFB74D;
  public static readonly tertiary: ResourceColor = 0xFFFFD180;
  public static readonly background: ResourceColor = 0xFFFFF8F2;
  public static readonly surface: ResourceColor = 0xFFFFFFFF;
  public static readonly surfaceVariant: ResourceColor = 0xFFFFE0B2;
  public static readonly outline: ResourceColor = 0xFFD7CCC8;
  public static readonly success: ResourceColor = 0xFF43A047;
  public static readonly warning: ResourceColor = 0xFFFFB300;
  public static readonly error: ResourceColor = 0xFFE53935;
  public static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  public static readonly onSecondary: ResourceColor = 0xFF3E2723;
  public static readonly onTertiary: ResourceColor = 0xFF3E2723;
  public static readonly onBackground: ResourceColor = 0xFF3E2723;
  public static readonly onSurface: ResourceColor = 0xFF3E2723;
  public static readonly onSurface70: ResourceColor = 0xB33E2723;
}

class AppTypography {
  public static readonly displaySize: number = 28;
  public static readonly titleSize: number = 18;
  public static readonly bodySize: number = 14;
  public static readonly labelSize: number = 12;
}

class AppShapes {
  public static readonly small: number = 8;
  public static readonly medium: number = 14;
  public static readonly large: number = 20;
}

class AppSpacing {
  public static readonly sm: number = 6;
  public static readonly md: number = 10;
  public static readonly lg: number = 16;
  public static readonly xl: number = 24;
  public static readonly xxl: number = 36;
}

class AppElevation {
  public static readonly level2Radius: number = 8;
  public static readonly level2OffsetY: number = 4;
  public static readonly level2Color: ResourceColor = 0x26000000;
}

class TripCard {
  id: number;
  title: string;
  days: number;
  price: string;

  constructor(id: number, title: string, days: number, price: string) {
    this.id = id;
    this.title = title;
    this.days = days;
    this.price = price;
  }
}

@Component
struct TripCardView {
  trip: TripCard = new TripCard(0, '', 0, '');

  build() {
    Column({ space: AppSpacing.sm }) {
      Row()
        .width('100%')
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.trip.title)
        .width('100%')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(22)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(`${this.trip.days} days`)
        .width('100%')
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface70)
        .lineHeight(20)

      Blank()
        .layoutWeight(1)

      Row() {
        Text(this.trip.price)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .lineHeight(28)

        Blank()
          .layoutWeight(1)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Details')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width(76)
        .height(36)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          console.info(`Details for ${this.trip.title}`);
        })
      }
      .width('100%')
      .height(36)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(238)
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2Radius,
      color: AppElevation.level2Color,
      offsetX: 0,
      offsetY: AppElevation.level2OffsetY
    })
  }
}

@Entry
@Component
struct ItineraryPlannerPage {
  private trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .lineHeight(38)
        .margin({ left: AppSpacing.lg, right: AppSpacing.lg, top: 8 })

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.lg)
        .rowsGap(AppSpacing.lg)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.xxl
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      angle: 180,
      colors: [
        [0x4DFFB74D, 0.0],
        [0xFFFFF8F2, 0.5],
        [0x4DFF7043, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}