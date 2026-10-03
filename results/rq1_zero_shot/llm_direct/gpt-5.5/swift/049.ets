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

const AppTokens = {
  Colors: {
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
    onSurface: '#3E2723',
    secondary30: '#4DFFB74D',
    primary30: '#4DFF7043',
    black10: '#1A000000',
    black15: '#26000000',
    black18: '#2E000000'
  },
  TypographyTokens: {
    display: {
      size: 28,
      weight: FontWeight.Bold
    },
    title: {
      size: 18,
      weight: FontWeight.Medium
    },
    body: {
      size: 14,
      weight: FontWeight.Regular
    },
    label: {
      size: 12,
      weight: FontWeight.Medium
    }
  },
  Shapes: {
    small: 8,
    medium: 14,
    large: 20
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  },
  ElevationMapping: {
    level1: {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.1,
      color: '#1A000000'
    },
    level2: {
      elevation: 6,
      radius: 8,
      dy: 4,
      opacity: 0.15,
      color: '#26000000'
    },
    level3: {
      elevation: 10,
      radius: 12,
      dy: 6,
      opacity: 0.18,
      color: '#2E000000'
    }
  },
  gridItemMinSize: 160
};

@Component
struct TripCardView {
  trip: TripCard = new TripCard(0, '', 0, '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Blank()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.trip.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Details')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .height(36)
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm / 2,
          bottom: AppTokens.Spacing.sm / 2
        })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          console.info(`Details for ${this.trip.title}`);
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: AppTokens.ElevationMapping.level2.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg
        })

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .width('100%')
        .columnsTemplate(`repeat(auto-fill, minmax(${AppTokens.gridItemMinSize}vp, 1fr))`)
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
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.secondary30, 0.0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary30, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [
      SafeAreaEdge.TOP,
      SafeAreaEdge.BOTTOM,
      SafeAreaEdge.START,
      SafeAreaEdge.END
    ])
  }
}