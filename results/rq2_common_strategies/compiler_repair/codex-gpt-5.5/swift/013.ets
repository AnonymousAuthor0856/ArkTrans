@Entry
@Component
struct Index {
  private cPrimary: string = '#EF476F'
  private cSecondary: string = '#FFD166'
  private cTertiary: string = '#06D6A0'
  private cBackground: string = '#FFFCF2'
  private cSurface: string = '#FFF8E1'
  private cSurfaceVariant: string = '#FCE7E7'
  private cOutline: string = '#BDBDBD'
  private cText: string = '#1F1F1F'

  @Builder
  Deck() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width(280)
        .height(280)
        .radius(16)
        .fill(this.cSurface)
        .stroke(this.cOutline)
      Circle()
        .width(232)
        .height(232)
        .fill(Color.Transparent)
        .stroke(this.cSecondary)
        .strokeWidth(8)
      Circle()
        .width(24)
        .height(24)
        .fill(this.cPrimary)
    }
    .width(280)
    .height(280)
  }

  @Builder
  ControlButton(title: string, bg: string, fg: string) {
    Button(title)
      .width(140)
      .height(56)
      .fontSize(22)
      .fontWeight(FontWeight.Medium)
      .fontColor(fg)
      .backgroundColor(bg)
      .borderRadius(12)
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height(80)
          .fill(this.cBackground)
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
      }
      .width('100%')
      .height(80)

      Blank()

      Column() {
        this.Deck()

        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .margin({ top: 32 })

        Row() {
          this.ControlButton('Play', this.cPrimary, '#FFFFFF')
          Blank().width(32)
          this.ControlButton('Pause', this.cSecondary, this.cText)
        }
        .margin({ top: 32 })

        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cTertiary)
          .margin({ top: 32 })
      }
      .width('100%')
      .padding({ left: 32, right: 32 })

      Blank()
      Blank().height(60)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
