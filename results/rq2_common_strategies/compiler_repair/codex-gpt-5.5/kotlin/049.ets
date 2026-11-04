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

class TravelColors {
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly background: string = '#FFF8F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE0B2';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#3E2723';
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
  ];

  @Builder
  TripTile(trip: TripCard) {
    Column() {
      Text('')
        .width('100%')
        .height(100)
        .backgroundColor(TravelColors.surfaceVariant)
        .borderRadius(14)

      Text(trip.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(TravelColors.onSurface)
        .width('100%')
        .maxLines(2)
        .margin({ top: 6 })

      Text(trip.days.toString() + ' days')
        .fontSize(14)
        .fontColor('#B03E2723')
        .width('100%')
        .margin({ top: 6 })

      Row() {
        Text(trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(TravelColors.primary)
          .layoutWeight(1)

        Button('Details')
          .height(36)
          .fontSize(12)
          .fontColor(TravelColors.onPrimary)
          .backgroundColor(TravelColors.primary)
          .borderRadius(14)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(10)
    .backgroundColor(TravelColors.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(TravelColors.primary)
        .width('100%')
        .margin({ bottom: 10 })

      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            this.TripTile(trip)
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: 36 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#4DFFB74D', 0.0], [TravelColors.background, 0.5], ['#4DFF7043', 1.0]]
    })
  }
}
