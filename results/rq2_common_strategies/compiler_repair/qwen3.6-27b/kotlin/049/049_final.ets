import { router } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface AppTokensColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokensTypography {
  display: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface AppTokensShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
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
    onSurface: '#3E2723'
  } as AppTokensColors,
  Typography: {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  } as AppTokensTypography,
  Shapes: {
    small: 8, // vp
    medium: 14, // vp
    large: 20 // vp
  } as AppTokensShapes,
  Spacing: {
    sm: 6, // vp
    md: 10, // vp
    lg: 16, // vp
    xl: 24, // vp
    xxl: 36 // vp
  } as AppTokensSpacing
}

interface TripCardData {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct ItineraryPlanner {
  @State trips: TripCardData[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ];

  build() {
    Column() {
      // Header
      Text("Itinerary Planner")
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.md })

      // Grid List
      LazyForEach(this.trips, (trip: TripCardData) => {
        this.TripItem(trip)
      }, (trip: TripCardData) => trip.id.toString())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.3],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.3]
      ]
    })
  }

  @Builder
  TripItem(trip: TripCardData) {
    Column() {
      // Image Placeholder
      Row()
        .width('100%')
        .height(100)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      Text(trip.title)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(`${trip.days} days`)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
        .margin({ top: 2 })

      Row() {
        Text(trip.price)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button("Details")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .height(36)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .onClick(() => {
            // Handle details click
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}