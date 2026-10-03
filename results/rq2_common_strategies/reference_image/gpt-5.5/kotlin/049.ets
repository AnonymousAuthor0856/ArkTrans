const NAME: string = '064*ItineraryPlanner*en';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: number = 0xFFFF7043;
  static readonly secondary: number = 0xFFFFB74D;
  static readonly tertiary: number = 0xFFFFD180;
  static readonly background: number = 0xFFFFF8F2;
  static readonly surface: number = 0xFFFFFFFF;
  static readonly surfaceVariant: number = 0xFFFFE0B2;
  static readonly outline: number = 0xFFD7CCC8;
  static readonly success: number = 0xFF43A047;
  static readonly warning: number = 0xFFFFB300;
  static readonly error: number = 0xFFE53935;
  static readonly onPrimary: number = 0xFFFFFFFF;
  static readonly onSecondary: number = 0xFF3E2723;
  static readonly onTertiary: number = 0xFF3E2723;
  static readonly onBackground: number = 0xFF3E2723;
  static readonly onSurface: number = 0xFF3E2723;
  static readonly onSurfaceMuted: number = 0xB33E2723;
  static readonly secondaryGradient: number = 0x4DFFB74D;
  static readonly primaryGradient: number = 0x4DFF7043;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 20;
}

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Component
struct TripCardView {
  trip: TripCard = {
    id: 0,
    title: '',
    days: 0,
    price: ''
  };

  build() {
    Column({ space: AppSpacing.sm }) {
      Blank()
        .width('100%')
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.medium)

      Text(this.trip.title)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ top: 6 })

      Text(`${this.trip.days} days`)
        .width('100%')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurfaceMuted)

      Row() {
        Text(this.trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button('Details')
          .height(36)
          .width(86)
          .borderRadius(AppRadius.medium)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 0, right: 0 })
          .onClick(() => {
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: 0x26000000,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Entry
@Component
struct Index {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ];

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Itinerary Planner')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .margin({ top: 20 })

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          ForEach(
            this.trips,
            (trip: TripCard) => {
              TripCardView({ trip: trip })
            },
            (trip: TripCard) => trip.id.toString()
          )
        }
        .width('100%')
        .padding({ bottom: AppSpacing.xxl })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg
    })
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondaryGradient, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primaryGradient, 1.0]
      ]
    })
  }
}