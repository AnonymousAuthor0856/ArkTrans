@Entry
@Component
struct SleepCycleApp {
  build() {
    Column() {
      // Top App Bar
      Row() {
        // Back button
        Button({ type: ButtonType.Circle }) {
          Text('<')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width(36)
        .height(36)
        .backgroundColor('#2563EB')
        .margin({ left: 16 })

        // Title
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Help button
        Button({ type: ButtonType.Circle }) {
          Text('?')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
        }
        .width(36)
        .height(36)
        .backgroundColor('#38BDF8')
        .margin({ right: 16 })
      }
      .width('100%')
      .height(64)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // Main content with gradient background
      Column() {
        // Sleep emoji circle
        Column() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: '#CBD5E1' })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 40 })

        // Welcome Back text
        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ top: 24 })

        // Description text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .margin({ top: 24, left: 32, right: 32 })

        // Sign In button
        Button('Sign In')
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#2563EB')
          .borderRadius(16)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#D6F0FC', 0.0], ['#D6E4FA', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}