const NAME: string = '064*ItineraryPlanner*en';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
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

@Entry
@Component
struct MainActivity {
  private trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  @Builder
  TripItem(trip: TripCard): void {
    Column({ space: AppSpacing.sm }) {
      Rect().width('100%').height(100).fill(AppColors.surfaceVariant).radius(14);
      Text(trip.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text(`${trip.days} days`)
        .fontSize(14)
        .fontColor('#B33E2723');
      Row() {
        Text(trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Blank();
        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(14)
          .height(36);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary);
      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            this.TripItem(trip);
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .layoutWeight(1)
      .padding({ bottom: AppSpacing.xxl });
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
