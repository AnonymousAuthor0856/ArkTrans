@Entry
@Component
struct Index {
  @State progress: number = 0.45

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('🚗')
          .fontSize(28)
          .fontColor('#3B82F6')
          .margin({ left: 12 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('⚙️')
          .fontSize(28)
          .fontColor('#F59E0B')
          .margin({ right: 12 })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Divider
      Divider()
        .color('#D4D4D8')
        .strokeWidth(1)

      // Content
      Column() {
        // Battery Icon
        Column() {
          Text('🔋')
            .fontSize(72)
            .fontColor('#3B82F6')
        }
        .margin({ bottom: 20 })

        // Percentage Text
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 20 })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('80%')
            .height(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(7)
            .border({ width: 1, color: '#D4D4D8', radius: 7 })

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

        // Simulate Charge Button
        Button('Simulate Charge')
          .width(200)
          .height(50)
          .backgroundColor('#22C55E')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(25)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1.0) {
              this.progress = 0
            }
          })

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