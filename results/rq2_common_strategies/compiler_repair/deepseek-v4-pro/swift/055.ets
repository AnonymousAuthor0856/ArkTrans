@Entry
@Component
struct WorkoutPlanApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F8FAFC')

      // Main content Column
      Column({ space: 16 }) {
        // Spacer for top bar
        Blank().height(64)

        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)

        // Workout preview box
        Stack() {
          Text('Workout Preview')
            .fontSize(14)
            .foregroundColor('#1E293B')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#CBD5E1', radius: 16 })

        // Authenticate button
        Button() {
          Text('Authenticate')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFF')
            .width('100%')
            .height(52)
            .textAlign(TextAlign.Center)
        }
        .width('80%')
        .height(52)
        .backgroundColor('#2563EB')
        .borderRadius(16)
        .margin({ left: '10%' })

        // Spacer for bottom bar
        Blank().height(80)
      }
      .width('100%')
      .height('100%')
      .padding(16)

      // Top bar (positioned at top)
      Column() {
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#0F172A')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(64)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .position({ x: 0, y: 0 }) // pinned to top

      // Bottom bar (positioned at bottom)
      Column() {
        Row({ space: 0 }) {
          Text('Home')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#2563EB')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Plan')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1E293B')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1E293B')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .position({ x: 0, y: '100%' }) // pinned to bottom
      .margin({ bottom: 0 }) // ensures bottom edge

      // FAB (positioned at bottom trailing)
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width(56)
          .height(56)
      }
      .width(56)
      .height(56)
      .backgroundColor('#2563EB')
      .borderRadius(28)
      .position({ x: '100%', y: '100%' })
      .margin({ right: 16, bottom: 96 }) // offset from bottom bar
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}