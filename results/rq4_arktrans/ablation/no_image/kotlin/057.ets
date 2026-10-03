@Entry
@Component
struct Index {
  @State emoji: string = '😴'
  @State fontSize: number = 48
  @State titleText: string = 'Welcome Back'
  @State subtitleText: string = 'Track your sleep patterns and improve rest quality.'
  @State buttonText: string = 'Sign In'
  @State appBarTitle: string = 'Sleep Cycle'
  @State backIcon: string = '<'
  @State helpIcon: string = '?'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // Box with Icon
        Stack({ alignContent: Alignment.Center }) {
          Text(this.emoji).fontSize(this.fontSize)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: '#E2E8F0', radius: 80 })

        // Title
        Text(this.titleText)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')

        // Subtitle
        Text(this.subtitleText)
          .fontSize(16)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)

        // Button
        Button() {
          Text(this.buttonText)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('80%')
        .height(52)
        .backgroundColor('#2563EB')
        .borderRadius(12)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#38BDF8', 0.15], ['#2563EB', 0.1]]
      })

      // Top App Bar Simulation
      Row() {
        // Back Button
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.backIcon)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#2563EB')
        }
        .margin({ right: 8 })

        // Title
        Text(this.appBarTitle)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Help Button
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.helpIcon)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#38BDF8')
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}