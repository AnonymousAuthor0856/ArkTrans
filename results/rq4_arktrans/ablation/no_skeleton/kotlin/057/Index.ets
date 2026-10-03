@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // === Top Bar ===
      Row() {
        // Back Button
        Row() {
          Text('<')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor('#2563EB')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        Blank()

        // Help Button
        Row() {
          Text('?')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor('#38BDF8')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // === Main Content ===
      Column() {
        // Avatar
        Row() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: '#CBD5E1' })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Headline
        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1E293B')
          .margin({ top: 24 })

        // Body Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .margin({ top: 12 })

        // Sign In Button
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
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#38BDF8', 0.15], ['#2563EB', 0.1]]
      })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}