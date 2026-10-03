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

class AppColors {
  static readonly primary: string = '#FF7043'
  static readonly secondary: string = '#FFB74D'
  static readonly background: string = '#FFF8F2'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFE0B2'
  static readonly onSurface: string = '#3E2723'
  static readonly bodyMuted: string = '#7A6662'
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
  ]

  @Builder
  TripItem(trip: TripCard) {
    Column() {
      Blank()
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(26)

      Text(trip.title)
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(42)
        .width('100%')
        .margin({ top: 12 })

      Text(`${trip.days} days`)
        .fontSize(28)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.bodyMuted)
        .lineHeight(36)
        .width('100%')
        .margin({ top: 10 })

      Row() {
        Text(trip.price)
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .lineHeight(42)

        Button('Details')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor(AppColors.primary)
          .borderRadius(26)
          .width(170)
          .height(72)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20, bottom: 19 })
    .backgroundColor(AppColors.surface)
    .borderRadius(34)
    .shadow({
      radius: 20,
      color: '#33000000',
      offsetX: 0,
      offsetY: 8
    })
  }

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .lineHeight(70)
        .width('100%')
        .margin({ top: 35, bottom: 20 })

      Scroll() {
        Column({ space: 32 }) {
          ForEach(this.trips, (trip: TripCard) => {
            this.TripItem(trip)
          }, (trip: TripCard) => trip.id.toString())
        }
        .width('100%')
        .padding({ bottom: 36 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFB74D', 0.0],
        [AppColors.background, 0.5],
        ['#4DFF7043', 1.0]
      ]
    })
  }
}
