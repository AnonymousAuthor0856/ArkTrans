const PRIMARY: string = '#FF7042'
const SECONDARY: string = '#FFB84D'
const BACKGROUND: string = '#FFF2E0'
const SURFACE: string = '#FFFFFF'
const TRACK: string = '#F9E2C2'
const TEXT: string = '#412B28'

@Entry
@Component
struct OrderTrackingApp {
  @State private progress: number = 42

  build() {
    Column() {
      Column({ space: 16 }) {
        Text('Order Tracking')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 24 })

        Column({ space: 10 }) {
          Text('Order #25491')
            .fontSize(36)
            .fontColor(TEXT)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(27)
            .fontColor(SECONDARY)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .height(20)
              .width('100%')
              .backgroundColor(TRACK)
              .borderRadius(10)

            Row()
              .height(20)
              .width(`${this.progress}%`)
              .backgroundColor(PRIMARY)
              .borderRadius(10)
          }
          .width('100%')
          .height(20)
          .margin({ top: 4, bottom: 6 })

          Row() {
            Text('Processing')
              .fontSize(24)
              .fontColor(SECONDARY)

            Blank()
              .layoutWeight(1)

            Text(`${Math.round(this.progress)}%`)
              .fontSize(24)
              .fontColor(PRIMARY)
          }
          .width('100%')
        }
        .width('100%')
        .padding(32)
        .backgroundColor(SURFACE)
        .borderRadius(32)
        .shadow({
          radius: 18,
          color: '#26000000',
          offsetX: 0,
          offsetY: 8
        })

        Column({ space: 18 }) {
          Text('Adjust Progress')
            .fontSize(36)
            .fontColor(TEXT)
            .width('100%')
            .textAlign(TextAlign.Center)

          Slider({
            value: this.progress,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .height(38)
            .blockColor(PRIMARY)
            .trackColor(TRACK)
            .selectedColor(PRIMARY)
            .showSteps(false)
            .onChange((value: number) => {
              this.progress = value
            })

          Button('Mark as Delivered', { type: ButtonType.Capsule })
            .fontSize(26)
            .fontColor('#FFFFFF')
            .width('100%')
            .height(69)
            .backgroundColor(PRIMARY)
            .onClick(() => {
              this.progress = 100
            })
        }
        .width('100%')
        .padding(32)
        .backgroundColor(SURFACE)
        .borderRadius(32)
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 0, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .justifyContent(FlexAlign.Center)
    .padding({ top: 0, bottom: 0 })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
