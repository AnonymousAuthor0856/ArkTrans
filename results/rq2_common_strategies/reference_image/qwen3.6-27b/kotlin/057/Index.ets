// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct SleepCyclePage {
  @State private isSignedIn: boolean = false;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('<')
          .backgroundColor('#2563EB')
          .width(40)
          .height(40)
          .borderRadius(20)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            // Back action
          })

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button('?')
          .backgroundColor('#38BDF8')
          .width(40)
          .height(40)
          .borderRadius(20)
          .fontColor('#0F172A')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            // Help action
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column() {
        // Avatar Circle
        Row() {
          Text('😴')
            .fontSize(60)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(Color.White)
        .border({ width: 2, color: '#CBD5E1' })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Welcome Text
        Text('Welcome Back')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1E293B')
          .margin({ top: 30 })

        // Subtitle
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(16)
          .fontColor('#1E293B')
          .margin({ top: 12 })
          .textAlign(TextAlign.Center)
          .lineHeight(24)

        // Sign In Button
        Button('Sign In')
          .width('80%')
          .height(52)
          .backgroundColor('#2563EB')
          .borderRadius(24)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 30 })
          .onClick(() => {
            this.isSignedIn = true;
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#38BDF8', 0.15], ['#2563EB', 0.1]]
    })
  }
}