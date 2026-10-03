@Entry
@Component
struct ItineraryPlannerPage {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ]

  build() {
    Stack() {
      Column() {
        Text('Itinerary Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFF7043')
          .margin({ bottom: 10 })

        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardItem({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(16)
        .columnsGap(16)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#FFFF7043', 0.0], ['#FFFFF8F2', 0.5], ['#FFFFB74D', 1.0]]
    })
    .backgroundColor('#FFFFF8F2')
  }
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

@Component
struct TripCardItem {
  @Prop trip: TripCard

  build() {
    Column() {
      Column({ space: 6 }) {
        Row()
          .width('100%')
          .height(100)
          .borderRadius(14)
          .backgroundColor('#FFFFE0B2')

        Text(this.trip.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF3E2723')

        Text(this.trip.days.toString() + ' days')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B33E2723')

        Row() {
          Text(this.trip.price)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFF7043')

          Blank()

          Button('Details')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFFFF')
            .backgroundColor('#FFFF7043')
            .borderRadius(14)
            .height(36)
            .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#FFFFFFFF')
    }
    .width('100%')
    .borderRadius(20)
    .backgroundColor('#FFFFFFFF')
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
  }
}
