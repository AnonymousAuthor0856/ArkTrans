// AppTokens.ets
export class AppTokens {
  static Colors = {
    primary: '#FFFF7043',
    secondary: '#FFFFB74D',
    tertiary: '#FFFFD180',
    background: '#FFFFF8F2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFE0B2',
    outline: '#FFD7CCC8',
    success: '#FF43A047',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF3E2723',
    onTertiary: '#FF3E2723',
    onBackground: '#FF3E2723',
    onSurface: '#FF3E2723'
  }

  static Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static Elevation = {
    level1: { radius: 4, dy: 2, color: '#1A000000' },
    level2: { radius: 8, dy: 4, color: '#26000000' },
    level3: { radius: 12, dy: 6, color: '#2E000000' }
  }

  static gridItemMinSize: number = 160
}

export class TripCard {
  id: number
  title: string
  days: number
  price: string

  constructor(id: number, title: string, days: number, price: string) {
    this.id = id
    this.title = title
    this.days = days
    this.price = price
  }
}

@Component
export struct TripCardView {
  private trip: TripCard = new TripCard(0, '', 0, '')

  build() {
    Column() {
      // Image Placeholder
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      // Title
      Text(this.trip.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      // Days
      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.sm })

      // Price and Details Button
      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Details') {
          Text('Details')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(36)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: AppTokens.Elevation.level2.color,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    new TripCard(1, "Kyoto Cherry Trail", 4, "$460"),
    new TripCard(2, "Tokyo City Break", 3, "$390"),
    new TripCard(3, "Osaka Gourmet Tour", 5, "$520"),
    new TripCard(4, "Mount Fuji Escape", 2, "$280"),
    new TripCard(5, "Okinawa Beach Week", 6, "$740"),
    new TripCard(6, "Hokkaido Winter Lights", 5, "$680")
  ]

  build() {
    Column() {
      // Header Title
      Text("Itinerary Planner")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

      // Scrollable Grid Content
      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate(`repeat(auto-fill, minmax(${AppTokens.gridItemMinSize}, 1fr))`)
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.3],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.3]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}