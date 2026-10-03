@Entry
@Component
struct ItineraryPlanner {
  private trips: TripCard[] = [
    new TripCard(1, "Kyoto Cherry Trail", 4, "$460"),
    new TripCard(2, "Tokyo City Break", 3, "$390"),
    new TripCard(3, "Osaka Gourmet Tour", 5, "$520"),
    new TripCard(4, "Mount Fuji Escape", 2, "$280"),
    new TripCard(5, "Okinawa Beach Week", 6, "$740"),
    new TripCard(6, "Hokkaido Winter Lights", 5, "$680")
  ]

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [0xFFE5B97F, 0.0],
            [0xFFFFF8F2, 0.4],
            [0xFFF5C6B8, 1.0]
          ]
        })

      Column() {
        Text("Itinerary Planner")
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(0xFFFF7043)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 24, bottom: 12, left: 16, right: 16 })

        List() {
          ForEach(this.trips, (trip: TripCard) => {
            ListItem() {
              TripCardItem({ trip: trip })
            }
            .margin({ bottom: 16, left: 16, right: 16 })
          }, (trip: TripCard) => trip.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TripCardItem {
  @State trip: TripCard = new TripCard(0, "", 0, "")

  build() {
    Column() {
      Row()
        .width('100%')
        .height(200)
        .backgroundColor(0xFFFFE0B2)
        .borderRadius({ topLeft: 28, topRight: 28, bottomLeft: 28, bottomRight: 28 })

      Text(this.trip.title)
        .fontSize(30)
        .fontWeight(FontWeight.Medium)
        .fontColor(0xFF3E2723)
        .width('100%')
        .margin({ top: 12, left: 4, right: 4 })

      Text(`${this.trip.days} days`)
        .fontSize(24)
        .fontColor('rgba(62, 39, 35, 0.7)')
        .width('100%')
        .margin({ top: 4, left: 4, right: 4 })

      Row() {
        Text(this.trip.price)
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(0xFFFF7043)

        Text("Details")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor(0xFFFF7043)
          .borderRadius(24)
          .padding({ left: 28, right: 28, top: 12, bottom: 12 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 12, left: 4, right: 4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(36)
    .shadow({
      radius: 16,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: 8
    })
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
