const RM_PRIMARY: string = '#EF476F'
const RM_SECONDARY: string = '#FFD166'
const RM_TERTIARY: string = '#06D6A0'
const RM_BACKGROUND: string = '#FFFCF2'
const RM_SURFACE: string = '#FFF8E1'
const RM_OUTLINE: string = '#BDBDBD'
const RM_TEXT: string = '#1F1F1F'

@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false

  private readonly deckSize: number = 280
  private readonly knobRadius: number = 12
  private readonly travelRadius: number = 120

  private updateKnob(event: GestureEvent): void {
    const center: number = this.deckSize / 2
    const dx: number = event.offsetX
    const dy: number = event.offsetY
    const distance: number = Math.sqrt(dx * dx + dy * dy)
    const limit: number = this.travelRadius

    if (distance <= limit) {
      this.knobX = center + dx
      this.knobY = center + dy
      return
    }

    const angle: number = Math.atan2(dy, dx)
    this.knobX = center + Math.cos(angle) * limit
    this.knobY = center + Math.sin(angle) * limit
  }

  build() {
    Column() {
      Stack() {
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM_TEXT)
      }
      .height(80)
      .width('100%')
      .backgroundColor(RM_BACKGROUND)

      Blank()
        .layoutWeight(1)

      Column({ space: 32 }) {
        Stack() {
          Stack()
            .width('100%')
            .height('100%')
            .backgroundColor(RM_SURFACE)
            .border({
              width: 3,
              color: RM_OUTLINE,
              radius: 16
            })

          Circle()
            .width(240)
            .height(240)
            .fillOpacity(0)
            .stroke(RM_SECONDARY)
            .strokeWidth(8)

          Circle()
            .width(24)
            .height(24)
            .fill(RM_PRIMARY)
            .position({
              x: this.knobX - this.knobRadius,
              y: this.knobY - this.knobRadius
            })
            .gesture(
              PanGesture({ direction: PanDirection.All, distance: 0 })
                .onActionStart(() => {
                  this.isDragging = true
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.updateKnob(event)
                })
                .onActionEnd(() => {
                  this.isDragging = false
                })
            )
        }
        .width(this.deckSize)
        .height(this.deckSize)

        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_TEXT)

        Row({ space: 32 }) {
          Button('Play')
            .width(140)
            .height(56)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor(RM_PRIMARY)
            .borderRadius(12)
            .onClick(() => {
              this.isDragging = false
            })

          Button('Pause')
            .width(140)
            .height(56)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM_TEXT)
            .backgroundColor(RM_SECONDARY)
            .borderRadius(12)
            .onClick(() => {
              this.isDragging = false
            })
        }

        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM_TERTIARY)
      }
      .padding({ left: 32, right: 32 })
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Blank()
        .height(60)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM_BACKGROUND)
    .justifyContent(FlexAlign.Start)
  }
}
