@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Text('Itinerary Planner')
          .padding({ left: 12, right: 12 })
          .fontColor('#FF7043')
          .fontSize(28)

        Scroll() {
          Grid() {
            ForEach([
              { title: 'Trip 1', days: 5, price: '$500' },
              { title: 'Trip 2', days: 3, price: '$300' }
            ], (item: TripItem) => {
              GridItem() {
                Column() {
                  Rect()
                    .width('100%')
                    .height(100)
                    .fill('#FFE0B2')
                    .borderRadius(8)

                  Text(item.title)
                    .fontColor('#3E2723')
                    .fontSize(20)

                  Text(`${item.days} days`)
                    .fontColor(Color.Gray)
                    .fontSize(14)

                  Row() {
                    Text(item.price)
                      .fontColor('#FF7043')
                      .fontSize(20)

                    Blank()

                    Button() {
                      Text('Details')
                        .fontColor(Color.White)
                    }
                    .height(36)
                    .borderRadius(8)
                    .backgroundColor('#FF7043')
                  }
                }
                .shadow({ radius: 4, color: '#1F000000' })
                .borderRadius(16)
                .backgroundColor('#FFFFFF')
                .padding(12)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({ bottom: 24, left: 12, right: 12 })
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface TripItem {
  title: string;
  days: number;
  price: string;
}