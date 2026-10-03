@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false

  private readonly deckSize: number = 280
  private readonly ringRadius: number = 120
  private readonly centerX: number = 140
  private readonly centerY: number = 140

  build() {
    Column() {
      // Top App Bar
      Text('Retro Music Player')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F1F1F')
        .margin({ top: 60, bottom: 40 })

      // Circular Deck
      Stack() {
        // Surface with border
        RoundRect()
          .width(this.deckSize)
          .height(this.deckSize)
          .fill('#FFF8E1')
          .radius(24)
          .stroke('#BDBDBD')
          .strokeWidth(4)

        // Outer yellow ring
        Circle()
          .width(this.deckSize - 40)
          .height(this.deckSize - 40)
          .fill('transparent')
          .stroke('#FFD166')
          .strokeWidth(12)

        // Draggable knob
        Circle()
          .width(24)
          .height(24)
          .fill('#EF476F')
          .translate({ x: this.knobX - this.centerX, y: this.knobY - this.centerY })
          .gesture(
            PanGesture()
              .onActionStart(() => {
                this.isDragging = true
              })
              .onActionUpdate((event: GestureEvent) => {
                let x = this.knobX + event.offsetX
                let y = this.knobY + event.offsetY
                let dx = x - this.centerX
                let dy = y - this.centerY
                let distance = Math.sqrt(dx * dx + dy * dy)
                if (distance <= this.ringRadius) {
                  this.knobX = x
                  this.knobY = y
                } else {
                  let angle = Math.atan2(dy, dx)
                  this.knobX = this.centerX + Math.cos(angle) * this.ringRadius
                  this.knobY = this.centerY + Math.sin(angle) * this.ringRadius
                }
              })
              .onActionEnd(() => {
                this.isDragging = false
              })
          )
      }
      .width(this.deckSize)
      .height(this.deckSize)
      .margin({ bottom: 48 })

      // Track Info
      Text('Track: Summer Nights')
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F1F1F')
        .margin({ bottom: 56 })

      // Control Buttons
      Row() {
        Button('Play')
          .width(180)
          .height(72)
          .fontSize(30)
          .fontColor('#FFFFFF')
          .backgroundColor('#EF476F')
          .borderRadius(16)

        Button('Pause')
          .width(180)
          .height(72)
          .fontSize(30)
          .fontColor('#1F1F1F')
          .backgroundColor('#FFD166')
          .borderRadius(16)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 48 })

      // Knob Coordinates
      Text('Knob X:268 Y:303')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#06D6A0')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 20, left: 32, right: 32, bottom: 20 })
  }
}
