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

@Entry
@Component
struct Index {
  private trips: TripCard[] = [
    new TripCard(1, 'Kyoto Cherry Trail', 4, '$460'),
    new TripCard(2, 'Tokyo City Break', 3, '$390'),
    new TripCard(3, 'Osaka Gourmet Tour', 5, '$520'),
    new TripCard(4, 'Mount Fuji Escape', 2, '$280'),
    new TripCard(5, 'Okinawa Beach Week', 6, '$740'),
    new TripCard(6, 'Hokkaido Winter Lights', 5, '$680')
  ]

  @Builder
  TripCardView(trip: TripCard) {
    Column() {
      Rect()
        .width('100%')
        .height(100)
        .radius(14)
        .fill('#FFE0B2')

      Text(trip.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 6 })

      Text(`${trip.days} days`)
        .fontSize(14)
        .fontColor('#B33E2723')
        .width('100%')
        .margin({ top: 6 })

      Row() {
        Text(trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF7043')
          .layoutWeight(1)

        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .height(36)
          .padding({ left: 10, right: 10 })
          .backgroundColor('#FF7043')
          .borderRadius(14)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#263E2723', offsetY: 4 })
  }

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF7043')
        .width('100%')
        .padding({ left: 16, right: 16 })

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              this.TripCardView(trip)
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 36 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding({ top: 16 })
    .linearGradient({
      angle: 180,
      colors: [['#4DFFB74D', 0.0], ['#FFF8F2', 0.5], ['#4DFF7043', 1.0]]
    })
  }
}
