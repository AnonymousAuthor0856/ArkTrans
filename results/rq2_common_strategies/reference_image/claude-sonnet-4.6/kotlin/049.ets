/**
 * 064*ItineraryPlanner*en  |  Travel  |  Warm Gradient  |  en  |  720x1280
 * ArkTS / ArkUI port of the Jetpack Compose "Itinerary Planner" screen.
 */

const NAME: string = '064*ItineraryPlanner*en';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------------------------------------------ */
/*  Design tokens                                                      */
/* ------------------------------------------------------------------ */

class AppColors {
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly tertiary: string = '#FFD180';
  static readonly background: string = '#FFF8F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE0B2';
  static readonly outline: string = '#D7CCC8';
  static readonly success: string = '#43A047';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onTertiary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';

  /* pre-blended alphas used by the layout */
  static readonly secondaryA30: string = '#4DFFB74D';
  static readonly primaryA30: string = '#4DFF7043';
  static readonly onSurfaceA70: string = '#B33E2723';
}

class TextStyleToken {
  fontSize: number;
  fontWeight: FontWeight;

  constructor(fontSize: number, fontWeight: FontWeight) {
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
  }
}

class AppTypography {
  static readonly display: TextStyleToken = new TextStyleToken(28, FontWeight.Bold);
  static readonly title: TextStyleToken = new TextStyleToken(18, FontWeight.Medium);
  static readonly body: TextStyleToken = new TextStyleToken(14, FontWeight.Normal);
  static readonly label: TextStyleToken = new TextStyleToken(12, FontWeight.Medium);
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class ShadowSpec {
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

  /* '#AARRGGBB' shadow colour built from the opacity token */
  color(): string {
    const a: number = Math.round(this.opacity * 255);
    return '#' + a.toString(16).padStart(2, '0').toUpperCase() + '000000';
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

/* ------------------------------------------------------------------ */
/*  Model                                                              */
/* ------------------------------------------------------------------ */

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

/* ------------------------------------------------------------------ */
/*  Screen                                                             */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct ItineraryPlanner {
  @State trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(AppTypography.display.fontSize)
        .fontWeight(AppTypography.display.fontWeight)
        .fontColor(AppColors.primary)
        .margin({ bottom: AppSpacing.md })

      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            this.TripCardView(trip)
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .margin({ bottom: AppSpacing.xxl })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondaryA30, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primaryA30, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  /* -------------------------- card -------------------------- */

  @Builder
  TripCardView(trip: TripCard) {
    Column({ space: AppSpacing.sm }) {
      /* image placeholder */
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(trip.title)
        .fontSize(AppTypography.title.fontSize)
        .fontWeight(AppTypography.title.fontWeight)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(`${trip.days} days`)
        .fontSize(AppTypography.body.fontSize)
        .fontWeight(AppTypography.body.fontWeight)
        .fontColor(AppColors.onSurfaceA70)

      Row() {
        Text(trip.price)
          .fontSize(AppTypography.title.fontSize)
          .fontWeight(AppTypography.title.fontWeight)
          .fontColor(AppColors.primary)

        Button('Details', { type: ButtonType.Normal, stateEffect: true })
          .height(36)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(AppTypography.label.fontSize)
          .fontWeight(AppTypography.label.fontWeight)
          .borderRadius(AppShapes.medium)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .onClick(() => {
            /* navigate to the trip detail page */
          })
      }
      .width('100%')
      .height(36)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .alignItems(HorizontalAlign.Start)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: ElevationMapping.level2.color(),
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }
}