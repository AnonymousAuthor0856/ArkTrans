@Entry
@Component
struct Index {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface Card
        Column() {
          Column({ space: 0 }) {
            Text('Current Spending')
              .fontColor('#06B6D4')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 8 })

            Text(`$${this.spending} / $${this.goal}`)
              .fontColor('#0F172A')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 16, bottom: 16 })

            Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color('#06B6D4')
              .backgroundColor('#E0F2FE')
              .borderRadius(4)
          }
          .width('100%')
          .height('100%')
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: 4 })
        .borderRadius(24)
        .width('100%')
        .height(160)

        Text('Adjust Spending')
          .fontColor('#0F172A')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .margin({ top: 8 })

        Slider({ value: this.spending, min: 0, max: 2000 })
          .width('100%')
          .selectedColor('#06B6D4')
          .trackColor('#E0F2FE')
          .blockColor('#3B82F6')
          .onChange((value: number) => {
            this.spending = Math.round(value)
          })

        Button('Reset')
          .width('100%')
          .height(48)
          .backgroundColor('#8B5CF6')
          .fontColor('#FFFFFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .onClick(() => {
            this.spending = 0
          })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#BFDBFE', 0], ['#F0F9FF', 0.5], ['#CFFAFE', 1]]
      })

      // Top App Bar
      Row() {
        Text('Bill Calendar')
          .fontColor('#0F172A')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#FFFFFF', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}