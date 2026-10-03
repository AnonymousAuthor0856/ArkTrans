@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false
  private scaleFactor: number = 1.0

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFCF2')

      Column({ space: 0 }) {
        Row() {
          Text('Retro Music Player')
            .fontSize(34 * this.scaleFactor)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1F1F1F')
        }
        .width('100%')
        .height(80 * this.scaleFactor)
        .backgroundColor('#FFFCF2')
        .justifyContent(FlexAlign.Center)

        Blank().layoutWeight(1)

        Column({ space: 32 * this.scaleFactor }) {
          Stack() {
            Image('')
              .width(280 * this.scaleFactor)
              .height(280 * this.scaleFactor)
              .borderRadius(140 * this.scaleFactor)
              .backgroundColor('#FFF8E1')
              .border({ width: 8 * this.scaleFactor, color: '#FFD166' })

            Image('')
              .width(24 * this.scaleFactor)
              .height(24 * this.scaleFactor)
              .borderRadius(12 * this.scaleFactor)
              .backgroundColor('#EF476F')
              .margin({ left: this.knobX - 12 * this.scaleFactor, top: this.knobY - 12 * this.scaleFactor })
          }
          .width(280 * this.scaleFactor)
          .height(280 * this.scaleFactor)

          Text('Track: Summer Nights')
            .fontSize(22 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1F1F')

          Row({ space: 32 * this.scaleFactor }) {
            Button({ type: ButtonType.Normal }) {
              Text('Play')
                .fontSize(22 * this.scaleFactor)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width(140 * this.scaleFactor)
            .height(56 * this.scaleFactor)
            .backgroundColor('#EF476F')
            .borderRadius(12 * this.scaleFactor)

            Button({ type: ButtonType.Normal }) {
              Text('Pause')
                .fontSize(22 * this.scaleFactor)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F1F1F')
            }
            .width(140 * this.scaleFactor)
            .height(56 * this.scaleFactor)
            .backgroundColor('#FFD166')
            .borderRadius(12 * this.scaleFactor)
          }

          Text('Knob X:268 Y:303')
            .fontSize(16 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor('#06D6A0')
        }
        .padding({ left: 32 * this.scaleFactor, right: 32 * this.scaleFactor })

        Blank().layoutWeight(1)

        Column()
          .height(60 * this.scaleFactor)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}