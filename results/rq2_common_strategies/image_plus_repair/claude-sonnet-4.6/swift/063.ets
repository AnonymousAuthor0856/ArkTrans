@Entry
@Component
struct ChargingProgressApp {
  @State progress: number = 0.45

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('⚡')
          .fontSize(24)
          .fontColor('#3B82F6')
          .padding({ left: 8 })

        Blank()

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Blank()

        Text('⚙')
          .fontSize(24)
          .fontColor('#F59E0B')
          .padding({ right: 8 })
      }
      .width('100%')
      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Content
      Column({ space: 14 }) {
        // Battery Icon + Percentage
        Column({ space: 10 }) {
          // Battery Icon
          Stack() {
            // Battery body
            Column() {
              // Battery top nub
              Row()
                .width(20)
                .height(8)
                .borderRadius(3)
                .backgroundColor('#3B82F6')
                .margin({ bottom: 0 })

              // Battery main body
              Stack() {
                // Battery background
                Column()
                  .width(50)
                  .height(90)
                  .borderRadius(8)
                  .backgroundColor('#3B82F6')

                // Lightning bolt shape using text
                Text('⚡')
                  .fontSize(32)
                  .fontColor('#FFFFFF')
                  .fontWeight(FontWeight.Bold)
              }
              .width(50)
              .height(90)
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width(60)
          .height(108)

          // Percentage Text
          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 10 })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(12)
            .borderRadius(6)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#D4D4D8' })

          // Indicator
          Row()
            .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
            .height(10)
            .borderRadius(5)
            .backgroundColor('#3B82F6')
            .margin({ left: 1 })
        }
        .width('70%')
        .height(12)
        .borderRadius(6)
        .clip(true)
        .margin({ top: 14 })

        // Simulate Button
        Button('Simulate Charge')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#22C55E')
          .borderRadius(50)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .margin({ top: 14 })
          .onClick(() => {
            let newProgress = this.progress + 0.1
            if (newProgress > 1.0) {
              newProgress = 0.0
            }
            animateTo({ duration: 300 }, () => {
              this.progress = newProgress
            })
          })

        // Status Text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E')
          .margin({ top: 10 })

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}