// ItineraryPlanner.ets

// Token definitions
class AppTokens {
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
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
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
}

// Data model
interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct ItineraryPlanner {
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
      // Header
      Text('Itinerary Planner')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.md })

      // Grid
      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            this.TripCardItem(trip)
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .padding({ bottom: AppTokens.Spacing.xxl })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.3],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.3]
      ]
    })
  }

  @Builder
  TripCardItem(trip: TripCard) {
    Column() {
      // Image placeholder
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ bottom: AppTokens.Spacing.sm })

      // Title
      Text(trip.title)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      // Days
      Text(`${trip.days} days`)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ bottom: AppTokens.Spacing.sm })

      // Price and button row
      Row() {
        Text(trip.price)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Details')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
  }
}