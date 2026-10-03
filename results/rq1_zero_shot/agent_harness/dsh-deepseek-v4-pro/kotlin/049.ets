const Colors = {
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
}

const Shapes = {
  small: 8,
  medium: 14,
  large: 20
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
  xxl: 36
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

@Entry
@Component
struct Index {
  @State trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ]

  build() {
    Scroll() {
      Column({ space: Spacing.md }) {
        Text('Itinerary Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)

        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            Column({ space: Spacing.sm }) {
              Row()
                .width('100%')
                .height(100)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
              Text(trip.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(trip.days + ' days')
                .fontSize(14)
                .fontColor('#B33E2723')
              Row() {
                Text(trip.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.primary)
                Button('Details', { type: ButtonType.Normal })
                  .height(36)
                  .borderRadius(Shapes.medium)
                  .backgroundColor(Colors.primary)
                  .fontColor(Colors.onPrimary)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .onClick(() => {})
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.large)
            .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.lg)
        .rowsGap(Spacing.lg)
        .width('100%')
      }
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4DFFB74D', 0.0], ['#FFF8F2', 0.5], ['#4DFF7043', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
