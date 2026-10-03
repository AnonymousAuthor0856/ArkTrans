@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;

  private textItems: number[] = [1, 2, 3, 4, 5, 6, 7, 8];

  build() {
    Column() {
      // Top App Bar
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 40, bottom: 16, left: 16, right: 16 })
        .backgroundColor('#FFF1F5F9')

      // Main content area
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#CCE2E8F0', 0.0],
              ['#FFF1F5F9', 0.5],
              ['#CCE2E8F0', 1.0]
            ]
          })

        // Document card
        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF38BDF8')
            .width('100%')

          ForEach(this.textItems, (item: number) => {
            Text(`This is a sample line of text content number ${item}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#FF1E1E1E')
              .width('100%')
          })

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .width('90%')
        .height(400)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(20)
        .shadow({
          color: '#2E000000',
          radius: 8,
          offsetX: 0,
          offsetY: 4
        })
        .translate({ x: 0, y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY = event.offsetY;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF1F5F9')
  }
}