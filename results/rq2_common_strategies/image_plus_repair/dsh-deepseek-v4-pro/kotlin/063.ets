@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  build() {
    Column() {
      // Center-aligned top app bar
      Row() {
        Text('🚗')
          .fontSize(24)
          .fontColor('#3B82F6')
          .padding({ left: 8 })

        Blank()

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Blank()

        Text('⚙️')
          .fontSize(24)
          .fontColor('#F59E0B')
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor('#FFFFFF')

      // Main content
      Column({ space: 20 }) {
        Text('🔋')
          .fontSize(72)
          .fontColor('#3B82F6')

        Text(Math.floor(this.progress * 100) + '%')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Progress({ value: Math.floor(this.progress * 100), total: 100, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color('#3B82F6')
          .backgroundColor('#FFFFFF')
          .borderRadius(7)
          .border({ width: 1, color: '#D4D4D8' })

        Button() {
          Text('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(40)
        .backgroundColor('#22C55E')
        .borderRadius(20)
        .onClick(() => {
          this.progress += 0.1
          if (this.progress > 1) {
            this.progress = 0
          }
        })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? '#3B82F6' : '#22C55E')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}
