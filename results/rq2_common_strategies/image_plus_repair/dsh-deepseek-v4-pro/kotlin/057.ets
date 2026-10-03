@Entry
@Component
struct SleepCyclePage {
  build() {
    Column() {
      // Top app bar (CenterAlignedTopAppBar equivalent)
      Stack({ alignContent: Alignment.Center }) {
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        Row() {
          // navigation icon: back
          Button() {
            Text('<')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#2563EB')
          .onClick(() => {})

          Blank()

          // action icon: help
          Button() {
            Text('?')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#38BDF8')
          .onClick(() => {})
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Content
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: '#CBD5E1' })

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ top: 24 })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .margin({ top: 24 })

        Button() {
          Text('Sign In')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('80%')
        .height(52)
        .borderRadius(16)
        .backgroundColor('#2563EB')
        .margin({ top: 24 })
        .onClick(() => {})
      }
      .layoutWeight(1)
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
