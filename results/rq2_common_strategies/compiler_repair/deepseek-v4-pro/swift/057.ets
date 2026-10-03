@Entry
@Component
struct SleepCycleApp {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#E6F0FF')

      // Main column
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          // Left navigation icon
          Button() {
            Text('<')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width(24)
              .height(24)
          }
          .width(24)
          .height(24)
          .backgroundColor('#2563EB')
          .borderRadius(12)
          .margin({ left: 16 })

          Blank()
          // Title
          Text('Sleep Cycle')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#0F172A')
          Blank()
          // Right actions icon
          Button() {
            Text('?')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#0F172A')
              .textAlign(TextAlign.Center)
              .width(24)
              .height(24)
          }
          .width(24)
          .height(24)
          .backgroundColor('#38BDF8')
          .borderRadius(12)
          .margin({ right: 16 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .alignItems(VerticalAlign.Center)

        // Main content
        Column({ space: 36 }) {
          Blank()
          // Central emoji box
          Stack() {
            // Outer circle
            Column()
              .width(160)
              .height(160)
              .backgroundColor('#FFFFFF')
              .borderRadius(80)
              .border({ width: 2, color: '#CBD5E1' })
            // Emoji text centered
            Text('😴')
              .fontSize(48)
          }
          .width(160)
          .height(160)
          .alignSelf(ItemAlign.Center)

          // Welcome Back Text
          Text('Welcome Back')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1E293B')
            .textAlign(TextAlign.Center)
            .width('100%')

          // Description Text
          Text('Track your sleep patterns and improve rest quality.')
            .fontSize(14)
            .foregroundColor('#1E293B')
            .textAlign(TextAlign.Center)
            .width('80%')
            .alignSelf(ItemAlign.Center)

          // Sign In Button
          Button() {
            Text('Sign In')
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
          .alignSelf(ItemAlign.Center)

          Blank()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}