import { router } from '@kit.ArkUI';

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

const PRIMARY_COLOR = '#FFFF7043';
const SECONDARY_COLOR = '#FFFFB74D';
const TERTIARY_COLOR = '#FFFFD180';
const BACKGROUND_COLOR = '#FFFFF8F2';
const SURFACE_COLOR = '#FFFFFFFF';
const SURFACE_VARIANT_COLOR = '#FFFFE0B2';
const OUTLINE_COLOR = '#FFD7CCC8';
const ON_PRIMARY_COLOR = '#FFFFFFFF';
const ON_SECONDARY_COLOR = '#FF3E2723';
const ON_SURFACE_COLOR = '#FF3E2723';
const ON_BACKGROUND_COLOR = '#FF3E2723';

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ];

  build() {
    Column() {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY_COLOR)
        .margin({ bottom: 10 })

      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          GridItem() {
            Column() {
              // Image placeholder
              Row()
                .width('100%')
                .height(100)
                .backgroundColor(SURFACE_VARIANT_COLOR)
                .borderRadius(14)

              Text(trip.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_SURFACE_COLOR)
                .margin({ top: 6 })
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(`${trip.days} days`)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#B33E2723')
                .margin({ top: 4 })

              Row() {
                Text(trip.price)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PRIMARY_COLOR)

                Button('Details')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_PRIMARY_COLOR)
                  .backgroundColor(PRIMARY_COLOR)
                  .borderRadius(14)
                  .height(36)
                  .padding({ left: 12, right: 12 })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .margin({ top: 6 })
            }
            .width('100%')
            .backgroundColor(SURFACE_COLOR)
            .borderRadius(20)
            .padding(10)
            .shadow({
              radius: 8,
              color: '#26000000',
              offsetX: 0,
              offsetY: 4
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .layoutDirection(GridDirection.Row)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFB74D', 0.0],
        ['#FFFFF8F2', 0.5],
        ['#4DFF7043', 1.0]
      ]
    })
    .alignItems(HorizontalAlign.Start)
  }
}