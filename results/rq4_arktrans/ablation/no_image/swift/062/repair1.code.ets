@Entry
@Component
struct Index {
  @State targetTemp: number = 25
  @State mode: string = 'Auto'

  build() {
    Stack() {
      Column() {
        // === HStack (Header) ===
        Row() {
          // Image placeholder using required resource
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .padding({ left: 8 })

          Blank()

          Text('ThermoCurve')
            .fontColor('#1E293B')
            .fontSize(26)

          Blank()

          Button()
            .type(ButtonType.Circle)
            .backgroundColor('transparent')
            .onClick(() => {
              this.targetTemp += 1
            })
            .padding({ right: 8 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F1F5F9') // surfaceVariant approximation

        // === VStack (Content) ===
        Column() {
          Text('Target Temperature')
            .fontColor('#1E293B')
            .fontSize(18)

          Text(`${this.targetTemp}°C`)
            .fontColor('#3B82F6')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)

          // Control Buttons Row
          Row() {
            Button('-')
              .onClick(() => {
                if (this.targetTemp > 10) {
                  this.targetTemp -= 1
                }
              })
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#E2E8F0')

            Button('+')
              .onClick(() => {
                if (this.targetTemp < 35) {
                  this.targetTemp += 1
                }
              })
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#E2E8F0')
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16, bottom: 16 })

          Text('Mode')
            .fontColor('#1E293B')
            .fontSize(18)

          // Mode Selection Row
          Row() {
            Button('Auto')
              .onClick(() => {
                this.mode = 'Auto'
              })
              .backgroundColor(this.mode === 'Auto' ? '#3B82F6' : '#E2E8F0')
              .fontColor(this.mode === 'Auto' ? '#FFFFFF' : '#1E293B')
              .borderRadius(8)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })

            Button('Manual')
              .onClick(() => {
                this.mode = 'Manual'
              })
              .backgroundColor(this.mode === 'Manual' ? '#3B82F6' : '#E2E8F0')
              .fontColor(this.mode === 'Manual' ? '#FFFFFF' : '#1E293B')
              .borderRadius(8)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          }
          .justifyContent(FlexAlign.Start)
          .margin({ top: 16, bottom: 16 })

          Text(`Current Mode: ${this.mode}`)
            .fontColor('#1E293B')
            .fontSize(14)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}