@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // Main Content
      Column() {
        // Gradient background column
        Column({ space: 16 }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          // Workout Preview Box
          Column() {
            Text('Workout Preview')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E293B')
          }
          .width('100%')
          .height(200)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#CBD5E1', radius: 16 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          // Authenticate Button
          Button('Authenticate')
            .width('80%')
            .height(52)
            .borderRadius(16)
            .backgroundColor('#2563EB')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#D6F0FC', 0.0], ['#CCDAF7', 1.0]]
      })

      // Bottom Bar
      Row() {
        Text('Home')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')

        Text('Plan')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
      }
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // FAB Row
      Row() {
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#2563EB')
          .fontColor('#FFFFFF')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 16, bottom: 8 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}