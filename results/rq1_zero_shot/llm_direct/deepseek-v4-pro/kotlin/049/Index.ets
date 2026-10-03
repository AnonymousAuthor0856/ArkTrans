@Entry
@Component
struct ItineraryPlannerPage {
  @State trips: TripCard[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ]

  build() {
    Column() {
      // Header
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF7043')
        .margin({ top: 16, bottom: 16, left: 16, right: 16 })

      // Grid of trip cards
      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            TripCardView({ trip: trip })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .padding({ left: 16, right: 16, bottom: 36 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#FFB74D', 0.3], ['#FFF8F2', 0.0], ['#FF7043', 0.3]]
    })
    .backgroundColor('#FFF8F2')
  }
}

@Component
struct TripCardView {
  @Prop trip: TripCard

  build() {
    Column() {
      // Image placeholder
      Row()
        .width('100%')
        .height(100)
        .backgroundColor('#FFE0B2')
        .borderRadius(14)

      // Title
      Text(this.trip.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .margin({ top: 8 })

      // Days
      Text(`${this.trip.days} days`)
        .fontSize(14)
        .fontColor('#3E2723')
        .opacity(0.7)
        .margin({ top: 4 })

      // Price and button row
      Row() {
        Text(this.trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF7043')
          .layoutWeight(1)

        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#FF7043')
          .borderRadius(14)
          .height(36)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .margin({ top: 8 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}