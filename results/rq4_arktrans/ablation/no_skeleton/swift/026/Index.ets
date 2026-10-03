@Entry
@Component
struct RootScreen {
  @State scrollOffset: number = 0

  build() {
    Column() {
      // === Top Bar ===
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .padding({ top: 20, bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#F1F5F9')

      // === Main Content Area ===
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column() {
          Row().height(1).backgroundColor('#E2E8F0').opacity(0.8)
          Column().layoutWeight(1).backgroundColor('#F1F5F9')
          Row().height(1).backgroundColor('#E2E8F0').opacity(0.8)
        }.width('100%').height('100%')

        // Surface Card
        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E1E1E')
          })

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .width('90%')
        .height(400)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })
        .translate({ y: this.scrollOffset / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffset += event.offsetY
            })
        )
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}