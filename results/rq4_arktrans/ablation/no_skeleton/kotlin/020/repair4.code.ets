@Entry
@Component
struct RetroRemoteControl {
  @State knobX: number = 0
  @State knobY: number = 0
  @State powerOn: boolean = false

  build() {
    Column() {
      // === Top Bar / Title ===
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 24 })

      // === Knob Surface ===
      Stack() {
        // Background Circle (Secondary with alpha)
        Circle({ width: 200, height: 200 })
          .fill(Color.Transparent)
          .backgroundColor('#FFC300')
          .opacity(0.2)

        // Draggable Knob (Primary)
        Circle({ width: 48, height: 48 })
          .fill('#FF7A00')
          .position({ x: this.knobX - 24, y: this.knobY - 24 })
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  this.knobX += event.offsetX
                  this.knobY += event.offsetY
                }
              })
          )
      }
      .width(280)
      .height(280)
      .borderRadius(24)
      .backgroundColor('#FFEBC8')
      .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
      .padding(16)

      // === Power Status Text ===
      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? '#28A745' : '#DC3545')
        .margin({ top: 24 })

      // === Action Buttons Row ===
      Row() {
        // On/Off Button
        Button(this.powerOn ? 'Off' : 'On')
          .type(ButtonType.Normal)
          .backgroundColor('#FF7A00')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width(80)
          .height(80)
          .borderRadius(40)
          .onClick(() => {
            this.powerOn = !this.powerOn
          })

        // Reset Button
        Button('Reset')
          .type(ButtonType.Normal)
          .backgroundColor('#FFC300')
          .fontColor('#1E1E1E')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width(80)
          .height(80)
          .borderRadius(40)
          .onClick(() => {
            this.knobX = 0
            this.knobY = 0
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ top: 24 })

      // === Progress Indicator ===
      Progress({
        value: Math.abs((this.knobX + this.knobY) % 400) / 400,
        total: 1,
        type: ProgressType.Linear
      })
      .width('100%')
      .height(6)
      .color('#FF7A00')
      .trackColor('#FFEBC8')
      .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
    .padding(16)
  }
}