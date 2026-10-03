@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Button() {
            Text('')
          }.padding({ left: 8 })
          Blank()
          Text('Productivity Check').fontColor('#0F172A')
          Blank()
          Button() {
            Text('')
          }.padding({ right: 8 })
        }.zIndex(1).shadow({ radius: 6, color: '#33000000' }).backgroundColor('#FFFFFF').height(56)

        Scroll() {
          Column() {
            Row() {
              ForEach([1, 2], (item: number) => {
                Button() {
                  Text('Filter')
                    .borderRadius(8)
                    .backgroundColor('#FFFFFF')
                    .padding({ top: 4, bottom: 4, left: 8, right: 8 })
                }
                Blank().width(4)
              })
            }.padding({ left: 8, right: 8 }).width('100%')

            Column() {
              Text('Weekly Throughput').padding({ bottom: 8 }).fontColor('#0F172A')
              Column() {
                Row() {
                  ForEach([1], (item: number) => {
                    // Placeholder for chart bars
                    Rect().width(20).height(50).fill('#E2E8F0')
                  })
                }
                Row() {
                  ForEach([1], (item: number) => {
                    Text('Label')
                      .width('100%')
                      .textAlign(TextAlign.Center)
                      .fontColor('#475569')
                  })
                }
              }
            }.padding({ left: 8, right: 8 }).shadow({ radius: 4, color: '#1A000000' }).borderRadius(16).backgroundColor('#FFFFFF')

            ForEach([1], (item: number) => {
              Column() {
                Row() {
                  Text('Item Title').fontColor('#0F172A')
                  Blank()
                  Row() {
                    Circle().width(10).height(10).fill('#10B981')
                    Text('Status').fontColor('#10B981')
                  }
                }.padding({ bottom: 8 })
                Row() {
                  Stack({ alignContent: Alignment.Start }) {
                    Rect().height(8).fill('#E2E8F0')
                    Rect().width(50).height(8).fill('#3B82F6')
                  }
                  Text('50%').width(40).textAlign(TextAlign.End).fontColor('#475569')
                }
              }.padding({ left: 8, right: 8 }).overlay(Rect().borderRadius(12)).borderRadius(12).backgroundColor('#FFFFFF')
            })
          }.padding({ bottom: 60 }).padding({ top: 8, bottom: 8 })
        }.backgroundColor('#F8FAFC')

        Column() {
          Button() {
            Text('Action')
          }.padding(8)
        }.zIndex(1).shadow({ radius: 6, color: '#33000000' }).backgroundColor('#FFFFFF').position({ x: 0, y: -60 })
      }
    }.width('100%').height('100%')
  }
}