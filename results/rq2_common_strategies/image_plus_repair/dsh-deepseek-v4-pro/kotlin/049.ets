interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct ItineraryPlannerPage {
  @State trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ];

  build() {
    Column({ space: 10 }) {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF7043')

      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            Column({ space: 6 }) {
              Row()
                .width('100%')
                .height(100)
                .backgroundColor('#FFE0B2')
                .borderRadius(14)

              Text(trip.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#3E2723')

              Text(trip.days + ' days')
                .fontSize(14)
                .fontColor('#B33E2723')

              Row() {
                Text(trip.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF7043')

                Button('Details')
                  .height(36)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#FF7043')
                  .borderRadius(14)
                  .onClick(() => {})
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .padding({ bottom: 36 })
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#4DFFB74D', 0.0], ['#FFF8F2', 0.5], ['#4DFF7043', 1.0]]
    })
    .padding(16)
  }
}
