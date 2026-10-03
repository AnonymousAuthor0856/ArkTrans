@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ]

  build() {
    Column({ space: 10 }) {
      // Title
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#FFFF7043')
        .padding({ left: 16, right: 16 })

      // Grid of trip cards
      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            Column({ space: 6 }) {
              // Image placeholder
              Button() { }
                .width('100%')
                .height(100)
                .backgroundColor('#FFFFE0B2')
                .borderRadius(14)

              Text(trip.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF3E2723')

              Text(trip.days.toString() + ' days')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .foregroundColor('rgba(62,39,35,0.7)')

              Row({ space: 0 }) {
                Text(trip.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FFFF7043')

                Blank().layoutWeight(1)

                Button() {
                  Text('Details')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FFFFFFFF')
                    .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                }
                .height(36)
                .backgroundColor('#FFFF7043')
                .borderRadius(14)
                .onClick(() => { })
              }
              .width('100%')
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#FFFFFFFF')
            .borderRadius(20)
            .shadow({
              radius: 8,
              color: 'rgba(0,0,0,0.15)',
              offsetX: 0,
              offsetY: 4
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 36 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [['rgba(255,183,77,0.3)', 0], ['#FFFFF8F2', 0.5], ['rgba(255,112,67,0.3)', 1]],
      direction: GradientDirection.Bottom
    })
  }
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}