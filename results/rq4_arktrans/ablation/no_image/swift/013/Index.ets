import { Curve } from '@kit.ArkUI'

interface Position {
  x: number
  y: number
}

@Entry
@Component
struct Index {
  @State knobPosition: Position = { x: 140, y: 140 }
  @State isDragging: boolean = false
  
  private scale: number = 1.0

  build() {
    Stack() {
      Column() {
        // Top Header Section
        Stack() {
          Rect().fill('#F5F5F5').height(80 * this.scale)
          Text('Retro Music Player')
            .fontColor('#FFFFFF')
            .fontSize(34 * this.scale)
            .fontWeight(FontWeight.Bold)
        }.height(80 * this.scale)

        Blank()

        // Main Content Area
        Column({ space: 32 * this.scale }) {
          
          // Knob Control Stack
          Stack() {
            // Background Surface with Stroke
            Rect()
              .fill('#E0E0E0')
              .borderRadius(16 * this.scale)
              .overlay(
                () => {
                  Rect()
                    .borderRadius(16 * this.scale)
                    .border({ width: 3 * this.scale, color: '#9E9E9E' })
                }
              )

            // Track Circle (Secondary Color)
            Circle()
              .stroke('#FFC107', 8 * this.scale)
              .padding(20 * this.scale)

            // Draggable Knob (Primary Color)
            Circle()
              .width(24 * this.scale)
              .height(24 * this.scale)
              .fill('#6200EE')
              .position({ x: this.knobPosition.x, y: this.knobPosition.y })
              .animation({ duration: 200, curve: Curve.EaseOut }, !this.isDragging)
              .gesture(
                DragGesture()
                  .onActionStart(() => {
                    this.isDragging = true
                  })
                  .onUpdate((event: GestureEvent) => {
                    const center: Position = { x: 140 * this.scale, y: 140 * this.scale }
                    const radius = 120 * this.scale
                    
                    let dx = event.offsetX - center.x
                    let dy = event.offsetY - center.y
                    
                    // Calculate distance from center
                    let distance = Math.sqrt(dx * dx + dy * dy)
                    
                    if (distance <= radius) {
                      this.knobPosition = { x: event.offsetX, y: event.offsetY }
                    } else {
                      let angle = Math.atan2(dy, dx)
                      this.knobPosition = {
                        x: center.x + Math.cos(angle) * radius,
                        y: center.y + Math.sin(angle) * radius
                      }
                    }
                  })
                  .onEnd(() => {
                    this.isDragging = false
                  })
              )
          }.width(280 * this.scale).height(280 * this.scale)

          // Track Name
          Text('Track: Summer Nights')
            .fontColor('#FFFFFF')
            .fontSize(22 * this.scale)
            .fontWeight(FontWeight.Medium)

          // Action Buttons
          Row({ space: 32 * this.scale }) {
            Button() {
              Text('Play')
                .fontColor('#FFFFFF')
                .fontSize(22 * this.scale)
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#6200EE')
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)

            Button() {
              Text('Pause')
                .fontColor('#000000')
                .fontSize(22 * this.scale)
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#FFC107')
            .borderRadius(12 * this.scale)
            .width(140 * this.scale)
            .height(56 * this.scale)
          }

          // Debug Info
          Text(`Knob X: ${Math.round(this.knobPosition.x)} Y:${Math.round(this.knobPosition.y)}`)
            .fontColor('#BDBDBD')
            .fontSize(16 * this.scale)
            .fontWeight(FontWeight.Medium)

        }.padding({ left: 32 * this.scale, right: 32 * this.scale })

        Blank()

        // Bottom Safe Area / Clear Space
        Rect()
          .fill(Color.Transparent)
          .height(60 * this.scale)

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }.width('100%').height('100%')
  }
}