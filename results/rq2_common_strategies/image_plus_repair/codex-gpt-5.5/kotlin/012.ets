@Entry
@Component
struct FavoriteSpotsPage {
  @State markerX: number = 200
  @State markerY: number = 400

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .maxLines(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9FAFB')

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(400)
          .borderRadius(24)
          .border({ width: 1, color: '#D1D5DB' })
          .backgroundColor('#F2F8FE')
          .clip(true)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(340)
            .height(340)
            .fill('#4D93C5FD')
          Circle()
            .width(220)
            .height(220)
            .fill('#3393C5FD')
        }
        .width('100%')
        .height(400)
        .clip(true)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(32)
            .height(32)
            .fill('#00000000')
            .stroke('#4D60A5FA')
            .strokeWidth(1.5)
          Circle()
            .width(14)
            .height(14)
            .fill('#60A5FA')
        }
        .width(32)
        .height(32)
        .position({ x: '30.5%', y: '50%' })

        Column() {
          Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
            .fontSize(14)
            .fontColor('#111827')
            .textAlign(TextAlign.Center)
            .width('100%')

          Button('Save Marker')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#60A5FA')
            .borderRadius(16)
            .width('100%')
            .height(48)
            .onClick(() => {
              this.markerX = 200
              this.markerY = 400
            })
        }
        .width('100%')
        .position({ x: 0, y: '100%' })
        .translate({ y: -96 })
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .height(80)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .alignContent(Alignment.Center)
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}
