@Entry
@Component
struct RetroMusicPlayerRoot {
  @State private knobX: number = 140;
  @State private knobY: number = 140;

  @Builder
  Deck() {
    Stack() {
      Rect()
        .width(280)
        .height(280)
        .fill('#FFF8E1')
        .stroke('#BDBDBD')
        .strokeWidth(3)
        .radius(16)
      Circle()
        .width(240)
        .height(240)
        .fill(Color.Transparent)
        .stroke('#FFD166')
        .strokeWidth(8)
      Circle()
        .width(24)
        .height(24)
        .fill('#EF476F')
        .position({ x: this.knobX, y: this.knobY })
    }
    .width(280)
    .height(280)
  }

  build() {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(80)
          .fill('#FFFCF2')
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
      }
      .height(80)

      Blank()

      Column() {
        this.Deck()
        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')
          .margin({ top: 32 })

        Row() {
          Button('Play')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#EF476F')
            .width(140)
            .height(56)
            .borderRadius(12)
          Button('Pause')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1F1F')
            .backgroundColor('#FFD166')
            .width(140)
            .height(56)
            .borderRadius(12)
            .margin({ left: 32 })
        }
        .margin({ top: 32 })

        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#06D6A0')
          .margin({ top: 32 })
      }
      .padding({ left: 32, right: 32 })

      Blank()
      Rect()
        .width('100%')
        .height(60)
        .fill(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }
}
