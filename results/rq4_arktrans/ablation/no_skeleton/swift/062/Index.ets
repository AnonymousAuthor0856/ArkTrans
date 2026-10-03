@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = "Cool"

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#3B82F6')
          .margin({ left: 12 })

        Blank()

        Text("ThermoCurve")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')

        Blank()

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#06B6D4')
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
        .margin({ right: 12 })
        .onClick(() => {
          this.targetTemp += 1
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E0F2FE')

      // === Main Content ===
      Column() {
        Text("Target Temperature")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B82F6')
          .margin({ top: 12, bottom: 26 })

        Row() {
          Button() {
            Text("–")
              .fontSize(20)
              .fontColor('#FFFFFF')
          }
          .width(60)
          .height(60)
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1
            }
          })

          Button() {
            Text("+")
              .fontSize(20)
              .fontColor('#FFFFFF')
          }
          .width(60)
          .height(60)
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .margin({ left: 12 })
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          })
        }
        .justifyContent(FlexAlign.Center)

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color('#CBD5E1')
          .opacity(0.5)
          .margin({ top: 26, bottom: 26 })

        Text("Mode")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)

        Row() {
          // Cool Mode Button
          Column() {
            Image($r('app.media.startIcon'))
              .width(32)
              .height(32)
              .objectFit(ImageFit.Contain)
              .fillColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
            
            Text("Cool")
              .fontSize(12)
              .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
              .margin({ top: 4 })
          }
          .width(100)
          .height(100)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E0F2FE')
          .shadow({ radius: 5, color: 'rgba(0,0,0,0.1)', offsetY: 5 })
          .onClick(() => {
            this.mode = 'Cool'
          })

          // Heat Mode Button
          Column() {
            Image($r('app.media.startIcon'))
              .width(32)
              .height(32)
              .objectFit(ImageFit.Contain)
              .fillColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
            
            Text("Heat")
              .fontSize(12)
              .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
              .margin({ top: 4 })
          }
          .width(100)
          .height(100)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(50)
          .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E0F2FE')
          .shadow({ radius: 5, color: 'rgba(0,0,0,0.1)', offsetY: 5 })
          .margin({ left: 18 })
          .onClick(() => {
            this.mode = 'Heat'
          })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 26 })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .margin({ top: 26 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(18)
      .linearGradient({
        angle: 90,
        colors: [['#06B6D4', 0.15], ['#3B82F6', 0.2]]
      })
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
  }
}