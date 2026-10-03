interface Trip {
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct Index {
  @State trips: Array<Trip> = [
    { title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { title: 'Tokyo City Break', days: 3, price: '$390' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Itinerary Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF7043')
          .margin({ left: 16, top: 16 })

        Grid() {
          ForEach(this.trips, (trip: Trip) => {
            GridItem() {
              Column() {
                Column({ space: 6 }) {
                  // Image Placeholder
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon'))
                      .width('100%')
                      .height('100%')
                      .objectFit(ImageFit.Cover)
                  }
                  .width('100%')
                  .height(100)
                  .backgroundColor('#FFE0B2')
                  .borderRadius(16)

                  Text(trip.title)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')

                  Text(`${trip.days} days`)
                    .fontSize(14)
                    .fontColor('#3E2723')
                    .opacity(0.7)

                  Row({ space: 0 }) {
                    Text(trip.price)
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF7043')

                    Blank()

                    Button() {
                      Text('Details')
                        .fontSize(14)
                        .fontColor('#FFFFFF')
                    }
                    .height(36)
                    .backgroundColor('#FF7043')
                    .borderRadius(18)
                    .margin({ right: 10 })
                  }
                  .alignItems(VerticalAlign.Center)
                  .width('100%')
                }
                .width('100%')
                .backgroundColor('#FFFFFF')
                .padding(10)
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFF8F2', 0], ['#FFE0B2', 0.5], ['#FFCCBC', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}