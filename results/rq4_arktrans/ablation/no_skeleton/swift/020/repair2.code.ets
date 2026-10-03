import { Point } from '@kit.ArkUI'

@Entry
@Component
struct RetroRemoteControl {
  @State knobPosition: Point = { x: 90, y: 140 }
  @State powerOn: boolean = false

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF8E7')

      // Scrollable Content
      Scroll() {
        Column() {
          // Knob Surface
          Stack() {
            // Background circle (secondary with opacity)
            Circle()
              .width(200)
              .height(200)
              .fill('#FFC300')
              .opacity(0.2)

            // Knob circle (primary)
            Circle()
              .width(32)
              .height(32)
              .fill('#FF7A00')
              .position({ x: this.knobPosition.x - 16, y: this.knobPosition.y - 16 })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    let newX = event.offsetX + 90
                    let newY = event.offsetY + 140
                    
                    // Clamp values between 16 and 264
                    if (newX < 16) newX = 16
                    if (newX > 264) newX = 264
                    if (newY < 16) newY = 16
                    if (newY > 264) newY = 264

                    this.knobPosition = { x: newX, y: newY }
                  })
              )
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .backgroundColor('#FFEBC8')
          .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
          .margin({ top: 16, bottom: 16 })

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? '#28A745' : '#DC3545')
            .margin({ top: 16, bottom: 16 })

          // Buttons Row
          Row() {
            // On Button
            Button() {
              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor('#FF7A00')
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            // Reset Button
            Button() {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E1E1E')
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E1E1E')
              }
            }
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor('#FFC300')
            .onClick(() => {
              this.knobPosition = { x: 90, y: 140 }
            })
          }
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
          .margin({ top: 16, bottom: 16 })

          // Progress Bar
          Capsule()
            .width('100%')
            .height(6)
            .fill('#FF7A00')
            .margin({ left: 16, right: 16 })
        }
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
  }
}