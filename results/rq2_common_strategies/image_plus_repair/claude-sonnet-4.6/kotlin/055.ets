@Entry
@Component
struct WorkoutPlanApp {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top App Bar
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')

        // Main Content with gradient background
        Column({ space: 16 }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .textAlign(TextAlign.Center)

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
          .border({ width: 1, color: '#CBD5E1' })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          // Authenticate Button
          Button('Authenticate')
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
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#D9F0FC', 0.0], ['#D6E4FA', 1.0]]
        })
      }
      .width('100%')
      .height('100%')

      // FAB Button
      Column() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#2563EB')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 80, right: 16 })
      .alignSelf(ItemAlign.End)

      // Bottom Navigation Bar
      Row() {
        Text('Home')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFF')
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}