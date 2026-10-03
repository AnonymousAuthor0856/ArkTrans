// src/main/ets/components/TripCard.ets

export interface TripData {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct ItineraryPlanner {
  // Data source matching the Kotlin implementation
  private trips: TripData[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ];

  build() {
    Column() {
      // Main Content Container with Gradient Background
      Column() {
        // Header Title
        Text("Itinerary Planner")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF7043')
          .margin({ bottom: 10 })

        // Scrollable List of Cards
        List({ space: 16 }) {
          ForEach(this.trips, (trip: TripData) => {
            ListItem() {
              this.TripItemComponent(trip)
            }
          })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ bottom: 36 }) // Bottom padding to allow scrolling past the last item
      }
      .width('100%')
      .height('100%')
      .padding(16)
      // Vertical Gradient Background mimicking the Kotlin Brush.verticalGradient
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFB74D', 0.3], ['#FFF8F2', 0.5], ['#FF7043', 0.3]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F2')
  }

  @Builder
  TripItemComponent(trip: TripData) {
    Column() {
      // Image Placeholder Area
      Row()
        .width('100%')
        .height(100)
        .borderRadius(14)
        .backgroundColor('#FFE0B2')

      Column() {
        // Trip Title
        Text(trip.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .margin({ top: 10, bottom: 4 })

        // Duration
        Text(`${trip.days} days`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#9E9E9E')
          .opacity(0.7)
          .margin({ bottom: 10 })

        // Price and Action Button Row
        Row() {
          Text(trip.price)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF7043')

          Blank()

          Button("Details")
            .backgroundColor('#FF7043')
            .fontColor('#FFFFFF')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(14)
            .height(36)
            .onClick(() => {
              // Handle details click
            })
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(10)
    }
    .width('100%')
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    // Shadow effect mimicking CardDefaults.cardElevation
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
  }
}