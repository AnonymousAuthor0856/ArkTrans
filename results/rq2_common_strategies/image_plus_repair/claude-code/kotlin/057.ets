@Entry
@Component
struct SleepCycle {
  @Builder
  BackButton() {
    Text('<')
      .fontSize(20)
      .fontColor('#FFFFFF')
      .fontWeight(FontWeight.Bold)
  }

  @Builder
  HelpButton() {
    Text('?')
      .fontSize(20)
      .fontColor('#0F172A')
      .fontWeight(FontWeight.Bold)
  }

  @Builder
  SleepEmoji() {
    Text('😴')
      .fontSize(64)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Back button
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 48, height: 48 })
            .fill('#2563EB')
          this.BackButton()
        }
        .width(48)
        .height(48)
        .margin({ left: 16 })

        // Title
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Help button
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 48, height: 48 })
            .fill('#38BDF8')
          this.HelpButton()
        }
        .width(48)
        .height(48)
        .margin({ right: 16 })
      }
      .width('100%')
      .height(72)
      .backgroundColor('#FFFFFF')

      // Main content with gradient background
      Column() {
        // Emoji circle
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 200, height: 200 })
            .fill('#FFFFFF')
            .stroke('#CBD5E1')
            .strokeWidth(2)
          this.SleepEmoji()
        }
        .width(200)
        .height(200)
        .margin({ top: 48, bottom: 32 })

        // Welcome Back
        Text('Welcome Back')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ bottom: 16 })

        // Subtitle
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(22)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .margin({ left: 24, right: 24, bottom: 36 })

        // Sign In button
        Button('Sign In')
          .width('80%')
          .height(68)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#2563EB')
          .borderRadius(28)
          .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['rgba(56, 189, 248, 0.15)', 0.0], ['rgba(37, 99, 235, 0.10)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
