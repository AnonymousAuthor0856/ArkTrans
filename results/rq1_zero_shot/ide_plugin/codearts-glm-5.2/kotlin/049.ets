const NAME = '064*ItineraryPlanner*en'
const UI_TYPE = 'Travel'
const STYLE_THEME = 'Warm Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  }
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' },
  ]

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            TripCardItem({ trip: trip })
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .width('100%')
      .layoutWeight(1)
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .padding({ bottom: AppTokens.Spacing.xxl })
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [['#4DFFB74D', 0.0], [AppTokens.Colors.background, 0.5], ['#4DFF7043', 1.0]]
    })
  }
}

@Component
struct TripCardItem {
  private trip: TripCard = { id: 0, title: '', days: 0, price: '' }

  build() {
    Column() {
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.trip.title)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor('#B33E2723')

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Details')
          .type(ButtonType.Normal)
          .height(36)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}