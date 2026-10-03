// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    tertiary: '#FFD180',
    background: '#FFF8F2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    outline: '#D7CCC8',
    success: '#43A047',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onTertiary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.15 },
    level3: { radius: 12, dy: 6, opacity: 0.18 }
  };

  static readonly gridItemMinSize = 160;
}

// TripCard.ets
export class TripCard {
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

// TripCardView.ets
import { AppTokens } from './AppTokens';
import { TripCard } from './TripCard';

@Component
export struct TripCardView {
  @Prop trip: TripCard;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Image placeholder
      Row()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      // Title
      Text(this.trip.title)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      // Days
      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor('#3E2723B3') // onSurface with 70% opacity

      // Price and Details button
      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Details')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm / 2, bottom: AppTokens.Spacing.sm / 2 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .onClick(() => {
            console.info(`Details for ${this.trip.title}`);
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy
    })
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { TripCard } from './TripCard';
import { TripCardView } from './TripCardView';

@Component
export struct RootScreen {
  @State trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      // Title
      Text('Itinerary Planner')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Scrollable grid
      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          })
        }
        .columnsTemplate(`repeat(auto-fill, minmax(${AppTokens.gridItemMinSize}px, 1fr))`)
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxl
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
        ['#FFB74D4D', 0], // secondary with 30% opacity
        [AppTokens.Colors.background, 0.5],
        ['#FF70434D', 1]  // primary with 30% opacity
      ]
    })
  }
}

// Entry.ets
import { RootScreen } from './RootScreen';

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}