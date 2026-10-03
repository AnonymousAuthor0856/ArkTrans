@Entry
@Component
struct SleepCycleApp {
  private readonly primaryColor: string = '#2563EB'
  private readonly secondaryColor: string = '#38BDF8'
  private readonly pageBackgroundColor: string = '#E6F0FF'
  private readonly darkTextColor: string = '#0F172A'
  private readonly bodyTextColor: string = '#1E293B'
  private readonly circleOutlineColor: string = '#CBD5E1'

  build() {
    Column() {
      Row() {
        Button('<')
          .width(48)
          .height(48)
          .fontSize(24)
          .fontColor('#FFFFFF')
          .backgroundColor(this.primaryColor)
          .borderRadius(24)
          .padding(0)
          .onClick(() => {
          })

        Text('Sleep Cycle')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.darkTextColor)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button('?')
          .width(48)
          .height(48)
          .fontSize(24)
          .fontColor(this.darkTextColor)
          .backgroundColor(this.secondaryColor)
          .borderRadius(24)
          .padding(0)
          .onClick(() => {
          })
      }
      .width('100%')
      .height(112)
      .padding({ left: 32, right: 32 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Blank()
          .layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(324)
            .height(324)
            .fill('#FFFFFF')
            .border({
              width: 4,
              color: this.circleOutlineColor,
              radius: 162
            })

          Text('😴')
            .fontSize(64)
            .textAlign(TextAlign.Center)
        }
        .width(324)
        .height(324)

        Text('Welcome Back')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.bodyTextColor)
          .textAlign(TextAlign.Center)
          .margin({ top: 48 })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(28)
          .fontColor(this.bodyTextColor)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 42 })

        Button('Sign In')
          .width('80%')
          .height(104)
          .fontSize(32)
          .fontColor('#FFFFFF')
          .backgroundColor(this.primaryColor)
          .borderRadius(32)
          .margin({ top: 48 })
          .onClick(() => {
          })

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .backgroundColor(this.pageBackgroundColor)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackgroundColor)
  }
}
