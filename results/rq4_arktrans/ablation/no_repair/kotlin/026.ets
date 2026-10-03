@Entry
@Component
struct Index {
  @State it: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background Layer (Glass Effect)
      Column() {
        Blank()
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 90,
        colors: [['#E2E8F0', 0], ['#FFFFFF', 0.5], ['#E2E8F0', 1]]
      })

      // Top App Bar
      Row() {
        Text('Glass Doc Reader')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Main Content Card
      Column() {
        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          // List of sample lines
          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(18)
              .fontColor('#1E1E1E')
              .lineHeight(28)
          })
        }
        .width('100%')
        .padding(24)
      }
      .width('90%')
      .height(400)
      .backgroundColor('#FFFFFF')
      .borderRadius(32)
      .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
  }
}