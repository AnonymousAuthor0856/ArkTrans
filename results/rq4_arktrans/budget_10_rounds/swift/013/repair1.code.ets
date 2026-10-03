@Entry
@Component
struct Index {
  @State knobPosition: { x: number, y: number } = { x: 140, y: 140 }
  @State isDragging: boolean = false

  build() {
    Stack() {
      Column() {
        // Header
        Stack() {
          Rect().fill('#FFF9F2')
          Text('Retro Music Player').fontColor('#1C1B1F').fontSize(34).fontWeight(FontWeight.Bold)
        }.width('100%').height(80)

        Blank()

        Column({ space: 32 }) {
          // Knob Area
          Stack() {
            Rect().borderRadius(16).border({ width: 3, color: '#BDBDBD' }).backgroundColor('#FFF3E0')
            Circle().stroke('#FFCA28').strokeWidth(8).width(240).height(240)
            
            Circle()
              .width(24)
              .height(24)
              .fill('#EC407A')
              .position({ x: this.knobPosition.x, y: this.knobPosition.y })
              .animation({ duration: 200, curve: Curve.EaseOut }, this.isDragging ? null : true)
              .gesture(
                PanGesture()
                  .onActionStart(() => { this.isDragging = true })
                  .onActionUpdate((event: GestureEvent) => {
                    const center = { x: 140, y: 140 }
                    const radius = 120
                    
                    let dx = event.offsetX + center.x
                    let dy = event.offsetY + center.y
                    
                    const distance = Math.sqrt(Math.pow(dx - center.x, 2) + Math.pow(dy - center.y, 2))
                    
                    if (distance <= radius) {
                      this.knobPosition = { x: dx, y: dy }
                    } else {
                      const angle = Math.atan2(dy - center.y, dx - center.x)
                      this.knobPosition = {
                        x: center.x + Math.cos(angle) * radius,
                        y: center.y + Math.sin(angle) * radius
                      }
                    }
                  })
                  .onActionEnd(() => { this.isDragging = false })
              )
          }.width(280).height(280)

          Text('Track: Summer Nights').fontColor('#1C1B1F').fontSize(22).fontWeight(FontWeight.Medium)

          Row({ space: 32 }) {
            Button() {
              Text('Play').fontColor('#FFFFFF').fontSize(22).fontWeight(FontWeight.Medium)
            }.backgroundColor('#EC407A').borderRadius(12).width(140).height(56)

            Button() {
              Text('Pause').fontColor('#1C1B1F').fontSize(22).fontWeight(FontWeight.Medium)
            }.backgroundColor('#FFCA28').borderRadius(12).width(140).height(56)
          }

          Text(`Knob X:${Math.round(this.knobPosition.x)} Y:${Math.round(this.knobPosition.y)}`)
            .fontColor('#00BFA5')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }.padding({ left: 32, right: 32 })

        Blank()

        Rect().fill(Color.Transparent).height(60)
      }.width('100%').height('100%').backgroundColor('#FFF9F2')
    }.width('100%').height('100%')
  }
}