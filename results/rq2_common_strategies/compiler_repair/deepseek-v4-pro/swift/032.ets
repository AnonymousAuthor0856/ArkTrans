@Entry
@Component
struct RootScreen {
  @State markerX: number = 200
  @State markerY: number = 400
  @State progress: number = 0.4

  build() {
    Column({ space: 0 }) {
      // Top bar
      Row({ space: 0 }) {
        Blank().layoutWeight(1)
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF1E1E1E')
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFBFFF2')

      // Middle area with circles
      Stack({ alignContent: Alignment.Center }) {
        // Big circle (radius 260)
        Button() {
          Text('')
        }
        .width(520)
        .height(520)
        .backgroundColor('#FFEEE6D6')
        .borderRadius(260)

        // Small marker circle (radius 20)
        Button() {
          Text('')
        }
        .width(40)
        .height(40)
        .backgroundColor('#FFFFA500')
        .borderRadius(20)
        .margin({ left: this.markerX, top: this.markerY })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 12, right: 12 })

      // Bottom controls
      Column({ space: 12 }) {
        Text('Transfer Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('80%')
          .height(8)
          .color('#FFFFA500')
          .backgroundColor('#FFEEE6D6')
          .borderRadius(4)

        Row({ space: 12 }) {
          // "+" button
          Button() {
            Text('+')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFA500')
          .foregroundColor('#FFFFFFFF')
          .borderRadius(32)
          .onClick(() => {
            if (this.progress < 1.0) {
              this.progress += 0.1
            }
          })

          // "-" button
          Button() {
            Text('-')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFC300')
          .foregroundColor('#FF1E1E1E')
          .borderRadius(32)
          .onClick(() => {
            if (this.progress > 0.0) {
              this.progress -= 0.1
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding({ bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBFFF2')
  }
}