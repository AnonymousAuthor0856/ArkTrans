import window from '@ohos.window';
import common from '@ohos.app.ability.common';

const NAME: string = '064*ItineraryPlanner*en';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: ResourceColor = 0xFFFF7043;
  static readonly secondary: ResourceColor = 0xFFFFB74D;
  static readonly tertiary: ResourceColor = 0xFFFFD180;
  static readonly background: ResourceColor = 0xFFFFF8F2;
  static readonly surface: ResourceColor = 0xFFFFFFFF;
  static readonly surfaceVariant: ResourceColor = 0xFFFFE0B2;
  static readonly outline: ResourceColor = 0xFFD7CCC8;
  static readonly success: ResourceColor = 0xFF43A047;
  static readonly warning: ResourceColor = 0xFFFFB300;
  static readonly error: ResourceColor = 0xFFE53935;
  static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  static readonly onSecondary: ResourceColor = 0xFF3E2723;
  static readonly onTertiary: ResourceColor = 0xFF3E2723;
  static readonly onBackground: ResourceColor = 0xFF3E2723;
  static readonly onSurface: ResourceColor = 0xFF3E2723;
  static readonly onSurface70: ResourceColor = 0xB33E2723;
  static readonly secondary30: ResourceColor = 0x4DFFB74D;
  static readonly primary30: ResourceColor = 0x4DFF7043;
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
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
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

class TripCardModel {
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
struct MainPage {
  private trips: TripCardModel[] = [
    new TripCardModel(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCardModel(2, 'Tokyo City Break', 3, '$390'),
    new TripCardModel(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCardModel(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCardModel(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCardModel(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  aboutToAppear(): void {
    this.hideSystemBars();
  }

  onPageShow(): void {
    this.hideSystemBars();
  }

  private hideSystemBars(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  @Builder
  private TripCardView(trip: TripCardModel) {
    Column({ space: AppSpacing.sm }) {
      Stack() {
      }
      .width('100%')
      .height(100)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      Text(trip.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Text(`${trip.days} days`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface70)
        .width('100%')

      Row() {
        Text(trip.price)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Details')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .height(36)
        .padding({ left: 12, right: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2.radius,
      color: 0x26000000,
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')

      Grid() {
        ForEach(this.trips, (trip: TripCardModel) => {
          GridItem() {
            this.TripCardView(trip)
          }
        }, (trip: TripCardModel) => trip.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .padding({ bottom: AppSpacing.xxl })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondary30, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primary30, 1.0]
      ]
    })
  }
}