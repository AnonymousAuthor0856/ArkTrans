@Entry
@Component
struct WorkoutPlanPage {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top app bar (center-aligned title)
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')

        // Main content
        Column({ space: 16 }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Column() {
            Text('Workout Preview')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E293B')
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#CBD5E1' })

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
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          angle: 180,
          colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
        })

        // Bottom app bar
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
        .height(64)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      // Floating action button
      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .backgroundColor('#2563EB')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ right: 16, bottom: 80 })
    }
    .width('100%')
    .height('100%')
  }
}