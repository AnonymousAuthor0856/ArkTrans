// AppEntry.ets
@Entry
@Component
struct ItineraryPlanner {
  @State trips: TripCard[] = [
    new TripCard(1, "Kyoto Cherry Trail", 4, "$460"),
    new TripCard(2, "Tokyo City Break", 3, "$390"),
    new TripCard(3, "Osaka Gourmet Tour", 5, "$520"),
    new TripCard(4, "Mount Fuji Escape", 2, "$280"),
    new TripCard(5, "Okinawa Beach Week", 6, "$740"),
    new TripCard(6, "Hokkaido Winter Lights", 5, "$680")
  ];

  build() {
    Column() {
      // Header
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF7043')
        .margin({ left: 16, top: 40 }) // Adjusted top margin for status bar area

      // Scrollable Grid Content
      Scroll() {
        GridContainer({ columnsTemplate: '1fr 1fr', columnGap: 16, rowGap: 16 }) {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          })
        }
      }
      .layoutWeight(1)
      .margin({ left: 16, right: 16, bottom: 36 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F2')
    .linearGradient({
      angle: 90,
      colors: [['#FFB74D', 0.3], ['#FFF8F2', 0.5], ['#FF7043', 0.3]]
    })
  }
}

// Data Model
class TripCard {
  id: number;
  title: string;
  days: number;
  price: string;

  constructor(id: number, title: string, days: number, price: string) {
    this.id = id;
    this.title = title;
    this.days = days;
    this.price = price;
  }
}

// Component: Trip Card
@Component
struct TripCardView {
  @Prop trip: TripCard;

  build() {
    Column() {
      // Image Placeholder
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
        .margin({ top: 10 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // Days
      Text(`${this.trip.days} days`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(Color.Gray)
        .margin({ top: 4 })

      // Spacer to push content down if needed, or just spacing
      Blank()

      // Price and Button Row
      Row() {
        Text(this.trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF7043')

        Blank()

        Button('Details', { type: ButtonType.Capsule })
          .backgroundColor('#FF7043')
          .fontColor('#FFFFFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(36)
          .onClick(() => {
            console.info(`Details clicked for ${this.trip.title}`);
          })
      }
      .width('100%')
      .margin({ top: 10 })
    }
    .padding(10)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
  }
}