@Entry
@Component
struct ItineraryPlanner {
  @State trips: TripCard[] = [
    { id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460" },
    { id: 2, title: "Tokyo City Break", days: 3, price: "$390" },
    { id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520" },
    { id: 4, title: "Mount Fuji Escape", days: 2, price: "$280" },
    { id: 5, title: "Okinawa Beach Week", days: 6, price: "$740" },
    { id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680" }
  ]

  build() {
    // === Column (Root) ===
    // props: { space: 10 }
    // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#FFF8F2' }
    // children: 2
    Column({ space: 10 }) {
      // === Text (Title) ===
      // props: { text: 'Itinerary Planner' }
      // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#FF7043' }
      Text('Itinerary Planner').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#FF7043')

      // === List (Grid Simulation) ===
      // props: { space: 16 }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 6
      List({ space: 16 }) {
        ForEach(this.trips, (trip: TripCard) => {
          ListItem() {
            // === Column (Card Container) ===
            // props: { space: 6 }
            // modifier: { width: '100%', padding: 10, backgroundColor: '#FFF', borderRadius: 20, shadow: { radius: 8, color: '#26000000' } }
            // children: 3
            Column({ space: 6 }) {
              // === Image (Placeholder) ===
              // modifier: { width: '100%', height: 100, borderRadius: 14, objectFit: ImageFit.Cover }
              Image($r('app.media.startIcon')).width('100%').height(100).borderRadius(14).objectFit(ImageFit.Cover)

              // === Column (Text Info) ===
              // props: { space: 2 }
              // children: 2
              Column({ space: 2 }) {
                // === Text (Trip Title) ===
                // props: { text: trip.title }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#3E2723' }
                Text(trip.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#3E2723')

                // === Text (Days) ===
                // props: { text: `${trip.days} days` }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#634B43' }
                Text(`${trip.days} days`).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#634B43')
              }

              // === Row (Footer) ===
              // props: { space: 10 }
              // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
              // children: 2
              Row({ space: 10 }) {
                // === Text (Price) ===
                // props: { text: trip.price }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#FF7043' }
                Text(trip.price).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FF7043')

                // === Button (Details) ===
                // modifier: { height: 36, backgroundColor: '#FF7043', borderRadius: 14, fontColor: '#FFF' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'Details' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
                  Text('Details').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
                }.height(36).backgroundColor('#FF7043').borderRadius(14).fontColor('#FFF')
              }
            }
          }
        }, (item: TripCard) => item.id.toString())
      }.width('100%').layoutWeight(1)
    }.width('100%').height('100%').padding(16).backgroundColor('#FFF8F2')
  }
}

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}