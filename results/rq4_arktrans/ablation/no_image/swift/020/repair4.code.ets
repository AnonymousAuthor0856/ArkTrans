import { gesture } from '@kit.ArkUI'

interface KnobPosition {
  x: number
  y: number
}

@Entry
@Component
struct Index {
  @State powerOn: boolean = false
  @State knobPosition: KnobPosition = { x: 90, y: 140 }

  build() {
    Stack() {
      Column() {
        // Header
        Stack() {
          Text('Retro Remote Control')
            .fontColor('#1E1E1E')
            .fontSize(28)
        }.height(64)

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Knob Canvas Area
            Stack() {
              // Simulating Canvas with a clickable area for the knob
              // In ArkTS, we use a container with gesture to track position
              Row() {
                Text('')
              }
              .width(280)
              .height(280)
              .backgroundColor('#F5F5F5') // Placeholder background for canvas area
              .borderRadius(24)
              .shadow({ radius: 10, color: '#1F000000', offsetX: 0, offsetY: 4 })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    if (event) {
                      let newX = this.knobPosition.x + event.offsetX
                      let newY = this.knobPosition.y + event.offsetY
                      
                      // Bounds checking (approximate based on 280x280 and padding)
                      const min = 16
                      const max = 264
                      
                      if (newX < min) newX = min
                      if (newX > max) newX = max
                      if (newY < min) newY = min
                      if (newY > max) newY = max

                      this.knobPosition = { x: newX, y: newY }
                    }
                  })
              )
              
              // Visual representation of the knob at current position
              Circle()
                .width(40)
                .height(40)
                .backgroundColor('#333333')
                .position({ x: this.knobPosition.x - 20, y: this.knobPosition.y - 20 })
            }
            .padding(24)
            .width(280)
            .height(280)
            .clipShape(RoundedRectangle({ width: 280, height: 280, radius: 24 }))
            .shadow({ radius: 10, color: '#1F000000', offsetX: 0, offsetY: 4 })

            // Power Status Text
            Text(this.powerOn ? "Power: ON" : "Power: OFF")
              .fontColor(this.powerOn ? '#4CAF50' : '#F44336')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            // Buttons Row
            Row({ space: 60 }) {
              // On/Off Button
              Button() {
                Text('On')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
              }
              .width(80)
              .height(80)
              .backgroundColor('#FF7A00')
              .clipShape(Circle())
              .onClick(() => {
                this.powerOn = !this.powerOn
              })

              // Reset Button
              Button() {
                Column() {
                  Text('Res')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                  Text('et')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                  Circle()
                    .width(10)
                    .height(10)
                    .backgroundColor('#FFFFFF')
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(80)
              .height(80)
              .backgroundColor('#607D8B')
              .clipShape(Circle())
              .onClick(() => {
                this.knobPosition = { x: 90, y: 140 }
              })
            }

            // Capsule / Rect placeholder
            Rect()
              .width(200)
              .height(20)
              .fill('#CCCCCC')
              .borderRadius(10)
          }
          .padding(24)
          .alignItems(HorizontalAlign.Center)
        }.backgroundColor('#FFF8E7')
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}