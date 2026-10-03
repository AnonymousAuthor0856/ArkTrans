@Entry
@Component
struct Index {
  @State powerOn: boolean = false
  @State knobPosition: { x: number, y: number } = { x: 90, y: 140 }

  build() {
    Stack() {
      Column() {
        // Header
        Text('Retro Remote Control')
          .fontColor('#1E1E1E')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 60, bottom: 30 })

        Scroll() {
          Column() {
            // Knob Area
            Stack() {
              // Background Circle (Track)
              Circle()
                .width(220)
                .height(220)
                .fill('#FFE5A0')

              // Draggable Knob
              Circle()
                .width(40)
                .height(40)
                .fill('#FF7A00')
                .position({ x: this.knobPosition.x - 20, y: this.knobPosition.y - 20 })
                .gesture(
                  PanGesture()
                    .onActionUpdate((event: GestureEvent) => {
                      if (event) {
                        let newX = this.knobPosition.x + event.offsetX
                        let newY = this.knobPosition.y + event.offsetY
                        
                        // Boundary checks (approximate for 280 container with padding)
                        const minX = 40; 
                        const maxX = 240;
                        const minY = 40;
                        const maxY = 240;

                        this.knobPosition.x = Math.max(minX, Math.min(maxX, newX))
                        this.knobPosition.y = Math.max(minY, Math.min(maxY, newY))
                      }
                    })
                )
            }
            .width(280)
            .height(280)
            .backgroundColor('#FFF0D4')
            .borderRadius(40)
            .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
            .margin({ bottom: 20 })

            // Status Text
            Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
              .fontColor(this.powerOn ? '#4CAF50' : '#D32F2F')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 30 })

            // Buttons Row
            Row() {
              // On Button
              Button() {
                Text('On')
                  .fontColor('#FFFFFF')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
              }
              .width(80)
              .height(80)
              .backgroundColor('#FF7A00')
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = true
              })

              // Reset Button
              Button() {
                Column() {
                  Text('Res')
                    .fontColor('#1E1E1E')
                    .fontSize(20)
                    .lineHeight(24)
                  Text('et')
                    .fontColor('#1E1E1E')
                    .fontSize(20)
                    .lineHeight(24)
                }
              }
              .width(80)
              .height(80)
              .backgroundColor('#FFCA28')
              .borderRadius(40)
              .onClick(() => {
                this.knobPosition = { x: 90, y: 140 }
              })
            }
            .justifyContent(FlexAlign.SpaceAround)
            .width('100%')
            .margin({ bottom: 30 })

            // Bottom Capsule/Line
            Rect()
              .width('90%')
              .height(8)
              .fill('#FF7A00')
              .borderRadius(4)
              .margin({ bottom: 40 })

          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .backgroundColor('#FFF8E7')

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
  }
}