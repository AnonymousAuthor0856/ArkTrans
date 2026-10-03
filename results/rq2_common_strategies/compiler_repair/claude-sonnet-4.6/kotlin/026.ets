@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0
  @State lastTouchY: number = 0

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')

      // Body
      Stack() {
        // Background gradient simulation
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#CCE2E8F0', 0.0],
              ['#F1F5F9', 0.5],
              ['#CCE2E8F0', 1.0]
            ]
          })

        // Glass card
        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
            Text(`This is a sample line of text content number ${item}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E1E1E')
          })
        }
        .width('90%')
        .height(400)
        .padding(16)
        .backgroundColor('rgba(255,255,255,0.7)')
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.18)',
          offsetX: 0,
          offsetY: 4
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.lastTouchY = event.touches[0].y
          } else if (event.type === TouchType.Move) {
            const deltaY = event.touches[0].y - this.lastTouchY
            this.scrollOffsetY += deltaY
            this.lastTouchY = event.touches[0].y
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}