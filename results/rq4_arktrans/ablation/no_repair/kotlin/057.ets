@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Column (Main Content) ===
      Column({ space: 24 }) {
        // === Box (Avatar Container) ===
        Stack({ alignContent: Alignment.Center }) {
          // === Text (Emoji) ===
          Text('😴').fontSize(48)
        }
        .width(160).height(160)
        .backgroundColor('#FFFFFF')
        .borderRadius(80)
        .border({ width: 2, color: '#CBD5E1', radius: 80 })

        // === Text (Welcome Back) ===
        Text('Welcome Back')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')

        // === Text (Description) ===
        Text('Track your sleep patterns and improve rest quality.')
        .fontSize(16)
        .fontColor('#1E293B')
        .textAlign(TextAlign.Center)
        .lineHeight(24)

        // === Button (Sign In) ===
        Button() {
          // === Text (Button Label) ===
          Text('Sign In')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
        }
        .width('80%')
        .height(52)
        .backgroundColor('#2563EB')
        .borderRadius(26)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 24, left: 16, right: 16 })
      .linearGradient({
        angle: 90,
        colors: [['#E0F2FE', 0], ['#DBEAFE', 1]]
      })

      // === CenterAlignedTopAppBar (Header) ===
      Row() {
        // === IconButton (Back) ===
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Text('<')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
          }
          .width(24).height(24)
          .backgroundColor('#2563EB')
          .borderRadius(12)
        }
        .margin({ left: 16, top: 16 })

        Blank()

        // === Text (Title) ===
        Text('Sleep Cycle')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

        Blank()

        // === IconButton (Help) ===
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Text('?')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
          }
          .width(24).height(24)
          .backgroundColor('#38BDF8')
          .borderRadius(12)
        }
        .margin({ right: 16, top: 16 })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}