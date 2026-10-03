@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Stack() {
            Circle()
              .fill(Color.White)
              .width(36)
              .height(36)
              .backgroundColor('#2563EB')
              .borderRadius(18)
            Text('<')
              .fontColor('#FFFFFF')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .width(36)
        .height(36)
        .borderRadius(18)
        .margin({ left: 16 })

        Blank()

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        Blank()

        Button() {
          Stack() {
            Circle()
              .fill(Color.White)
              .width(36)
              .height(36)
              .backgroundColor('#38BDF8')
              .borderRadius(18)
            Text('?')
              .fontColor('#0F172A')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .width(36)
        .height(36)
        .borderRadius(18)
        .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column({ space: 24 }) {
        Blank()

        // Central Emoji Circle
        Stack() {
          Circle()
            .fill(Color.White)
            .width(160)
            .height(160)
            .backgroundColor('#FFFFFF')
            .border({ width: 2, color: '#CBD5E1', radius: 80 })
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .padding({ left: 16, right: 16 })

        // Sign In Button
        Button('Sign In')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('80%')
          .height(52)
          .backgroundColor('#2563EB')
          .borderRadius(16)

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#E6F0FF')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6F0FF')
  }
}