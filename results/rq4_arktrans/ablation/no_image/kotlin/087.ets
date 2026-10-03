@Entry
@Component
struct Index {
  @State step: string = '0'
  @State text: string = '0'

  build() {
    Stack() {
      Row({ space: 0 }) {
        // Box equivalent using Stack with circular background
        Stack({ alignContent: Alignment.Center }) {
          Text(this.step)
            .fontSize(12) // labelSmall approximation
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .backgroundColor('#F5F5F5')
        .borderRadius(12) // CircleShape

        Blank().width(12)

        Text(this.text)
          .fontSize(16) // bodyMedium approximation
          .fontColor(Color.Gray)

        Blank().layoutWeight(1)

        Image($r('app.media.startIcon'))
          .width(16)
          .height(16)
          .fillColor('#EEEEEE')
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 8, bottom: 8 })

      Divider()
        .vertical(false)
        .color('#FAFAFA')
    }
    .width('100%')
    .height('100%')
  }
}