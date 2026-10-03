@Entry
@Component
struct WorkoutPlanPage {
  @State selectedTab: string = 'Home'

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Row() {
          Text('Workout Plan')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
        }
        .width('100%')
        .height(72)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')

        // Main content area with gradient background
        Column() {
          Text('Sign In to Continue')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .margin({ top: 24, bottom: 24 })

          // Workout Preview box
          Row() {
            Text('Workout Preview')
              .fontSize(28)
              .fontColor('#1E293B')
          }
          .width('100%')
          .height(200)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .border({ width: 1, color: '#CBD5E1' })
          .justifyContent(FlexAlign.Center)

          // Authenticate button
          Button('Authenticate')
            .width('80%')
            .height(52)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#2563EB')
            .borderRadius(24)
            .margin({ top: 24 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['rgba(37, 99, 235, 0.15)', 0.0], ['rgba(56, 189, 248, 0.1)', 1.0]]
        })

        // Bottom Navigation Bar
        Row() {
          Text('Home')
            .fontSize(28)
            .fontColor('#2563EB')
            .fontWeight(FontWeight.Medium)
            .onClick(() => { this.selectedTab = 'Home' })

          Text('Plan')
            .fontSize(28)
            .fontColor('#1E293B')
            .fontWeight(FontWeight.Medium)
            .onClick(() => { this.selectedTab = 'Plan' })

          Text('Profile')
            .fontSize(28)
            .fontColor('#1E293B')
            .fontWeight(FontWeight.Medium)
            .onClick(() => { this.selectedTab = 'Profile' })
        }
        .width('100%')
        .height(72)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#EDF2FE')
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Stack() {
        Text('+')
          .fontSize(40)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(64)
      .height(64)
      .backgroundColor('#2563EB')
      .borderRadius(32)
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.3)', offsetX: 2, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
    .alignContent(Alignment.BottomEnd)
    .padding({ right: 24, bottom: 96 })
  }
}
