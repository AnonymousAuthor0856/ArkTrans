interface Trip {
  title: string
  days: number
  price: number
}

@Entry
@Component
struct Index {
  @State trips: Trip[] = [
    { title: 'Kyoto Cherry Trail', days: 4, price: 460 },
    { title: 'Tokyo City Break', days: 3, price: 390 },
    { title: 'Osaka Gourmet Tour', days: 5, price: 520 },
    { title: 'Mount Fuji Escape', days: 2, price: 280 },
    { title: 'Okinawa Beach Getaway', days: 7, price: 650 },
    { title: 'Hokkaido Winter', days: 4, price: 510 }
  ]

  build() {
    Stack() {
      Column() {
        Text('Itinerary Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF7043')
          .padding({ left: 12, right: 12 })

        Scroll() {
          Grid() {
            ForEach(this.trips, (trip: Trip) => {
              GridItem() {
                Column() {
                  Rect()
                    .width('100%')
                    .height(100)
                    .fill('#FFE0B2')
                    .borderRadius(16)

                  Text(trip.title)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')
                    .margin({ top: 12 })

                  Text(`${trip.days} days`)
                    .fontSize(14)
                    .fontColor('#3E2723')
                    .opacity(0.7)
                    .margin({ top: 4 })

                  Row() {
                    Text(`$${trip.price}`)
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FF7043')

                    Blank()

                    Button() {
                      Text('Details')
                        .fontColor('#FFFFFF')
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                    }
                    .backgroundColor('#FF7043')
                    .borderRadius(18)
                    .height(36)
                    .margin({ right: 12 })
                  }
                  .width('100%')
                  .margin({ top: 12 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
              }
            }, (item: Trip) => item.title)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .width('100%')
          .padding({ bottom: 24, left: 12, right: 12 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#FFE0B2', 0], ['#FFCCBC', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}