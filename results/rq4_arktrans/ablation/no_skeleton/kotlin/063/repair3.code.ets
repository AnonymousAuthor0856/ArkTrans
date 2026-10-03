@Entry
@Component
struct ChargingProgress {
  @State progress: number = 45

  build() {
    Column() {
      // === Header Row ===
      Row() {
        // Left Icon (Car)
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#3B82F6') // Tint simulation via background for placeholder
          .borderRadius(4)
        
        Blank()

        // Title Text
        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
        
        Blank()

        // Right Icon (Settings)
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#F59E0B') // Tint simulation
          .borderRadius(4)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // === Main Content Column ===
      Column() {
        // Battery Icon
        Image($r('app.media.startIcon'))
          .width(72)
          .height(72)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#3B82F6') // Tint simulation
          .borderRadius(8)
        
        // Percentage Text
        Text(`${this.progress}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ top: 20 })

        // Progress Bar Container
        Stack({ alignContent: Alignment.Start }) {
          // Track (White with Border)
          Row()
            .width('80%')
            .height(14)
            .backgroundColor('#FFFFFF')
            .borderWidth(1)
            .borderColor('#D4D4D8')
            .borderRadius(7)
          
          // Fill (Blue)
          Row()
            .width(`${this.progress}%`)
            .height(14)
            .backgroundColor('#3B82F6')
            .borderRadius(7)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        // Simulate Charge Button
        Button('Simulate Charge')
          .type(ButtonType.Capsule)
          .backgroundColor('#22C55E')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('60%')
          .height(48)
          .margin({ top: 20 })
          .onClick(() => {
            this.progress += 10;
            if (this.progress > 100) {
              this.progress = 0;
            }
          })

        // Status Text
        Text(this.progress < 100 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 100 ? '#3B82F6' : '#22C55E')
          .margin({ top: 20 })

      }
      .layoutWeight(1)
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 14, right: 14 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}