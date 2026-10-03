import { LengthMetrics } from '@kit.ArkUI'

// MARK: - AppTokens
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
  },
  Typography: {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Normal,
    labelSize: 12,
    labelWeight: FontWeight.Medium,
  },
  Shapes: {
    small: 8,
    medium: 14,
    large: 20,
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  },
  Elevation: {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.15 },
    level3: { radius: 12, dy: 6, opacity: 0.18 },
  },
  gridItemMinSize: 160,
}

// MARK: - Data Model
interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

// MARK: - TripCardView
@Component
struct TripCardView {
  trip: TripCard = { id: 0, title: '', days: 0, price: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Image placeholder
      Row()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.trip.title)
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(AppTokens.Typography.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(AppTokens.Typography.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Details')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.sm / 2,
            bottom: AppTokens.Spacing.sm / 2,
          })
          .onClick(() => {
            console.log(`Details for ${this.trip.title}`)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
      radius: AppTokens.Elevation.level2.radius,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy,
    })
  }
}

// MARK: - RootScreen
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
    Column({ space: AppTokens.Spacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Scroll() {
        WaterFlow() {
          ForEach(this.trips, (trip: TripCard) => {
            FlowItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxl,
        })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [`${AppTokens.Colors.secondary}4D`, 0.0],
        [AppTokens.Colors.background, 0.5],
        [`${AppTokens.Colors.primary}4D`, 1.0],
      ],
    })
  }
}