import { router } from '@kit.ArkUI';

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' },
  ];

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFF7043')
        .margin({ bottom: 10 })

      List({ space: 16 }) {
        ForEach(this.trips, (trip: TripCard) => {
          ListItem() {
            Column() {
              // Image placeholder
              Row()
                .width('100%')
                .height(160)
                .backgroundColor('#FFFFE0B2')
                .borderRadius(14)
                .margin({ bottom: 6 })

              Text(trip.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FF3E2723')
                .margin({ bottom: 4 })

              Text(`${trip.days} days`)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('rgba(62,39,35,0.7)')
                .margin({ bottom: 6 })

              Row() {
                Text(trip.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFF7043')

                Button('Details')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFFFF')
                  .backgroundColor('#FFFF7043')
                  .borderRadius(14)
                  .height(36)
                  .padding({ left: 16, right: 16 })
                  .onClick(() => {})
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor('#FFFFFFFF')
            .borderRadius(20)
            .padding(10)
            .shadow({
              radius: 8,
              color: 'rgba(0,0,0,0.15)',
              offsetX: 0,
              offsetY: 4
            })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(255,183,77,0.3)', 0.0],
        ['#FFFFF8F2', 0.5],
        ['rgba(255,112,67,0.3)', 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Start)
  }
}