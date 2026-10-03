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
        .fontColor('#FF7043')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 16 })

      // Scrollable Grid
      Scroll() {
        GridContainer({ items: this.trips })
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 36 })
      }
      .layoutWeight(1)
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

// Grid Container Component
@Component
struct GridContainer {
  @Link items: TripCard[];

  build() {
    Grid() {
      ForEach(this.items, (item: TripCard) => {
        GridItem() {
          TripCardView(trip: item)
        }
      }, (item: TripCard) => item.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(16)
    .columnsGap(16)
  }
}

// Card Component
@Component
struct TripCardView {
  trip: TripCard;

  build() {
    Column() {
      // Image Placeholder
      Rectangle()
        .fill('#FFE0B2')
        .borderRadius(14)
        .height(100)
        .width('100%')

      // Title
      Text(this.trip.title)
        .fontColor('#3E2723')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 10 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // Days
      Text(`${this.trip.days} days`)
        .fontColor('#3E2723')
        .opacity(0.7)
        .fontSize(14)
        .margin({ top: 6 })

      // Price and Button Row
      Row() {
        Text(this.trip.price)
          .fontColor('#FF7043')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Button('Details', { type: ButtonType.Normal })
          .fontColor('#FFFFFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#FF7043')
          .borderRadius(14)
          .height(36)
          .width(80)
      }
      .margin({ top: 10 })
    }
    .padding(10)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
  }
}