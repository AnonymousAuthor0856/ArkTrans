@Entry
@Component
struct Index {
  @State tripTitle: string = 'Trip Title'
  @State tripDays: number = 5
  @State tripPrice: string = '$1200'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Itinerary Planner')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF7043')

        Grid() {
          GridItem() {
            Column() {
              Column({ space: 6 }) {
                // Image Placeholder Box
                Stack({ alignContent: Alignment.Center }) {
                  Text('Image')
                    .fontColor('#999')
                }
                .width('100%')
                .height(100)
                .backgroundColor('#FFE0B2')
                .borderRadius(8)

                Text(this.tripTitle)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#3E2723')

                Text(`${this.tripDays} days`)
                  .fontSize(14)
                  .fontColor('#3E2723')

                Row() {
                  Text(this.tripPrice)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FF7043')

                  Blank()

                  Button() {
                    Text('Details')
                      .fontSize(12)
                      .fontColor('#FFFFFF')
                  }
                  .height(36)
                  .backgroundColor('#FF7043')
                  .borderRadius(8)
                  .onClick(() => {
                    // Handle click
                  })
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .padding(10)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFCCBC', 0.0], ['#FFF8F2', 0.5], ['#FFAB91', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
  }
}