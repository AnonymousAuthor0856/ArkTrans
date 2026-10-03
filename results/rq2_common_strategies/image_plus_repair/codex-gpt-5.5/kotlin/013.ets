const PLAYER_PRIMARY: string = '#EF476F'
const PLAYER_SECONDARY: string = '#FFD166'
const PLAYER_TERTIARY: string = '#06D6A0'
const PLAYER_BACKGROUND: string = '#FFFCF2'
const PLAYER_SURFACE: string = '#FFF8E1'
const PLAYER_OUTLINE: string = '#BDBDBD'
const PLAYER_ON_PRIMARY: string = '#FFFFFF'
const PLAYER_ON_SECONDARY: string = '#1F1F1F'
const PLAYER_ON_SURFACE: string = '#1F1F1F'

@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 140
  @State knobY: number = 140

  build() {
    Column() {
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(PLAYER_ON_SURFACE)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .padding({ top: 12, bottom: 12 })

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(260)
            .height(260)
            .fill('#00000000')
            .stroke(PLAYER_SECONDARY)
            .strokeWidth(6)

          Circle()
            .width(20)
            .height(20)
            .fill(PLAYER_PRIMARY)
            .position({ x: this.knobX - 10, y: this.knobY - 10 })
        }
        .width(280)
        .height(280)
        .backgroundColor(PLAYER_SURFACE)
        .border({ width: 3, color: PLAYER_OUTLINE, radius: 16 })
        .clip(true)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              let point = event.fingerList[0]
              this.knobX = Math.max(10, Math.min(270, point.localX))
              this.knobY = Math.max(10, Math.min(270, point.localY))
            })
        )

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PLAYER_ON_SURFACE)

        Row() {
          Button('Play')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PLAYER_ON_PRIMARY)
            .backgroundColor(PLAYER_PRIMARY)
            .borderRadius(12)
            .width(120)
            .height(48)

          Button('Pause')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PLAYER_ON_SECONDARY)
            .backgroundColor(PLAYER_SECONDARY)
            .borderRadius(12)
            .width(120)
            .height(48)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Text(`Knob X:${Math.floor(this.knobX)} Y:${Math.floor(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(PLAYER_TERTIARY)

        Blank().height(32)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PLAYER_BACKGROUND)
  }
}
