@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('<')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .width(36)
        .height(36)
        .backgroundColor('#2563EB')

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text('?')
            .fontSize(12)
            .fontColor('#0F172A')
            .fontWeight(FontWeight.Medium)
        }
        .width(36)
        .height(36)
        .backgroundColor('#38BDF8')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F8FAFC')

      // Main Content
      Column() {
        // Sleep emoji circle
        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill('#FFFFFF')
            .stroke('#CBD5E1')
            .strokeWidth(2)

          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .margin({ bottom: 24 })

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ bottom: 12 })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .padding({ left: 24, right: 24 })
          .margin({ bottom: 24 })

        Button('Sign In')
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#2563EB')
          .borderRadius(16)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#26BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}