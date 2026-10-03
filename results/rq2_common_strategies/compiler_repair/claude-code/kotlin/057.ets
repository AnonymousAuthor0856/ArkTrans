@Entry
@Component
struct SleepCyclePage {
  @State title: string = 'Sleep Cycle'

  build() {
    Column() {
      this.TopBar()

      Column() {
        Stack() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(80)
        .border({ width: 2, color: '#FFCBD5E1' })
        .alignContent(Alignment.Center)

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF1E293B')
          .margin({ top: 24 })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FF1E293B')
          .margin({ top: 12 })
          .textAlign(TextAlign.Center)

        Button('Sign In')
          .width('80%')
          .height(52)
          .borderRadius(16)
          .backgroundColor('#FF2563EB')
          .fontColor('#FFFFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['rgba(37, 99, 235, 0.1)', 0.0], ['rgba(56, 189, 248, 0.15)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Text('<')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFFFF')
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#FF2563EB')
      .margin({ left: 16 })

      Text(this.title)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF0F172A')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button() {
        Text('?')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF0F172A')
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#FF38BDF8')
      .margin({ right: 16 })
    }
    .width('100%')
    .height(56)
    .backgroundColor('#FFF8FAFC')
    .alignItems(VerticalAlign.Center)
  }
}
