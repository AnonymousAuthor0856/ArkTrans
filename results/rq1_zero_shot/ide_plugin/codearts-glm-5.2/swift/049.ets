class AppTokens {
  static readonly Colors = {
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
    onSurface: '#FF3E2723',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

class TripCard {
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
struct TripCardView {
  @Prop title: string
  @Prop days: number
  @Prop price: string

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.days} days`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor('#B33E2723')

      Row() {
        Text(this.price)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)

        Button('Details')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: 3, bottom: 3 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
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
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680'),
  ]

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Row({ space: AppTokens.Spacing.lg }) {
            TripCardView({ title: this.trips[0].title, days: this.trips[0].days, price: this.trips[0].price })
              .layoutWeight(1)
            TripCardView({ title: this.trips[1].title, days: this.trips[1].days, price: this.trips[1].price })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: AppTokens.Spacing.lg }) {
            TripCardView({ title: this.trips[2].title, days: this.trips[2].days, price: this.trips[2].price })
              .layoutWeight(1)
            TripCardView({ title: this.trips[3].title, days: this.trips[3].days, price: this.trips[3].price })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: AppTokens.Spacing.lg }) {
            TripCardView({ title: this.trips[4].title, days: this.trips[4].days, price: this.trips[4].price })
              .layoutWeight(1)
            TripCardView({ title: this.trips[5].title, days: this.trips[5].days, price: this.trips[5].price })
              .layoutWeight(1)
          }
          .width('100%')
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      angle: 180,
      colors: [['#4DFFB74D', 0.0], [AppTokens.Colors.background, 0.5], ['#4DFF7043', 1.0]]
    })
  }
}