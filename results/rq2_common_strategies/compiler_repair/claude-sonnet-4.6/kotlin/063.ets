@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('⚡')
          .fontSize(24)
          .fontColor('#3B82F6')
          .margin({ left: 8 })
        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('⚙')
          .fontSize(24)
          .fontColor('#F59E0B')
          .margin({ right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Content
      Column() {
        // Battery Icon
        Text('🔋')
          .fontSize(72)
          .margin({ bottom: 20 })

        // Percentage
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 20 })

        // Progress Bar Container
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('80%')
            .height(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(7)
            .border({ width: 1, color: '#D4D4D8' })

          // Fill
          Row()
            .width(`${this.progress * 80}%`)
            .height(14)
            .backgroundColor('#3B82F6')
            .borderRadius(7)
        }
        .width('100%')
        .height(14)
        .margin({ bottom: 20 })

        // Button
        Button('Simulate Charge')
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1.0) {
              this.progress = 0
            }
          })
          .backgroundColor('#22C55E')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .borderRadius(50)
          .margin({ bottom: 20 })

        // Status Text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F4')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .padding(14)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}