@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  private handleSimulateCharge(): void {
    this.progress += 0.1
    if (this.progress > 1.0) {
      this.progress = 0.0
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        // Electric Car Icon
        Text('\u{1F697}')
          .fontSize(24)
          .fontColor('#3B82F6')

        Spacer()

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Spacer()

        // Settings Gear Icon
        Text('\u{2699}\u{FE0F}')
          .fontSize(24)
          .fontColor('#F59E0B')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFFFFF')

      // Main Content
      Column({ space: 14 }) {
        // Battery and Percentage
        Column({ space: 10 }) {
          // Custom Vertical Battery Icon
          Stack() {
            // Battery body - full blue
            Column()
              .width(50)
              .height(90)
              .backgroundColor('#3B82F6')
              .borderRadius(8)

            // Battery top nub
            Column()
              .width(20)
              .height(10)
              .backgroundColor('#3B82F6')
              .borderRadius(3)
              .translate({ y: -50 })

            // Lightning bolt - using text
            Text('\u{26A1}')
              .fontSize(40)
              .fontColor('#FFFFFF')
          }
          .width(60)
          .height(100)

          // Percentage Text
          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
        }
        .margin({ top: 10 })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('70%')
            .height(12)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#D4D4D8' })
            .borderRadius(6)

          // Indicator
          Row()
            .width(`${Math.min(Math.max(this.progress, 0), 1) * 70}%`)
            .height(12)
            .backgroundColor('#3B82F6')
            .borderRadius(6)
            .margin({ left: 1, top: 1, bottom: 1 })
        }
        .width('100%')
        .margin({ top: 14 })

        // Simulate Charge Button
        Button('Simulate Charge')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#22C55E')
          .borderRadius(999)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .onClick(() => {
            this.handleSimulateCharge()
          })
          .margin({ top: 14 })

        // Status Text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E')
          .margin({ top: 10 })

        Spacer()
      }
      .width('100%')
      .padding(14)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}
