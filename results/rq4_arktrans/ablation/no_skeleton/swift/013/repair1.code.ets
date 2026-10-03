@Entry
@Component
struct RetroMusicPlayerRoot {
  @State knobPosition: { x: number, y: number } = { x: 140, y: 140 }
  @State isDragging: boolean = false

  build() {
    Column() {
      // ===== Top App Bar =====
      Stack({ alignContent: Alignment.Center }) {
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
      }
      .width('100%')
      .height(80)

      Blank()

      // ===== Main Content =====
      Column({ space: 32 }) {
        // ===== Circular Deck =====
        Stack({ alignContent: Alignment.Center }) {
          // Background surface with border
          Rect()
            .fill('#FFF8E1')
            .border({ width: 3, color: '#BDBDBD' })
            .borderRadius(16)
            .width(280)
            .height(280)

          // Outer circle (record) - 黄色圆环
          Circle()
            .stroke('#FFD166')
            .strokeWidth(8)
            .width(240)
            .height(240)

          // Draggable knob - 红色圆点
          Circle()
            .fill('#EF476F')
            .width(24)
            .height(24)
            .position({ x: this.knobPosition.x, y: this.knobPosition.y })
            .gesture(
              PanGesture()
                .onActionUpdate((event?: GestureEvent) => {
                  if (event) {
                    this.isDragging = true
                    const center = { x: 140, y: 140 }
                    const radius = 120
                    
                    let dx = event.offsetX - center.x
                    let dy = event.offsetY - center.y
                    const distance = Math.sqrt(dx * dx + dy * dy)
                    
                    if (distance <= radius) {
                      this.knobPosition = { x: event.offsetX, y: event.offsetY }
                    } else {
                      const angle = Math.atan2(dy, dx)
                      this.knobPosition = {
                        x: center.x + Math.cos(angle) * radius,
                        y: center.y + Math.sin(angle) * radius
                      }
                    }
                  }
                })
                .onEnd(() => {
                  this.isDragging = false
                })
            )
        }
        .width(280)
        .height(280)

        // ===== Track Info =====
        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')

        // ===== Control Buttons =====
        Row({ space: 32 }) {
          Button() {
            Text('Play')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width(140)
          .height(56)
          .backgroundColor('#EF476F')
          .borderRadius(12)

          Button() {
            Text('Pause')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F1F1F')
          }
          .width(140)
          .height(56)
          .backgroundColor('#FFD166')
          .borderRadius(12)
        }

        // ===== Knob Coordinates =====
        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#06D6A0')
      }
      .padding({ left: 32, right: 32 })

      Blank()

      // ===== Bottom Spacer =====
      Rect()
        .fill(Color.Transparent)
        .height(60)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }
}